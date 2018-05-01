|-*-Text-*-	Emacs'mode

| This file is part of Tetrix4LN (fun code displayer)
| Copyright (C) 2007 Martial Demolins

|	Tetrix4LN is free software; you can redistribute it and/or modify
|	it under the terms of the GNU General Public License as published by
|	the Free Software Foundation; either version 2 of the License, or
|	(at your option) any later version.

|	Tetrix4LN is distributed in the hope that it will be useful,
|	but WITHOUT ANY WARRANTY; without even the implied warranty of
|	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
|	GNU General Public License for more details.

|	You should have received a copy of the GNU General Public License
|	along with Tetrix4LN; if not, write to the Free Software
|	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

	.include	"kernel.h"

	.xdef		_main

	.xdef		_ti89
	.xdef		_ti89ti
	.xdef		_ti92
	.xdef		_v200

.set	TETRIX_SIZE,	3356

_main:					|this code just echoes to the screen the content of the binary file "tetrix" :D
	ROM_THROW	ScreenClear	|clear the screen
	lea.l	TetrixStr(%pc),%a0	|get the str ptr
	moveq.l	#0,%d1			|version
	jsr	kernel__LibsBegin	|relloc it
	move.l	%a0,%d0			|check the descriptor
	beq.s	Quit			|if null, quit
	jsr	kernel__Ptr2Hd		|else get its handle
	move.w	%d0,-(%sp)		|push it on the stack
	ROM_THROW	HeapDeref	|deref it
	addq.l	#2,%sp			|adjust sp
	move.l	#TETRIX_SIZE/4-1,%d0	|counter
	lea.l	LCD_MEM,%a1		|*screen
Loop:	move.l	(%a0)+,(%a1)+		|and print ^^
	dbra.w	%d0,Loop
	ROM_THROW	ngetchx		|wait a key
Quit:	rts				|and quit

TetrixStr:	.asciz	"tetrix"
