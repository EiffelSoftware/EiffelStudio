indexing
	description: "list of all opcodes defined for the jvm"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	JVM_OPCODES

feature {NONE}
			
	oc_aaload: INTEGER is 0x32
	oc_aastore: INTEGER is 0x53
	oc_aconst_null: INTEGER is 0x01
	oc_aload: INTEGER is 0x19
	oc_aload_0: INTEGER is 0x2A
	oc_aload_1: INTEGER is 0x2B
	oc_aload_2: INTEGER is 0x2C
	oc_aload_3: INTEGER is 0x2D
	oc_anewarray: INTEGER is 0xBD
	oc_areturn: INTEGER is 0xB0
	oc_arraylength: INTEGER is 0xBE
	oc_astore: INTEGER is 0x3A
	oc_astore_0: INTEGER is 0x4B
	oc_astore_1: INTEGER is 0x4C
	oc_astore_2: INTEGER is 0x4D
	oc_astore_3: INTEGER is 0x4E
	oc_athrow: INTEGER is 0xBF
	oc_baload: INTEGER is 0x33
	oc_bastore: INTEGER is 0x54
	oc_bipush: INTEGER is 0x10
	oc_breakpoint: INTEGER is 0xCA
	oc_caload: INTEGER is 0x34
	oc_castore: INTEGER is 0x55
	oc_checkcast: INTEGER is 0xC0
	oc_d2f: INTEGER is 0x90
	oc_d2i: INTEGER is 0x8E
	oc_d2l: INTEGER is 0x8F
	oc_dadd: INTEGER is 0x63
	oc_daload: INTEGER is 0x31
	oc_dastore: INTEGER is 0x52
	oc_dcmpg: INTEGER is 0x98
	oc_dcmpl: INTEGER is 0x97
	oc_dconst_0: INTEGER is 0x0E
	oc_dconst_1: INTEGER is 0x0F
	oc_ddiv: INTEGER is 0x6F
	oc_dload: INTEGER is 0x18
	oc_dload_0: INTEGER is 0x26
	oc_dload_1: INTEGER is 0x27
	oc_dload_2: INTEGER is 0x28
	oc_dload_3: INTEGER is 0x29
	oc_dmul: INTEGER is 0x6B
	oc_dneg: INTEGER is 0x77
	oc_drem: INTEGER is 0x73
	oc_dreturn: INTEGER is 0xAF
	oc_dstore: INTEGER is 0x39
	oc_dstore_0: INTEGER is 0x47
	oc_dstore_1: INTEGER is 0x48
	oc_dstore_2: INTEGER is 0x49
	oc_dstore_3: INTEGER is 0x4A
	oc_dsub: INTEGER is 0x67
	oc_dup: INTEGER is 0x59
	oc_dup2: INTEGER is 0x5C
	oc_dup2_x1: INTEGER is 0x5D
	oc_dup2_x2: INTEGER is 0x5E
	oc_dup_x1: INTEGER is 0x5A
	oc_dup_x2: INTEGER is 0x5B
	oc_f2d: INTEGER is 0x8D
	oc_f2i: INTEGER is 0x8B
	oc_f2l: INTEGER is 0x8C
	oc_fadd: INTEGER is 0x62
	oc_faload: INTEGER is 0x30
	oc_fastore: INTEGER is 0x51
	oc_fcmpg: INTEGER is 0x96
	oc_fcmpl: INTEGER is 0x95
	oc_fconst_0: INTEGER is 0x0B
	oc_fconst_1: INTEGER is 0x0C
	oc_fconst_2: INTEGER is 0x0D
	oc_fdiv: INTEGER is 0x6E
	oc_fload: INTEGER is 0x17
	oc_fload_0: INTEGER is 0x22
	oc_fload_1: INTEGER is 0x23
	oc_fload_2: INTEGER is 0x24
	oc_fload_3: INTEGER is 0x25
	oc_fmul: INTEGER is 0x6A
	oc_fneg: INTEGER is 0x72
	oc_frem: INTEGER is 0x72
	oc_freturn: INTEGER is 0xAE
	oc_fstore: INTEGER is 0x38
	oc_fstore_0: INTEGER is 0x43
	oc_fstore_1: INTEGER is 0x44
	oc_fstore_2: INTEGER is 0x45
	oc_fstore_3: INTEGER is 0x46
	oc_fsub: INTEGER is 0x66
	oc_getfield: INTEGER is 0xB4
	oc_getstatic: INTEGER is 0xB2
	oc_goto: INTEGER is 0xA7
	oc_goto_w: INTEGER is 0xC8
	oc_i2b: INTEGER is 0x91
	oc_i2c: INTEGER is 0x92
	oc_i2d: INTEGER is 0x87
	oc_i2f: INTEGER is 0x86
	oc_i2l: INTEGER is 0x85
	oc_i2s: INTEGER is 0x93
	oc_iadd: INTEGER is 0x60
	oc_iaload: INTEGER is 0x2E
	oc_iand: INTEGER is 0x7E
	oc_iastore: INTEGER is 0x4F
	oc_iconst_0: INTEGER is 0x03
	oc_iconst_1: INTEGER is 0x04
	oc_iconst_2: INTEGER is 0x05
	oc_iconst_3: INTEGER is 0x06
	oc_iconst_4: INTEGER is 0x07
	oc_iconst_5: INTEGER is 0x08
	oc_iconst_m1: INTEGER is 0x02
	oc_idiv: INTEGER is 0x6C
	oc_if_acmpeq: INTEGER is 0xA5
	oc_if_acmpne: INTEGER is 0xA6
	oc_if_icmpeq: INTEGER is 0x9F
	oc_if_icmpge: INTEGER is 0xA2
	oc_if_icmpgt: INTEGER is 0xA3
	oc_if_icmple: INTEGER is 0xA4
	oc_if_icmplt: INTEGER is 0xA1
	oc_if_icmpne: INTEGER is 0xA0
	oc_ifeq: INTEGER is 0x99
	oc_ifge: INTEGER is 0x9C
	oc_ifgt: INTEGER is 0x9D
	oc_ifle: INTEGER is 0x9E
	oc_iflt: INTEGER is 0x9B
	oc_ifne: INTEGER is 0x9A
	oc_ifnonnull: INTEGER is 0xC7
	oc_ifnull: INTEGER is 0xC6
	oc_iinc: INTEGER is 0x84
	oc_iload: INTEGER is 0x15
	oc_iload_0: INTEGER is 0x1A
	oc_iload_1: INTEGER is 0x1B
	oc_iload_2: INTEGER is 0x1C
	oc_iload_3: INTEGER is 0x1D
	oc_impdep1: INTEGER is 0xFE
	oc_impdep2: INTEGER is 0xFF
	oc_imul: INTEGER is 0x68
	oc_ineg: INTEGER is 0x74
	oc_instanceof: INTEGER is 0xC1
	oc_invokeinterface: INTEGER is 0xB9
	oc_invokespecial: INTEGER is 0xB7
	oc_invokestatic: INTEGER is 0xB8
	oc_invokevirtual: INTEGER is 0xB6
	oc_ior: INTEGER is 0x80
	oc_irem: INTEGER is 0x70
	oc_ireturn: INTEGER is 0xAC
	oc_ishl: INTEGER is 0x78
	oc_ishr: INTEGER is 0x7A
	oc_istore: INTEGER is 0x36
	oc_istore_0: INTEGER is 0x3B
	oc_istore_1: INTEGER is 0x3C
	oc_istore_2: INTEGER is 0x3D
	oc_istore_3: INTEGER is 0x3E
	oc_isub: INTEGER is 0x64
	oc_iushr: INTEGER is 0x7C
	oc_ixor: INTEGER is 0x82
	oc_jsr: INTEGER is 0xA8
	oc_jsr_w: INTEGER is 0xC9
	oc_l2d: INTEGER is 0x8A
	oc_l2f: INTEGER is 0x89
	oc_l2i: INTEGER is 0x88
	oc_ladd: INTEGER is 0x61
	oc_laload: INTEGER is 0x2F
	oc_land: INTEGER is 0x74
	oc_lastore: INTEGER is 0x50
	oc_lcmp: INTEGER is 0x94
	oc_lconst_0: INTEGER is 0x09
	oc_lconst_1: INTEGER is 0x0A
	oc_ldc: INTEGER is 0x12
	oc_ldc_w: INTEGER is 0x13
	oc_ldc2_w: INTEGER is 0x14
	oc_ldiv: INTEGER is 0x6D
	oc_lload: INTEGER is 0x16
	oc_lload_0: INTEGER is 0x1E
	oc_lload_1: INTEGER is 0x1F
	oc_lload_2: INTEGER is 0x20
	oc_lload_3: INTEGER is 0x21
	oc_lmul: INTEGER is 0x69
	oc_lneg: INTEGER is 0x75
	oc_lookupswitch: INTEGER is 0xAB
	oc_lor: INTEGER is 0x81
	oc_lrem: INTEGER is 0x71
	oc_lreturn: INTEGER is 0xAD
	oc_lshl: INTEGER is 0x79
	oc_lshr: INTEGER is 0x7B
	oc_lstore: INTEGER is 0x37
	oc_lstore_0: INTEGER is 0x3F
	oc_lstore_1: INTEGER is 0x40
	oc_lstore_2: INTEGER is 0x41
	oc_lstore_3: INTEGER is 0x42
	oc_lsub: INTEGER is 0x65
	oc_lushr: INTEGER is 0x7D
	oc_lxor: INTEGER is 0x83
	oc_monitorenter: INTEGER is 0xC2
	oc_monitorexit: INTEGER is 0xC3
	oc_multianewarray: INTEGER is 0xC5
	oc_new: INTEGER is 0xBB
	oc_newarray: INTEGER is 0xBC
	oc_nop: INTEGER is 0x00
	oc_pop: INTEGER is 0x57
	oc_pop2: INTEGER is 0x58
	oc_putfield: INTEGER is 0xB5
	oc_putstatic: INTEGER is 0xB3
	oc_ret: INTEGER is 0xA9
	oc_return: INTEGER is 0xB1
	oc_saload: INTEGER is 0x35
	oc_sastore: INTEGER is 0x56
	oc_sipush: INTEGER is 0x11
	oc_swap: INTEGER is 0x5F
	oc_tableswitch: INTEGER is 0xAA
	oc_wide: INTEGER is 0xC4;
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
