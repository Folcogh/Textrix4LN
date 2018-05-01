;This file is part of Tetrix4LN (object management, moves, and scrolling)
;Copyright (C) 2007 Martial Demolins

;	Tetrix4LN is free software; you can redistribute it and/or modify
;	it under the terms of the GNU General Public License as published by
;	the Free Software Foundation; either version 2 of the License, or
;	(at your option) any later version.

;	Tetrix4LN is distributed in the hope that it will be useful,
;	but WITHOUT ANY WARRANTY; without even the implied warranty of
;	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;	GNU General Public License for more details.

;	You should have received a copy of the GNU General Public License
;	along with Tetrix4LN; if not, write to the Free Software
;	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

	include	"romcalls.h"
	include	"tetrix.h"

	xdef	SelectRandomObject
	xdef	DispNextObject
	xdef	ObjectLeft
	xdef	ObjectRight
	xdef	ObjectRotate
	xdef	ObjectDown
	xdef	DispSprite
	xdef	InitNewObject

;|=========================================
;|	InitNewObject
;|=========================================
;|	init some data to prepare a new object
;|
;|	input		nothing
;|	output		nothing
;|	destroys	probably a lot of things %)
;|
;|=========================================
InitNewObject:
	btst.b	#FLAG.Down1,FLAG(a4)
	beq.s	\NoDown
	bset.b	#FLAG.Down2,FLAG(a4)
\NoDown:
	move.w	NEXT_OBJECT(a4),CURRENT_OBJECT(a4)	;next object become the current one
	bsr	SelectRandomObject			;new object in d1.w
	move.w	d1,NEXT_OBJECT(a4)			;saved in the stack frame
	move.l	#4<<16+0,CURRENT_X(a4)			;initial coordinates
	clr.w	POSITION(a4)				;initial position
	bsr	DispSprite
	bsr	DispNextObject

	;|=========================================
	;|	Disp level
	;|=========================================
		move.w	#1,-(sp)
		ROM_THROW	FontSetSys

		lea.l	-10(sp),sp
		move.w	LEVEL(a4),-(sp)
		pea.l	LevelStr(pc)
		pea.l	6(sp)
		ROM_THROW	sprintf

		clr.w	(sp)
		pea.l	Clip(pc)
		pea.l	\LevelRect(pc)
		bsr	ClearRect

		move.w	#1,(sp)
		pea.l	18(sp)
		pea.l	87<<16+49

		bsr	DispText

	;|=========================================
	;|	Disp score
	;|=========================================
		move.w	#2,(sp)			;huge font
		ROM_THROW	FontSetSys	;...

		lea.l	-10(sp),sp		;stack frame
		move.l	SCORE(a4),-(sp)		;number to compute
		pea.l	ScoreStr2(pc)		;push *arg string
		pea.l	6(sp)			;and *stack frame
		ROM_THROW	sprintf		;create the formated string

		clr.w	(sp)			;rect mode
		pea.l	Clip(pc)		;clip zone (struct of bytes, tetrix.asm)
		pea.l	\ScoreRect(pc)		;*rect to clear
		bsr	ClearRect		;call the right function

		move.w	#1,(sp)			;drawing mode
		pea.l	20(sp)			;*formated string
		pea.l	79<<16+84		;{x,y}
		bsr	DispText		;and disp that in the two planes
		addi.l	#$10001,(sp)		;offest {x+1,y+1}
		ROM_THROW	DrawStr		;draw the string in only one plane
		lea.l	76(sp),sp	;restore the stack



	bclr.b	#FLAG.Down,FLAG(a4)					;object is currently falling down
	bsr	InitDownTempo
	move.b	#3,KEYS_TEMPO(a4)


	;|=========================================
	;|	Check if the object doesn't cover another one
	;|=========================================
	bsr	FindObjectData
	move.w	CURRENT_X(a4),d1
	move.w	CURRENT_Y(a4),d2
	moveq	#3,d0
\Check:
	bsr	FindCoordinateInMatrix
	bsr	TestInMatrix
	bne	ReInit
	dbra.w	d0,\Check
	rts
\LevelRect:
		dc.b	88,47,135,56		;level area
\ScoreRect:
		dc.b	78,84,143,94		;score area

;|=========================================
;|	ReInit
;|=========================================
ReInit:
	addq.l	#8,sp				;remove the return adress of previous function
	lea.l	Restart(pc),a0
	st.b	(a0)
	bra	Quit				;and quit

