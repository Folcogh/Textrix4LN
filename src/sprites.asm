;This file is part of Tetrix4LN (sprites)
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
	
	xdef	GenericSpriteMask
	xdef	BackgroundLight
	xdef	BackgroundDark

	xdef	i,j,l,o,s,t,z

	even
i:	dc.w	5,3
	dc.b	$FF,$FF,$F0
	dc.b	$DB,$6D,$B0
	dc.b	$ED,$B6,$D0
	dc.b	$B6,$DB,$70
	dc.b	$FF,$FF,$F0

	even
	dc.w	5,3
	dc.b	$FF,$FF,$F0
	dc.b	$A4,$92,$50
	dc.b	$92,$49,$30
	dc.b	$C9,$24,$90
	dc.b	$FF,$FF,$F0

	even
	dc.w	20,1
	dc.b	$F8
	dc.b	$D8
	dc.b	$B8
	dc.b	$E8
	dc.b	$D8
	dc.b	$B8
	dc.b	$E8
	dc.b	$D8
	dc.b	$B8
	dc.b	$E8
	dc.b	$D8
	dc.b	$B8
	dc.b	$E8
	dc.b	$D8
	dc.b	$B8
	dc.b	$E8
	dc.b	$D8
	dc.b	$B8
	dc.b	$E8
	dc.b	$F8

	even
	dc.w	20,1
	dc.b	$F8
	dc.b	$A8
	dc.b	$C8
	dc.b	$98
	dc.b	$A8
	dc.b	$C8
	dc.b	$98
	dc.b	$A8
	dc.b	$C8
	dc.b	$98
	dc.b	$A8
	dc.b	$C8
	dc.b	$98
	dc.b	$A8
	dc.b	$C8
	dc.b	$98
	dc.b	$A8
	dc.b	$C8
	dc.b	$98
	dc.b	$F8

	even
j:	dc.w	10,2
	dc.b	$F8,$00
	dc.b	$D8,$00
	dc.b	$B8,$00
	dc.b	$E8,$00
	dc.b	$D8,$00
	dc.b	$BF,$FE
	dc.b	$ED,$B6
	dc.b	$DB,$6E
	dc.b	$B6,$DA
	dc.b	$FF,$FE

	even
	dc.w	10,2
	dc.b	$F8,$00
	dc.b	$A8,$00
	dc.b	$C8,$00
	dc.b	$98,$00
	dc.b	$A8,$00
	dc.b	$CF,$FE
	dc.b	$92,$4A
	dc.b	$A4,$92
	dc.b	$C9,$26
	dc.b	$FF,$FE

	even
	dc.w	15,2
	dc.b	$FF,$C0
	dc.b	$B6,$C0
	dc.b	$DB,$40
	dc.b	$ED,$C0
	dc.b	$BF,$C0
	dc.b	$D8,$00
	dc.b	$E8,$00
	dc.b	$B8,$00
	dc.b	$D8,$00
	dc.b	$E8,$00
	dc.b	$B8,$00
	dc.b	$D8,$00
	dc.b	$E8,$00
	dc.b	$B8,$00
	dc.b	$F8,$00

	even
	dc.w	15,2
	dc.b	$FF,$C0
	dc.b	$C9,$40
	dc.b	$A4,$C0
	dc.b	$92,$40
	dc.b	$CF,$C0
	dc.b	$A8,$00
	dc.b	$98,$00
	dc.b	$C8,$00
	dc.b	$A8,$00
	dc.b	$98,$00
	dc.b	$C8,$00
	dc.b	$A8,$00
	dc.b	$98,$00
	dc.b	$C8,$00
	dc.b	$F8,$00

	even
	dc.w	10,2
	dc.b	$FF,$FE
	dc.b	$B6,$DA
	dc.b	$ED,$B6
	dc.b	$DB,$6E
	dc.b	$FF,$FA
	dc.b	$00,$36
	dc.b	$00,$2E
	dc.b	$00,$3A
	dc.b	$00,$36
	dc.b	$00,$3E

	even
	dc.w	10,2
	dc.b	$FF,$FE
	dc.b	$C9,$26
	dc.b	$92,$4A
	dc.b	$A4,$92
	dc.b	$FF,$E6
	dc.b	$00,$2A
	dc.b	$00,$32
	dc.b	$00,$26
	dc.b	$00,$2A
	dc.b	$00,$3E

	even
	dc.w	15,2
	dc.b	$07,$C0
	dc.b	$07,$40
	dc.b	$05,$C0
	dc.b	$06,$C0
	dc.b	$07,$40
	dc.b	$05,$C0
	dc.b	$06,$C0
	dc.b	$07,$40
	dc.b	$05,$C0
	dc.b	$06,$C0
	dc.b	$FF,$40
	dc.b	$ED,$C0
	dc.b	$B6,$C0
	dc.b	$DB,$40
	dc.b	$FF,$C0

	even
	dc.w	15,2
	dc.b	$07,$C0
	dc.b	$04,$C0
	dc.b	$06,$40
	dc.b	$05,$40
	dc.b	$04,$C0
	dc.b	$06,$40
	dc.b	$05,$40
	dc.b	$04,$C0
	dc.b	$06,$40
	dc.b	$05,$40
	dc.b	$FC,$C0
	dc.b	$92,$40
	dc.b	$C9,$40
	dc.b	$A4,$C0
	dc.b	$FF,$C0

	even
