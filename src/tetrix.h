;This file is part of Tetrix4LN (constants definition)
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

MATRIX_SIZE		equ	252

OLD_INT_1		equ	MATRIX_SIZE+0	;4
OLD_INT_5		equ	MATRIX_SIZE+4	;4
CALC			equ	MATRIX_SIZE+11	;1
FLAG			equ	MATRIX_SIZE+10	;1
CURRENT_OBJECT		equ	MATRIX_SIZE+8	;2
NEXT_OBJECT		equ	MATRIX_SIZE+12	;2
CURRENT_TEMPO		equ	MATRIX_SIZE+14	;1
KEYS_TEMPO		equ	MATRIX_SIZE+15	;1
POSITION		equ	MATRIX_SIZE+16	;2
CURRENT_X		equ	MATRIX_SIZE+18	;2
CURRENT_Y		equ	MATRIX_SIZE+20	;2
LEVEL			equ	MATRIX_SIZE+22	;2
SCORE			equ	MATRIX_SIZE+24	;4
SPRITE_TABLE		equ	MATRIX_SIZE+28	;7*4
DATA_TABLE		equ	MATRIX_SIZE+56	;7*4
PUT_SPRITE_MASK		equ	MATRIX_SIZE+84	;4
SCORE_LIST		equ	MATRIX_SIZE+88	;4*10
STACK_FRAME_SIZE	equ	MATRIX_SIZE+128	;end

FLAG.Down		equ	0
FLAG.Rotate		equ	1
FLAG.Down1		equ	2
FLAG.Down2		equ	3

LEVEL_STEP		equ	2000		;number of points to get to increase level