;This file is part of Tetrix4LN (main file)
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

	include	"tios.h"
	include	"romcalls.h"
	include	"graphlib.h"
	include	"tetrix.h"

	xdef	_main
	xdef	_comment
	xdef	_ti89
	xdef	_ti89ti
	xdef	_ti92plus
	xdef	_v200

	xdef	Quit
	xdef	MainLoop
	xdef	ScoreStr2
	xdef	LevelStr
	xdef	StackFramePtr
	xdef	Clip
	xdef	Restart

_main:
;|=========================================
;|	Init the stack frame
;|=========================================
	move.l	#LEVEL_STEP*10,d0
	moveq	#9,d1
\RegScore:
	move.l	d0,-(sp)
	subi.w	#LEVEL_STEP,d0
	dbra.w	d1,\RegScore
	pea.l	graphlib::put_sprite_mask
	pea.l	zdata(pc)
	pea.l	tdata(pc)
	pea.l	sdata(pc)
	pea.l	odata(pc)
	pea.l	ldata(pc)
	pea.l	jdata(pc)
	pea.l	idata(pc)
	pea.l	z(pc)
	pea.l	t(pc)
	pea.l	s(pc)
	pea.l	o(pc)
	pea.l	l(pc)
	pea.l	j(pc)
	pea.l	i(pc)
	clr.l	-(sp)		;Score
	clr.w	-(sp)		;level
	subq.l	#8,sp		;Position, KeysTempo, DownTempo, CurrentX, CurrentY
	bsr	SelectRandomObject
	move.w	d1,-(sp)	;NextObject
	moveq.l	#0,d0		;default : ti92/v200
	cmpi.b	#1,CALCULATOR
	bge.s	\92
	moveq.l	#1,d0		;CALC is 1 on 89/89ti else 0
\92:	move.l	d0,-(sp)	;CurrentObject,Flag,Calc

;|=========================================
;|	Redirect auto-ints 1 & 5, and update the stack frame
;|=========================================
	lea.l	($64).w,a1		;**int 1
	lea.l	($74).w,a5		;**int 5

	move.l	(a1),-(sp)		;save old vectors
	move.l	(a5),-(sp)

		;|=========================================
		;|	Complete the stack frame
		;|=========================================
		lea.l	-MATRIX_SIZE(sp),sp
		lea.l	StackFramePtr(pc),a0
		move.l	sp,(a0)			;save *sf for the new int 5
		movea.l	sp,a4

	lea.l	DummyHandler(pc),a2	;new int 1
	lea.l	Int5Counter(pc),a3	;new int 5

	moveq	#2,d0		;bit
	pea.l	$600001		;*port
	movea.l	(sp),a0

	bclr.b	d0,(a0)		;unprotect
	move.l	a2,(a1)		;install
	move.l	a3,(a5)		;new vectors
	bset.b	d0,(a0)		;protect

;|=========================================
;|	Init graphlib
;|=========================================
	jsr	graphlib::gray4
	tst.l	d0
	beq	Quit
	movea.l	graphlib::plane0,a6	;dark
	movea.l	graphlib::plane1,a5	;& light #roll#
	move.w	#1,graphlib::choosescreen

;|=========================================
;|	Fill scr with background spr (H=20, L=16)
;|=========================================
	moveq	#-1,d3
	moveq	#8-1,d4
	movea.l	PUT_SPRITE_MASK(a4),a2
\LoopVert:
	moveq	#14,d2
\LoopHorz:
	move.w	d2,d0
	lsl.w	#4,d0
	move.w	d4,d1
	lsl.w	#4,d1
	movea.l	a5,a1
	lea.l	BackgroundLight(pc),a0
	jsr	(a2)
	movea.l	a6,a1
	lea.l	BackgroundDark(pc),a0
	jsr	(a2)
	dbra.w	d2,\LoopHorz
	dbra.w	d4,\LoopVert

;|=========================================
;|	Create the game area
;|=========================================
	lea.l	RectData(pc),a2
	moveq	#4,d3			;count
	clr.w	-(sp)			;attr			sp+2
	pea.l	Clip(pc)		;*clip			sp+6
\RectLoop:
	pea.l	(a2)			;*SCR_RECT		sp+10
	bsr	ClearRect
	ROM_THROW	ScrToWin	;SCR_RECT to WIN_RECT
	move.l	a0,(sp)			;replace
	addq.w	#1,8(sp)
	ROM_THROW	DrawClipRect
	bsr	PortSetPlane0
	ROM_THROW	DrawClipRect
	subq.w	#1,8(sp)
	addq.l	#4,sp						;sp+6
	addq.l	#4,a2
	dbra.w	d3,\RectLoop

	ROM_THROW	SetCurClip
	pea.l	GameAreaLines(pc)				;sp+10
	pea.l	0			;offset!!! #rage#	;sp+14
	ROM_THROW	DrawMultiLines
	bsr	PortSetPlane1
	ROM_THROW	DrawMultiLines

;|=========================================
;|	Disp the title
;|=========================================
	move.w	#2,(sp)
	ROM_THROW	FontSetSys
	subq.w	#1,(sp)
	pea.l	GameTitle(pc)					;sp+18
	pea.l	75<<16+7					;sp+22
	bsr	DispText
	bsr	PortSetPlane0
	addi.l	#$10001,(sp)
	ROM_THROW	DrawStr

;|=========================================
;|	Disp "Score"
;|=========================================
	addq.l	#8,sp						;sp+14
	pea.l	ScoreStr1(pc)					;sp+18
	pea.l	91<<16+72					;sp+22
	bsr	DispText

