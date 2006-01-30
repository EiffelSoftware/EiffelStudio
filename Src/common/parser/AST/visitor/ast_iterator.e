indexing
	description: "Visitor to iterate through all the nodes of an AST."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_ITERATOR

inherit
	AST_VISITOR

feature -- Roundtrip

	process_none_id_as (l_as: NONE_ID_AS) is
			-- Process `l_as'.
		do
			process_id_as (l_as)
		end

	process_typed_char_as (l_as: TYPED_CHAR_AS) is
			-- Process `l_as'.
		do
			process_char_as (l_as)
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS) is
			-- Process `l_as'.
		do
			process_routine_creation_as (l_as)
		end

	process_tilda_routine_creation_as (l_as: TILDA_ROUTINE_CREATION_AS) is
			-- Process `l_as'.
		do
			process_routine_creation_as (l_as)
		end

	process_create_creation_as (l_as: CREATE_CREATION_AS) is
			-- Process `l_as'.
		do
			process_creation_as (l_as)
		end

	process_bang_creation_as (l_as: BANG_CREATION_AS) is
			-- Process `l_as'.
		do
			process_creation_as (l_as)
		end

	process_create_creation_expr_as (l_as: CREATE_CREATION_EXPR_AS) is
			-- Process `l_as'.
		do
			process_creation_expr_as (l_as)
		end

	process_bang_creation_expr_as (l_as: BANG_CREATION_EXPR_AS) is
			-- Process `l_as'.
		do
			process_creation_expr_as (l_as)
		end

