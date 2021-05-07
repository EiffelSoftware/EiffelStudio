note
	description: "[
					Roundtrip visitor to simply iterate an AST tree and do nothing
					Usage:
						There are two things that you have to do:
							1. invoke `set_parsed_class' to set on which class this visitor should work
							2. invoke `set_match_list' bacause a LEAF_AS_LIST is needed for roundtrip visiting
						And two things you may need to do:
							1. invoke `set_will_process_leading_leaves' to let the visitor process leading breaks and optional semicolons
							2. invoke `set_will_process_trailing_leaves' to let the visitor process trailing breaks
						or you can call `setup' to do all the things at one time.
					Note: 1. Always `call process_ast_node' to process an AST node, do not use process_xxx directly.
						  2. `process_leading_leaves' and `process_trailing_leaves' are designed to deal with
						  	 non-attached terminals (For more information, see `LEAF_AS_LIST') to make sure they can be
						  	 processed correctly. Before we process every attached terminal, we check if there is any
						  	 non-attached terminal that has not been processed, if so, we process those terminals first. And after we
						  	 have process the last attached-terminal, we check any non-attached terminals have been left, if so,
						  	 we process thoes as well.
				]"

class
	AST_ROUNDTRIP_ITERATOR

inherit
	AST_VISITOR
		redefine
			is_valid
		end

feature -- Status report

	is_valid: BOOLEAN
		do
			Result := parsed_class /= Void and then internal_match_list /= Void
		end

feature -- AST process

	process_ast_node (a_node: AST_EIFFEL)
			-- Process `a_node'.
			-- Note: `a_node' must be included in `parsed_class'.
		require
			is_valid: is_valid
		do
			if
				attached match_list.item_by_start_position (a_node.complete_start_position (match_list)) as l_start_leaf and then
				attached match_list.item_by_end_position (a_node.complete_end_position (match_list)) as l_end_leaf
			then
				start_index := l_start_leaf.index
				end_index := l_end_leaf.index
			end
			last_index := start_index - 1
			safe_process (a_node)
			process_trailing_leaves
		end

feature -- Access

	parsed_class: detachable CLASS_AS
			-- Roundtrip-parsed class
			-- All iteration will be conducted within the scope of this class.

	last_index: INTEGER
			-- Index of last processed item in `match_list'.

	start_index: INTEGER
	end_index: INTEGER
			-- Start and end item index in `match_list'.

	match_list: LEAF_AS_LIST
			-- List of tokens
		require
			is_valid: is_valid
		do
			check attached internal_match_list as l_list then
				Result := l_list
			end
		end

	will_process_leading_leaves: BOOLEAN
			-- Will leading ast nodes (BREAK_AS or SYMBOL_AS:optional semicolon) be processed?	

	will_process_trailing_leaves: BOOLEAN
			-- Will trailing ast nodes (BREAK_AS) be processed?

feature -- Settings

	reset
			-- Reset current
		do
			parsed_class := Void
			internal_match_list := Void
		end

	setup (a_class: CLASS_AS; a_list: LEAF_AS_LIST; will_process_leading, will_process_trailing: BOOLEAN)
			-- Setup environment for roundtrip visit.
		require
			a_class_not_void: a_class /= Void
			a_list_not_void: a_list /= Void
		do
			set_parsed_class (a_class)
			set_match_list (a_list)
			set_will_process_leading_leaves (will_process_leading)
			set_will_process_trailing_leaves (will_process_trailing)
		ensure
			is_valid: is_valid
		end

	set_parsed_class (a_class: CLASS_AS)
			-- Set `parsed_class' with `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			parsed_class := a_class
			last_index := 0
			start_index := 1
		ensure
			parsed_class_set: parsed_class = a_class
		end

	set_match_list (a_list: LEAF_AS_LIST)
			-- Set `match_list' with `a_list'.
		require
			a_list_not_void: a_list /= Void
		do
			internal_match_list := a_list
			end_index := a_list.count
		ensure
			match_list_set: internal_match_list = a_list
		end

	set_will_process_leading_leaves (b: BOOLEAN)
			-- Set `will_process_leading_leaves' with `b'.
		do
			will_process_leading_leaves := b
		ensure
			will_process_leading_leaves_set: will_process_leading_leaves = b
		end

	set_will_process_trailing_leaves (b: BOOLEAN)
			-- Set `will_process_trailing_leaves' with `b'.
		do
			will_process_trailing_leaves := b
		ensure
			will_process_trailing_leaves_set: will_process_trailing_leaves = b
		end

feature -- Roundtrip: process leaf

	process_keyword_as (l_as: KEYWORD_AS)
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_symbol_as (l_as: SYMBOL_AS)
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_break_as (l_as: BREAK_AS)
			-- Process `l_as'.			
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_leaf_stub_as (l_as: LEAF_STUB_AS)
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_symbol_stub_as (l_as: SYMBOL_STUB_AS)
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_keyword_stub_as (l_as: KEYWORD_STUB_AS)
			-- Process `l_as'.
		do
			process_keyword_as (l_as)
		end

	process_bool_as (l_as: BOOL_AS)
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_char_as (l_as: CHAR_AS)
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_result_as (l_as: RESULT_AS)
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_retry_as (l_as: RETRY_AS)
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_unique_as (l_as: UNIQUE_AS)
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_deferred_as (l_as: DEFERRED_AS)
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_void_as (l_as: VOID_AS)
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_string_as (l_as: STRING_AS)
		do
			if l_as.is_once_string then
				safe_process (l_as.once_string_keyword (match_list))
			end
			safe_process (l_as.type)
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS)
		do
			if l_as.is_once_string then
				safe_process (l_as.once_string_keyword (match_list))
			end
			safe_process (l_as.type)
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_current_as (l_as: CURRENT_AS)
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_integer_as (l_as: INTEGER_AS)
		do
			safe_process (l_as.constant_type)
			safe_process (l_as.sign_symbol (match_list))
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_real_as (l_as: REAL_AS)
		do
			safe_process (l_as.constant_type)
			safe_process (l_as.sign_symbol (match_list))
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_id_as (l_as: ID_AS)
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

