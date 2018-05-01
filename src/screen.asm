;This file is part of Tetrix4LN (display common subroutines)
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

	xdef	PortSetPlane0
	xdef	PortSetPlane1
	xdef	DispText
	xdef	ClearRect

;|=========================================
;|	ClearRect
;|=========================================
;|	clear a rectangle in the two planes
;|
;|	input		nothing
;|	output		nothing
;|	destroys	d0-d2/a0-a1/a3
;|
;|=========================================
ClearRect:
	movea.l	(sp)+,a3		;return adress
	bsr	PortSetPlane0		;set the active plane
	ROM_THROW	ScrRectFill	;and clear the rect in it
	bsr	PortSetPlane1		;same thing for the second plane
	ROM_THROW	ScrRectFill
	pea.l	(a3)			;and restore the return adress
	rts

;|=========================================
;|	DispText
;|=========================================
;|	disp a text in the two planes
;|
;|	input		nothing
;|	output		nothing
;|	destroys	d0-d2/d6/a0-a1
;|
;|=========================================
DispText:
	move.l	(sp)+,d6		;return adress
	bsr	PortSetPlane0		;set the active plane
	ROM_THROW	DrawStr		;and print the string
	bsr	PortSetPlane1		;same thing in the other plane
	ROM_THROW	DrawStr
	move.l	d6,-(sp)		;restore th return adress
	rts

;|=========================================
;|	PortSetPlane0
;|=========================================
;|	set AMS functions to a screen pointed to by a5
;|
;|	input		a5.l	*screen
;|	output		nothing
;|	destroys	d0-d2/a0-a1
;|
;|=========================================
PortSetPlane0:
	pea.l	239<<16+127		;width, height
	pea.l	(a5)			;adress of plane 0
	ROM_THROW	PortSet
	addq.l	#8,sp
	rts

;|=========================================
;|	PortSetPlane1
;|=========================================
;|	set AMS functions to a screen pointed to by a6
;|
;|	input		nothing
;|	output		nothing
;|	destroys	d0-d2/a0-a1
;|
;|=========================================
PortSetPlane1:
	pea.l	239<<16+127		;width, height
	pea.l	(a6)			;adress of plane 1
	ROM_THROW	PortSet
	addq.l	#8,sp
	rts

	end