;|=========================================
;|	SelectRandomObject
;|=========================================
;|	select a random object (#0-#6)
;|
;|	input		nothing
;|	output		d1.w	number of the selected object. first is #0
;|	destroys	d0-d2/a0-a1
;|
;|=========================================
SelectRandomObject:
	bsr	rand		;("andi.b #7,d0 // rts" seems to provide a strange random number... why??)
	moveq	#0,d1
	move.w	d0,d1
	divu.w	#7,d1
	swap.w	d1
	rts

;|=========================================
;|	DispNextObject
;|=========================================
;|	disp te next object in the rectangle "Next"
;|
;|	input		nothing
;|	output		nothing
;|	destroys	d0-d2/a0-a2
;|
;|=========================================
DispNextObject:
	clr.w	-(sp)			;clear previous object
	pea.l	Clip(pc)		;push *clip area
	pea.l	\Rect(pc)		;and *SCR_RECT
	bsr	ClearRect		;clear for the two planes
	lea.l	10(sp),sp
	moveq	#114,d0
	moveq	#30,d1
	moveq	#0,d3
	lea.l	SPRITE_TABLE(a4),a0	;sprite of the first object
	move.w	NEXT_OBJECT(a4),d5
	lsl.w	#2,d5			;adress are 4-bytes long
	movea.l	0(a0,d5.w),a0		;sprite of the real object
	movea.l	PUT_SPRITE_MASK(a4),a2	;graphlib::put_sprite_mask
	movea.l	a5,a1			;plane 0
	jsr	(a2)			;disp the sprite
	;|=========================================
	;|	skip the light plane
	;|=========================================
	move.w	(a0)+,d4		;x of the sprite
	mulu.w	(a0)+,d4		;y of the sprite
	btst.l	#0,d4			;perhaps the size is odd?
	beq	\EvenAdr
	addq.w	#1,d4			;so fix it (is there a better method to get an even ptr? thx to help me!)
\EvenAdr:
	lea.l	0(a0,d4.w),a0		;to get an even adress
	movea.l	a6,a1			;plane 1
	jsr	(a2)			;and disp the sprite
	rts

\Rect:	dc.b	111,28,133,40		;data to erase the previous "next object"

;|=========================================
;|	FindObjectData
;|=========================================
;|	return a ptr to the current object data, according to its position
;|
;|	input		nothing
;|	output		a3.l	*data
;|	destroys	a3
;|
;|=========================================
FindObjectData:
	move.w	d0,-(sp)		;save it for another function
	lea.l	DATA_TABLE(a4),a3
	move.w	CURRENT_OBJECT(a4),d0
	lsl.w	#2,d0			;offset of the object's data (table is made with adress)
	movea.l	0(a3,d0.w),a3		;*object
	move.w	POSITION(a4),d0		;(look at sdata.asm for the data format)
	lsl.w	#3,d0			;a position description is 8-bytes long
	lea.l	2(a3,d0.w),a3		;*data (skip the size)
	move.w	(sp)+,d0		;restore d0
	rts

;|=========================================
;|	FindCoordinateInMartix
;|=========================================
;|	return the real coordinates in the game area matrix, starting from coordinates of the top-left corner
;|
;|	input		d1.w	x object
;|			d2.w	y object
;|			a3.l	*{x.b,y.b}
;|	output		d3.w	x bloc
;|			d4.w	y bloc
;|	destroys	d3.w, d4.w, and add 2 to a3
;|
;|=========================================
FindCoordinateInMatrix:
	move.w	d1,d3
	add.b	(a3)+,d3	;x
	move.w	d2,d4
	add.b	(a3)+,d4	;y
	rts

;|=========================================
;|	TestInMatrix
;|=========================================
;|	simple function. just determine if there is an object or not in the matrix
;|
;|	input		{d3.w,d4.w}
;|	output		Z-Flag is set when there is no object
;|	destroys	d4.l
;|
;|=========================================
TestInMatrix:
	mulu.w	#12,d4
	add.w	d3,d4
	tst.b	0(a4,d4.w)
	rts

;|=========================================
;|	ObjectLeft
;|=========================================
;|
;|	input		nothing
;|	output		nothing
;|	destroys	d0-d3/a0-a1
;|
;|=========================================
ObjectLeft:
	bsr	FindObjectData		;put *data in a3
	move.w	CURRENT_X(a4),d1	;x of the top-left
	move.w	CURRENT_Y(a4),d2	;y...
	moveq	#3,d0			;check 4 times for the entire object
\Check:
	bsr	FindCoordinateInMatrix	;get {x,y} in {d3.w,d4.w}
	subq.w	#1,d3			;check at the left of the object
	bsr	TestInMatrix
	bne	\NoLeft			;lazy function. quit as soon as possible
	dbra.w	d0,\Check
	bsr	EraseCurrentSprite	;if succeed, erase the sprite,
	subq.w	#1,CURRENT_X(a4)	;shift it
	bsr	DispSprite		;and disp it again
\NoLeft:
	rts

;|=========================================
;|	ObjectRight
;|=========================================
;|
;|	input		nothing
;|	output		nothing
;|	destroys	d0-d2/a0-a1
;|
;|=========================================
ObjectRight:
	bsr	FindObjectData		;put *data in a3
	move.w	CURRENT_X(a4),d1	;x of the top-left
	move.w	CURRENT_Y(a4),d2	;y...
	moveq	#3,d0			;check 4 times for the entire object
\Check:
	bsr	FindCoordinateInMatrix	;get {x,y} in {d3.w,d4.w}
	addq.w	#1,d3			;check at the right of the object
	bsr	TestInMatrix
	bne	\NoRight		;lazy function. quit as soon as possible
	dbra.w	d0,\Check
	bsr	EraseCurrentSprite	;if succeed, erase the sprite
	addq.w	#1,CURRENT_X(a4)	;shift it
	bsr	DispSprite		;and disp it again
\NoRight:
	rts

;|=========================================
;|	ObjectRotate
;|=========================================
;|
;|	input		nothing
;|	output		nothing
;|	destroys	d0-d2/a0-a1
;|
;|=========================================
ObjectRotate:
	move.w	POSITION(a4),d5		;current position
	move.w	d5,d6			;save current position if the rotation is not possible
	addq.w	#1,d5			;new position
	lea.l	DATA_TABLE(a4),a3	;*data table
	move.w	CURRENT_OBJECT(a4),d0
	lsl.w	#2,d0			;offset of the current object
	movea.l	0(a3,d0.w),a3		;*current object in the table
	cmp.w	(a3),d5			;check it the last position is reached
	bne	\NoInitPosition		;no? position is valid
	moveq	#0,d5			;else come back to the first (#0)
\NoInitPosition:
	move.w	d5,POSITION(a4)		;so, valide the new position (already... but some functions assume this variable contains the real position)

	bsr	FindObjectData		;*data in a3
	moveq	#3,d0			;check for each element of the object
	move.w	CURRENT_X(a4),d1	;always the same routine... :)
	move.w	CURRENT_Y(a4),d2