l:	dc.w	10,2
	dc.b	$00,$3E
	dc.b	$00,$2E
	dc.b	$00,$3A
	dc.b	$00,$36
	dc.b	$00,$2E
	dc.b	$FF,$FA
	dc.b	$ED,$B6
	dc.b	$DB,$6E
	dc.b	$B6,$DA
	dc.b	$FF,$FE

	even
	dc.w	10,2
	dc.b	$00,$3E
	dc.b	$00,$32
	dc.b	$00,$26
	dc.b	$00,$2A
	dc.b	$00,$32
	dc.b	$FF,$E6
	dc.b	$92,$4A
	dc.b	$A4,$92
	dc.b	$C9,$26
	dc.b	$FF,$FE

	even
	dc.w	15,2
	dc.b	$F8,$00
	dc.b	$B8,$00
	dc.b	$D8,$00
	dc.b	$E8,$00
	dc.b	$B8,$00
	dc.b	$D8,$00
	dc.b	$E8,$00
	dc.b	$B8,$00
	dc.b	$D8,$00
	dc.b	$E8,$00
	dc.b	$BF,$C0
	dc.b	$DB,$40
	dc.b	$ED,$C0
	dc.b	$B6,$C0
	dc.b	$FF,$C0

	even
	dc.w	15,2
	dc.b	$F8,$00
	dc.b	$C8,$00
	dc.b	$A8,$00
	dc.b	$98,$00
	dc.b	$C8,$00
	dc.b	$A8,$00
	dc.b	$98,$00
	dc.b	$C8,$00
	dc.b	$A8,$00
	dc.b	$98,$00
	dc.b	$CF,$C0
	dc.b	$A4,$C0
	dc.b	$92,$40
	dc.b	$C9,$40
	dc.b	$FF,$C0

	even
	dc.w	10,2
	dc.b	$FF,$FE
	dc.b	$B6,$DA
	dc.b	$ED,$B6
	dc.b	$DB,$6E
	dc.b	$BF,$FE
	dc.b	$E8,$00
	dc.b	$D8,$00
	dc.b	$B8,$00
	dc.b	$E8,$00
	dc.b	$F8,$00

	even
	dc.w	10,2
	dc.b	$FF,$FE
	dc.b	$C9,$26
	dc.b	$92,$4A
	dc.b	$A4,$92
	dc.b	$CF,$FE
	dc.b	$98,$00
	dc.b	$A8,$00
	dc.b	$C8,$00
	dc.b	$98,$00
	dc.b	$F8,$00

	even
	dc.w	15,2
	dc.b	$FF,$C0
	dc.b	$DB,$40
	dc.b	$ED,$C0
	dc.b	$B6,$C0
	dc.b	$FF,$40
	dc.b	$05,$C0
	dc.b	$06,$C0
	dc.b	$07,$40
	dc.b	$05,$C0
	dc.b	$06,$C0
	dc.b	$07,$40
	dc.b	$05,$C0
	dc.b	$06,$C0
	dc.b	$07,$40
	dc.b	$07,$C0

	even
	dc.w	15,2
	dc.b	$FF,$C0
	dc.b	$A4,$C0
	dc.b	$92,$40
	dc.b	$C9,$40
	dc.b	$FC,$C0
	dc.b	$06,$40
	dc.b	$05,$40
	dc.b	$04,$C0
	dc.b	$06,$40
	dc.b	$05,$40
	dc.b	$04,$C0
	dc.b	$06,$40
	dc.b	$05,$40
	dc.b	$04,$C0
	dc.b	$07,$C0

	even
