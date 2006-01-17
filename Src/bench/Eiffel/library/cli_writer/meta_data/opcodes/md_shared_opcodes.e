indexing
	description: "List all known opcodes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_SHARED_OPCODES

feature -- Access

	opcodes: HASH_TABLE [MD_OPCODE, INTEGER_16] is
			-- All opcodes indexed by their opcode value.
		once
			create Result.make (300)

				-- Commented lines are because opcodes are not in use.
				-- If new opcodes are added we should uncomment corresponding lines.

--	Exception here because `nop' is `0' and HASH_TABLE does not like
--  a key whose value is 0.
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.nop, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.nop)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.break, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.break)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldarg_0, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldarg_0)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldarg_1, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldarg_1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldarg_2, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldarg_2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldarg_3, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldarg_3)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldloc_0, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldloc_0)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldloc_1, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldloc_1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldloc_2, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldloc_2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldloc_3, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldloc_3)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stloc_0, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stloc_0)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stloc_1, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stloc_1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stloc_2, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stloc_2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stloc_3, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stloc_3)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldarg_s, 1,
					{MD_OPCODE_FORMAT}.short_variable_arg),
				{MD_OPCODES}.ldarg_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldarga_s, 1,
					{MD_OPCODE_FORMAT}.short_variable_arg),
				{MD_OPCODES}.ldarga_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.starg_s, -1,
					{MD_OPCODE_FORMAT}.short_variable_arg),
				{MD_OPCODES}.starg_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldloc_s, 1,
					{MD_OPCODE_FORMAT}.short_variable_arg),
				{MD_OPCODES}.ldloc_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldloca_s, 1,
					{MD_OPCODE_FORMAT}.short_variable_arg),
				{MD_OPCODES}.ldloca_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stloc_s, -1,
					{MD_OPCODE_FORMAT}.short_variable_arg),
				{MD_OPCODES}.stloc_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldnull, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldnull)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i4_m1, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldc_i4_m1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i4_0, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldc_i4_0)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i4_1, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldc_i4_1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i4_2, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldc_i4_2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i4_3, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldc_i4_3)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i4_4, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldc_i4_4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i4_5, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldc_i4_5)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i4_6, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldc_i4_6)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i4_7, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldc_i4_7)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i4_8, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldc_i4_8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i4_s, 1,
					{MD_OPCODE_FORMAT}.short_i_arg),
				{MD_OPCODES}.ldc_i4_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i4, 1,
					{MD_OPCODE_FORMAT}.i_arg),
				{MD_OPCODES}.ldc_i4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_i8, 1,
					{MD_OPCODE_FORMAT}.i8_arg),
				{MD_OPCODES}.ldc_i8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_r4, 1,
					{MD_OPCODE_FORMAT}.short_r_arg),
				{MD_OPCODES}.ldc_r4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldc_r8, 1,
					{MD_OPCODE_FORMAT}.short_r_arg),
				{MD_OPCODES}.ldc_r8)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused49, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused49)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.dup, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.dup)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.pop, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.pop)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.jmp, 0,
					{MD_OPCODE_FORMAT}.method_arg),
				{MD_OPCODES}.jmp)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.call, 0xFF000000,
					{MD_OPCODE_FORMAT}.method_arg),
				{MD_OPCODES}.call)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.calli, 0xFF000000,
					{MD_OPCODE_FORMAT}.signature_arg),
				{MD_OPCODES}.calli)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ret, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ret)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.br_s, 0,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.br_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.brfalse_s, -1,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.brfalse_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.brtrue_s, -1,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.brtrue_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.beq_s, -2,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.beq_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.bge_s, -2,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.bge_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.bgt_s, -2,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.bgt_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ble_s, -2,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.ble_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.blt_s, -2,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.blt_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.bne_un_s, -2,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.bne_un_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.bge_un_s, -2,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.bge_un_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.bgt_un_s, -2,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.bgt_un_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ble_un_s, -2,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.ble_un_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.blt_un_s, -2,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.blt_un_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.br, 0,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.br)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.brfalse, -1,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.brfalse)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.brtrue, -1,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.brtrue)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.beq, -2,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.beq)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.bge, -2,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.bge)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.bgt, -2,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.bgt)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ble, -2,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.ble)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.blt, -2,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.blt)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.bne_un, -2,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.bne_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.bge_un, -2,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.bge_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.bgt_un, -2,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.bgt_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ble_un, -2,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.ble_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.blt_un, -2,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.blt_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.switch, -1,
					{MD_OPCODE_FORMAT}.switch_arg),
				{MD_OPCODES}.switch)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldind_i1, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldind_i1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldind_u1, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldind_u1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldind_i2, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldind_i2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldind_u2, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldind_u2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldind_i4, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldind_i4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldind_u4, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldind_u4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldind_i8, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldind_i8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldind_i, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldind_i)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldind_r4, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldind_r4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldind_r8, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldind_r8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldind_ref, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldind_ref)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stind_ref, -2,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stind_ref)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stind_i1, -2,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stind_i1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stind_i2, -2,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stind_i2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stind_i4, -2,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stind_i4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stind_i8, -2,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stind_i8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stind_r4, -2,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stind_r4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stind_r8, -2,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stind_r8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.add, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.add)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.sub, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.sub)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.mul, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.mul)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.div, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.div)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.div_un, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.div_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.rem, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.rem)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.rem_un, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.rem_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.and_opcode, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.and_opcode)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.or_opcode, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.or_opcode)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.xor_opcode, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.xor_opcode)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.shl, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.shl)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.shr, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.shr)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.shr_un, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.shr_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.neg, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.neg)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.not_opcode, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.not_opcode)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_i1, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_i1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_i2, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_i2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_i4, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_i4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_i8, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_i8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_r4, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_r4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_r8, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_r8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_u4, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_u4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_u8, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_u8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.callvirt, 0xFF000000,
					{MD_OPCODE_FORMAT}.method_arg),
				{MD_OPCODES}.callvirt)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.cpobj, -2,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.cpobj)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldobj, 0,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.ldobj)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldstr, 1,
					{MD_OPCODE_FORMAT}.string_arg),
				{MD_OPCODES}.ldstr)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.newobj, 0xFF000000,
					{MD_OPCODE_FORMAT}.method_arg),
				{MD_OPCODES}.newobj)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.castclass, 0,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.castclass)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.isinst, 0,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.isinst)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_r_un, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_r_un)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused58, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused58)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused1, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.unbox, 0,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.unbox)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.throw, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.throw)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldfld, 0,
					{MD_OPCODE_FORMAT}.field_arg),
				{MD_OPCODES}.ldfld)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldflda, 0,
					{MD_OPCODE_FORMAT}.field_arg),
				{MD_OPCODES}.ldflda)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stfld, -2,
					{MD_OPCODE_FORMAT}.field_arg),
				{MD_OPCODES}.stfld)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldsfld, 1,
					{MD_OPCODE_FORMAT}.field_arg),
				{MD_OPCODES}.ldsfld)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldsflda, 1,
					{MD_OPCODE_FORMAT}.field_arg),
				{MD_OPCODES}.ldsflda)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stsfld, -1,
					{MD_OPCODE_FORMAT}.field_arg),
				{MD_OPCODES}.stsfld)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stobj, -2,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.stobj)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_i1_un, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_i1_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_i2_un, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_i2_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_i4_un, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_i4_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_i8_un, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_i8_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_u1_un, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_u1_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_u2_un, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_u2_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_u4_un, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_u4_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_u8_un, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_u8_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_i_un, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_i_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_u_un, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_u_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.box, 0,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.box)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.newarr, 0,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.newarr)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldlen, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldlen)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldelema, -1,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.ldelema)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldelem_i1, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldelem_i1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldelem_u1, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldelem_u1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldelem_i2, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldelem_i2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldelem_u2, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldelem_u2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldelem_i4, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldelem_i4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldelem_u4, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldelem_u4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldelem_i8, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldelem_i8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldelem_i, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldelem_i)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldelem_r4, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldelem_r4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldelem_r8, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldelem_r8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldelem_ref, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ldelem_ref)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stelem_i, -3,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stelem_i)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stelem_i1, -3,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stelem_i1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stelem_i2, -3,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stelem_i2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stelem_i4, -3,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stelem_i4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stelem_i8, -3,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stelem_i8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stelem_r4, -3,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stelem_r4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stelem_r8, -3,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stelem_r8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stelem_ref, -3,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stelem_ref)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused2, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused2)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused3, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused3)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused4, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused4)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused5, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused5)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused6, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused6)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused7, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused7)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused8, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused8)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused9, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused9)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused10, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused10)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused11, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused11)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused12, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused12)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused13, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused13)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused14, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused14)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused15, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused15)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused16, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused16)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused17, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused17)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_i1, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_i1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_u1, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_u1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_i2, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_i2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_u2, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_u2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_i4, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_i4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_u4, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_u4)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_i8, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_i8)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_u8, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_u8)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused50, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused50)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused18, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused18)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused19, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused19)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused20, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused20)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused21, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused21)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused22, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused22)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused23, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused23)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.refanyval, 0,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.refanyval)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ckfinite, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ckfinite)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused24, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused24)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused25, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused25)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.mkrefany, 0,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.mkrefany)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused59, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused59)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused60, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused60)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused61, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused61)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused62, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused62)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused63, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused63)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused64, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused64)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused65, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused65)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused66, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused66)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused67, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused67)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldtoken, 1,
					{MD_OPCODE_FORMAT}.token_arg),
				{MD_OPCODES}.ldtoken)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_u2, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_u2)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_u1, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_u1)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_i, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_i)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_i, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_i)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_ovf_u, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_ovf_u)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.add_ovf, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.add_ovf)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.add_ovf_un, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.add_ovf_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.mul_ovf, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.mul_ovf)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.mul_ovf_un, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.mul_ovf_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.sub_ovf, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.sub_ovf)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.sub_ovf_un, 1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.sub_ovf_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.endfinally, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.endfinally)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.leave, 0,
					{MD_OPCODE_FORMAT}.branch_target_arg),
				{MD_OPCODES}.leave)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.leave_s, 0,
					{MD_OPCODE_FORMAT}.short_branch_target_arg),
				{MD_OPCODES}.leave_s)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stind_i, -2,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.stind_i)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.conv_u, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.conv_u)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused26, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused26)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused27, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused27)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused28, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused28)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused29, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused29)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused30, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused30)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused31, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused31)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused32, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused32)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused33, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused33)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused34, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused34)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused35, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused35)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused36, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused36)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused37, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused37)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused38, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused38)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused39, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused39)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused40, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused40)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused41, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused41)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused42, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused42)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused43, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused43)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused44, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused44)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused45, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused45)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused46, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused46)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused47, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused47)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused48, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused48)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.prefix7, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.prefix7)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.prefix6, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.prefix6)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.prefix5, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.prefix5)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.prefix4, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.prefix4)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.prefix3, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.prefix3)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.prefix2, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.prefix2)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.prefix1, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.prefix1)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.prefixref, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.prefixref)

			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.arglist, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.arglist)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ceq, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.ceq)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.cgt, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.cgt)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.cgt_un, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.cgt_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.clt, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.clt)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.clt_un, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.clt_un)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldftn, 1,
					{MD_OPCODE_FORMAT}.method_arg),
				{MD_OPCODES}.ldftn)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldvirtftn, 0,
					{MD_OPCODE_FORMAT}.method_arg),
				{MD_OPCODES}.ldvirtftn)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused56, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused56)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldarg, 1,
					{MD_OPCODE_FORMAT}.variable_arg),
				{MD_OPCODES}.ldarg)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldarga, 1,
					{MD_OPCODE_FORMAT}.variable_arg),
				{MD_OPCODES}.ldarga)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.starg, -1,
					{MD_OPCODE_FORMAT}.variable_arg),
				{MD_OPCODES}.starg)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldloc, 1,
					{MD_OPCODE_FORMAT}.variable_arg),
				{MD_OPCODES}.ldloc)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.ldloca, 1,
					{MD_OPCODE_FORMAT}.variable_arg),
				{MD_OPCODES}.ldloca)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.stloc, -1,
					{MD_OPCODE_FORMAT}.variable_arg),
				{MD_OPCODES}.stloc)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.localloc, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.localloc)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused57, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused57)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.endfilter, -1,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.endfilter)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.unaligned, 0,
					{MD_OPCODE_FORMAT}.short_i_arg),
				{MD_OPCODES}.unaligned)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.volatile, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.volatile)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.tailcall, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.tailcall)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.initobj, -1,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.initobj)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused68, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused68)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.cpblk, -3,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.cpblk)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.initblk, -3,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.initblk)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused69, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused69)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.rethrow, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.rethrow)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused51, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused51)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.sizeof, 1,
					{MD_OPCODE_FORMAT}.type_arg),
				{MD_OPCODES}.sizeof)
			Result.put (
				create {MD_OPCODE}.make ({MD_OPCODES}.refanytype, 0,
					{MD_OPCODE_FORMAT}.no_arg),
				{MD_OPCODES}.refanytype)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused52, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused52)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused53, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused53)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused54, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused54)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused55, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused55)
-- 			Result.put (
-- 				create {MD_OPCODE}.make (feature {MD_OPCODES}.unused70, 0,
-- 					feature {MD_OPCODE_FORMAT}.no_arg),
-- 				feature {MD_OPCODES}.unused70)
		end
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

end -- class MD_SHARED_OPCODES
