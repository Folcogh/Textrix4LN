;This file is part of Tetrix4LN (data used for objects rotations)
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
	
	xdef	idata,jdata,ldata,odata,sdata,tdata,zdata

;|=========================================
;|	Format
;|=========================================
;	word	number of positions
;	bytes	x1,y1,x2,y2,x3,y3,x4,y4
;	etc...

idata:
	dc.w	2
	dc.b	0,0,1,0,2,0,3,0
	dc.b	0,0,0,1,0,2,0,3

jdata:
	dc.w	4
	dc.b	0,0,0,1,1,1,2,1
	dc.b	0,0,1,0,0,1,0,2
	dc.b	0,0,1,0,2,0,2,1
	dc.b	1,0,1,1,1,2,0,2

ldata:
	dc.w	4
	dc.b	0,1,1,1,2,1,2,0
	dc.b	0,0,0,1,0,2,1,2
	dc.b	0,0,0,1,1,0,2,0
	dc.b	0,0,1,0,1,1,1,2

odata:
	dc.w	1
	dc.b	0,0,0,1,1,0,1,1

sdata:
	dc.w	2
	dc.b	0,1,1,1,1,0,2,0
	dc.b	0,0,0,1,1,1,1,2

tdata:
	dc.w	4
	dc.b	1,0,0,1,1,1,2,1
	dc.b	0,0,0,1,0,2,1,1
	dc.b	0,0,1,0,2,0,1,1
	dc.b	0,1,1,0,1,1,1,2

zdata:
	dc.w	2
	dc.b	0,0,1,0,1,1,2,1
	dc.b	0,1,1,1,1,0,0,2

 	end