feature -- Roundtrip

	process_keyword_as (l_as: KEYWORD_AS) is
			-- Process `l_as'.
		do
		end

	process_symbol_as (l_as: SYMBOL_AS) is
			-- Process `l_as'.
		do
		end
	process_break_as (l_as: BREAK_AS) is
			-- Process `l_as'.
		do
		end

	process_leaf_stub_as (l_as: LEAF_STUB_AS) is
			-- Process `l_as'.
		do
		end

	process_symbol_stub_as (l_as: SYMBOL_STUB_AS) is
			-- Process `l_as'.
		do
		end

feature {NONE} -- Implementation

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS) is
		do
			l_as.creation_expr.process (Current)
			safe_process (l_as.tuple)
		end

	process_id_as (l_as: ID_AS) is
		do
				-- Nothing to be done
		end

	process_integer_as (l_as: INTEGER_AS) is
		do
				-- Nothing to be done
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
		do
			l_as.class_type.process (Current)
			safe_process (l_as.parameters)
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS) is
		do
			safe_process (l_as.clients)
			l_as.features.process (Current)
		end

	process_unique_as (l_as: UNIQUE_AS) is
		do
				-- Nothing to be done
		end

	process_tuple_as (l_as: TUPLE_AS) is
		do
			l_as.expressions.process (Current)
		end

	process_real_as (l_as: REAL_AS) is
		do
				-- Nothing to be done
		end

	process_bool_as (l_as: BOOL_AS) is
		do
				-- Nothing to be done
		end

	process_bit_const_as (l_as: BIT_CONST_AS) is
		do
				-- Nothing to be done
		end

	process_array_as (l_as: ARRAY_AS) is
		do
			l_as.expressions.process (Current)
		end

	process_char_as (l_as: CHAR_AS) is
		do
				-- Nothing to be done
		end

	process_string_as (l_as: STRING_AS) is
		do
				-- Nothing to be done
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS) is
		do
				-- Nothing to be done
		end

	process_body_as (l_as: BODY_AS) is
		do
			safe_process (l_as.arguments)
			safe_process (l_as.type)
			safe_process (l_as.assigner)
			safe_process (l_as.content)
		end

	process_result_as (l_as: RESULT_AS) is
		do
				-- Nothing to be done
		end

	process_current_as (l_as: CURRENT_AS) is
		do
				-- Nothing to be done
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
		do
			safe_process (l_as.parameters)
		end

	process_access_inv_as (l_as: ACCESS_INV_AS) is
		do
			process_access_feat_as (l_as)
		end

	process_access_id_as (l_as: ACCESS_ID_AS) is
		do
			process_access_feat_as (l_as)
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS) is
		do
			process_access_feat_as (l_as)
		end

	process_precursor_as (l_as: PRECURSOR_AS) is
		do
			safe_process (l_as.parent_base_class)
			safe_process (l_as.parameters)
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS) is
		do
			l_as.target.process (Current)
			l_as.message.process (Current)
		end

	process_nested_as (l_as: NESTED_AS) is
		do
			l_as.target.process (Current)
			l_as.message.process (Current)
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS) is
		do
			l_as.type.process (Current)
			safe_process (l_as.call)
		end

	process_type_expr_as (l_as: TYPE_EXPR_AS) is
		do
			l_as.type.process (Current)
		end

	process_routine_as (l_as: ROUTINE_AS) is
		do
			safe_process (l_as.precondition)
			safe_process (l_as.locals)
			l_as.routine_body.process (Current)
			safe_process (l_as.postcondition)
			safe_process (l_as.rescue_clause)
		end

	process_constant_as (l_as: CONSTANT_AS) is
		do
			l_as.value.process (Current)
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL]) is
		local
			l_cursor: CURSOR
		do
			from
				l_cursor := l_as.cursor
				l_as.start
			until
				l_as.after
			loop
				l_as.item.process (Current)
				l_as.forth
			end
			l_as.go_to (l_cursor)
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS) is
		do
			process_eiffel_list (l_as)
		end

	process_operand_as (l_as: OPERAND_AS) is
		do
			safe_process (l_as.class_type)
			safe_process (l_as.expression)
			safe_process (l_as.target)
		end

	process_tagged_as (l_as: TAGGED_AS) is
		do
			l_as.expr.process (Current)
		end

	process_variant_as (l_as: VARIANT_AS) is
		do
			l_as.expr.process (Current)
		end

	process_un_strip_as (l_as: UN_STRIP_AS) is
		do
				-- Nothing to be done
		end

	process_paran_as (l_as: PARAN_AS) is
		do
			l_as.expr.process (Current)
		end

	process_expr_call_as (l_as: EXPR_CALL_AS) is
		do
			l_as.call.process (Current)
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS) is
		do
			l_as.expr.process (Current)
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS) is
		do
				-- Nothing to be done
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS) is
		do
				-- Nothing to be done
		end

	process_address_as (l_as: ADDRESS_AS) is
		do
				-- Nothing to be done
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS) is
		do
			safe_process (l_as.target)
			safe_process (l_as.operands)
		end

	process_unary_as (l_as: UNARY_AS) is
		do
			l_as.expr.process (Current)
		end

	process_un_free_as (l_as: UN_FREE_AS) is
		do
			process_unary_as (l_as)
		end

	process_un_minus_as (l_as: UN_MINUS_AS) is
		do
			process_unary_as (l_as)
		end

	process_un_not_as (l_as: UN_NOT_AS) is
		do
			process_unary_as (l_as)
		end

	process_un_old_as (l_as: UN_OLD_AS) is
		do
			process_unary_as (l_as)
		end

	process_un_plus_as (l_as: UN_PLUS_AS) is
		do
			process_unary_as (l_as)
		end

	process_binary_as (l_as: BINARY_AS) is
		do
			l_as.left.process (Current)
			l_as.right.process (Current)
		end

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_free_as (l_as: BIN_FREE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_implies_as (l_as: BIN_IMPLIES_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_or_as (l_as: BIN_OR_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_or_else_as (l_as: BIN_OR_ELSE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_xor_as (l_as: BIN_XOR_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_ge_as (l_as: BIN_GE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_gt_as (l_as: BIN_GT_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_le_as (l_as: BIN_LE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_lt_as (l_as: BIN_LT_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_div_as (l_as: BIN_DIV_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_minus_as (l_as: BIN_MINUS_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_mod_as (l_as: BIN_MOD_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_plus_as (l_as: BIN_PLUS_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_power_as (l_as: BIN_POWER_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_slash_as (l_as: BIN_SLASH_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_star_as (l_as: BIN_STAR_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_and_as (l_as: BIN_AND_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_eq_as (l_as: BIN_EQ_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_ne_as (l_as: BIN_NE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bracket_as (l_as: BRACKET_AS) is
		do
			l_as.target.process (Current)
			l_as.operands.process (Current)
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS) is
		do
				-- Nothing to be done
		end

	process_feature_as (l_as: FEATURE_AS) is
		do
			l_as.feature_names.process (Current)
			l_as.body.process (Current)
			safe_process (l_as.indexes)
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
		do
				-- Nothing to be done
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS) is
		do
				-- Nothing to be done
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS) is
			-- Process `l_as'.
		do
				-- Nothing to be done.
		end

	process_feature_list_as (l_as: FEATURE_LIST_AS) is
		do
			l_as.features.process (Current)
		end

	process_all_as (l_as: ALL_AS) is
		do
				-- Nothing to be done
		end

	process_assign_as (l_as: ASSIGN_AS) is
		do
			l_as.target.process (Current)
			l_as.source.process (Current)
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS) is
		do
			l_as.target.process (Current)
			l_as.source.process (Current)
		end

	process_reverse_as (l_as: REVERSE_AS) is
		do
			process_assign_as (l_as)
		end

	process_check_as (l_as: CHECK_AS) is
		do
			safe_process (l_as.check_list)
		end

	process_creation_as (l_as: CREATION_AS) is
		do
			l_as.target.process (Current)
			safe_process (l_as.type)
			safe_process (l_as.call)
		end

	process_debug_as (l_as: DEBUG_AS) is
		do
			safe_process (l_as.compound)
		end

	process_if_as (l_as: IF_AS) is
		do
			l_as.condition.process (Current)
			safe_process (l_as.compound)
			safe_process (l_as.elsif_list)
			safe_process (l_as.else_part)
		end

	process_inspect_as (l_as: INSPECT_AS) is
		do
			l_as.switch.process (Current)
			safe_process (l_as.case_list)
			safe_process (l_as.else_part)
		end

	process_instr_call_as (l_as: INSTR_CALL_AS) is
		do
			l_as.call.process (Current)
		end

	process_loop_as (l_as: LOOP_AS) is
		do
			safe_process (l_as.from_part)
			safe_process (l_as.variant_part)
			safe_process (l_as.invariant_part)
			l_as.stop.process (Current)
			safe_process (l_as.compound)
		end

	process_retry_as (l_as: RETRY_AS) is
		do
				-- Nothing to be done
		end

	process_external_as (l_as: EXTERNAL_AS) is
		do
				-- Nothing to be done
		end

	process_deferred_as (l_as: DEFERRED_AS) is
		do
				-- Nothing to be done
		end

	process_do_as (l_as: DO_AS) is
		do
			safe_process (l_as.compound)
		end

	process_once_as (l_as: ONCE_AS) is
		do
			safe_process (l_as.compound)
		end

	process_type_dec_as (l_as: TYPE_DEC_AS) is
		do
			l_as.type.process (Current)
		end

	process_class_as (l_as: CLASS_AS) is
		do
			safe_process (l_as.top_indexes)
			l_as.class_name.process (Current)
			safe_process (l_as.generics)
			safe_process (l_as.parents)
			safe_process (l_as.creators)
			safe_process (l_as.convertors)
			safe_process (l_as.features)
			safe_process (l_as.invariant_part)
			safe_process (l_as.bottom_indexes)
		end

	process_parent_as (l_as: PARENT_AS) is
		do
			l_as.type.process (Current)
			safe_process (l_as.renaming)
			safe_process (l_as.exports)
			safe_process (l_as.undefining)
			safe_process (l_as.redefining)
			safe_process (l_as.selecting)
		end

	process_like_id_as (l_as: LIKE_ID_AS) is
		do
				-- Nothing to be done
		end

	process_like_cur_as (l_as: LIKE_CUR_AS) is
		do
				-- Nothing to be done
		end

	process_formal_as (l_as: FORMAL_AS) is
		do
				-- Nothing to be done
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS) is
		do
			safe_process (l_as.constraint)
			safe_process (l_as.creation_feature_list)
		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		do
			l_as.class_name.process (Current)
			safe_process (l_as.generics)
		end

	process_none_type_as (l_as: NONE_TYPE_AS) is
		do
				-- Nothing to be done
		end

	process_bits_as (l_as: BITS_AS) is
		do
				-- Nothing to be done
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS) is
		do
				-- Nothing to be done
		end

	process_rename_as (l_as: RENAME_AS) is
		do
			l_as.old_name.process (Current)
			l_as.new_name.process (Current)
		end

	process_invariant_as (l_as: INVARIANT_AS) is
		do
			safe_process (l_as.assertion_list)
		end

	process_interval_as (l_as: INTERVAL_AS) is
		do
			l_as.lower.process (Current)
			safe_process (l_as.upper)
		end

	process_index_as (l_as: INDEX_AS) is
		do
			l_as.index_list.process (Current)
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS) is
		do
			l_as.clients.process (Current)
			safe_process (l_as.features)
		end

	process_elseif_as (l_as: ELSIF_AS) is
		do
			l_as.expr.process (Current)
			safe_process (l_as.compound)
		end

	process_create_as (l_as: CREATE_AS) is
		do
			safe_process (l_as.clients)
			safe_process (l_as.feature_list)
		end

	process_client_as (l_as: CLIENT_AS) is
		do
			l_as.clients.process (Current)
		end

	process_case_as (l_as: CASE_AS) is
		do
			l_as.interval.process (Current)
			safe_process (l_as.compound)
		end

	process_ensure_as (l_as: ENSURE_AS) is
		do
			safe_process (l_as.assertions)
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS) is
		do
			safe_process (l_as.assertions)
		end

	process_require_as (l_as: REQUIRE_AS) is
		do
			safe_process (l_as.assertions)
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS) is
		do
			safe_process (l_as.assertions)
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS) is
		do
			l_as.feature_name.process (Current)
			l_as.conversion_types.process (Current)
		end

	process_void_as (l_as: VOID_AS) is
		do
				-- Nothing to be done
		end

	process_type_list_as (l_as: TYPE_LIST_AS) is
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
		end

	process_convert_feat_list_as (l_as: CONVERT_FEAT_LIST_AS) is
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
		end

	process_class_list_as (l_as: CLASS_LIST_AS) is
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
		end

	process_parent_list_as (l_as: PARENT_LIST_AS) is
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
		end

	process_local_dec_list_as (l_as: LOCAL_DEC_LIST_AS) is
			-- Process `l_as'.
		do
			l_as.locals.process (Current)
		end

	process_formal_argu_dec_list_as (l_as: FORMAL_ARGU_DEC_LIST_AS) is
			-- Process `l_as'.
		do
			l_as.arguments.process (Current)
		end

	process_debug_key_list_as (l_as: DEBUG_KEY_LIST_AS) is
			-- Process `l_as'.
		do
			l_as.keys.process (Current)
		end

	process_delayed_actual_list_as (l_as: DELAYED_ACTUAL_LIST_AS) is
			-- Process `l_as'.
		do
			l_as.operands.process (Current)
		end

	process_parameter_list_as (l_as: PARAMETER_LIST_AS) is
			-- Process `l_as'.
		do
			l_as.parameters.process (Current)
		end

	process_rename_clause_as (l_as: RENAME_CLAUSE_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_export_clause_as (l_as: EXPORT_CLAUSE_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_undefine_clause_as (l_as: UNDEFINE_CLAUSE_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_redefine_clause_as (l_as: REDEFINE_CLAUSE_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_select_clause_as (l_as: SELECT_CLAUSE_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.content)
		end

	process_formal_generic_list_as (l_as: FORMAL_GENERIC_LIST_AS) is
			-- Process `l_as'.
		do
			process_eiffel_list (l_as)
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

end