o:	dc.w	10,2
	dc.b	$FF,$C0
	dc.b	$ED,$C0
	dc.b	$DB,$40
	dc.b	$B6,$C0
	dc.b	$ED,$C0
	dc.b	$DB,$40
	dc.b	$B6,$C0
	dc.b	$ED,$C0
	dc.b	$DB,$40
	dc.b	$FF,$C0

	even
	dc.w	10,2
	dc.b	$FF,$C0
	dc.b	$92,$40
	dc.b	$A4,$C0
	dc.b	$C9,$40
	dc.b	$92,$40
	dc.b	$A4,$C0
	dc.b	$C9,$40
	dc.b	$92,$40
	dc.b	$A4,$C0
	dc.b	$FF,$C0

	even
s:	dc.w	10,2
	dc.b	$07,$FE
	dc.b	$06,$DA
	dc.b	$05,$B6
	dc.b	$07,$6E
	dc.b	$06,$FE
	dc.b	$FD,$C0
	dc.b	$DB,$40
	dc.b	$B6,$C0
	dc.b	$ED,$C0
	dc.b	$FF,$C0

	even
	dc.w	10,2
	dc.b	$07,$FE
	dc.b	$05,$26
	dc.b	$06,$4A
	dc.b	$04,$92
	dc.b	$05,$7E
	dc.b	$FE,$40
	dc.b	$A4,$C0
	dc.b	$C9,$40
	dc.b	$92,$40
	dc.b	$FF,$C0

	even
	dc.w	15,2
	dc.b	$F8,$00
	dc.b	$D8,$00
	dc.b	$E8,$00
	dc.b	$B8,$00
	dc.b	$D8,$00
	dc.b	$EF,$C0
	dc.b	$B6,$C0
	dc.b	$DB,$40
	dc.b	$ED,$C0
	dc.b	$FE,$C0
	dc.b	$07,$40
	dc.b	$05,$C0
	dc.b	$06,$C0
	dc.b	$07,$40
	dc.b	$07,$C0

	even
	dc.w	15,2
	dc.b	$F8,$00
	dc.b	$A8,$00
	dc.b	$98,$00
	dc.b	$C8,$00
	dc.b	$A8,$00
	dc.b	$9F,$C0
	dc.b	$C9,$40
	dc.b	$A4,$C0
	dc.b	$92,$40
	dc.b	$FD,$40
	dc.b	$04,$C0
	dc.b	$06,$40
	dc.b	$05,$40
	dc.b	$04,$C0
	dc.b	$07,$C0

	even
t:	dc.w	10,2
	dc.b	$07,$C0
	dc.b	$06,$C0
	dc.b	$05,$C0
	dc.b	$07,$40
	dc.b	$06,$C0
	dc.b	$FD,$FE
	dc.b	$DB,$6E
	dc.b	$B6,$DA
	dc.b	$ED,$B6
	dc.b	$FF,$FE

	even
	dc.w	10,2
	dc.b	$07,$C0
	dc.b	$05,$40
	dc.b	$06,$40
	dc.b	$04,$C0
	dc.b	$05,$40
	dc.b	$FE,$7E
	dc.b	$A4,$92
	dc.b	$C9,$26
	dc.b	$92,$4A
	dc.b	$FF,$FE

	even
	dc.w	15,2
	dc.b	$F8,$00
	dc.b	$D8,$00
	dc.b	$E8,$00
	dc.b	$B8,$00
	dc.b	$D8,$00
	dc.b	$EF,$C0
	dc.b	$B6,$C0
	dc.b	$DB,$40
	dc.b	$ED,$C0
	dc.b	$BF,$C0
	dc.b	$D8,$00
	dc.b	$E8,$00
	dc.b	$B8,$00
	dc.b	$D8,$00
	dc.b	$F8,$00

	even
	dc.w	15,2
	dc.b	$F8,$00
	dc.b	$A8,$00
	dc.b	$98,$00
	dc.b	$C8,$00
	dc.b	$A8,$00
	dc.b	$9F,$C0
	dc.b	$C9,$40
	dc.b	$A4,$C0
	dc.b	$92,$40
	dc.b	$CF,$C0
	dc.b	$A8,$00
	dc.b	$98,$00
	dc.b	$C8,$00
	dc.b	$A8,$00
	dc.b	$F8,$00

	even
	dc.w	10,2
	dc.b	$FF,$FE
	dc.b	$DB,$6E
	dc.b	$B6,$DA
	dc.b	$ED,$B6
	dc.b	$FF,$7E
	dc.b	$06,$C0
	dc.b	$05,$C0
	dc.b	$07,$40
	dc.b	$06,$C0
	dc.b	$07,$C0

	even
	dc.w	10,2
	dc.b	$FF,$FE
	dc.b	$A4,$92
	dc.b	$C9,$26
	dc.b	$92,$4A
	dc.b	$FC,$FE
	dc.b	$05,$40
	dc.b	$06,$40
	dc.b	$04,$C0
	dc.b	$05,$40
	dc.b	$07,$C0

	even
	dc.w	15,2
	dc.b	$07,$C0
	dc.b	$06,$C0
	dc.b	$07,$40
	dc.b	$05,$C0
	dc.b	$06,$C0
	dc.b	$FF,$40
	dc.b	$ED,$C0
	dc.b	$B6,$C0
	dc.b	$DB,$40
	dc.b	$FD,$C0
	dc.b	$06,$C0
	dc.b	$07,$40
	dc.b	$05,$C0
	dc.b	$06,$C0
	dc.b	$07,$C0

	even
	dc.w	15,2
	dc.b	$07,$C0
	dc.b	$05,$40
	dc.b	$04,$C0
	dc.b	$06,$40
	dc.b	$05,$40
	dc.b	$FC,$C0
	dc.b	$92,$40
	dc.b	$C9,$40
	dc.b	$A4,$C0
	dc.b	$FE,$40
	dc.b	$05,$40
	dc.b	$04,$C0
	dc.b	$06,$40
	dc.b	$05,$40
	dc.b	$07,$C0

	even
