note
	description: "Names of the Opcodes"
	date: "$Date$"
	revision: "$Revision$"
	see: "Table III.1: Opcode Encodings"

once class
	CIL_INSTRUCTION_OPCODES

create

	--should never occur
	i_unknown,
		--  This instruction is a placeholder for a label
	i_label,
		-- This instruction is a placeholder for a comment
	i_comment,
		-- row [ ':' column ] [ '/' filepath ]
	i_line,
		-- This instruction is an SEH specifier
	i_SEH,
		-- actual CIL instructions start here
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

	i_unknown once end
	i_label once end
	i_comment once end
	i_line once end
	i_SEH once end

		--actual CIL instructions start here
	i_add once end
	i_add_ovf once end
	i_add_ovf_un once end

	i_and once end

	i_arglist once end

	i_beq once end
	i_beq_s once end

	i_bge once end
	i_bge_s once end
	i_bge_un once end
	i_bge_un_s once end

	i_bgt once end
	i_bgt_s once end
	i_bgt_un once end
	i_bgt_un_s once end

	i_ble once end
	i_ble_s once end
	i_ble_un once end
	i_ble_un_s once end

	i_blt once end
	i_blt_s once end
	i_blt_un once end
	i_blt_un_s once end

	i_bne_un once end
	i_bne_un_s once end

	i_box once end

	i_br once end
	i_br_s once end

	i_break once end

	i_brfalse once end
	i_brfalse_s once end

	i_brinst once end
	i_brinst_s once end

	i_brnull once end
	i_brnull_s once end

	i_brtrue once end
	i_brtrue_s once end

	i_brzero once end
	i_brzero_s once end

	i_call once end
	i_calli once end
	i_callvirt once end

	i_castclass once end

	i_ceq once end

	i_cgt once end
	i_cgt_un once end

	i_ckfinite once end

	i_clt once end
	i_clt_un once end

	i_constrained_ once end

	i_conv_i once end
	i_conv_i1 once end
	i_conv_i2 once end
	i_conv_i4 once end
	i_conv_i8 once end

	i_conv_ovf_i once end
	i_conv_ovf_i_un once end
	i_conv_ovf_i1 once end
	i_conv_ovf_i1_un once end
	i_conv_ovf_i2 once end
	i_conv_ovf_i2_un once end
	i_conv_ovf_i4 once end
	i_conv_ovf_i4_un once end
	i_conv_ovf_i8 once end
	i_conv_ovf_i8_un once end

	i_conv_ovf_u once end
	i_conv_ovf_u_un once end
	i_conv_ovf_u1 once end
	i_conv_ovf_u1_un once end
	i_conv_ovf_u2 once end
	i_conv_ovf_u2_un once end
	i_conv_ovf_u4 once end
	i_conv_ovf_u4_un once end
	i_conv_ovf_u8 once end
	i_conv_ovf_u8_un once end

	i_conv_r_un once end
	i_conv_r4 once end
	i_conv_r8 once end

	i_conv_u once end
	i_conv_u1 once end
	i_conv_u2 once end
	i_conv_u4 once end
	i_conv_u8 once end

	i_cpblk once end

	i_cpobj once end

	i_div once end
	i_div_un once end

	i_dup once end

	i_endfault once end

	i_endfilter once end
	i_endfinally once end
	i_initblk once end
	i_initobj once end
	i_isinst once end
	i_jmp once end
	i_ldarg once end
	i_ldarg_0 once end
	i_ldarg_1 once end
	i_ldarg_2 once end
	i_ldarg_3 once end
	i_ldarg_s once end
	i_ldarga once end
	i_ldarga_s once end
	i_ldc_i4 once end
	i_ldc_i4_0 once end
	i_ldc_i4_1 once end
	i_ldc_i4_2 once end
	i_ldc_i4_3 once end
	i_ldc_i4_4 once end
	i_ldc_i4_5 once end
	i_ldc_i4_6 once end
	i_ldc_i4_7 once end
	i_ldc_i4_8 once end
	i_ldc_i4_m1 once end
	i_ldc_i4_M1_ once end
	i_ldc_i4_s once end
	i_ldc_i8 once end
	i_ldc_r4 once end
	i_ldc_r8 once end
	i_ldelem once end
	i_ldelem_i once end
	i_ldelem_i1 once end
	i_ldelem_i2 once end
	i_ldelem_i4 once end
	i_ldelem_i8 once end
	i_ldelem_r4 once end
	i_ldelem_r8 once end
	i_ldelem_ref once end
	i_ldelem_u1 once end
	i_ldelem_u2 once end
	i_ldelem_u4 once end
	i_ldelem_u8 once end
	i_ldelema once end
	i_ldfld once end
	i_ldflda once end
	i_ldftn once end
	i_ldind_i once end
	i_ldind_i1 once end
	i_ldind_i2 once end
	i_ldind_i4 once end
	i_ldind_i8 once end
	i_ldind_r4 once end
	i_ldind_r8 once end
	i_ldind_ref once end
	i_ldind_u1 once end
	i_ldind_u2 once end
	i_ldind_u4 once end
	i_ldind_u8 once end
	i_ldlen once end
	i_ldloc once end
	i_ldloc_0 once end
	i_ldloc_1 once end
	i_ldloc_2 once end
	i_ldloc_3 once end
	i_ldloc_s once end
	i_ldloca once end
	i_ldloca_s once end
	i_ldnull once end
	i_ldobj once end
	i_ldsfld once end
	i_ldsflda once end
	i_ldstr once end
	i_ldtoken once end
	i_ldvirtftn once end
	i_leave once end
	i_leave_s once end
	i_localloc once end
	i_mkrefany once end
	i_mul once end
	i_mul_ovf once end
	i_mul_ovf_un once end
	i_neg once end
	i_newarr once end
	i_newobj once end
	i_no_ once end
	i_nop once end
	i_not once end
	i_or once end
	i_pop once end
	i_readonly_ once end
	i_refanytype once end
	i_refanyval once end
	i_rem once end
	i_rem_un once end
	i_ret once end
	i_rethrow once end
	i_shl once end
	i_shr once end
	i_shr_un once end
	i_sizeof once end
	i_starg once end
	i_starg_s once end
	i_stelem once end
	i_stelem_i once end
	i_stelem_i1 once end
	i_stelem_i2 once end
	i_stelem_i4 once end
	i_stelem_i8 once end
	i_stelem_r4 once end
	i_stelem_r8 once end
	i_stelem_ref once end
	i_stfld once end
	i_stind_i once end
	i_stind_i1 once end
	i_stind_i2 once end
	i_stind_i4 once end
	i_stind_i8 once end
	i_stind_r4 once end
	i_stind_r8 once end
	i_stind_ref once end
	i_stloc once end
	i_stloc_0 once end
	i_stloc_1 once end
	i_stloc_2 once end
	i_stloc_3 once end
	i_stloc_s once end
	i_stobj once end
	i_stsfld once end
	i_sub once end
	i_sub_ovf once end
	i_sub_ovf_un once end
	i_switch once end
	i_tail_ once end
	i_throw once end
	i_unaligned_ once end
	i_unbox once end
	i_unbox_any once end
	i_volatile_ once end
	i_xor once end

