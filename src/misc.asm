;This file is part of Tetrix4LN (various subroutines)
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
	
	include	"tetrix.h"

	xdef	TestKey
	xdef	InitDownTempo
	xdef	DummyHandler
	xdef	Int5Counter

;|=========================================
;|	TestKey
;|=========================================
;|	low-level key testing, but int 1 & 5 must be disabled
;|
;|	input		column in d0.b & bit to test in d1.b
;|	output		Z-Flag is set if key is pressed
;|	destroys	d0
;|=========================================
TestKey:
	move.w	d0,$600018	;port to write
	moveq	#6,d0		;wait delay
\WaitHW:
	dbra.w	d0,\WaitHW
	btst.b	d1,$60001b	;port to read
	rts

;|=========================================
;|	InitDownTempo
;|=========================================
;|	init the tempo which regulate objects falling, depending on the game level
;|
;|	input		nothing
;|	output		nothing
;|	destroys	d0
;|=========================================
InitDownTempo:
	move.w	LEVEL(a4),d0
	move.b	DownTempo(pc,d0.w),CURRENT_TEMPO(a4)	;set the falling down tempo of the objects according to the current game level
	rts
DownTempo:
	dc.b	9,8,7,6,5,4,3,2,1,0

;|=========================================
;|	Int5Counter (auto-int 1&5 handler)
;|=========================================
;|	decrease objects and keys'timers, if the're !=0
;|	also export *rte to provide a dummy handler for the auto-int 1
;|
;|	input		nothing
;|	output		nothing
;|	destroys	nothing
;|=========================================
Int5Counter:
	pea.l	(a0)					;save a0
	movea.l	StackFramePtr(pc),a0			;(can't use a4 as frame pointer, we are in an interrupt handler #bang# ^^)
		tst.b	CURRENT_TEMPO(a0)		;check if null?
		beq	\DownTempoAlreadyNULL		;yes, do nothing for this counter
			subq.b	#1,CURRENT_TEMPO(a0)	;else, decrease it
\DownTempoAlreadyNULL:
		tst.b	KEYS_TEMPO(a0)			;same thing
		beq	\KeysTempoAlreadyNULL
			subq.b	#1,KEYS_TEMPO(a0)
\KeysTempoAlreadyNULL:
	movea.l	(sp)+,a0				;restore a0
DummyHandler:						;dummy hanler fot the auto-int 1
	rte

	end
