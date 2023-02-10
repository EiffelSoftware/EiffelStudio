note
	description: "List of available opcodes"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_MD_OPCODES

feature -- Access: one byte opcodes

	nop: INTEGER_16 = 0x0000
	break: INTEGER_16 = 0x0001
	ldarg_0: INTEGER_16 = 0x0002
	ldarg_1: INTEGER_16 = 0x0003
	ldarg_2: INTEGER_16 = 0x0004
	ldarg_3: INTEGER_16 = 0x0005
	ldloc_0: INTEGER_16 = 0x0006
	ldloc_1: INTEGER_16 = 0x0007
	ldloc_2: INTEGER_16 = 0x0008
	ldloc_3: INTEGER_16 = 0x0009
	stloc_0: INTEGER_16 = 0x000A
	stloc_1: INTEGER_16 = 0x000B
	stloc_2: INTEGER_16 = 0x000C
	stloc_3: INTEGER_16 = 0x000D
	ldarg_s: INTEGER_16 = 0x000E
	ldarga_s: INTEGER_16 = 0x000F
	starg_s: INTEGER_16 = 0x0010
	ldloc_s: INTEGER_16 = 0x0011
	ldloca_s: INTEGER_16 = 0x0012
	stloc_s: INTEGER_16 = 0x0013
	ldnull: INTEGER_16 = 0x0014
	ldc_i4_m1: INTEGER_16 = 0x0015
	ldc_i4_0: INTEGER_16 = 0x0016
	ldc_i4_1: INTEGER_16 = 0x0017
	ldc_i4_2: INTEGER_16 = 0x0018
	ldc_i4_3: INTEGER_16 = 0x0019
	ldc_i4_4: INTEGER_16 = 0x001A
	ldc_i4_5: INTEGER_16 = 0x001B
	ldc_i4_6: INTEGER_16 = 0x001C
	ldc_i4_7: INTEGER_16 = 0x001D
	ldc_i4_8: INTEGER_16 = 0x001E
	ldc_i4_s: INTEGER_16 = 0x001F
	ldc_i4: INTEGER_16 = 0x0020
	ldc_i8: INTEGER_16 = 0x0021
	ldc_r4: INTEGER_16 = 0x0022
	ldc_r8: INTEGER_16 = 0x0023
	unused49: INTEGER_16 = 0x0024
	dup: INTEGER_16 = 0x0025
	pop: INTEGER_16 = 0x0026
	jmp: INTEGER_16 = 0x0027
	call: INTEGER_16 = 0x0028
	calli: INTEGER_16 = 0x0029
	ret: INTEGER_16 = 0x002A
	br_s: INTEGER_16 = 0x002B
	brfalse_s, brnull_s, brzero_s: INTEGER_16 = 0x002C
	brtrue_s, brinst_s: INTEGER_16 = 0x002D
	beq_s: INTEGER_16 = 0x002E
	bge_s: INTEGER_16 = 0x002F
	bgt_s: INTEGER_16 = 0x0030
	ble_s: INTEGER_16 = 0x0031
	blt_s: INTEGER_16 = 0x0032
	bne_un_s: INTEGER_16 = 0x0033
	bge_un_s: INTEGER_16 = 0x0034
	bgt_un_s: INTEGER_16 = 0x0035
	ble_un_s: INTEGER_16 = 0x0036
	blt_un_s: INTEGER_16 = 0x0037
	br: INTEGER_16 = 0x0038
	brfalse, brnull, brzero: INTEGER_16 = 0x0039
	brtrue, brinst: INTEGER_16 = 0x003A
	beq: INTEGER_16 = 0x003B
	bge: INTEGER_16 = 0x003C
	bgt: INTEGER_16 = 0x003D
	ble: INTEGER_16 = 0x003E
	blt: INTEGER_16 = 0x003F
	bne_un: INTEGER_16 = 0x0040
	bge_un: INTEGER_16 = 0x0041
	bgt_un: INTEGER_16 = 0x0042
	ble_un: INTEGER_16 = 0x0043
	blt_un: INTEGER_16 = 0x0044
	switch: INTEGER_16 = 0x0045
	ldind_i1: INTEGER_16 = 0x0046
	ldind_u1: INTEGER_16 = 0x0047
	ldind_i2: INTEGER_16 = 0x0048
	ldind_u2: INTEGER_16 = 0x0049
	ldind_i4: INTEGER_16 = 0x004A
	ldind_u4: INTEGER_16 = 0x004B
	ldind_i8, ldind_u8: INTEGER_16 = 0x004C
	ldind_i: INTEGER_16 = 0x004D
	ldind_r4: INTEGER_16 = 0x004E
	ldind_r8: INTEGER_16 = 0x004F
	ldind_ref: INTEGER_16 = 0x0050
	stind_ref: INTEGER_16 = 0x0051
	stind_i1: INTEGER_16 = 0x0052
	stind_i2: INTEGER_16 = 0x0053
	stind_i4: INTEGER_16 = 0x0054
	stind_i8: INTEGER_16 = 0x0055
	stind_r4: INTEGER_16 = 0x0056
	stind_r8: INTEGER_16 = 0x0057
	add: INTEGER_16 = 0x0058
	sub: INTEGER_16 = 0x0059
	mul: INTEGER_16 = 0x005A
	div: INTEGER_16 = 0x005B
	div_un: INTEGER_16 = 0x005C
	rem: INTEGER_16 = 0x005D
	rem_un: INTEGER_16 = 0x005E
	and_opcode: INTEGER_16 = 0x005F
	or_opcode: INTEGER_16 = 0x0060
	xor_opcode: INTEGER_16 = 0x0061
	shl: INTEGER_16 = 0x0062
	shr: INTEGER_16 = 0x0063
	shr_un: INTEGER_16 = 0x0064
	neg: INTEGER_16 = 0x0065
	not_opcode: INTEGER_16 = 0x0066
	conv_i1: INTEGER_16 = 0x0067
	conv_i2: INTEGER_16 = 0x0068
	conv_i4: INTEGER_16 = 0x0069
	conv_i8: INTEGER_16 = 0x006A
	conv_r4: INTEGER_16 = 0x006B
	conv_r8: INTEGER_16 = 0x006C
	conv_u4: INTEGER_16 = 0x006D
	conv_u8: INTEGER_16 = 0x006E
	callvirt: INTEGER_16 = 0x006F
	cpobj: INTEGER_16 = 0x0070
	ldobj: INTEGER_16 = 0x0071
	ldstr: INTEGER_16 = 0x0072
	newobj: INTEGER_16 = 0x0073
	castclass: INTEGER_16 = 0x0074
	isinst: INTEGER_16 = 0x0075
	conv_r_un: INTEGER_16 = 0x0076
	unused58: INTEGER_16 = 0x0077
	unused1: INTEGER_16 = 0x0078
	unbox: INTEGER_16 = 0x0079
	throw: INTEGER_16 = 0x007A
	ldfld: INTEGER_16 = 0x007B
	ldflda: INTEGER_16 = 0x007C
	stfld: INTEGER_16 = 0x007D
	ldsfld: INTEGER_16 = 0x007E
	ldsflda: INTEGER_16 = 0x007F
	stsfld: INTEGER_16 = 0x0080
	stobj: INTEGER_16 = 0x0081
	conv_ovf_i1_un: INTEGER_16 = 0x0082
	conv_ovf_i2_un: INTEGER_16 = 0x0083
	conv_ovf_i4_un: INTEGER_16 = 0x0084
	conv_ovf_i8_un: INTEGER_16 = 0x0085
	conv_ovf_u1_un: INTEGER_16 = 0x0086
	conv_ovf_u2_un: INTEGER_16 = 0x0087
	conv_ovf_u4_un: INTEGER_16 = 0x0088
	conv_ovf_u8_un: INTEGER_16 = 0x0089
	conv_ovf_i_un: INTEGER_16 = 0x008A
	conv_ovf_u_un: INTEGER_16 = 0x008B
	box: INTEGER_16 = 0x008C
	newarr: INTEGER_16 = 0x008D
	ldlen: INTEGER_16 = 0x008E
	ldelema: INTEGER_16 = 0x008F
	ldelem_i1: INTEGER_16 = 0x0090
	ldelem_u1: INTEGER_16 = 0x0091
	ldelem_i2: INTEGER_16 = 0x0092
	ldelem_u2: INTEGER_16 = 0x0093
	ldelem_i4: INTEGER_16 = 0x0094
	ldelem_u4: INTEGER_16 = 0x0095
	ldelem_i8, ldelem_u8: INTEGER_16 = 0x0096
	ldelem_i: INTEGER_16 = 0x0097
	ldelem_r4: INTEGER_16 = 0x0098
	ldelem_r8: INTEGER_16 = 0x0099
	ldelem_ref: INTEGER_16 = 0x009A
	stelem_i: INTEGER_16 = 0x009B
	stelem_i1: INTEGER_16 = 0x009C
	stelem_i2: INTEGER_16 = 0x009D
	stelem_i4: INTEGER_16 = 0x009E
	stelem_i8: INTEGER_16 = 0x009F
	stelem_r4: INTEGER_16 = 0x00A0
	stelem_r8: INTEGER_16 = 0x00A1
	stelem_ref: INTEGER_16 = 0x00A2
	unused2: INTEGER_16 = 0x00A3
	unused3: INTEGER_16 = 0x00A4
	unused4: INTEGER_16 = 0x00A5
	unused5: INTEGER_16 = 0x00A6
	unused6: INTEGER_16 = 0x00A7
	unused7: INTEGER_16 = 0x00A8
	unused8: INTEGER_16 = 0x00A9
	unused9: INTEGER_16 = 0x00AA
	unused10: INTEGER_16 = 0x00AB
	unused11: INTEGER_16 = 0x00AC
	unused12: INTEGER_16 = 0x00AD
	unused13: INTEGER_16 = 0x00AE
	unused14: INTEGER_16 = 0x00AF
	unused15: INTEGER_16 = 0x00B0
	unused16: INTEGER_16 = 0x00B1
	unused17: INTEGER_16 = 0x00B2
	conv_ovf_i1: INTEGER_16 = 0x00B3
	conv_ovf_u1: INTEGER_16 = 0x00B4
	conv_ovf_i2: INTEGER_16 = 0x00B5
	conv_ovf_u2: INTEGER_16 = 0x00B6
	conv_ovf_i4: INTEGER_16 = 0x00B7
	conv_ovf_u4: INTEGER_16 = 0x00B8
	conv_ovf_i8: INTEGER_16 = 0x00B9
	conv_ovf_u8: INTEGER_16 = 0x00BA
	unused50: INTEGER_16 = 0x00BB
	unused18: INTEGER_16 = 0x00BC
	unused19: INTEGER_16 = 0x00BD
	unused20: INTEGER_16 = 0x00BE
	unused21: INTEGER_16 = 0x00BF
	unused22: INTEGER_16 = 0x00C0
	unused23: INTEGER_16 = 0x00C1
	refanyval: INTEGER_16 = 0x00C2
	ckfinite: INTEGER_16 = 0x00C3
	unused24: INTEGER_16 = 0x00C4
	unused25: INTEGER_16 = 0x00C5
	mkrefany: INTEGER_16 = 0x00C6
	unused59: INTEGER_16 = 0x00C7
	unused60: INTEGER_16 = 0x00C8
	unused61: INTEGER_16 = 0x00C9
	unused62: INTEGER_16 = 0x00CA
	unused63: INTEGER_16 = 0x00CB
	unused64: INTEGER_16 = 0x00CC
	unused65: INTEGER_16 = 0x00CD
	unused66: INTEGER_16 = 0x00CE
	unused67: INTEGER_16 = 0x00CF
	ldtoken: INTEGER_16 = 0x00D0
	conv_u2: INTEGER_16 = 0x00D1
	conv_u1: INTEGER_16 = 0x00D2
	conv_i: INTEGER_16 = 0x00D3
	conv_ovf_i: INTEGER_16 = 0x00D4
	conv_ovf_u: INTEGER_16 = 0x00D5
	add_ovf: INTEGER_16 = 0x00D6
	add_ovf_un: INTEGER_16 = 0x00D7
	mul_ovf: INTEGER_16 = 0x00D8
	mul_ovf_un: INTEGER_16 = 0x00D9
	sub_ovf: INTEGER_16 = 0x00DA
	sub_ovf_un: INTEGER_16 = 0x00DB
	endfinally, endfault: INTEGER_16 = 0x00DC
	leave: INTEGER_16 = 0x00DD
	leave_s: INTEGER_16 = 0x00DE
	stind_i: INTEGER_16 = 0x00DF
	conv_u: INTEGER_16 = 0x00E0
	unused26: INTEGER_16 = 0x00E1
	unused27: INTEGER_16 = 0x00E2
	unused28: INTEGER_16 = 0x00E3
	unused29: INTEGER_16 = 0x00E4
	unused30: INTEGER_16 = 0x00E5
	unused31: INTEGER_16 = 0x00E6
	unused32: INTEGER_16 = 0x00E7
	unused33: INTEGER_16 = 0x00E8
	unused34: INTEGER_16 = 0x00E9
	unused35: INTEGER_16 = 0x00EA
	unused36: INTEGER_16 = 0x00EB
	unused37: INTEGER_16 = 0x00EC
	unused38: INTEGER_16 = 0x00ED
	unused39: INTEGER_16 = 0x00EE
	unused40: INTEGER_16 = 0x00EF
	unused41: INTEGER_16 = 0x00F0
	unused42: INTEGER_16 = 0x00F1
	unused43: INTEGER_16 = 0x00F2
	unused44: INTEGER_16 = 0x00F3
	unused45: INTEGER_16 = 0x00F4
	unused46: INTEGER_16 = 0x00F5
	unused47: INTEGER_16 = 0x00F6
	unused48: INTEGER_16 = 0x00F7
	prefix7: INTEGER_16 = 0x00F8
	prefix6: INTEGER_16 = 0x00F9
	prefix5: INTEGER_16 = 0x00FA
	prefix4: INTEGER_16 = 0x00FB
	prefix3: INTEGER_16 = 0x00FC
	prefix2: INTEGER_16 = 0x00FD
	prefix1: INTEGER_16 = 0x00FE
	prefixref: INTEGER_16 = 0x00FF