\Check:
	bsr	FindCoordinateInMatrix
	bsr	TestInMatrix
	bne	\AbortRotation
	dbra.w	d0,\Check
	move.w	d6,POSITION(a4)
	bsr	EraseCurrentSprite
	move.w	d5,POSITION(a4)
	bsr	DispSprite
	rts
\AbortRotation:
	move.w	d6,POSITION(a4)		;failed. restore original position
	rts

;|=========================================
;|	ObjectDown
;|=========================================
;|
;|	input
;|	output		nothing
;|	destroys	d0-d2/a0-a1
;|
;|=========================================
ObjectDown:
	bsr	FindObjectData		;put *data in a3
	move.w	CURRENT_X(a4),d1	;always the same routine
	move.w	CURRENT_Y(a4),d2
	moveq	#3,d0
\Check:
	bsr	FindCoordinateInMatrix
	addq.w	#1,d4			;but check under the object ^^
	bsr	TestInMatrix
	bne	\NoDown
	dbra.w	d0,\Check
	bsr	EraseCurrentSprite
	addq.w	#1,CURRENT_Y(a4)
	bsr	DispSprite
	bclr.b	#FLAG.Down,FLAG(a4)	;object was'nt putted on somewhere, so it was falling down again
	rts
\NoDown:
	bset.b	#FLAG.Down,FLAG(a4)	;else not, we must remember that we are already on some object (can move still once!)
	bne	ObjectBlocked		;if we were already on an object, go to the final step
	rts