z:	dc.w	10,2
	dc.b	$FF,$C0
	dc.b	$ED,$C0
	dc.b	$DB,$40
	dc.b	$B6,$C0
	dc.b	$FD,$C0
	dc.b	$07,$7E
	dc.b	$06,$DA
	dc.b	$05,$B6
	dc.b	$07,$6E
	dc.b	$07,$FE

	even
	dc.w	10,2
	dc.b	$FF,$C0
	dc.b	$92,$40
	dc.b	$A4,$C0
	dc.b	$C9,$40
	dc.b	$FE,$40
	dc.b	$04,$FE
	dc.b	$05,$26
	dc.b	$06,$4A
	dc.b	$04,$92
	dc.b	$07,$FE

	even
	dc.w	15,2
	dc.b	$07,$C0
	dc.b	$05,$C0
	dc.b	$06,$C0
	dc.b	$07,$40
	dc.b	$05,$C0
	dc.b	$FE,$C0
	dc.b	$DB,$40
	dc.b	$ED,$C0
	dc.b	$B6,$C0
	dc.b	$DF,$C0
	dc.b	$E8,$00
	dc.b	$B8,$00
	dc.b	$D8,$00
	dc.b	$E8,$00
	dc.b	$F8,$00

	even
	dc.w	15,2
	dc.b	$07,$C0
	dc.b	$06,$40
	dc.b	$05,$40
	dc.b	$04,$C0
	dc.b	$06,$40
	dc.b	$FD,$40
	dc.b	$A4,$C0
	dc.b	$92,$40
	dc.b	$C9,$40
	dc.b	$AF,$C0
	dc.b	$98,$00
	dc.b	$C8,$00
	dc.b	$A8,$00
	dc.b	$98,$00
	dc.b	$F8,$00

	even
BackgroundLight:
	dc.w	16,2
	dc.b	$08,$00
	dc.b	$80,$00
	dc.b	$80,$48
	dc.b	$C0,$00
	dc.b	$53,$8A
	dc.b	$00,$81
	dc.b	$00,$19
	dc.b	$00,$08
	dc.b	$64,$60
	dc.b	$01,$20
	dc.b	$00,$80
	dc.b	$8C,$04
	dc.b	$C0,$06
	dc.b	$40,$40
	dc.b	$04,$E0
	dc.b	$10,$30

	even
BackgroundDark:
	dc.w	16,2
	dc.b	$FF,$F3
	dc.b	$3F,$FF
	dc.b	$07,$75
	dc.b	$24,$FF
	dc.b	$5C,$37
	dc.b	$2F,$3F
	dc.b	$1C,$77
	dc.b	$FF,$FE
	dc.b	$9F,$9E
	dc.b	$FF,$D3
	dc.b	$F3,$FF
	dc.b	$F3,$FB
	dc.b	$EF,$F9
	dc.b	$EF,$17
	dc.b	$FF,$1F
	dc.b	$EC,$91

	even
GenericSpriteMask:
	dc.w	5,1
	dc.b	$0,0,0,0,0

	end