feature -- Access

	instances: ITERABLE [CIL_INSTRUCTION_OPCODES]
			-- All known CIL instruction opcodes.
		do
			Result := <<
					{CIL_INSTRUCTION_OPCODES}.i_unknown,
					{CIL_INSTRUCTION_OPCODES}.i_label,
					{CIL_INSTRUCTION_OPCODES}.i_comment,
					{CIL_INSTRUCTION_OPCODES}.i_line,
					{CIL_INSTRUCTION_OPCODES}.i_SEH,

						--actual CIL instructions start here
					{CIL_INSTRUCTION_OPCODES}.i_add,
					{CIL_INSTRUCTION_OPCODES}.i_add_ovf,
					{CIL_INSTRUCTION_OPCODES}.i_add_ovf_un,

					{CIL_INSTRUCTION_OPCODES}.i_and,

					{CIL_INSTRUCTION_OPCODES}.i_arglist,

					{CIL_INSTRUCTION_OPCODES}.i_beq,
					{CIL_INSTRUCTION_OPCODES}.i_beq_s,

					{CIL_INSTRUCTION_OPCODES}.i_bge,
					{CIL_INSTRUCTION_OPCODES}.i_bge_s,
					{CIL_INSTRUCTION_OPCODES}.i_bge_un,
					{CIL_INSTRUCTION_OPCODES}.i_bge_un_s,

					{CIL_INSTRUCTION_OPCODES}.i_bgt,
					{CIL_INSTRUCTION_OPCODES}.i_bgt_s,
					{CIL_INSTRUCTION_OPCODES}.i_bgt_un,
					{CIL_INSTRUCTION_OPCODES}.i_bgt_un_s,

					{CIL_INSTRUCTION_OPCODES}.i_ble,
					{CIL_INSTRUCTION_OPCODES}.i_ble_s,
					{CIL_INSTRUCTION_OPCODES}.i_ble_un,
					{CIL_INSTRUCTION_OPCODES}.i_ble_un_s,

					{CIL_INSTRUCTION_OPCODES}.i_blt,
					{CIL_INSTRUCTION_OPCODES}.i_blt_s,
					{CIL_INSTRUCTION_OPCODES}.i_blt_un,
					{CIL_INSTRUCTION_OPCODES}.i_blt_un_s,

					{CIL_INSTRUCTION_OPCODES}.i_bne_un,
					{CIL_INSTRUCTION_OPCODES}.i_bne_un_s,

					{CIL_INSTRUCTION_OPCODES}.i_box,

					{CIL_INSTRUCTION_OPCODES}.i_br,
					{CIL_INSTRUCTION_OPCODES}.i_br_s,

					{CIL_INSTRUCTION_OPCODES}.i_break,

					{CIL_INSTRUCTION_OPCODES}.i_brfalse,
					{CIL_INSTRUCTION_OPCODES}.i_brfalse_s,

					{CIL_INSTRUCTION_OPCODES}.i_brinst,
					{CIL_INSTRUCTION_OPCODES}.i_brinst_s,

					{CIL_INSTRUCTION_OPCODES}.i_brnull,
					{CIL_INSTRUCTION_OPCODES}.i_brnull_s,

					{CIL_INSTRUCTION_OPCODES}.i_brtrue,
					{CIL_INSTRUCTION_OPCODES}.i_brtrue_s,

					{CIL_INSTRUCTION_OPCODES}.i_brzero,
					{CIL_INSTRUCTION_OPCODES}.i_brzero_s,

					{CIL_INSTRUCTION_OPCODES}.i_call,
					{CIL_INSTRUCTION_OPCODES}.i_calli,
					{CIL_INSTRUCTION_OPCODES}.i_callvirt,

					{CIL_INSTRUCTION_OPCODES}.i_castclass,

					{CIL_INSTRUCTION_OPCODES}.i_ceq,

					{CIL_INSTRUCTION_OPCODES}.i_cgt,
					{CIL_INSTRUCTION_OPCODES}.i_cgt_un,

					{CIL_INSTRUCTION_OPCODES}.i_ckfinite,

					{CIL_INSTRUCTION_OPCODES}.i_clt,
					{CIL_INSTRUCTION_OPCODES}.i_clt_un,

					{CIL_INSTRUCTION_OPCODES}.i_constrained_,

					{CIL_INSTRUCTION_OPCODES}.i_conv_i,
					{CIL_INSTRUCTION_OPCODES}.i_conv_i1,
					{CIL_INSTRUCTION_OPCODES}.i_conv_i2,
					{CIL_INSTRUCTION_OPCODES}.i_conv_i4,
					{CIL_INSTRUCTION_OPCODES}.i_conv_i8,

					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_i,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_i_un,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_i1,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_i1_un,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_i2,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_i2_un,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_i4,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_i4_un,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_i8,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_i8_un,

					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_u,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_u_un,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_u1,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_u1_un,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_u2,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_u2_un,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_u4,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_u4_un,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_u8,
					{CIL_INSTRUCTION_OPCODES}.i_conv_ovf_u8_un,

					{CIL_INSTRUCTION_OPCODES}.i_conv_r_un,
					{CIL_INSTRUCTION_OPCODES}.i_conv_r4,
					{CIL_INSTRUCTION_OPCODES}.i_conv_r8,

					{CIL_INSTRUCTION_OPCODES}.i_conv_u,
					{CIL_INSTRUCTION_OPCODES}.i_conv_u1,
					{CIL_INSTRUCTION_OPCODES}.i_conv_u2,
					{CIL_INSTRUCTION_OPCODES}.i_conv_u4,
					{CIL_INSTRUCTION_OPCODES}.i_conv_u8,

					{CIL_INSTRUCTION_OPCODES}.i_cpblk,

					{CIL_INSTRUCTION_OPCODES}.i_cpobj,

					{CIL_INSTRUCTION_OPCODES}.i_div,
					{CIL_INSTRUCTION_OPCODES}.i_div_un,

					{CIL_INSTRUCTION_OPCODES}.i_dup,

					{CIL_INSTRUCTION_OPCODES}.i_endfault,

					{CIL_INSTRUCTION_OPCODES}.i_endfilter,
					{CIL_INSTRUCTION_OPCODES}.i_endfinally,
					{CIL_INSTRUCTION_OPCODES}.i_initblk,
					{CIL_INSTRUCTION_OPCODES}.i_initobj,
					{CIL_INSTRUCTION_OPCODES}.i_isinst,
					{CIL_INSTRUCTION_OPCODES}.i_jmp,
					{CIL_INSTRUCTION_OPCODES}.i_ldarg,
					{CIL_INSTRUCTION_OPCODES}.i_ldarg_0,
					{CIL_INSTRUCTION_OPCODES}.i_ldarg_1,
					{CIL_INSTRUCTION_OPCODES}.i_ldarg_2,
					{CIL_INSTRUCTION_OPCODES}.i_ldarg_3,
					{CIL_INSTRUCTION_OPCODES}.i_ldarg_s,
					{CIL_INSTRUCTION_OPCODES}.i_ldarga,
					{CIL_INSTRUCTION_OPCODES}.i_ldarga_s,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_0,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_1,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_2,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_3,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_4,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_5,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_6,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_7,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_8,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_m1,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_M1_,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_s,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i8,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_r4,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_r8,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem_i,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem_i1,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem_i2,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem_i4,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem_i8,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem_r4,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem_r8,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem_ref,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem_u1,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem_u2,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem_u4,
					{CIL_INSTRUCTION_OPCODES}.i_ldelem_u8,
					{CIL_INSTRUCTION_OPCODES}.i_ldelema,
					{CIL_INSTRUCTION_OPCODES}.i_ldfld,
					{CIL_INSTRUCTION_OPCODES}.i_ldflda,
					{CIL_INSTRUCTION_OPCODES}.i_ldftn,
					{CIL_INSTRUCTION_OPCODES}.i_ldind_i,
					{CIL_INSTRUCTION_OPCODES}.i_ldind_i1,
					{CIL_INSTRUCTION_OPCODES}.i_ldind_i2,
					{CIL_INSTRUCTION_OPCODES}.i_ldind_i4,
					{CIL_INSTRUCTION_OPCODES}.i_ldind_i8,
					{CIL_INSTRUCTION_OPCODES}.i_ldind_r4,
					{CIL_INSTRUCTION_OPCODES}.i_ldind_r8,
					{CIL_INSTRUCTION_OPCODES}.i_ldind_ref,
					{CIL_INSTRUCTION_OPCODES}.i_ldind_u1,
					{CIL_INSTRUCTION_OPCODES}.i_ldind_u2,
					{CIL_INSTRUCTION_OPCODES}.i_ldind_u4,
					{CIL_INSTRUCTION_OPCODES}.i_ldind_u8,
					{CIL_INSTRUCTION_OPCODES}.i_ldlen,
					{CIL_INSTRUCTION_OPCODES}.i_ldloc,
					{CIL_INSTRUCTION_OPCODES}.i_ldloc_0,
					{CIL_INSTRUCTION_OPCODES}.i_ldloc_1,
					{CIL_INSTRUCTION_OPCODES}.i_ldloc_2,
					{CIL_INSTRUCTION_OPCODES}.i_ldloc_3,
					{CIL_INSTRUCTION_OPCODES}.i_ldloc_s,
					{CIL_INSTRUCTION_OPCODES}.i_ldloca,
					{CIL_INSTRUCTION_OPCODES}.i_ldloca_s,
					{CIL_INSTRUCTION_OPCODES}.i_ldnull,
					{CIL_INSTRUCTION_OPCODES}.i_ldobj,
					{CIL_INSTRUCTION_OPCODES}.i_ldsfld,
					{CIL_INSTRUCTION_OPCODES}.i_ldsflda,
					{CIL_INSTRUCTION_OPCODES}.i_ldstr,
					{CIL_INSTRUCTION_OPCODES}.i_ldtoken,
					{CIL_INSTRUCTION_OPCODES}.i_ldvirtftn,
					{CIL_INSTRUCTION_OPCODES}.i_leave,
					{CIL_INSTRUCTION_OPCODES}.i_leave_s,
					{CIL_INSTRUCTION_OPCODES}.i_localloc,
					{CIL_INSTRUCTION_OPCODES}.i_mkrefany,
					{CIL_INSTRUCTION_OPCODES}.i_mul,
					{CIL_INSTRUCTION_OPCODES}.i_mul_ovf,
					{CIL_INSTRUCTION_OPCODES}.i_mul_ovf_un,
					{CIL_INSTRUCTION_OPCODES}.i_neg,
					{CIL_INSTRUCTION_OPCODES}.i_newarr,
					{CIL_INSTRUCTION_OPCODES}.i_newobj,
					{CIL_INSTRUCTION_OPCODES}.i_no_,
					{CIL_INSTRUCTION_OPCODES}.i_nop,
					{CIL_INSTRUCTION_OPCODES}.i_not,
					{CIL_INSTRUCTION_OPCODES}.i_or,
					{CIL_INSTRUCTION_OPCODES}.i_pop,
					{CIL_INSTRUCTION_OPCODES}.i_readonly_,
					{CIL_INSTRUCTION_OPCODES}.i_refanytype,
					{CIL_INSTRUCTION_OPCODES}.i_refanyval,
					{CIL_INSTRUCTION_OPCODES}.i_rem,
					{CIL_INSTRUCTION_OPCODES}.i_rem_un,
					{CIL_INSTRUCTION_OPCODES}.i_ret,
					{CIL_INSTRUCTION_OPCODES}.i_rethrow,
					{CIL_INSTRUCTION_OPCODES}.i_shl,
					{CIL_INSTRUCTION_OPCODES}.i_shr,
					{CIL_INSTRUCTION_OPCODES}.i_shr_un,
					{CIL_INSTRUCTION_OPCODES}.i_sizeof,
					{CIL_INSTRUCTION_OPCODES}.i_starg,
					{CIL_INSTRUCTION_OPCODES}.i_starg_s,
					{CIL_INSTRUCTION_OPCODES}.i_stelem,
					{CIL_INSTRUCTION_OPCODES}.i_stelem_i,
					{CIL_INSTRUCTION_OPCODES}.i_stelem_i1,
					{CIL_INSTRUCTION_OPCODES}.i_stelem_i2,
					{CIL_INSTRUCTION_OPCODES}.i_stelem_i4,
					{CIL_INSTRUCTION_OPCODES}.i_stelem_i8,
					{CIL_INSTRUCTION_OPCODES}.i_stelem_r4,
					{CIL_INSTRUCTION_OPCODES}.i_stelem_r8,
					{CIL_INSTRUCTION_OPCODES}.i_stelem_ref,
					{CIL_INSTRUCTION_OPCODES}.i_stfld,
					{CIL_INSTRUCTION_OPCODES}.i_stind_i,
					{CIL_INSTRUCTION_OPCODES}.i_stind_i1,
					{CIL_INSTRUCTION_OPCODES}.i_stind_i2,
					{CIL_INSTRUCTION_OPCODES}.i_stind_i4,
					{CIL_INSTRUCTION_OPCODES}.i_stind_i8,
					{CIL_INSTRUCTION_OPCODES}.i_stind_r4,
					{CIL_INSTRUCTION_OPCODES}.i_stind_r8,
					{CIL_INSTRUCTION_OPCODES}.i_stind_ref,
					{CIL_INSTRUCTION_OPCODES}.i_stloc,
					{CIL_INSTRUCTION_OPCODES}.i_stloc_0,
					{CIL_INSTRUCTION_OPCODES}.i_stloc_1,
					{CIL_INSTRUCTION_OPCODES}.i_stloc_2,
					{CIL_INSTRUCTION_OPCODES}.i_stloc_3,
					{CIL_INSTRUCTION_OPCODES}.i_stloc_s,
					{CIL_INSTRUCTION_OPCODES}.i_stobj,
					{CIL_INSTRUCTION_OPCODES}.i_stsfld,
					{CIL_INSTRUCTION_OPCODES}.i_sub,
					{CIL_INSTRUCTION_OPCODES}.i_sub_ovf,
					{CIL_INSTRUCTION_OPCODES}.i_sub_ovf_un,
					{CIL_INSTRUCTION_OPCODES}.i_switch,
					{CIL_INSTRUCTION_OPCODES}.i_tail_,
					{CIL_INSTRUCTION_OPCODES}.i_throw,
					{CIL_INSTRUCTION_OPCODES}.i_unaligned_,
					{CIL_INSTRUCTION_OPCODES}.i_unbox,
					{CIL_INSTRUCTION_OPCODES}.i_unbox_any,
					{CIL_INSTRUCTION_OPCODES}.i_volatile_,
					{CIL_INSTRUCTION_OPCODES}.i_xor
				>>
		ensure
			instance_free: class
		end


	index_of (a_value: CIL_INSTRUCTION_OPCODES): NATURAL_8
			-- Index of first occurrence of item identical to `a_value'.
			-- -1 if none.
		local
			l_area: SPECIAL [CIL_INSTRUCTION_OPCODES]
		do
			l_area := (create {ARRAYED_LIST [CIL_INSTRUCTION_OPCODES]}.make_from_iterable ({CIL_INSTRUCTION_OPCODES}.instances)).area
			Result :=  l_area.index_of(a_value, l_area.lower).to_natural_8
		ensure
			instance_free: class
		end


	next (a_value: CIL_INSTRUCTION_OPCODES): CIL_INSTRUCTION_OPCODES
			-- next value relative to a_value.
			-- if a_value is the last item, return the first one.
		local
			l_array: ARRAYED_LIST [CIL_INSTRUCTION_OPCODES]
			l_index: INTEGER
		do
			create {ARRAYED_LIST [CIL_INSTRUCTION_OPCODES]}l_array.make_from_iterable ({CIL_INSTRUCTION_OPCODES}.instances)
			l_index := l_array.index_of (a_value, l_array.lower)
			if l_index = l_array.count then
				Result := l_array.at (l_array.lower)
			else
				Result := l_array.at (l_index + 1)
			end
		ensure
			instance_free: class
		end

end