feature

	process_none_id_as (l_as: NONE_ID_AS)
			-- Process `l_as'.
		do
			-- Do nothing, because this id is automatically inserted by Eiffel compiler,
			-- we should not produce it when doing roundtrip.
		end

	process_typed_char_as (l_as: TYPED_CHAR_AS)
			-- Process `l_as'.
		do
			l_as.type.process (Current)
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.agent_keyword (match_list))
			if l_as.target /= Void then
				safe_process (l_as.lparan_symbol (match_list))
				safe_process (l_as.target)
				safe_process (l_as.rparan_symbol (match_list))
				safe_process (l_as.dot_symbol (match_list))
			end
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_operands)
		end

	process_inline_agent_creation_as (l_as: INLINE_AGENT_CREATION_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.agent_keyword (match_list))
			safe_process (l_as.body)
			safe_process (l_as.internal_operands)
		end

	process_creation_as (l_as: CREATION_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.create_keyword (match_list))
			safe_process (l_as.type)
			safe_process (l_as.target)
			safe_process (l_as.call)
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.create_keyword (match_list))
			safe_process (l_as.type)
			safe_process (l_as.call)
		end

feature

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS)
		do
			safe_process (l_as.creation_expr)
			safe_process (l_as.tuple)
			safe_process (l_as.end_keyword (match_list))
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS)
		do
			safe_process (l_as.feature_keyword (match_list))
			safe_process (l_as.class_type)
			safe_process (l_as.dot_symbol (match_list))
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_parameters)
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
		do
			safe_process (l_as.feature_keyword)
			safe_process (l_as.clients)
			safe_process (l_as.features)
		end

	process_tuple_as (l_as: TUPLE_AS)
		do
			safe_process (l_as.lbracket_symbol (match_list))
			safe_process (l_as.expressions)
			safe_process (l_as.rbracket_symbol (match_list))
		end

	process_array_as (l_as: ARRAY_AS)
		do
			safe_process (l_as.type)
			safe_process (l_as.larray_symbol (match_list))
			safe_process (l_as.expressions)
			safe_process (l_as.rarray_symbol (match_list))
		end

	process_body_as (l_as: BODY_AS)
		do
			safe_process (l_as.internal_arguments)
			safe_process (l_as.colon_symbol (match_list))
			safe_process (l_as.type)
			safe_process (l_as.assign_keyword (match_list))
			safe_process (l_as.assigner)
			safe_process (l_as.is_keyword (match_list))

			if attached {CONSTANT_AS} l_as.content as c_as then
				c_as.process (Current)
				safe_process (l_as.indexing_clause)
			else
				safe_process (l_as.indexing_clause)
				safe_process (l_as.content)
			end
		end

	process_built_in_as (l_as: BUILT_IN_AS)
			-- Process `l_as'.
		do
			process_external_as (l_as)
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS)
		do
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_parameters)
		end

	process_access_inv_as (l_as: ACCESS_INV_AS)
		do
			safe_process (l_as.dot_symbol (match_list))
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_parameters)
		end

	process_access_id_as (l_as: ACCESS_ID_AS)
		do
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_parameters)
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS)
		do
			process_access_feat_as (l_as)
		end

	process_precursor_as (l_as: PRECURSOR_AS)
		do
			safe_process (l_as.precursor_keyword)
			safe_process (l_as.parent_base_class)
			safe_process (l_as.internal_parameters)
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS)
		do
			safe_process (l_as.target)
			safe_process (l_as.dot_symbol (match_list))
			safe_process (l_as.message)
		end

	process_type_expr_as (l_as: TYPE_EXPR_AS)
		do
			safe_process (l_as.type)
		end

	process_routine_as (l_as: ROUTINE_AS)
		do

			safe_process (l_as.obsolete_keyword (match_list))
			safe_process (l_as.obsolete_message)
			safe_process (l_as.precondition)
			safe_process (l_as.internal_locals)
			safe_process (l_as.routine_body)
			safe_process (l_as.postcondition)
			safe_process (l_as.rescue_keyword (match_list))
			safe_process (l_as.rescue_clause)
			safe_process (l_as.end_keyword)
		end

	process_constant_as (l_as: CONSTANT_AS)
		do
			safe_process (l_as.value)
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL])
		local
			i: INTEGER
			j: INTEGER
			n: INTEGER
			m: INTEGER
		do
			from
				n := l_as.count
				i := 1
				check
					consistent_separator_count: attached l_as.separator_list as l implies l.count = n or else l.count = n - 1
				end
				if attached l_as.separator_list as l_sep_list then
					m := l_sep_list.count
					if m >= n then
							-- There is a leading separator, start from index 1.
						j := 1
					end
				else
					m := 0
				end
			until
				i > n
			loop
				if j = 0 then
						-- There is no leading separator, advance to the next one.
					j := 1
				elseif j <= m then
						-- There is a separator, process it.
					safe_process (l_as.separator_list_i_th (j, match_list))
					j := j + 1
				end
					-- Process list element.
				safe_process (l_as [i])
				i := i + 1
			end
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS)
		do
			safe_process (l_as.indexing_keyword (match_list))
			process_eiffel_list (l_as)
			safe_process (l_as.end_keyword (match_list))
		end

	process_operand_as (l_as: OPERAND_AS)
		do
			safe_process (l_as.class_type)
			safe_process (l_as.question_mark_symbol (match_list))
			safe_process (l_as.expression)
		end

	process_tagged_as (l_as: TAGGED_AS)
		do
			safe_process (l_as.tag)
			safe_process (l_as.colon_symbol (match_list))
			safe_process (l_as.class_keyword (match_list))
			safe_process (l_as.expr)
		end

	process_variant_as (l_as: VARIANT_AS)
		do
			safe_process (l_as.variant_keyword (match_list))
			safe_process (l_as.tag)
			safe_process (l_as.colon_symbol (match_list))
			safe_process (l_as.expr)
		end

	process_un_strip_as (l_as: UN_STRIP_AS)
		do
			safe_process (l_as.strip_keyword (match_list))
			safe_process (l_as.lparan_symbol (match_list))
			process_identifier_list (l_as.id_list)
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_converted_expr_as (l_as: CONVERTED_EXPR_AS)
		do
			l_as.expr.process (Current)
		end

	process_paran_as (l_as: PARAN_AS)
		do
			safe_process (l_as.lparan_symbol (match_list))
			l_as.expr.process (Current)
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_expr_call_as (l_as: EXPR_CALL_AS)
		do
			l_as.call.process (Current)
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS)
		do
			safe_process (l_as.address_symbol (match_list))
			safe_process (l_as.lparan_symbol (match_list))
			safe_process (l_as.expr)
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS)
		do
			safe_process (l_as.address_symbol (match_list))
			safe_process (l_as.result_keyword)
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS)
		do
			safe_process (l_as.address_symbol (match_list))
			safe_process (l_as.current_keyword)
		end

	process_address_as (l_as: ADDRESS_AS)
		do
			safe_process (l_as.address_symbol (match_list))
			safe_process (l_as.feature_name)
		end

	process_predecessor_as (a: PREDECESSOR_AS)
			-- <Precursor>
		do
			safe_process (a.predecessor_symbol (match_list))
			safe_process (a.name)
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS)
		do
			check
				should_not_reach_here: False
			end
		end

	process_unary_as (l_as: UNARY_AS)
		do
			safe_process (l_as.operator (match_list))
			safe_process (l_as.expr)
		end

	process_un_free_as (l_as: UN_FREE_AS)
		do
			safe_process (l_as.op_name)
			safe_process (l_as.expr)
		end

	process_un_minus_as (l_as: UN_MINUS_AS)
		do
			process_unary_as (l_as)
		end

	process_un_not_as (l_as: UN_NOT_AS)
		do
			process_unary_as (l_as)
		end

	process_un_old_as (l_as: UN_OLD_AS)
		do
			process_unary_as (l_as)
		end

	process_un_plus_as (l_as: UN_PLUS_AS)
		do
			process_unary_as (l_as)
		end

	process_binary_as (l_as: BINARY_AS)
		do
			safe_process (l_as.left)
			safe_process (l_as.operator (match_list))
			safe_process (l_as.right)
		end

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS)
		do
			safe_process (l_as.left)
			safe_process (l_as.and_keyword (match_list))
			safe_process (l_as.then_keyword (match_list))
			safe_process (l_as.right)
		end

	process_bin_free_as (l_as: BIN_FREE_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_implies_as (l_as: BIN_IMPLIES_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_or_as (l_as: BIN_OR_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_or_else_as (l_as: BIN_OR_ELSE_AS)
		do
			safe_process (l_as.left)
			safe_process (l_as.or_keyword (match_list))
			safe_process (l_as.else_keyword (match_list))
			safe_process (l_as.right)
		end

	process_bin_xor_as (l_as: BIN_XOR_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_ge_as (l_as: BIN_GE_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_gt_as (l_as: BIN_GT_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_le_as (l_as: BIN_LE_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_lt_as (l_as: BIN_LT_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_div_as (l_as: BIN_DIV_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_minus_as (l_as: BIN_MINUS_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_mod_as (l_as: BIN_MOD_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_plus_as (l_as: BIN_PLUS_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_power_as (l_as: BIN_POWER_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_slash_as (l_as: BIN_SLASH_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_star_as (l_as: BIN_STAR_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_and_as (l_as: BIN_AND_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_eq_as (l_as: BIN_EQ_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_ne_as (l_as: BIN_NE_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_tilde_as (l_as: BIN_TILDE_AS)
		do
			process_binary_as (l_as)
		end

	process_bin_not_tilde_as (l_as: BIN_NOT_TILDE_AS)
		do
			process_binary_as (l_as)
		end

	process_bracket_as (l_as: BRACKET_AS)
		do
			safe_process (l_as.target)
			safe_process (l_as.lbracket_symbol)
			safe_process (l_as.operands)
			safe_process (l_as.rbracket_symbol)
		end

	process_object_test_as (l_as: OBJECT_TEST_AS)
		do
			if l_as.is_attached_keyword then
				safe_process (l_as.attached_keyword (match_list))
				safe_process (l_as.type)
				l_as.expression.process (Current)
				safe_process (l_as.as_keyword (match_list))
				safe_process (l_as.name)
			else
				safe_process (l_as.lcurly_symbol (match_list))
				safe_process (l_as.name)
				safe_process (l_as.type)
				l_as.expression.process (Current)
			end
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS)
		do
			l_as.language_name.process (Current)
		end

	process_feature_as (l_as: FEATURE_AS)
		do
			safe_process (l_as.feature_names)
			safe_process (l_as.body)
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS)
		do
			safe_process (l_as.frozen_keyword)
			safe_process (l_as.feature_name)
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS)
		do
			safe_process (l_as.frozen_keyword)
			safe_process (l_as.feature_name)
			across
				l_as.aliases as ic
			loop
				safe_process (l_as.keyword_at (match_list, ic.item.alias_keyword_index))
				safe_process (ic.item.alias_name)
			end
			if l_as.convert_keyword_index > 0 then
				safe_process (l_as.convert_keyword (match_list))
			end

		end

	process_feature_list_as (l_as: FEATURE_LIST_AS)
		do
			safe_process (l_as.features)
		end

	process_all_as (l_as: ALL_AS)
		do
			safe_process (l_as.all_keyword (match_list))
		end

	process_assign_as (l_as: ASSIGN_AS)
		do
			safe_process (l_as.target)
			safe_process (l_as.assignment_symbol (match_list))
			safe_process (l_as.source)
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS)
		do
			safe_process (l_as.target)
			safe_process (l_as.assignment_symbol)
			safe_process (l_as.source)
		end

	process_reverse_as (l_as: REVERSE_AS)
		do
			safe_process (l_as.target)
			safe_process (l_as.assignment_symbol (match_list))
			safe_process (l_as.source)
		end

	process_check_as (l_as: CHECK_AS)
		do
			safe_process (l_as.check_keyword (match_list))
			safe_process (l_as.full_assertion_list)
			safe_process (l_as.end_keyword)
		end

	process_debug_as (l_as: DEBUG_AS)
		do
			safe_process (l_as.debug_keyword (match_list))
			safe_process (l_as.internal_keys)
			safe_process (l_as.compound)
			safe_process (l_as.end_keyword)
		end

	process_guard_as (l_as: GUARD_AS)
		do
			safe_process (l_as.check_keyword (match_list))
			safe_process (l_as.full_assertion_list)
			safe_process (l_as.then_keyword (match_list))
			safe_process (l_as.compound)
			safe_process (l_as.end_keyword)
		end

	process_if_as (l_as: IF_AS)
		do
			safe_process (l_as.if_keyword (match_list))
			safe_process (l_as.condition)
			safe_process (l_as.then_keyword (match_list))
			safe_process (l_as.compound)
			safe_process (l_as.elsif_list)
			safe_process (l_as.else_keyword (match_list))
			safe_process (l_as.else_part)
			safe_process (l_as.end_keyword)
		end

	process_if_expression_as (l_as: IF_EXPRESSION_AS)
		do
			safe_process (l_as.if_keyword (match_list))
			l_as.condition.process (Current)
			safe_process (l_as.then_keyword (match_list))
			l_as.then_expression.process (Current)
			safe_process (l_as.elsif_list)
			safe_process (l_as.else_keyword (match_list))
			l_as.else_expression.process (Current)
			safe_process (l_as.end_keyword)
		end

	process_inspect_abstraction (a: INSPECT_ABSTRACTION_AS [CASE_ABSTRACTION_AS [detachable AST_EIFFEL], detachable AST_EIFFEL])
			-- Process `a`.
		do
			safe_process (a.inspect_keyword (match_list))
			safe_process (a.switch)
			safe_process (a.case_list)
			safe_process (a.else_keyword (match_list))
			safe_process (a.else_part)
			safe_process (a.end_keyword)
		end

	process_inspect_as (a: INSPECT_AS)
		do
			process_inspect_abstraction (a)
		end

	process_inspect_expression_as (a: INSPECT_EXPRESSION_AS)
		do
			process_inspect_abstraction (a)
		end

	process_instr_call_as (l_as: INSTR_CALL_AS)
		do
			l_as.call.process (Current)
		end

	process_loop_as (l_as: LOOP_AS)
		local
			l_until: detachable KEYWORD_AS
			l_variant_processing_after: BOOLEAN
			l_variant_part: detachable VARIANT_AS
			i: ITERATION_AS
		do
			i := l_as.iteration
			if attached i and then i.is_symbolic then
					-- The loop is of the form
					-- ⟳ var: expr ¦ compound ⟲
				safe_process (l_as.repeat_symbol (match_list))
				i.process (Current)
				safe_process (l_as.compound)
				safe_process (l_as.end_symbol)
			else
				safe_process (i)
				safe_process (l_as.from_keyword (match_list))
				safe_process (l_as.from_part)
				safe_process (l_as.invariant_keyword (match_list))
				safe_process (l_as.full_invariant_list)
					-- Special code to handle the old or new ordering of the `variant'
					-- clause in a loop.
				l_until := l_as.until_keyword (match_list)
				l_variant_part := l_as.variant_part
				if l_until = Void then
						-- Must be across loop
					l_variant_processing_after := True
				elseif l_variant_part /= Void then
					if l_variant_part.start_position > l_until.start_position then
						l_variant_processing_after := True
					else
						l_variant_part.process (Current)
					end
				end
				safe_process (l_until)
				safe_process (l_as.stop)
				safe_process (l_as.loop_keyword (match_list))
				safe_process (l_as.compound)
				if l_variant_part /= Void and l_variant_processing_after then
					l_variant_part.process (Current)
				end
				safe_process (l_as.end_keyword)
			end
		end

	process_iteration_as (a: ITERATION_AS)
			-- <Precursor>
		do
			if a.is_symbolic then
				a.identifier.process (Current)
				safe_process (a.in_symbol (match_list))
				a.expression.process (Current)
				safe_process (a.bar_symbol (match_list))
			else
				safe_process (a.across_keyword (match_list))
				a.expression.process (Current)
				safe_process (a.as_keyword (match_list))
				a.identifier.process (Current)
			end
		end

	process_loop_expr_as (l_as: LOOP_EXPR_AS)
		local
			i: ITERATION_AS
		do
			i := l_as.iteration
			if i.is_symbolic then
					-- The loop is of the form
					-- ∀ var: expr | expr
				safe_process (l_as.qualifier_symbol (match_list))
				i.process (Current)
				l_as.expression.process (Current)
			else
					-- The loop is of the form
					-- across expr as var [invariant expr] [until expr] all expr [variant expr] end
				i.process (Current)
				safe_process (l_as.invariant_keyword (match_list))
				safe_process (l_as.full_invariant_list)
				safe_process (l_as.until_keyword (match_list))
				safe_process (l_as.exit_condition)
				safe_process (l_as.qualifier_keyword (match_list))
				l_as.expression.process (Current)
				safe_process (l_as.variant_part)
				safe_process (l_as.end_keyword)
			end
		end

	process_separate_instruction_as (a: SEPARATE_INSTRUCTION_AS)
			-- <Precursor>
		do
			safe_process (a.separate_keyword (match_list))
			a.arguments.process (Current)
			safe_process (a.do_keyword (match_list))
			safe_process (a.compound)
			a.end_keyword.process (Current)
		end

	process_external_as (l_as: EXTERNAL_AS)
		do
			safe_process (l_as.external_keyword (match_list))
			safe_process (l_as.language_name)
			safe_process (l_as.alias_keyword (match_list))
			safe_process (l_as.alias_name_literal)
		end

	process_attribute_as (l_as: ATTRIBUTE_AS)
		do
			safe_process (l_as.attribute_keyword (match_list))
			safe_process (l_as.compound)
		end

	process_do_as (l_as: DO_AS)
		do
			safe_process (l_as.do_keyword (match_list))
			safe_process (l_as.compound)
		end

	process_once_as (l_as: ONCE_AS)
		do
			safe_process (l_as.once_keyword (match_list))
			safe_process (l_as.internal_keys)
			safe_process (l_as.compound)
		end

	process_list_dec_as (l_as: LIST_DEC_AS)
		do
			process_identifier_list (l_as.id_list)
		end

	process_type_dec_as (l_as: TYPE_DEC_AS)
		do
			process_identifier_list (l_as.id_list)
			safe_process (l_as.colon_symbol (match_list))
			safe_process (l_as.type)
		end

	process_class_as (l_as: CLASS_AS)
		do
			safe_process (l_as.internal_top_indexes)
			safe_process (l_as.frozen_keyword (match_list))
			safe_process (l_as.deferred_keyword (match_list))
			safe_process (l_as.expanded_keyword (match_list))
			safe_process (l_as.once_keyword (match_list))
			safe_process (l_as.external_keyword (match_list))
			safe_process (l_as.class_keyword (match_list))
			safe_process (l_as.class_name)
			safe_process (l_as.internal_generics)
			safe_process (l_as.alias_keyword (match_list))
			safe_process (l_as.external_class_name)
			safe_process (l_as.obsolete_keyword (match_list))
			safe_process (l_as.obsolete_message)
			safe_process (l_as.internal_conforming_parents)
			safe_process (l_as.internal_non_conforming_parents)
			safe_process (l_as.creators)
			safe_process (l_as.convertors)
			safe_process (l_as.features)
			safe_process (l_as.internal_invariant)
			safe_process (l_as.internal_bottom_indexes)
			safe_process (l_as.end_keyword)
		end

	process_parent_as (l_as: PARENT_AS)
		do
			safe_process (l_as.type)
			safe_process (l_as.internal_renaming)
			safe_process (l_as.internal_exports)
			safe_process (l_as.internal_undefining)
			safe_process (l_as.internal_redefining)
			safe_process (l_as.internal_selecting)
			safe_process (l_as.end_keyword (match_list))
		end

	process_like_id_as (l_as: LIKE_ID_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.attachment_mark (match_list))
			safe_process (l_as.like_keyword (match_list))
			safe_process (l_as.anchor)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_like_cur_as (l_as: LIKE_CUR_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.attachment_mark (match_list))
			safe_process (l_as.like_keyword (match_list))
			safe_process (l_as.current_keyword)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_qualified_anchored_type_as (l_as: QUALIFIED_ANCHORED_TYPE_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.attachment_mark (match_list))
			safe_process (l_as.like_keyword (match_list))
			safe_process (l_as.qualifier)
			safe_process (l_as.chain)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_feature_id_as (l_as: FEATURE_ID_AS)
			-- <Precursor>
		do
			safe_process (l_as.name)
		end

	process_formal_as (l_as: FORMAL_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.attachment_mark (match_list))
			safe_process (l_as.formal_keyword (match_list))
			safe_process (l_as.name)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS)
		do
			safe_process (l_as.formal)
			safe_process (l_as.constrain_symbol (match_list))
			safe_process (l_as.constraints)
			safe_process (l_as.create_keyword (match_list))
			safe_process (l_as.creation_feature_list)
			safe_process (l_as.end_keyword (match_list))
		end

	process_class_type_as (l_as: CLASS_TYPE_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.attachment_mark (match_list))
			safe_process (l_as.expanded_keyword (match_list))
			safe_process (l_as.separate_keyword (match_list))
			safe_process (l_as.class_name)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.attachment_mark (match_list))
			safe_process (l_as.expanded_keyword (match_list))
			safe_process (l_as.separate_keyword (match_list))
			safe_process (l_as.class_name)
			safe_process (l_as.internal_generics)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.attachment_mark (match_list))
			safe_process (l_as.separate_keyword (match_list))
			safe_process (l_as.class_name)
			safe_process (l_as.parameters)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_constraining_type_as (l_as: CONSTRAINING_TYPE_AS)
		do
			l_as.type.process (Current)
			safe_process (l_as.renaming)
			safe_process (l_as.end_keyword (match_list))
		end

	process_none_type_as (l_as: NONE_TYPE_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.class_name_literal)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_rename_as (l_as: RENAME_AS)
		do
			safe_process (l_as.old_name)
			safe_process (l_as.as_keyword (match_list))
			safe_process (l_as.new_name)
		end

	process_invariant_as (l_as: INVARIANT_AS)
		do
			safe_process (l_as.invariant_keyword (match_list))
			safe_process (l_as.full_assertion_list)
		end

	process_interval_as (l_as: INTERVAL_AS)
		do
			safe_process (l_as.lower)
			safe_process (l_as.dotdot_symbol)
			safe_process (l_as.upper)
		end

	process_index_as (l_as: INDEX_AS)
		do
			safe_process (l_as.tag)
			safe_process (l_as.colon_symbol (match_list))
			safe_process (l_as.index_list)
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS)
		do
			safe_process (l_as.clients)
			safe_process (l_as.features)
		end

	process_elseif_as (l_as: ELSIF_AS)
		do
			safe_process (l_as.elseif_keyword (match_list))
			safe_process (l_as.expr)
			safe_process (l_as.then_keyword (match_list))
			safe_process (l_as.compound)
		end

	process_elseif_expression_as (l_as: ELSIF_EXPRESSION_AS)
		do
			safe_process (l_as.elseif_keyword (match_list))
			l_as.condition.process (Current)
			safe_process (l_as.then_keyword (match_list))
			l_as.expression.process (Current)
		end

	process_create_as (l_as: CREATE_AS)
		do
			safe_process (l_as.create_creation_keyword (match_list))
			safe_process (l_as.clients)
			safe_process (l_as.feature_list)
		end

	process_client_as (l_as: CLIENT_AS)
		do
			safe_process (l_as.clients)
		end

	process_case_abstraction (a: CASE_ABSTRACTION_AS [detachable AST_EIFFEL])
			-- Process `a`.
		do
			safe_process (a.when_keyword (match_list))
			safe_process (a.interval)
			safe_process (a.then_keyword (match_list))
			safe_process (a.content)
		end

	process_case_as (a: CASE_AS)
		do
			process_case_abstraction (a)
		end

	process_case_expression_as (a: CASE_EXPRESSION_AS)
		do
			process_case_abstraction (a)
		end

	process_ensure_as (l_as: ENSURE_AS)
		do
			safe_process (l_as.ensure_keyword (match_list))
			safe_process (l_as.full_assertion_list)
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS)
		do
			safe_process (l_as.ensure_keyword (match_list))
			safe_process (l_as.then_keyword (match_list))
			safe_process (l_as.full_assertion_list)
		end

	process_require_as (l_as: REQUIRE_AS)
		do
			safe_process (l_as.require_keyword (match_list))
			safe_process (l_as.full_assertion_list)
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS)
		do
			safe_process (l_as.require_keyword (match_list))
			safe_process (l_as.else_keyword (match_list))
			safe_process (l_as.full_assertion_list)
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS)
		do
			safe_process (l_as.feature_name)
			safe_process (l_as.colon_symbol (match_list))
			safe_process (l_as.lparan_symbol (match_list))
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.conversion_types)
			safe_process (l_as.rcurly_symbol (match_list))
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_type_list_as (l_as: TYPE_LIST_AS)
		do
			safe_process (l_as.opening_bracket_as (match_list))
			process_eiffel_list (l_as)
			safe_process (l_as.closing_bracket_as (match_list))
		end

	process_list_dec_list_as (l_as: LIST_DEC_LIST_AS)
		do
			safe_process (l_as.opening_bracket_as (match_list))
			process_eiffel_list (l_as)
			safe_process (l_as.closing_bracket_as (match_list))
		end

	process_type_dec_list_as (l_as: TYPE_DEC_LIST_AS)
		do
			safe_process (l_as.opening_bracket_as (match_list))
			process_eiffel_list (l_as)
			safe_process (l_as.closing_bracket_as (match_list))
		end

	process_convert_feat_list_as (l_as: CONVERT_FEAT_LIST_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.convert_keyword (match_list))
			process_eiffel_list (l_as)
		end

	process_class_list_as (l_as: CLASS_LIST_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_eiffel_list (l_as)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_parent_list_as (l_as: PARENT_LIST_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.inherit_keyword (match_list))
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.none_id_as (match_list))
			safe_process (l_as.rcurly_symbol (match_list))
			process_eiffel_list (l_as)
		end

	process_local_dec_list_as (l_as: LOCAL_DEC_LIST_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.local_keyword (match_list))
			safe_process(l_as.locals)
		end

	process_formal_argu_dec_list_as (l_as: FORMAL_ARGU_DEC_LIST_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.lparan_symbol (match_list))
			safe_process (l_as.arguments)
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_key_list_as (l_as: KEY_LIST_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.lparan_symbol (match_list))
			safe_process (l_as.keys)
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_delayed_actual_list_as (l_as: DELAYED_ACTUAL_LIST_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.lparan_symbol (match_list))
			safe_process (l_as.operands)
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_parameter_list_as (l_as: PARAMETER_LIST_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.lparan_symbol (match_list))
			safe_process (l_as.parameters)
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_named_expression_as (a_as: NAMED_EXPRESSION_AS)
			-- <Precursor>
		do
			a_as.expression.process (Current)
			safe_process (a_as.as_keyword (match_list))
			a_as.name.process (Current)
		end

	process_rename_clause_as (l_as: RENAME_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.rename_keyword (match_list))
			safe_process (l_as.content)
		end

	process_export_clause_as (l_as: EXPORT_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.export_keyword (match_list))
			safe_process (l_as.content)
		end

	process_undefine_clause_as (l_as: UNDEFINE_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.undefine_keyword (match_list))
			safe_process (l_as.content)
		end

	process_redefine_clause_as (l_as: REDEFINE_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.redefine_keyword (match_list))
			safe_process (l_as.content)
		end

	process_select_clause_as (l_as: SELECT_CLAUSE_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.select_keyword (match_list))
			safe_process (l_as.content)
		end

	process_formal_generic_list_as (l_as: FORMAL_GENERIC_LIST_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.lsqure_symbol (match_list))
			process_eiffel_list (l_as)
			safe_process (l_as.rsqure_symbol (match_list))
		end

