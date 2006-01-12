indexing
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
				]"
	author: ""
	date: ""
	revision: ""

class
	AST_ROUNDTRIP_ITERATOR

inherit
	AST_VISITOR
		redefine
			process_type_a
		end

feature -- AST process

	process_ast_node (a_node: AST_EIFFEL) is
			-- Process `a_node'.
			-- Note: `a_node' must be included in `parsed_class'.
		require
			parsed_not_void: parsed_class /= Void
			match_list_not_void: match_list /= Void
		do
			start_index := match_list.item_by_start_position (a_node.complete_start_position (match_list)).index
			end_index := match_list.item_by_end_position (a_node.complete_end_position (match_list)).index
			last_index := start_index - 1
			safe_process (a_node)
			process_trailing_leaves
		end

feature -- Access

	parsed_class: CLASS_AS
			-- Roundtrip-parsed class
			-- All iteration will be conducted within the scope of this class.

	last_index: INTEGER
			-- Index of last processed item in `match_list'.

	start_index: INTEGER
	end_index: INTEGER
			-- Start and end item index in `match_list'.

	match_list: LEAF_AS_LIST
			-- List of tokens

	will_process_leading_leaves: BOOLEAN
			-- Will leading ast nodes (BREAK_AS or SYMBOL_AS:optional semicolon) be processed?	

	will_process_trailing_leaves: BOOLEAN
			-- Will trailing ast nodes (BREAK_AS) be processed?

feature -- Settings

	setup (a_class: CLASS_AS; a_list: LEAF_AS_LIST; will_process_leading, will_process_trailing: BOOLEAN) is
			-- Setup environment for roundtrip visit.
		require
			a_class_not_void: a_class /= Void
			a_list_not_void: a_list /= Void
		do
			set_parsed_class (a_class)
			set_match_list (a_list)
			set_will_process_leading_leaves (will_process_leading)
			set_will_process_trailing_leaves (will_process_trailing)
		end

	set_parsed_class (a_class: CLASS_AS) is
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

	set_match_list (a_list: LEAF_AS_LIST) is
			-- Set `match_list' with `a_list'.
		require
			a_list_not_void: a_list /= Void
		do
			match_list := a_list
			end_index := match_list.count
		ensure
			match_list_set: match_list = a_list
		end

	set_will_process_leading_leaves (b: BOOLEAN) is
			-- Set `will_process_leading_leaves' with `b'.
		do
			will_process_leading_leaves := b
		ensure
			will_process_leading_leaves_set: will_process_leading_leaves = b
		end

	set_will_process_trailing_leaves (b: BOOLEAN) is
			-- Set `will_process_trailing_leaves' with `b'.
		do
			will_process_trailing_leaves := b
		ensure
			will_process_trailing_leaves_set: will_process_trailing_leaves = b
		end