;|=========================================
;|	EraseCurrentSprite
;|=========================================
;|
;|	input		a3+8	*data
;|	output		nothing
;|	destroys	d0-d4/a0-a1
;|
;|=========================================
EraseCurrentSprite:
	bsr	FindObjectData
	moveq	#3,d2			;must clear 4 objects
	move.b	#$f8,d3			;mask is 5 bits long
	lea.l	GenericSpriteMask(pc),a0	;same sprite for all parts of all objects
	movea.l	PUT_SPRITE_MASK(a4),a2
\Erase:
	move.w	CURRENT_X(a4),d0	;x of the top-left corner
	add.b	(a3)+,d0		;x of the current bloc to erase
	mulu.w	#5,d0			;graphical x (starting on the left side of the game area)
	addq.w	#5,d0			;real x (starting of the top-left corner of the screen)
	move.w	CURRENT_Y(a4),d1	;same way for y
	add.b	(a3)+,d1		;...
	mulu.w	#5,d1			;... real y. no vertical offset
	movea.l	a5,a1			;light plane
	jsr	(a2)			;erase
	movea.l	a6,a1			;dark
	jsr	(a2)			;idem
	dbra.w	d2,\Erase		;for the 4 parts of the sprite
	rts

;|=========================================
;|	DispSprite
;|=========================================
;|
;|	input		nothing
;|	output		nothingD0=
;|	destroys
;|
;|=========================================
DispSprite:
	lea.l	SPRITE_TABLE(a4),a0
	move.w	CURRENT_OBJECT(a4),d0
	lsl.w	#2,d0
	movea.l	0(a0,d0.w),a0		;get the adress of the sprite (in position #0)

	move.w	POSITION(a4),d0		;what is the position?
	beq	\PosInit		;#0? ok, so a0 is the good adress
	add.w	d0,d0			;else, we must skip sprites of the other position (light and dark planes for each one)
	subq.w	#1,d0			;(dbf...)
\SkipSprite:
	move.w	(a0)+,d1		;width of the sprite
	mulu.w	(a0)+,d1		;*height==it's size
	btst.l	#0,d1			;have we got an odd adress
	beq	\EvenAdr		;no? so adress is valid
	addq.w	#1,d1			;esle fix it (all sprites are word-aligned)
\EvenAdr:
	lea.l	0(a0,d1.w),a0		;valid adress
	dbra.w	d0,\SkipSprite		;until the good sprite is reached
\PosInit:
	move.w	CURRENT_X(a4),d0	;compute the coordinates
	mulu.w	#5,d0			;x in the gale area
	addq.w	#5,d0			;real x on the screen
	move.w	CURRENT_Y(a4),d1	;same thing for y
	mulu.w	#5,d1			;but offset is null
	moveq	#0,d3			;mask of the sprite
	movea.l	a5,a1			;plane 0
	movea.l	PUT_SPRITE_MASK(a4),a2	;*disp
	jsr	(a2)			;disp
	movea.l	a6,a1			;plane 1
	move.w	(a0)+,d2		;skip the light plane sprite
	mulu.w	(a0)+,d2
	btst.l	#0,d2			;always the same problem...
	beq	\EvenAdr2
	addq.w	#1,d2
\EvenAdr2:
	lea.l	0(a0,d2.w),a0
	jsr	(a2)			;and disp the other plane
	rts

;|=========================================
;|	ObjectBlocked
;|=========================================
;|	called when an object is blocked on the game area
;|
;|	1	create the object in the matrix
;|	2	check if lines must be cleared
;|	3	create a new object if needed
;|
;|	input		nothing
;|	output		nothing
;|	destroys
;|
;|=========================================
ObjectBlocked:
	;|=========================================
	;|	Set to $ff the position of the object in the matrix
	;|=========================================
	bsr	FindObjectData
	move.w	CURRENT_X(a4),d1
	move.w	CURRENT_Y(a4),d2

	moveq	#3,d0			;for each part of the object
\UpdateMatrix:
	bsr	FindCoordinateInMatrix	;get {x,y} in {d3.w,d4.w}
	mulu.w	#12,d4			;offset of the line in bytes
	add.w	d3,d4			;offest in the matrix
	st.b	0(a4,d4.w)		;set the byte to "occuped"
	dbra.w	d0,\UpdateMatrix

	;|=========================================
	;|	check and detroys complete lines, and update the score
	;|=========================================
	moveq	#0,d6		;score
InitLoop2:
	moveq	#94,d4		;graphical ordinate
	lea.l	12*20-1(a4),a0	;first byte to check
\InitLoop:
	moveq	#9,d0		;counter
	moveq	#0,d1		;number of occuped elements
\Loop:
	tst.b	-(a0)		;is there something?
	beq	\empty		;no? so continue to loop
	addq.w	#1,d1		;else increment the counter
\empty:
	dbra.w	d0,\Loop	;10 times...
	cmpi.w	#10,d1		;was the line complete?
	bne	\NotFull	;no

	;|=========================================
	;|	clear a line (data)
	;|=========================================
		add.w	d6,d6		;the complete line #L adds 100x2^(L-1)to the score
		bne	\CopyLoop	;if it was null
		moveq	#1,d6		;but the first line just give 100 points
\CopyLoop:
		move.b	-(a0),12(a0)	;copy each element at its place+12 bytes
		cmpa.l	a0,a4		;quit when the top is reached
		bne	\CopyLoop
		st.b	(a0)		;restore the sides of the first line
		st.b	11(a0)		;(useless... these boundaries can't be reached, but...)
		bsr	PortSetPlane0	;and scroll down the graphics
		bsr	ScrollRect
		bsr	PortSetPlane1	;in the two planes
		bsr	ScrollRect
		bra	InitLoop2	;a complete line has been cleared. restart again ^^


\NotFull:
	subq.l	#1,a0		;begining of the line
	cmpa.l	a0,a4		;does the matrix start here?
	beq	\StopCheck	;yes. so stop to check, we can continue to play
	subq.l	#1,a0		;end of the previous line
	subq.w	#5,d4		;and update the graphical ordinate of the line
	bra	\InitLoop	;and continue to loop, strarting again at the beginig of the matrix (really usefull? i don't think. but it's so fast...)

\StopCheck
	mulu.w	#100,d6		;score multiplier for a line
	bne	\CompleteLine	;if not null, there is at least a line
	addi.w	#10,d6		;else, just add the score for only one object
\CompleteLine:
	add.l	d6,SCORE(a4)	;update the score

	;|=========================================
	;|	check and update level
	;|=========================================
	move.w	LEVEL(a4),d0	;current game level
	lsl.w	#2,d0		;offset in the longwords table
	lea.l	SCORE_LIST(a4),a0	;list of scores where level must be updated
	adda.l	d0,a0		;*next score
	lea.l	SCORE(a4),a1	;current one
	cmp.l	(a1)+,(a0)+	;check if we must update
	bhi	\SameLevel	;no
	addq.w	#1,LEVEL(a4)	;yes, so update
\SameLevel:
	bsr	InitNewObject	;and continue, initializing a new object
	lea.l	-4(a4),sp	;come back to the initial stack value, wich is the stack frame's one-4 ($600001 has been pushed)
	bra	MainLoop	;and come back to the game
	rts

;|=========================================
;|	ScrollRect (clear a graphical line)
;|=========================================
;|	scroll down the game area when a line is complete
;|
;|	input		nothing
;|	output		nothing
;|	destroys	nothing
;|
;|=========================================
ScrollRect:
	move.w	d4,-(sp)	;graphical y2
	move.b	#59,(sp)	;x2
	move.w	#10<<8+0,-(sp)	;x1 and y1 (SCR_RECT sruct is now ready)

	lea.l	-710(sp),sp	;BIT_MAP buffer

	pea.l	(sp)		;*buffer
	pea.l	4+710(sp)		;could be 4+700-5*7??
	ROM_THROW	BitmapGet	;*bitmap,*rect

	addq.b	#5,710+4+4+2+1(sp)	;new ordinate
	clr.w	-(sp)			;clear a rect
	pea.l	Clip(pc)		;always the clip zone...
	pea.l	6+8+710(sp)
	ROM_THROW	ScrRectFill	;*rect,*clip,attr

	addq.l	#4,sp			;*clip
	addq.w	#1,4(sp)		;mode
	pea.l	14(sp)			;*bitmap
	pea.l	10<<16+5		;{x,y}
	ROM_THROW	BitmapPut	;x,y,*bitmap,*clip,attr

	lea.l	4+10+8+710+4(sp),sp
	rts
	end