feature

	process_all_break_as
			-- Process all BREAK AST nodes in `match_list'.
		require
			match_list_not_void: match_list /= Void
			leading_leaves_not_processed: not will_process_leading_leaves
		local
			l_start_index, l_end_index, l_last_index: INTEGER
			l_index: INTEGER
		do
			l_start_index := start_index
			l_end_index := end_index
			l_last_index := last_index
			from
				l_index := 1
				start_index := 1
				last_index := 0
				end_index := match_list.count
			until
				l_index > end_index
			loop
				if attached {BREAK_AS} match_list.i_th (l_index) as l_break then
					l_break.process (Current)
				end
				l_index := l_index + 1
			end
			start_index := l_start_index
			end_index := l_end_index
			last_index := l_last_index
		end

feature{NONE} -- Implementation

	process_leading_leaves (ind: INTEGER)
			-- Process all not-processed leading leaves in `match_list' before index `ind'.
		require
			valid_index: ind >= start_index and then ind <= end_index
		local
			i: INTEGER
		do
			if
				will_process_leading_leaves and then
				ind > last_index + 1
			then
				from
					i := last_index + 1
				until
					i = ind
				loop
					match_list.i_th (i).process (Current)
					i := i + 1
				end
			end
		end

	process_trailing_leaves
			-- Process all trailing leaves in `match_list' after `last_index'.
		local
			l_count: INTEGER
		do
			if will_process_trailing_leaves then
				l_count := end_index
				if last_index < l_count then
					from
						last_index := last_index + 1
					until
						last_index > l_count
					loop
						match_list.i_th (last_index).process (Current)
						last_index := last_index + 1
					end
				end
			end
		end

	process_identifier_list (l_as: IDENTIFIER_LIST)
			-- Process `l_as'
		local
			i, l_count: INTEGER
			l_index: INTEGER
			l_id_as: ID_AS
			l_leaf: LEAF_AS
		do
			if
				attached l_as and then
				attached l_as.id_list as l_ids and then
				l_ids.count > 0
			then
				across
					l_ids as id_as_index
				from
					i := 1
						-- Temporary/reused objects to print identifiers.
					create l_id_as.initialize_from_id (1)
					if attached l_as.separator_list as l_sep_list then
						l_count := l_sep_list.count
					end
				loop
					l_index := id_as_index.item
					if match_list.valid_index (l_index) then
						l_leaf := match_list.i_th (l_index)
							-- Note that we do not set the `name_id' for `l_id_as' since it will require
							-- updating the NAMES_HEAP and we do not want to do that. It is assumed in roundtrip
							-- mode that the text is never obtained from the node itself but from the `text' queries.
						l_id_as.set_position (l_leaf.line, l_leaf.column, l_leaf.position, l_leaf.location_count,
							l_leaf.character_column, l_leaf.character_position, l_leaf.character_count)
						l_id_as.set_index (l_index)
						safe_process (l_id_as)
					end
					if i <= l_count then
						safe_process (l_as.separator_list_i_th (i, match_list))
						i := i + 1
					end
				end
			end
		end

	internal_match_list: detachable like match_list
			-- Storage for `match_list'.

;note
	ca_ignore: "CA033", "CA033: too large class"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
