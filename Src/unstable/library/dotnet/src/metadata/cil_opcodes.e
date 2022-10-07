note
	description: "Names of the Opcodes"
	date: "$Date$"
	revision: "$Revision$"
	see: "Table III.1: Opcode Encodings"

once class
	CIL_OPCODES

create

	i_unknown, -- This should never occur

	i_label, -- This instruction is a placeholder for a label

	i_comment, -- This instruction is a placeholder for a comment
	i_SEH, --This instruction is an SEH specifier
		--actual CIL instructions start here
	i_add, i_add_ovf, i_add_ovf_un, i_and, i_arglist, i_beq, i_beq_s, i_bge,
	i_bge_s, i_bge_un, i_bge_un_s, i_bgt, i_bgt_s, i_bgt_un, i_bgt_un_s, i_ble,
	i_ble_s, i_ble_un, i_ble_un_s, i_blt, i_blt_s, i_blt_un, i_blt_un_s, i_bne_un,
	i_bne_un_s, i_box, i_br, i_br_s, i_break, i_brfalse, i_brfalse_s, i_brinst,
	i_brinst_s, i_brnull, i_brnull_s, i_brtrue, i_brtrue_s, i_brzero, i_brzero_s, i_call,
	i_calli, i_callvirt, i_castclass, i_ceq, i_cgt, i_cgt_un, i_ckfinite, i_clt,
	i_clt_un, i_constrained_, i_conv_i, i_conv_i1, i_conv_i2, i_conv_i4, i_conv_i8, i_conv_ovf_i,
	i_conv_ovf_i_un, i_conv_ovf_i1, i_conv_ovf_i1_un, i_conv_ovf_i2, i_conv_ovf_i2_un, i_conv_ovf_i4, i_conv_ovf_i4_un, i_conv_ovf_i8,
	i_conv_ovf_i8_un, i_conv_ovf_u, i_conv_ovf_u_un, i_conv_ovf_u1, i_conv_ovf_u1_un, i_conv_ovf_u2, i_conv_ovf_u2_un, i_conv_ovf_u4,
	i_conv_ovf_u4_un, i_conv_ovf_u8, i_conv_ovf_u8_un, i_conv_r_un, i_conv_r4, i_conv_r8, i_conv_u, i_conv_u1,
	i_conv_u2, i_conv_u4, i_conv_u8, i_cpblk, i_cpobj, i_div, i_div_un, i_dup,
	i_endfault, i_endfilter, i_endfinally, i_initblk, i_initobj, i_isinst, i_jmp, i_ldarg,
	i_ldarg_0, i_ldarg_1, i_ldarg_2, i_ldarg_3, i_ldarg_s, i_ldarga, i_ldarga_s, i_ldc_i4,
	i_ldc_i4_0, i_ldc_i4_1, i_ldc_i4_2, i_ldc_i4_3, i_ldc_i4_4, i_ldc_i4_5, i_ldc_i4_6, i_ldc_i4_7,
	i_ldc_i4_8, i_ldc_i4_m1, i_ldc_i4_M1_, i_ldc_i4_s, i_ldc_i8, i_ldc_r4, i_ldc_r8, i_ldelem,
	i_ldelem_i, i_ldelem_i1, i_ldelem_i2, i_ldelem_i4, i_ldelem_i8, i_ldelem_r4, i_ldelem_r8, i_ldelem_ref,
	i_ldelem_u1, i_ldelem_u2, i_ldelem_u4, i_ldelem_u8, i_ldelema, i_ldfld, i_ldflda, i_ldftn,
	i_ldind_i, i_ldind_i1, i_ldind_i2, i_ldind_i4, i_ldind_i8, i_ldind_r4, i_ldind_r8, i_ldind_ref,
	i_ldind_u1, i_ldind_u2, i_ldind_u4, i_ldind_u8, i_ldlen, i_ldloc, i_ldloc_0, i_ldloc_1,
	i_ldloc_2, i_ldloc_3, i_ldloc_s, i_ldloca, i_ldloca_s, i_ldnull, i_ldobj, i_ldsfld,
	i_ldsflda, i_ldstr, i_ldtoken, i_ldvirtftn, i_leave, i_leave_s, i_localloc, i_mkrefany,
	i_mul, i_mul_ovf, i_mul_ovf_un, i_neg, i_newarr, i_newobj, i_no_, i_nop,
	i_not, i_or, i_pop, i_readonly_, i_refanytype, i_refanyval, i_rem, i_rem_un,
	i_ret, i_rethrow, i_shl, i_shr, i_shr_un, i_sizeof, i_starg, i_starg_s,
	i_stelem, i_stelem_i, i_stelem_i1, i_stelem_i2, i_stelem_i4, i_stelem_i8, i_stelem_r4, i_stelem_r8,
	i_stelem_ref, i_stfld, i_stind_i, i_stind_i1, i_stind_i2, i_stind_i4, i_stind_i8, i_stind_r4,
	i_stind_r8, i_stind_ref, i_stloc, i_stloc_0, i_stloc_1, i_stloc_2, i_stloc_3, i_stloc_s,
	i_stobj, i_stsfld, i_sub, i_sub_ovf, i_sub_ovf_un, i_switch, i_tail_, i_throw,
	i_unaligned_, i_unbox, i_unbox_any, i_volatile_, i_xor

