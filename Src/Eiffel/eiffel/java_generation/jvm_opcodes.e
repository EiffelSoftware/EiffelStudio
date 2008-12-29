note
	description: "list of all opcodes defined for the jvm"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	JVM_OPCODES

feature {NONE}
			
	oc_aaload: INTEGER = 0x32
	oc_aastore: INTEGER = 0x53
	oc_aconst_null: INTEGER = 0x01
	oc_aload: INTEGER = 0x19
	oc_aload_0: INTEGER = 0x2A
	oc_aload_1: INTEGER = 0x2B
	oc_aload_2: INTEGER = 0x2C
	oc_aload_3: INTEGER = 0x2D
	oc_anewarray: INTEGER = 0xBD
	oc_areturn: INTEGER = 0xB0
	oc_arraylength: INTEGER = 0xBE
	oc_astore: INTEGER = 0x3A
	oc_astore_0: INTEGER = 0x4B
	oc_astore_1: INTEGER = 0x4C
	oc_astore_2: INTEGER = 0x4D
	oc_astore_3: INTEGER = 0x4E
	oc_athrow: INTEGER = 0xBF
	oc_baload: INTEGER = 0x33
	oc_bastore: INTEGER = 0x54
	oc_bipush: INTEGER = 0x10
	oc_breakpoint: INTEGER = 0xCA
	oc_caload: INTEGER = 0x34
	oc_castore: INTEGER = 0x55
	oc_checkcast: INTEGER = 0xC0
	oc_d2f: INTEGER = 0x90
	oc_d2i: INTEGER = 0x8E
	oc_d2l: INTEGER = 0x8F
	oc_dadd: INTEGER = 0x63
	oc_daload: INTEGER = 0x31
	oc_dastore: INTEGER = 0x52
	oc_dcmpg: INTEGER = 0x98
	oc_dcmpl: INTEGER = 0x97
	oc_dconst_0: INTEGER = 0x0E
	oc_dconst_1: INTEGER = 0x0F
	oc_ddiv: INTEGER = 0x6F
	oc_dload: INTEGER = 0x18
	oc_dload_0: INTEGER = 0x26
	oc_dload_1: INTEGER = 0x27
	oc_dload_2: INTEGER = 0x28
	oc_dload_3: INTEGER = 0x29
	oc_dmul: INTEGER = 0x6B
	oc_dneg: INTEGER = 0x77
	oc_drem: INTEGER = 0x73
	oc_dreturn: INTEGER = 0xAF
	oc_dstore: INTEGER = 0x39
	oc_dstore_0: INTEGER = 0x47
	oc_dstore_1: INTEGER = 0x48
	oc_dstore_2: INTEGER = 0x49
	oc_dstore_3: INTEGER = 0x4A
	oc_dsub: INTEGER = 0x67
	oc_dup: INTEGER = 0x59
	oc_dup2: INTEGER = 0x5C
	oc_dup2_x1: INTEGER = 0x5D
	oc_dup2_x2: INTEGER = 0x5E
	oc_dup_x1: INTEGER = 0x5A
	oc_dup_x2: INTEGER = 0x5B
	oc_f2d: INTEGER = 0x8D
	oc_f2i: INTEGER = 0x8B
	oc_f2l: INTEGER = 0x8C
	oc_fadd: INTEGER = 0x62
	oc_faload: INTEGER = 0x30
	oc_fastore: INTEGER = 0x51
	oc_fcmpg: INTEGER = 0x96
	oc_fcmpl: INTEGER = 0x95
	oc_fconst_0: INTEGER = 0x0B
	oc_fconst_1: INTEGER = 0x0C
	oc_fconst_2: INTEGER = 0x0D
	oc_fdiv: INTEGER = 0x6E
	oc_fload: INTEGER = 0x17
	oc_fload_0: INTEGER = 0x22
	oc_fload_1: INTEGER = 0x23
	oc_fload_2: INTEGER = 0x24
	oc_fload_3: INTEGER = 0x25
	oc_fmul: INTEGER = 0x6A
	oc_fneg: INTEGER = 0x72
	oc_frem: INTEGER = 0x72
	oc_freturn: INTEGER = 0xAE
	oc_fstore: INTEGER = 0x38
	oc_fstore_0: INTEGER = 0x43
	oc_fstore_1: INTEGER = 0x44
	oc_fstore_2: INTEGER = 0x45
	oc_fstore_3: INTEGER = 0x46
	oc_fsub: INTEGER = 0x66
	oc_getfield: INTEGER = 0xB4
	oc_getstatic: INTEGER = 0xB2
	oc_goto: INTEGER = 0xA7
	oc_goto_w: INTEGER = 0xC8
	oc_i2b: INTEGER = 0x91
	oc_i2c: INTEGER = 0x92
	oc_i2d: INTEGER = 0x87
	oc_i2f: INTEGER = 0x86
	oc_i2l: INTEGER = 0x85
	oc_i2s: INTEGER = 0x93
	oc_iadd: INTEGER = 0x60
	oc_iaload: INTEGER = 0x2E
	oc_iand: INTEGER = 0x7E
	oc_iastore: INTEGER = 0x4F
	oc_iconst_0: INTEGER = 0x03
	oc_iconst_1: INTEGER = 0x04
	oc_iconst_2: INTEGER = 0x05
	oc_iconst_3: INTEGER = 0x06
	oc_iconst_4: INTEGER = 0x07
	oc_iconst_5: INTEGER = 0x08
	oc_iconst_m1: INTEGER = 0x02
	oc_idiv: INTEGER = 0x6C
	oc_if_acmpeq: INTEGER = 0xA5
	oc_if_acmpne: INTEGER = 0xA6
	oc_if_icmpeq: INTEGER = 0x9F
	oc_if_icmpge: INTEGER = 0xA2
	oc_if_icmpgt: INTEGER = 0xA3
	oc_if_icmple: INTEGER = 0xA4
	oc_if_icmplt: INTEGER = 0xA1
	oc_if_icmpne: INTEGER = 0xA0
	oc_ifeq: INTEGER = 0x99
	oc_ifge: INTEGER = 0x9C
	oc_ifgt: INTEGER = 0x9D
	oc_ifle: INTEGER = 0x9E
	oc_iflt: INTEGER = 0x9B
	oc_ifne: INTEGER = 0x9A
	oc_ifnonnull: INTEGER = 0xC7
	oc_ifnull: INTEGER = 0xC6
	oc_iinc: INTEGER = 0x84
	oc_iload: INTEGER = 0x15
	oc_iload_0: INTEGER = 0x1A
	oc_iload_1: INTEGER = 0x1B
	oc_iload_2: INTEGER = 0x1C
	oc_iload_3: INTEGER = 0x1D
	oc_impdep1: INTEGER = 0xFE
	oc_impdep2: INTEGER = 0xFF
	oc_imul: INTEGER = 0x68
	oc_ineg: INTEGER = 0x74
	oc_instanceof: INTEGER = 0xC1
	oc_invokeinterface: INTEGER = 0xB9
	oc_invokespecial: INTEGER = 0xB7
	oc_invokestatic: INTEGER = 0xB8
	oc_invokevirtual: INTEGER = 0xB6
	oc_ior: INTEGER = 0x80
	oc_irem: INTEGER = 0x70
	oc_ireturn: INTEGER = 0xAC
	oc_ishl: INTEGER = 0x78
	oc_ishr: INTEGER = 0x7A
	oc_istore: INTEGER = 0x36
	oc_istore_0: INTEGER = 0x3B
	oc_istore_1: INTEGER = 0x3C
	oc_istore_2: INTEGER = 0x3D
	oc_istore_3: INTEGER = 0x3E
	oc_isub: INTEGER = 0x64
	oc_iushr: INTEGER = 0x7C
	oc_ixor: INTEGER = 0x82
	oc_jsr: INTEGER = 0xA8
	oc_jsr_w: INTEGER = 0xC9
	oc_l2d: INTEGER = 0x8A
	oc_l2f: INTEGER = 0x89
	oc_l2i: INTEGER = 0x88
	oc_ladd: INTEGER = 0x61
	oc_laload: INTEGER = 0x2F
	oc_land: INTEGER = 0x74
	oc_lastore: INTEGER = 0x50
	oc_lcmp: INTEGER = 0x94
	oc_lconst_0: INTEGER = 0x09
	oc_lconst_1: INTEGER = 0x0A
	oc_ldc: INTEGER = 0x12
	oc_ldc_w: INTEGER = 0x13
	oc_ldc2_w: INTEGER = 0x14
	oc_ldiv: INTEGER = 0x6D
	oc_lload: INTEGER = 0x16
	oc_lload_0: INTEGER = 0x1E
	oc_lload_1: INTEGER = 0x1F
	oc_lload_2: INTEGER = 0x20
	oc_lload_3: INTEGER = 0x21
	oc_lmul: INTEGER = 0x69
	oc_lneg: INTEGER = 0x75
	oc_lookupswitch: INTEGER = 0xAB
	oc_lor: INTEGER = 0x81
	oc_lrem: INTEGER = 0x71
	oc_lreturn: INTEGER = 0xAD
	oc_lshl: INTEGER = 0x79
	oc_lshr: INTEGER = 0x7B
	oc_lstore: INTEGER = 0x37
	oc_lstore_0: INTEGER = 0x3F
	oc_lstore_1: INTEGER = 0x40
	oc_lstore_2: INTEGER = 0x41
	oc_lstore_3: INTEGER = 0x42
	oc_lsub: INTEGER = 0x65
	oc_lushr: INTEGER = 0x7D
	oc_lxor: INTEGER = 0x83
	oc_monitorenter: INTEGER = 0xC2
	oc_monitorexit: INTEGER = 0xC3
	oc_multianewarray: INTEGER = 0xC5
	oc_new: INTEGER = 0xBB
	oc_newarray: INTEGER = 0xBC
	oc_nop: INTEGER = 0x00
	oc_pop: INTEGER = 0x57
	oc_pop2: INTEGER = 0x58
	oc_putfield: INTEGER = 0xB5
	oc_putstatic: INTEGER = 0xB3
	oc_ret: INTEGER = 0xA9
	oc_return: INTEGER = 0xB1
	oc_saload: INTEGER = 0x35
	oc_sastore: INTEGER = 0x56
	oc_sipush: INTEGER = 0x11
	oc_swap: INTEGER = 0x5F
	oc_tableswitch: INTEGER = 0xAA
	oc_wide: INTEGER = 0xC4;
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

end