feature -- Access: two bytes opcodes

	arglist: INTEGER_16 = 0xFE00
	ceq: INTEGER_16 = 0xFE01
	cgt: INTEGER_16 = 0xFE02
	cgt_un: INTEGER_16 = 0xFE03
	clt: INTEGER_16 = 0xFE04
	clt_un: INTEGER_16 = 0xFE05
	ldftn: INTEGER_16 = 0xFE06
	ldvirtftn: INTEGER_16 = 0xFE07
	unused56: INTEGER_16 = 0xFE08
	ldarg: INTEGER_16 = 0xFE09
	ldarga: INTEGER_16 = 0xFE0A
	starg: INTEGER_16 = 0xFE0B
	ldloc: INTEGER_16 = 0xFE0C
	ldloca: INTEGER_16 = 0xFE0D
	stloc: INTEGER_16 = 0xFE0E
	localloc: INTEGER_16 = 0xFE0F
	unused57: INTEGER_16 = 0xFE10
	endfilter: INTEGER_16 = 0xFE11
	unaligned: INTEGER_16 = 0xFE12
	volatile: INTEGER_16 = 0xFE13
	tailcall: INTEGER_16 = 0xFE14
	initobj: INTEGER_16 = 0xFE15
	unused68: INTEGER_16 = 0xFE16
	cpblk: INTEGER_16 = 0xFE17
	initblk: INTEGER_16 = 0xFE18
	unused69: INTEGER_16 = 0xFE19
	rethrow: INTEGER_16 = 0xFE1A
	unused51: INTEGER_16 = 0xFE1B
	sizeof: INTEGER_16 = 0xFE1C
	refanytype: INTEGER_16 = 0xFE1D
	unused52: INTEGER_16 = 0xFE1E
	unused53: INTEGER_16 = 0xFE1F
	unused54: INTEGER_16 = 0xFE20
	unused55: INTEGER_16 = 0xFE21
	unused70: INTEGER_16 = 0xFE22;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CIL_MD_OPCODES