feature {NONE} -- Creation

	i_unknown once index := 0 end
	i_label once index := 1 end
	i_comment once index := 2 end
	i_SEH once index := 3 end

		--actual CIL instructions start here
	i_add once index := 4 end
	i_add_ovf once index := 5 end
	i_add_ovf_un once index := 6 end

	i_and once index := 7 end

	i_arglist once index := 8 end

	i_beq once index := 9 end
	i_beq_s once index := 10 end

	i_bge once index := 11 end
	i_bge_s once index := 12 end
	i_bge_un once index := 13 end
	i_bge_un_s once index := 14 end

	i_bgt once index := 15 end
	i_bgt_s once index := 16 end
	i_bgt_un once index := 17 end
	i_bgt_un_s once index := 18 end

	i_ble once index := 19 end
	i_ble_s once index := 20 end
	i_ble_un once index := 21 end
	i_ble_un_s once index := 22 end

	i_blt once index := 23 end
	i_blt_s once index := 24 end
	i_blt_un once index := 25 end
	i_blt_un_s once index := 26 end

	i_bne_un once index := 27 end
	i_bne_un_s once index := 28 end

	i_box once index := 29 end

	i_br once index := 30 end
	i_br_s once index := 31 end

	i_break once index := 32 end

	i_brfalse once index := 33 end
	i_brfalse_s once index := 34 end

	i_brinst once index := 35 end
	i_brinst_s once index := 36 end

	i_brnull once index := 37 end
	i_brnull_s once index := 38 end

	i_brtrue once index := 39 end
	i_brtrue_s once index := 40 end

	i_brzero once index := 41 end
	i_brzero_s once index := 42 end

	i_call once index := 43 end
	i_calli once index := 44 end
	i_callvirt once index := 45 end

	i_castclass once index := 46 end

	i_ceq once index := 47 end

	i_cgt once index := 48 end
	i_cgt_un once index := 49 end

	i_ckfinite once index := 50 end

	i_clt once index := 51 end
	i_clt_un once index := 52 end

	i_constrained_ once index := 53 end

	i_conv_i once index := 54 end
	i_conv_i1 once index := 55 end
	i_conv_i2 once index := 56 end
	i_conv_i4 once index := 57 end
	i_conv_i8 once index := 58 end

	i_conv_ovf_i once index := 59 end
	i_conv_ovf_i_un once index := 60 end
	i_conv_ovf_i1 once index := 61 end
	i_conv_ovf_i1_un once index := 62 end
	i_conv_ovf_i2 once index := 63 end
	i_conv_ovf_i2_un once index := 64 end
	i_conv_ovf_i4 once index := 65 end
	i_conv_ovf_i4_un once index := 66 end
	i_conv_ovf_i8 once index := 67 end
	i_conv_ovf_i8_un once index := 68 end

	i_conv_ovf_u once index := 69 end
	i_conv_ovf_u_un once index := 70 end
	i_conv_ovf_u1 once index := 71 end
	i_conv_ovf_u1_un once index := 72 end
	i_conv_ovf_u2 once index := 73 end
	i_conv_ovf_u2_un once index := 74 end
	i_conv_ovf_u4 once index := 75 end
	i_conv_ovf_u4_un once index := 76 end
	i_conv_ovf_u8 once index := 77 end
	i_conv_ovf_u8_un once index := 78 end

	i_conv_r_un once index := 79 end
	i_conv_r4 once index := 80 end
	i_conv_r8 once index := 81 end

	i_conv_u once index := 82 end
	i_conv_u1 once index := 83 end
	i_conv_u2 once index := 84 end
	i_conv_u4 once index := 85 end
	i_conv_u8 once index := 86 end

	i_cpblk once index := 87 end

	i_cpobj once index := 88 end

	i_div once index := 89 end
	i_div_un once index := 90 end

	i_dup once index := 91 end

	i_endfault once index := 92 end

	i_endfilter once index := 93 end
	i_endfinally once index := 94 end
	i_initblk once index := 95 end
	i_initobj once index := 96 end
	i_isinst once index := 97 end
	i_jmp once index := 98 end
	i_ldarg once index := 99 end
	i_ldarg_0 once index := 100 end
	i_ldarg_1 once index := 101 end
	i_ldarg_2 once index := 102 end
	i_ldarg_3 once index := 103 end
	i_ldarg_s once index := 104 end
	i_ldarga once index := 105 end
	i_ldarga_s once index := 106 end
	i_ldc_i4 once index := 107 end
	i_ldc_i4_0 once index := 108 end
	i_ldc_i4_1 once index := 109 end
	i_ldc_i4_2 once index := 110 end
	i_ldc_i4_3 once index := 111 end
	i_ldc_i4_4 once index := 112 end
	i_ldc_i4_5 once index := 113 end
	i_ldc_i4_6 once index := 114 end
	i_ldc_i4_7 once index := 115 end
	i_ldc_i4_8 once index := 116 end
	i_ldc_i4_m1 once index := 117 end
	i_ldc_i4_M1_ once index := 118 end
	i_ldc_i4_s once index := 119 end
	i_ldc_i8 once index := 120 end
	i_ldc_r4 once index := 121 end
	i_ldc_r8 once index := 122 end
	i_ldelem once index := 123 end
	i_ldelem_i once index := 124 end
	i_ldelem_i1 once index := 125 end
	i_ldelem_i2 once index := 126 end
	i_ldelem_i4 once index := 127 end
	i_ldelem_i8 once index := 128 end
	i_ldelem_r4 once index := 129 end
	i_ldelem_r8 once index := 130 end
	i_ldelem_ref once index := 131 end
	i_ldelem_u1 once index := 132 end
	i_ldelem_u2 once index := 133 end
	i_ldelem_u4 once index := 134 end
	i_ldelem_u8 once index := 135 end
	i_ldelema once index := 136 end
	i_ldfld once index := 137 end
	i_ldflda once index := 138 end
	i_ldftn once index := 139 end
	i_ldind_i once index := 140 end
	i_ldind_i1 once index := 141 end
	i_ldind_i2 once index := 142 end
	i_ldind_i4 once index := 143 end
	i_ldind_i8 once index := 144 end
	i_ldind_r4 once index := 145 end
	i_ldind_r8 once index := 146 end
	i_ldind_ref once index := 147 end
	i_ldind_u1 once index := 148 end
	i_ldind_u2 once index := 149 end
	i_ldind_u4 once index := 150 end
	i_ldind_u8 once index := 151 end
	i_ldlen once index := 152 end
	i_ldloc once index := 153 end
	i_ldloc_0 once index := 154 end
	i_ldloc_1 once index := 155 end
	i_ldloc_2 once index := 156 end
	i_ldloc_3 once index := 157 end
	i_ldloc_s once index := 158 end
	i_ldloca once index := 159 end
	i_ldloca_s once index := 160 end
	i_ldnull once index := 161 end
	i_ldobj once index := 162 end
	i_ldsfld once index := 163 end
	i_ldsflda once index := 164 end
	i_ldstr once index := 165 end
	i_ldtoken once index := 166 end
	i_ldvirtftn once index := 167 end
	i_leave once index := 168 end
	i_leave_s once index := 169 end
	i_localloc once index := 170 end
	i_mkrefany once index := 171 end
	i_mul once index := 172 end
	i_mul_ovf once index := 173 end
	i_mul_ovf_un once index := 174 end
	i_neg once index := 175 end
	i_newarr once index := 176 end
	i_newobj once index := 177 end
	i_no_ once index := 178 end
	i_nop once index := 179 end
	i_not once index := 180 end
	i_or once index := 181 end
	i_pop once index := 182 end
	i_readonly_ once index := 183 end
	i_refanytype once index := 184 end
	i_refanyval once index := 185 end
	i_rem once index := 186 end
	i_rem_un once index := 187 end
	i_ret once index := 188 end
	i_rethrow once index := 189 end
	i_shl once index := 190 end
	i_shr once index := 191 end
	i_shr_un once index := 192 end
	i_sizeof once index := 193 end
	i_starg once index := 194 end
	i_starg_s once index := 195 end
	i_stelem once index := 196 end
	i_stelem_i once index := 197 end
	i_stelem_i1 once index := 198 end
	i_stelem_i2 once index := 199 end
	i_stelem_i4 once index := 200 end
	i_stelem_i8 once index := 201 end
	i_stelem_r4 once index := 202 end
	i_stelem_r8 once index := 203 end
	i_stelem_ref once index := 204 end
	i_stfld once index := 205 end
	i_stind_i once index := 206 end
	i_stind_i1 once index := 207 end
	i_stind_i2 once index := 208 end
	i_stind_i4 once index := 209 end
	i_stind_i8 once index := 210 end
	i_stind_r4 once index := 211 end
	i_stind_r8 once index := 212 end
	i_stind_ref once index := 213 end
	i_stloc once index := 214 end
	i_stloc_0 once index := 215 end
	i_stloc_1 once index := 216 end
	i_stloc_2 once index := 217 end
	i_stloc_3 once index := 218 end
	i_stloc_s once index := 219 end
	i_stobj once index := 220 end
	i_stsfld once index := 221 end
	i_sub once index := 222 end
	i_sub_ovf once index := 223 end
	i_sub_ovf_un once index := 224 end
	i_switch once index := 225 end
	i_tail_ once index := 226 end
	i_throw once index := 227 end
	i_unaligned_ once index := 228 end
	i_unbox once index := 229 end
	i_unbox_any once index := 230 end
	i_volatile_ once index := 231 end
	i_xor once index := 232 end

feature -- Access

	index: NATURAL_8
			-- Index of the element.

end