;|=========================================
;|	Disp "Next"
;|=========================================
	addq.l	#8,sp						;sp+14
	ROM_THROW	FontSetSys
	pea.l	Next(pc)					;sp+18
	pea.l	87<<16+31					;sp+22
	bsr	DispText

	lea.l	22(sp),sp
;|=========================================
;|	Init the game matrix (12*21==252 bytes)
;|=========================================
	moveq	#19,d0
	movea.l	a4,a0
\Loop:
	st.b	(a0)+
	clr.b	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.b	(a0)+
	st.b	(a0)+
	dbra.w	d0,\Loop
	moveq	#-1,d0
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)
	bsr	InitNewObject
;|=========================================
;|	Main loop
;|=========================================
MainLoop:
	;|=========================================
	;|	check if we can read keys
	;|=========================================
	tst.b	KEYS_TEMPO(a4)
	bne	\SkipKeys
	;|=========================================
	;|	test left
	;|=========================================
	moveq	#-2,d0
	moveq	#4,d1
	tst.b	CALC(a4)
	beq.s	\No92_1
		moveq	#%-2,d0
		moveq	#1,d1
\No92_1:
	bsr	TestKey
	bne	\NoLeft
	move.b	#3,KEYS_TEMPO(a4)
	bsr	ObjectLeft
\NoLeft:
	;|=========================================
	;|	test right
	;|=========================================
	moveq	#-2,d0
	moveq	#6,d1
	tst.b	CALC(a4)
	beq.s	\No92_2
		moveq	#%-2,d0
		moveq	#3,d1
\No92_2:
	bsr	TestKey
	bne	\NoRight
	move.b	#3,KEYS_TEMPO(a4)
	bsr	ObjectRight
\NoRight:
	;|=========================================
	;|	test F1
	;|=========================================
	moveq	#$ffffffbf,d0
	moveq	#4,d1
	tst.b	CALC(a4)
	beq.s	\No92_3
		moveq	#$ffffffdf,d0
		moveq	#7,d1
\No92_3:
	lea.l	FLAG(a4),a0
	bsr	TestKey
	bne	\NoRotate
	btst.b	#FLAG.Rotate,(a0)
	bne	\KeyStillPressed
	bset.b	#FLAG.Rotate,(a0)
	bsr	ObjectRotate
	bra	\KeyStillPressed
\NoRotate:
	bclr.b	#FLAG.Rotate,(a0)
\KeyStillPressed:
	;|=========================================
	;|	test down
	;|=========================================
	moveq	#-2,d0
	moveq	#7,d1
	tst.b	CALC(a4)
	beq.s	\No92_4
		moveq	#-2,d0
		moveq	#2,d1
\No92_4:
	bsr	TestKey
	bne.s	\NoDown
	btst.b	#FLAG.Down2,FLAG(a4)
	bne.s	\Down
	clr.b	CURRENT_TEMPO(a4)
	bset.b	#FLAG.Down1,FLAG(a4)
	bra.s	\Down
\NoDown:
	bclr.b	#FLAG.Down1,FLAG(a4)
	bclr.b	#FLAG.Down2,FLAG(a4)
\Down:
	;|=========================================
	;|	regualate speed
	;|=========================================
\SkipKeys:
	tst.b	CURRENT_TEMPO(a4)
	bne	\NoObjectDown
	bsr	InitDownTempo
	bsr	ObjectDown
\NoObjectDown:
	;|=========================================
	;|	test f2
	;|=========================================
\Pause:
	moveq	#$ffffffef,d0
	moveq	#4,d1
	tst.b	CALC(a4)
	beq.s	\No92_5
		moveq	#$ffffffef,d0
		moveq	#7,d1
\No92_5:
	bsr	TestKey
	beq	\Pause
	;|=========================================
	;|	test esc
	;|=========================================
	move.w	#$feff,d0
	moveq	#6,d1
	tst.b	CALC(a4)
	beq.s	\No92_6
		moveq	#$ffffffbf,d0
		moveq	#0,d1
\No92_6:
	bsr	TestKey
	bne	MainLoop


;|=========================================
;|	Quit
;|=========================================
	lea.l	Restart(pc),a0
	sf.b	(a0)
Quit:
	jsr	graphlib::gray2
	ROM_THROW	PortRestore
	moveq	#2,d0
	movea.l	(sp)+,a0
	lea.l	MATRIX_SIZE(sp),sp
	bclr.b	d0,(a0)
	move.l	(sp)+,($74).w
	move.l	(sp)+,($64).w
	bset.b	d0,(a0)
	lea.l	STACK_FRAME_SIZE-MATRIX_SIZE-(2*4)(sp),sp
	move.b	Restart(pc),d0					;restart game?
	beq.s	NoRestart					;no, quit now
	pea.l	_main(pc)					;else push _main to restart game
NoRestart:
	rts

;|=========================================
;|	Vars
;|=========================================
	even

StackFramePtr:
		dc.l	0
RectData:
		dc.b	9,0,60,99
		dc.b	67,3,155,20
		dc.b	85,27,137,41
		dc.b	85,46,137,58
		dc.b	68,68,157,96
Clip:
		dc.b	0,0,239,127
GameAreaLines:
		dc.b	2
		dc.b	0,10,0,59,0
		dc.b	0,10,99,59,99

_comment:
	dc.b	"by M.Demolins",0
GameTitle:
	dc.b	"TetriX4LN",0
Next:
	dc.b	"Next",0
LevelStr:
	dc.b	"Level %02u",0
ScoreStr1:
	dc.b	"SCORE",0
ScoreStr2:
	dc.b	"%08lu",0
Restart:
	dc.b	0

	end