feature -- Roundtrip: process leaf

	process_keyword_as (l_as: KEYWORD_AS) is
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_symbol_as (l_as: SYMBOL_AS) is
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_separator_as (l_as: SEPARATOR_AS) is
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_new_line_as (l_as: NEW_LINE_AS) is
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_comment_as (l_as: COMMENT_AS) is
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_break_as (l_as: BREAK_AS) is
			-- Process `l_as'.			
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_bool_as (l_as: BOOL_AS) is
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_char_as (l_as: CHAR_AS) is
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_result_as (l_as: RESULT_AS) is
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_retry_as (l_as: RETRY_AS) is
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_unique_as (l_as: UNIQUE_AS) is
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_deferred_as (l_as: DEFERRED_AS) is
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_void_as (l_as: VOID_AS) is
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_string_as (l_as: STRING_AS) is
		do
			if l_as.is_once_string then
				safe_process (l_as.once_string_keyword)
			end
			safe_process (l_as.type)
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS) is
		do
			if l_as.is_once_string then
				safe_process (l_as.once_string_keyword)
			end
			safe_process (l_as.type)
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_current_as (l_as: CURRENT_AS) is
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_integer_as (l_as: INTEGER_AS) is
		do
			safe_process (l_as.constant_type)
			safe_process (l_as.sign_symbol)
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_real_as (l_as: REAL_AS) is
		do
			safe_process (l_as.constant_type)
			safe_process (l_as.sign_symbol)
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

	process_id_as (l_as: ID_AS) is
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
		end

feature

	process_bit_const_as (l_as: BIT_CONST_AS) is
		do
			safe_process (l_as.value)
		end

	process_none_id_as (l_as: NONE_ID_AS) is
			-- Process `l_as'.
		do
			-- Do nothing, because this id is automatically inserted by Eiffel compiler,
			-- we should not produce it when doing roundtrip.
		end

	process_typed_char_as (l_as: TYPED_CHAR_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.type)
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.agent_keyword)
			if l_as.target /= Void then
				safe_process (l_as.lparan_symbol)
				l_as.target.process (Current)
				safe_process (l_as.rparan_symbol)
				safe_process (l_as.dot_symbol)
			end
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_operands)
		end

	process_tilda_routine_creation_as (l_as: TILDA_ROUTINE_CREATION_AS) is
			-- Process `l_as'.
		do
			if l_as.target /= Void then
				safe_process (l_as.lparan_symbol)
				l_as.target.process (Current)
				safe_process (l_as.rparan_symbol)
			end
			safe_process (l_as.tilda_symbol)
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_operands)
		end

	process_create_creation_as (l_as: CREATE_CREATION_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.create_keyword)
			safe_process (l_as.type)
			safe_process (l_as.target)
			safe_process (l_as.call)
		end

	process_bang_creation_as (l_as: BANG_CREATION_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.lbang_symbol)
			safe_process (l_as.type)
			safe_process (l_as.rbang_symbol)
			safe_process (l_as.target)
			safe_process (l_as.call)
		end

	process_create_creation_expr_as (l_as: CREATE_CREATION_EXPR_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.create_keyword)
			safe_process (l_as.type)
			safe_process (l_as.call)
		end

	process_bang_creation_expr_as (l_as: BANG_CREATION_EXPR_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as.lbang_symbol)
			safe_process (l_as.type)
			safe_process (l_as.rbang_symbol)
			safe_process (l_as.call)
		end

feature

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS) is
		do
			safe_process (l_as.creation_expr)
			safe_process (l_as.tuple)
			safe_process (l_as.end_keyword)
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
		do
			safe_process (l_as.feature_keyword)
			safe_process (l_as.class_type)
			safe_process (l_as.dot_symbol)
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_parameters)
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS) is
		local
			feature_keyword: LEAF_AS
		do
			feature_keyword ?= l_as.feature_keyword
			safe_process (feature_keyword)
			safe_process (l_as.clients)
			safe_process (l_as.features)
		end

	process_tuple_as (l_as: TUPLE_AS) is
		do
			safe_process (l_as.lbracket)
			safe_process (l_as.expressions)
			safe_process (l_as.rbracket)
		end

	process_array_as (l_as: ARRAY_AS) is
		do
			safe_process (l_as.larray)
			safe_process (l_as.expressions)
			safe_process (l_as.rarray)
		end

	process_body_as (l_as: BODY_AS) is
		local
			c_as: CONSTANT_AS
		do
			safe_process (l_as.internal_arguments)
			safe_process (l_as.colon_symbol)
			safe_process (l_as.type)
			safe_process (l_as.assign_keyword)
			safe_process (l_as.assigner)
			safe_process (l_as.is_keyword)

			c_as ?= l_as.content
			if c_as /= Void then
				l_as.content.process (Current)
				safe_process (l_as.indexing_clause)
			else
				safe_process (l_as.indexing_clause)
				safe_process (l_as.content)
			end
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
		do
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_parameters)
		end

	process_access_inv_as (l_as: ACCESS_INV_AS) is
		do
			safe_process (l_as.dot_symbol)
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_parameters)
		end

	process_access_id_as (l_as: ACCESS_ID_AS) is
		do
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_parameters)
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS) is
		do
			process_access_feat_as (l_as)
		end

	process_precursor_as (l_as: PRECURSOR_AS) is
		do
			safe_process (l_as.precursor_keyword)
			safe_process (l_as.parent_base_class)
			safe_process (l_as.internal_parameters)
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS) is
		do
			safe_process (l_as.lparan_symbol)
			safe_process (l_as.target)
			safe_process (l_as.rparan_symbol)
			safe_process (l_as.dot_symbol)
			safe_process (l_as.message)
		end

	process_nested_as (l_as: NESTED_AS) is
		do
			safe_process (l_as.target)
			safe_process (l_as.dot_symbol)
			safe_process (l_as.message)
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS) is
		do
			check
				should_not_reach_here: False
			end
		end

	process_type_expr_as (l_as: TYPE_EXPR_AS) is
		do
			safe_process (l_as.type)
		end

	process_routine_as (l_as: ROUTINE_AS) is
		do

			safe_process (l_as.obsolete_keyword)
			safe_process (l_as.obsolete_message)
			safe_process (l_as.precondition)
			safe_process (l_as.locals)
			safe_process (l_as.routine_body)
			safe_process (l_as.postcondition)
			safe_process (l_as.rescue_keyword)
			safe_process (l_as.rescue_clause)
			safe_process (l_as.end_keyword)
		end

	process_constant_as (l_as: CONSTANT_AS) is
		do
			safe_process (l_as.value)
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL]) is
		local
			i, l_count: INTEGER
		do
			safe_process (l_as.pre_as_list)
			if l_as.count > 0 then
				from
					l_as.start
					i := 1
					if l_as.separator_list /= Void then
						l_count := l_as.separator_list.count
					end
				until
					l_as.after
				loop
					safe_process (l_as.item)
					if i <= l_count then
						safe_process (l_as.separator_list.i_th (i))
						i := i + 1
					end
					l_as.forth
				end
			end
			safe_process (l_as.post_as_list)
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS) is
		do
			process_eiffel_list (l_as)
		end

	process_operand_as (l_as: OPERAND_AS) is
		do
			safe_process (l_as.class_type)
			if l_as.question_mark_symbol /= Void then
				l_as.question_mark_symbol.process (Current)
			end
			safe_process (l_as.target)
			safe_process (l_as.expression)
		end

	process_tagged_as (l_as: TAGGED_AS) is
		do
			safe_process (l_as.tag)
			safe_process (l_as.colon_symbol)
			safe_process (l_as.expr)
		end

	process_variant_as (l_as: VARIANT_AS) is
		do
			safe_process (l_as.variant_keyword)
			safe_process (l_as.tag)
			safe_process (l_as.colon_symbol)
			safe_process (l_as.expr)
		end

	process_un_strip_as (l_as: UN_STRIP_AS) is
		local
			i_as: IDENTIFIER_LIST
		do
			i_as ?= l_as.id_list
			safe_process (l_as.strip_keyword)
			safe_process (i_as.id_list)
		end

	process_paran_as (l_as: PARAN_AS) is
		do
			safe_process (l_as.lparan_symbol)
			safe_process (l_as.expr)
			safe_process (l_as.rparan_symbol)
		end

	process_expr_call_as (l_as: EXPR_CALL_AS) is
		do
			l_as.call.process (Current)
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS) is
		do
			safe_process (l_as.address_symbol)
			safe_process (l_as.lparan_symbol)
			safe_process (l_as.expr)
			safe_process (l_as.rparan_symbol)
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS) is
		do
			safe_process (l_as.address_symbol)
			safe_process (l_as.result_keyword)
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS) is
		do
			safe_process (l_as.address_symbol)
			safe_process (l_as.current_keyword)
		end

	process_address_as (l_as: ADDRESS_AS) is
		do
			safe_process (l_as.address_symbol)
			safe_process (l_as.feature_name)
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS) is
		do
			check
				should_not_reach_here: False
			end
		end

	process_unary_as (l_as: UNARY_AS) is
		do
			safe_process (l_as.operator)
			safe_process (l_as.expr)
		end

	process_un_free_as (l_as: UN_FREE_AS) is
		do
			safe_process (l_as.op_name)
			safe_process (l_as.expr)
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
			safe_process (l_as.left)
			safe_process (l_as.operator)
			safe_process (l_as.right)
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
			safe_process (l_as.target)
			safe_process (l_as.lbracket_symbol)
			safe_process (l_as.operands)
			safe_process (l_as.rbracket_symbol)
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS) is
		do
			l_as.language_name.process (Current)
		end

	process_feature_as (l_as: FEATURE_AS) is
		do
			safe_process (l_as.feature_names)
			safe_process (l_as.body)
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
		do
			safe_process (l_as.frozen_keyword)
			safe_process (l_as.infix_prefix_keyword)
			safe_process (l_as.alias_name)
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS) is
		do
			safe_process (l_as.frozen_keyword)
			safe_process (l_as.feature_name)
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS) is
		do
			safe_process (l_as.frozen_keyword)
			safe_process (l_as.feature_name)
			if l_as.alias_name /= Void then
				safe_process (l_as.alias_keyword)
				safe_process (l_as.alias_name)
				if l_as.has_convert_mark then
					safe_process (l_as.convert_keyword)
				end
			end
		end

	process_feature_list_as (l_as: FEATURE_LIST_AS) is
		do
			safe_process (l_as.features)
		end

	process_all_as (l_as: ALL_AS) is
		do
			safe_process (l_as.all_keyword)
		end

	process_assign_as (l_as: ASSIGN_AS) is
		do
			safe_process (l_as.target)
			safe_process (l_as.assignment_symbol)
			safe_process (l_as.source)
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS) is
		do
			safe_process (l_as.target)
			safe_process (l_as.assignment_symbol)
			safe_process (l_as.source)
		end

	process_reverse_as (l_as: REVERSE_AS) is
		do
			safe_process (l_as.target)
			safe_process (l_as.assignment_symbol)
			safe_process (l_as.source)
		end

	process_check_as (l_as: CHECK_AS) is
		do
			safe_process (l_as.check_keyword)
			safe_process (l_as.full_assertion_list)
			safe_process (l_as.end_keyword)
		end

	process_creation_as (l_as: CREATION_AS) is
		do
			check
				Should_not_reach_here: False
			end
		end

	process_debug_as (l_as: DEBUG_AS) is
		do
			safe_process (l_as.debug_keyword)
			safe_process (l_as.internal_keys)
			safe_process (l_as.compound)
			safe_process (l_as.end_keyword)
		end

	process_if_as (l_as: IF_AS) is
		do
			safe_process (l_as.if_keyword)
			safe_process (l_as.condition)
			safe_process (l_as.then_keyword)
			safe_process (l_as.compound)
			safe_process (l_as.elsif_list)
			safe_process (l_as.else_keyword)
			safe_process (l_as.else_part)
			safe_process (l_as.end_keyword)
		end

	process_inspect_as (l_as: INSPECT_AS) is
		do
			safe_process (l_as.inspect_keyword)
			safe_process (l_as.switch)
			safe_process (l_as.case_list)
			safe_process (l_as.else_keyword)
			safe_process (l_as.else_part)
			safe_process (l_as.end_keyword)
		end

	process_instr_call_as (l_as: INSTR_CALL_AS) is
		do
			l_as.call.process (Current)
		end

	process_loop_as (l_as: LOOP_AS) is
		do
			safe_process (l_as.from_keyword)
			safe_process (l_as.from_part)
			safe_process (l_as.invariant_keyword)
			safe_process (l_as.full_invariant_list)
			safe_process (l_as.variant_part)
			safe_process (l_as.until_keyword)
			safe_process (l_as.stop)
			safe_process (l_as.loop_keyword)
			safe_process (l_as.compound)
			safe_process (l_as.end_keyword)
		end

	process_external_as (l_as: EXTERNAL_AS) is
		do
			safe_process (l_as.external_keyword)
			safe_process (l_as.language_name)
			safe_process (l_as.alias_keyword)
			safe_process (l_as.alias_name_literal)
		end

	process_do_as (l_as: DO_AS) is
		do
			safe_process (l_as.do_keyword)
			safe_process (l_as.compound)
		end

	process_once_as (l_as: ONCE_AS) is
		do
			safe_process (l_as.once_keyword)
			safe_process (l_as.compound)
		end

	process_type_dec_as (l_as: TYPE_DEC_AS) is
		local
			id_list: IDENTIFIER_LIST
		do
			id_list ?= l_as.id_list
			safe_process (id_list.id_list)
			safe_process (l_as.colon_symbol)
			safe_process (l_as.type)
			safe_process (l_as.semicolon_symbol)
		end

	process_class_as (l_as: CLASS_AS) is
		local
			s: STRING_AS
		do
			safe_process (l_as.internal_top_indexes)
			safe_process (l_as.frozen_keyword)
			safe_process (l_as.deferred_keyword)
			safe_process (l_as.expanded_keyword)
			safe_process (l_as.separate_keyword)
			safe_process (l_as.external_keyword)
			safe_process (l_as.class_keyword)
			safe_process (l_as.class_name)
			safe_process (l_as.internal_generics)
			safe_process (l_as.alias_keyword)
			s ?= l_as.external_class_name
			safe_process (s)
			safe_process (l_as.obsolete_keyword)
			safe_process (l_as.obsolete_message)
			safe_process (l_as.internal_parents)
			safe_process (l_as.creators)
			safe_process (l_as.convertors)
			safe_process (l_as.features)
			safe_process (l_as.internal_invariant)
			safe_process (l_as.internal_bottom_indexes)
			safe_process (l_as.end_keyword)
		end

	process_parent_as (l_as: PARENT_AS) is
		do
			safe_process (l_as.type)
			safe_process (l_as.internal_renaming)
			safe_process (l_as.internal_exports)
			safe_process (l_as.internal_undefining)
			safe_process (l_as.internal_redefining)
			safe_process (l_as.internal_selecting)
			safe_process (l_as.end_keyword)
		end

	process_like_id_as (l_as: LIKE_ID_AS) is
		do
			safe_process (l_as.like_keyword)
			safe_process (l_as.anchor)
		end

	process_like_cur_as (l_as: LIKE_CUR_AS) is
		do
			safe_process (l_as.like_keyword)
			safe_process (l_as.current_keyword)
		end

	process_formal_as (l_as: FORMAL_AS) is
		do
			safe_process (l_as.reference_expanded_keyword)
			safe_process (l_as.name)
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS) is
		do
			safe_process (l_as.formal_para)
			safe_process (l_as.constrain_symbol)
			safe_process (l_as.constraint)
			safe_process (l_as.creation_feature_list)
		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		do
			safe_process (l_as.expanded_keyword)
			safe_process (l_as.separate_keyword)
			safe_process (l_as.class_name)
			safe_process (l_as.internal_generics)
		end

	process_none_type_as (l_as: NONE_TYPE_AS) is
		do
			safe_process (l_as.class_name_literal)
		end

	process_bits_as (l_as: BITS_AS) is
		do
			safe_process (l_as.bit_keyword)
			safe_process (l_as.bits_value)
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS) is
		do
			safe_process (l_as.bit_keyword)
			safe_process (l_as.bits_symbol)
		end

	process_rename_as (l_as: RENAME_AS) is
		do
			safe_process (l_as.old_name)
			safe_process (l_as.as_keyword)
			safe_process (l_as.new_name)
		end

	process_invariant_as (l_as: INVARIANT_AS) is
		do
			safe_process (l_as.invariant_keyword)
			safe_process (l_as.full_assertion_list)
		end

	process_interval_as (l_as: INTERVAL_AS) is
		do
			safe_process (l_as.lower)
			safe_process (l_as.dotdot_symbol)
			safe_process (l_as.upper)
		end

	process_index_as (l_as: INDEX_AS) is
		do
			safe_process (l_as.tag)
			safe_process (l_as.colon_symbol)
			safe_process (l_as.index_list)
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS) is
		do
			safe_process (l_as.clients)
			safe_process (l_as.features)
		end

	process_elseif_as (l_as: ELSIF_AS) is
		do
			safe_process (l_as.elseif_keyword)
			safe_process (l_as.expr)
			safe_process (l_as.then_keyword)
			safe_process (l_as.compound)
		end

	process_create_as (l_as: CREATE_AS) is
		do
			safe_process (l_as.create_creation_keyword)
			safe_process (l_as.clients)
			safe_process (l_as.feature_list)
		end

	process_client_as (l_as: CLIENT_AS) is
		do
			safe_process (l_as.clients)
		end

	process_case_as (l_as: CASE_AS) is
		do
			safe_process (l_as.when_keyword)
			safe_process (l_as.interval)
			safe_process (l_as.then_keyword)
			safe_process (l_as.compound)
		end

	process_ensure_as (l_as: ENSURE_AS) is
		do
			safe_process (l_as.ensure_keyword)
			safe_process (l_as.full_assertion_list)
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS) is
		do
			safe_process (l_as.ensure_keyword)
			safe_process (l_as.then_keyword)
			safe_process (l_as.full_assertion_list)
		end

	process_require_as (l_as: REQUIRE_AS) is
		do
			safe_process (l_as.require_keyword)
			safe_process (l_as.full_assertion_list)
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS) is
		do
			safe_process (l_as.require_keyword)
			safe_process (l_as.else_keyword)
			safe_process (l_as.full_assertion_list)
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS) is
		do
			safe_process (l_as.feature_name)
			safe_process (l_as.colon_symbol)
			safe_process (l_as.lparan_symbol)
			safe_process (l_as.conversion_types)
			safe_process (l_as.rparan_symbol)
		end

	process_use_list_as (l_as: USE_LIST_AS) is
		do
			process_eiffel_list (l_as)
		end

	process_type_a (a_type: TYPE_A) is
		do
			check
				should_not_arrive_here: False
			end
		end

feature

	process_all_break_as is
			-- Process all BREAK AST nodes.
		require
			match_list_not_void: match_list /= Void
		local
			l_break: BREAK_AS
		do
			from
				match_list.start
			until
				match_list.after
			loop
				l_break ?= match_list.item
				if l_break /= Void then
					l_break.process (Current)
				end
				match_list.forth
			end
		end

feature{NONE} -- Implementation

	process_leading_leaves (ind: INTEGER) is
			-- Process all not-processed leading leaves in `match_list' before index `ind'.
		require
			valid_index: ind >= start_index and then ind <= end_index
		local
			i: INTEGER
		do
			if will_process_leading_leaves then
				if ind > last_index + 1 then
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
		end

	process_trailing_leaves is
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

end
