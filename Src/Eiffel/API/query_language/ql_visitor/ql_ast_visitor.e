indexing
	description: "AST visitor to check if certain AST nodes exists"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_AST_VISITOR

inherit
	AST_VISITOR
		redefine
			default_create
		end

	QL_NAMES
		undefine
			default_create
		end

create
	default_create,
	make

feature{NONE} -- Initialization

	default_create is
			-- Initialize.
		do
			create ast_array.make (max_ast_type)
			enable_match_all_asts
		end

	make (a_ast_index_list: LIST [INTEGER]; a_and_relation: BOOLEAN) is
			-- Initialize Current.
			-- `a_ast_index_list' is a list of ast node index to be matched.
			-- `a_and_relation' is True indicates that we should match all ast nodes specified by `a_ast_index_list',
			-- otherwise, we just need match any of them.
		require
			a_ast_index_list_valid: a_ast_index_list /= Void and then not a_ast_index_list.is_empty
		do
			create ast_array.make (max_ast_type)
			set_ast_index_list (a_ast_index_list)
			if a_and_relation then
				enable_match_all_asts
			else
				disable_match_all_asts
			end
		end

feature -- Status reporting

	is_ast_index_valid (a_ast_index: INTEGER): BOOLEAN is
			-- Is `a_ast_index' a valid ast index?
		do
			Result := a_ast_index >= none_id and then a_ast_index <= formal_generic_list
		end

	should_all_ast_be_matched: BOOLEAN
			-- Should a specified ast nodes be matched, or just any of them?

feature -- Access

	ast_index_list: LIST [INTEGER] is
			-- List of indexes of specified AST nodes			
		do
			Result := ast_array.list_of_bit_index (True)
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_ast_index_list (a_ast_index_list: LIST [INTEGER]) is
			-- Set `a_ast_index_list' into Current.
			-- `a_ast_index_list' is a list of ast node index to be matched.
		require
			a_ast_index_list_valid: a_ast_index_list /= Void and then not a_ast_index_list.is_empty
		do
			create ast_array.make (max_ast_type)
			a_ast_index_list.do_all (agent ast_array.set_bit (?))
		end

	enable_match_all_asts is
			-- Set `should_all_ast_be_matched' to True.
		do
			should_all_ast_be_matched := True
		ensure
			should_all_ast_be_matched_set: should_all_ast_be_matched
		end

	disable_match_all_asts is
			-- Set `should_all_ast_be_matched' to False.
		do
			should_all_ast_be_matched := False
		ensure
			should_all_ast_be_matched_set: not should_all_ast_be_matched
		end

feature -- Process

	is_code_structure_item_satisfied (a_code_structure_item: QL_CODE_STRUCTURE_ITEM): BOOLEAN is
			-- Does `a_code_structure_item' contains AST nodes specified by `set_ast_index_list'?
			-- If `should_all_ast_be_matched' is True, `a_code_stucture_item' is is considered satisfied if it contains
			-- all kinds of specified AST nodes. Otherwise, is just any kind of specified AST node is enough.
		require
			a_code_structure_item_attached: a_code_structure_item /= Void
		do
			if ast_array.count_of_set_bits = 0 then
				Result := True
			else
				Result := is_ast_satisfied (a_code_structure_item.ast)
			end
		end

feature{NONE} -- Implementation

	is_ast_satisfied (a_ast: AST_EIFFEL): BOOLEAN is
			-- Process `a_ast'.
		require
			a_ast_attached: a_ast /= Void
		do
			is_matching_finished := False
			if should_all_ast_be_matched then
				unmatched_ast_types := ast_array.count_of_set_bits
				create found_ast_array.make (max_ast_type)
			end
			a_ast.process (Current)
			Result := is_matching_finished
		end

	is_matching_finished: BOOLEAN
			-- Is matching finished?

	match_ast (a_index: INTEGER) is
			-- Record that ast specified by `a_index' is found.
		require
			a_index_valid: is_ast_index_valid (a_index)
		local
			l_found_ast_array: like found_ast_array
		do
			if should_all_ast_be_matched then
				l_found_ast_array := found_ast_array
				check l_found_ast_array /= Void end
				if ast_array.is_bit_set (a_index) then
					if not l_found_ast_array.is_bit_set (a_index) then
						l_found_ast_array.set_bit (a_index)
						unmatched_ast_types := unmatched_ast_types - 1
						is_matching_finished := unmatched_ast_types = 0
					end
				end
			else
				is_matching_finished := ast_array.is_bit_set (a_index)
			end
		end

	max_ast_type: INTEGER is 150
			-- Max ast type

	unmatched_ast_types: INTEGER
			-- Number of types of unmatched ast nodes

	found_ast_array: QL_BIT_ARRAY
			-- Bit array indicating all found ast node types

	ast_array: QL_BIT_ARRAY
			-- Bit array for ast match

feature{NONE} -- Implementation

	process_keyword_as (l_as: KEYWORD_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (keyword)
			end
		end

	process_symbol_as (l_as: SYMBOL_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (symbol)
			end
		end

	process_break_as (l_as: BREAK_AS)
			-- Process `l_as'.			
		do
		end

	process_leaf_stub_as (l_as: LEAF_STUB_AS)
			-- Process `l_as'.
		do
		end

	process_symbol_stub_as (l_as: SYMBOL_STUB_AS)
			-- Process `l_as'.
		do
		end

	process_bool_as (l_as: BOOL_AS)
		do
			if not is_matching_finished then
				match_ast (bool)
			end
		end

	process_char_as (l_as: CHAR_AS)
		do
			if not is_matching_finished then
				match_ast (char)
			end
		end

	process_result_as (l_as: RESULT_AS)
		do
			if not is_matching_finished then
				match_ast (result_as)
			end
		end

	process_retry_as (l_as: RETRY_AS)
		do
			if not is_matching_finished then
				match_ast (retry_as)
			end
		end

	process_unique_as (l_as: UNIQUE_AS)
		do
			if not is_matching_finished then
				match_ast (unique_as)
			end
		end

	process_deferred_as (l_as: DEFERRED_AS)
		do
			if not is_matching_finished then
				match_ast (deferred_as)
			end
		end

	process_void_as (l_as: VOID_AS)
		do
			if not is_matching_finished then
				match_ast (void_as)
			end
		end

	process_string_as (l_as: STRING_AS)
		do
			if not is_matching_finished then
				match_ast (string)
				if l_as.is_once_string then
					safe_process (l_as.once_string_keyword)
				end
				safe_process (l_as.type)
			end
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS)
		do
			if not is_matching_finished then
				match_ast (verbatim_string)
				if l_as.is_once_string then
					safe_process (l_as.once_string_keyword)
				end
			end
		end

	process_current_as (l_as: CURRENT_AS)
		do
			if not is_matching_finished then
				match_ast (1)
			end
		end

	process_integer_as (l_as: INTEGER_AS)
		do
			if not is_matching_finished then
				match_ast (integer)
				safe_process (l_as.constant_type)
				safe_process (l_as.sign_symbol)
			end
		end

	process_real_as (l_as: REAL_AS)
		do
			if not is_matching_finished then
				match_ast (real)
				safe_process (l_as.constant_type)
				safe_process (l_as.sign_symbol)
			end
		end

	process_id_as (l_as: ID_AS)
		do
			if not is_matching_finished then
				match_ast (id)
			end
		end

	process_bit_const_as (l_as: BIT_CONST_AS)
		do
			if not is_matching_finished then
				match_ast (bit_const)
				safe_process (l_as.value)
			end
		end

	process_none_id_as (l_as: NONE_ID_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (none_id)
			end
		end

	process_typed_char_as (l_as: TYPED_CHAR_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (typed_char)
				safe_process (l_as.type)
			end
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (agent_routine_creation)
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
		end

	process_tilda_routine_creation_as (l_as: TILDA_ROUTINE_CREATION_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (tilda_routine_creation)
				if l_as.target /= Void then
					safe_process (l_as.lparan_symbol)
					l_as.target.process (Current)
					safe_process (l_as.rparan_symbol)
				end
				safe_process (l_as.tilda_symbol)
				safe_process (l_as.feature_name)
				safe_process (l_as.internal_operands)
			end
		end

	process_inline_agent_creation_as (l_as: INLINE_AGENT_CREATION_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (inline_agent_creation)
				safe_process (l_as.agent_keyword)
				if l_as.target /= Void then
					safe_process (l_as.lparan_symbol)
					l_as.target.process (Current)
					safe_process (l_as.rparan_symbol)
					safe_process (l_as.dot_symbol)
				end
				safe_process (l_as.internal_operands)
				safe_process (l_as.body)
			end
		end

	process_create_creation_as (l_as: CREATE_CREATION_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (create_creation)
				safe_process (l_as.create_keyword)
				safe_process (l_as.type)
				safe_process (l_as.target)
				safe_process (l_as.call)
			end
		end

	process_bang_creation_as (l_as: BANG_CREATION_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (bang_creation)
				safe_process (l_as.lbang_symbol)
				safe_process (l_as.type)
				safe_process (l_as.rbang_symbol)
				safe_process (l_as.target)
				safe_process (l_as.call)
			end
		end

	process_create_creation_expr_as (l_as: CREATE_CREATION_EXPR_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (create_creation_expr)
				safe_process (l_as.create_keyword)
				safe_process (l_as.type)
				safe_process (l_as.call)
			end
		end

	process_bang_creation_expr_as (l_as: BANG_CREATION_EXPR_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (bang_creation_expr)
				safe_process (l_as.lbang_symbol)
				safe_process (l_as.type)
				safe_process (l_as.rbang_symbol)
				safe_process (l_as.call)
			end
		end

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS)
		do
			if not is_matching_finished then
				match_ast (custom_attribute)
				safe_process (l_as.creation_expr)
				safe_process (l_as.tuple)
				safe_process (l_as.end_keyword)
			end
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS)
		do
			if not is_matching_finished then
				match_ast (static_access)
				safe_process (l_as.feature_keyword)
				safe_process (l_as.class_type)
				safe_process (l_as.dot_symbol)
				safe_process (l_as.feature_name)
				safe_process (l_as.internal_parameters)
			end
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
		do
			if not is_matching_finished then
				match_ast (feature_clause)
				safe_process (l_as.feature_keyword)
				safe_process (l_as.clients)
				safe_process (l_as.features)
			end
		end

	process_tuple_as (l_as: TUPLE_AS)
		do
			if not is_matching_finished then
				match_ast (tuple)
				safe_process (l_as.lbracket)
				safe_process (l_as.expressions)
				safe_process (l_as.rbracket)
			end
		end

	process_array_as (l_as: ARRAY_AS)
		do
			if not is_matching_finished then
				match_ast (array)
				safe_process (l_as.larray)
				safe_process (l_as.expressions)
				safe_process (l_as.rarray)
			end
		end

	process_body_as (l_as: BODY_AS)
		local
			c_as: CONSTANT_AS
		do
			if not is_matching_finished then
				match_ast (body)
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
		end

	process_built_in_as (l_as: BUILT_IN_AS) is
			-- Process `l_as'.
		do
			process_external_as (l_as)
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS)
		do
			if not is_matching_finished then
				match_ast (access_feat)
				safe_process (l_as.feature_name)
				safe_process (l_as.internal_parameters)
			end
		end

	process_access_inv_as (l_as: ACCESS_INV_AS)
		do
			if not is_matching_finished then
				match_ast (access_inv)
				safe_process (l_as.dot_symbol)
				safe_process (l_as.feature_name)
				safe_process (l_as.internal_parameters)
			end
		end

	process_access_id_as (l_as: ACCESS_ID_AS)
		do
			if not is_matching_finished then
				match_ast (access_id)
				safe_process (l_as.feature_name)
				safe_process (l_as.internal_parameters)
			end
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS)
		do
			if not is_matching_finished then
				match_ast (access_assert)
				process_access_feat_as (l_as)
			end
		end

	process_precursor_as (l_as: PRECURSOR_AS)
		do
			if not is_matching_finished then
				match_ast (precursor_as)
				safe_process (l_as.precursor_keyword)
				safe_process (l_as.parent_base_class)
				safe_process (l_as.internal_parameters)
			end
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS)
		do
			if not is_matching_finished then
				match_ast (nested_expr)
				safe_process (l_as.lparan_symbol)
				safe_process (l_as.target)
				safe_process (l_as.rparan_symbol)
				safe_process (l_as.dot_symbol)
				safe_process (l_as.message)
			end
		end

	process_nested_as (l_as: NESTED_AS)
		do
			if not is_matching_finished then
				match_ast (nested)
				safe_process (l_as.target)
				safe_process (l_as.dot_symbol)
				safe_process (l_as.message)
			end
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS)
		do
		end

	process_type_expr_as (l_as: TYPE_EXPR_AS)
		do
			if not is_matching_finished then
				match_ast (type_expr)
				safe_process (l_as.type)
			end
		end

	process_routine_as (l_as: ROUTINE_AS)
		do
			if not is_matching_finished then
				match_ast (routine)
				safe_process (l_as.obsolete_keyword)
				safe_process (l_as.obsolete_message)
				safe_process (l_as.precondition)
				safe_process (l_as.internal_locals)
				safe_process (l_as.routine_body)
				safe_process (l_as.postcondition)
				safe_process (l_as.rescue_keyword)
				safe_process (l_as.rescue_clause)
				safe_process (l_as.end_keyword)
			end
		end

	process_constant_as (l_as: CONSTANT_AS)
		do
			if not is_matching_finished then
				match_ast (constant)
				safe_process (l_as.value)
			end
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL])
		local
			i, l_count: INTEGER_32
		do
			if not is_matching_finished then
				match_ast (eiffel_list)
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
			end
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS)
		do
			if not is_matching_finished then
				match_ast (indexing_clause)
				safe_process (l_as.indexing_keyword)
				process_eiffel_list (l_as)
				safe_process (l_as.end_keyword)
			end
		end

	process_operand_as (l_as: OPERAND_AS)
		do
			if not is_matching_finished then
				match_ast (operand)
				safe_process (l_as.class_type)
				if l_as.question_mark_symbol /= Void then
					l_as.question_mark_symbol.process (Current)
				end
				safe_process (l_as.target)
				safe_process (l_as.expression)
			end
		end

	process_tagged_as (l_as: TAGGED_AS)
		do
			if not is_matching_finished then
				match_ast (tagged)
				safe_process (l_as.tag)
				safe_process (l_as.colon_symbol)
				safe_process (l_as.expr)
			end
		end

	process_variant_as (l_as: VARIANT_AS)
		do
			if not is_matching_finished then
				match_ast (variant_as)
				safe_process (l_as.variant_keyword)
				safe_process (l_as.tag)
				safe_process (l_as.colon_symbol)
				safe_process (l_as.expr)
			end
		end

	process_un_strip_as (l_as: UN_STRIP_AS)
		local
			i_as: IDENTIFIER_LIST
		do
			if not is_matching_finished then
				match_ast (un_strip)
				i_as ?= l_as.id_list
				safe_process (l_as.strip_keyword)
				safe_process (l_as.lparan_symbol)
				safe_process (i_as.id_list)
				safe_process (l_as.rparan_symbol)
			end
		end

	process_paran_as (l_as: PARAN_AS)
		do
			if not is_matching_finished then
				match_ast (paran)
				safe_process (l_as.lparan_symbol)
				safe_process (l_as.expr)
				safe_process (l_as.rparan_symbol)
			end
		end

	process_expr_call_as (l_as: EXPR_CALL_AS)
		do
			if not is_matching_finished then
				match_ast (expr_call)
				l_as.call.process (Current)
			end
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS)
		do
			if not is_matching_finished then
				match_ast (expr_address)
				safe_process (l_as.address_symbol)
				safe_process (l_as.lparan_symbol)
				safe_process (l_as.expr)
				safe_process (l_as.rparan_symbol)
			end
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS)
		do
			if not is_matching_finished then
				match_ast (address_result)
				safe_process (l_as.address_symbol)
				safe_process (l_as.result_keyword)
			end
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS)
		do
			if not is_matching_finished then
				match_ast (address_current)
				safe_process (l_as.address_symbol)
				safe_process (l_as.current_keyword)
			end
		end

	process_address_as (l_as: ADDRESS_AS)
		do
			if not is_matching_finished then
				match_ast (address)
				safe_process (l_as.address_symbol)
				safe_process (l_as.feature_name)
			end
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS)
		do
		end

	process_unary_as (l_as: UNARY_AS)
		do
			if not is_matching_finished then
				match_ast (unary)
				safe_process (l_as.operator)
				safe_process (l_as.expr)
			end
		end

	process_un_free_as (l_as: UN_FREE_AS)
		do
			if not is_matching_finished then
				match_ast (un_free)
				safe_process (l_as.op_name)
				safe_process (l_as.expr)
			end
		end

	process_un_minus_as (l_as: UN_MINUS_AS)
		do
			if not is_matching_finished then
				match_ast (un_minus)
				process_unary_as (l_as)
			end
		end

	process_un_not_as (l_as: UN_NOT_AS)
		do
			if not is_matching_finished then
				match_ast (un_not)
				process_unary_as (l_as)
			end
		end

	process_un_old_as (l_as: UN_OLD_AS)
		do
			if not is_matching_finished then
				match_ast (un_old)
				process_unary_as (l_as)
			end
		end

	process_un_plus_as (l_as: UN_PLUS_AS)
		do
			if not is_matching_finished then
				match_ast (un_plus)
				process_unary_as (l_as)
			end
		end

	process_binary_as (l_as: BINARY_AS)
		do
			if not is_matching_finished then
				match_ast (binary)
				safe_process (l_as.left)
				safe_process (l_as.operator)
				safe_process (l_as.right)
			end
		end

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS)
		do
			if not is_matching_finished then
				match_ast (bin_and_then)
				process_binary_as (l_as)
			end
		end

	process_bin_free_as (l_as: BIN_FREE_AS)
		do
			if not is_matching_finished then
				match_ast (bin_free)
				process_binary_as (l_as)
			end
		end

	process_bin_implies_as (l_as: BIN_IMPLIES_AS)
		do
			if not is_matching_finished then
				match_ast (bin_implies)
				process_binary_as (l_as)
			end
		end

	process_bin_or_as (l_as: BIN_OR_AS)
		do
			if not is_matching_finished then
				match_ast (bin_or)
				process_binary_as (l_as)
			end
		end

	process_bin_or_else_as (l_as: BIN_OR_ELSE_AS)
		do
			if not is_matching_finished then
				match_ast (bin_or_else)
				process_binary_as (l_as)
			end
		end

	process_bin_xor_as (l_as: BIN_XOR_AS)
		do
			if not is_matching_finished then
				match_ast (bin_xor)
				process_binary_as (l_as)
			end
		end

	process_bin_ge_as (l_as: BIN_GE_AS)
		do
			if not is_matching_finished then
				match_ast (bin_ge)
				process_binary_as (l_as)
			end
		end

	process_bin_gt_as (l_as: BIN_GT_AS)
		do
			if not is_matching_finished then
				match_ast (bin_gt)
				process_binary_as (l_as)
			end
		end

	process_bin_le_as (l_as: BIN_LE_AS)
		do
			if not is_matching_finished then
				match_ast (bin_le)
				process_binary_as (l_as)
			end
		end

	process_bin_lt_as (l_as: BIN_LT_AS)
		do
			if not is_matching_finished then
				match_ast (bin_lt)
				process_binary_as (l_as)
			end
		end

	process_bin_div_as (l_as: BIN_DIV_AS)
		do
			if not is_matching_finished then
				match_ast (bin_div)
				process_binary_as (l_as)
			end
		end

	process_bin_minus_as (l_as: BIN_MINUS_AS)
		do
			if not is_matching_finished then
				match_ast (bin_minus)
				process_binary_as (l_as)
			end
		end

	process_bin_mod_as (l_as: BIN_MOD_AS)
		do
			if not is_matching_finished then
				match_ast (bin_mod)
				process_binary_as (l_as)
			end
		end

	process_bin_plus_as (l_as: BIN_PLUS_AS)
		do
			if not is_matching_finished then
				match_ast (bin_plus)
				process_binary_as (l_as)
			end
		end

	process_bin_power_as (l_as: BIN_POWER_AS)
		do
			if not is_matching_finished then
				match_ast (bin_power)
				process_binary_as (l_as)
			end
		end

	process_bin_slash_as (l_as: BIN_SLASH_AS)
		do
			if not is_matching_finished then
				match_ast (bin_slash)
				process_binary_as (l_as)
			end
		end

	process_bin_star_as (l_as: BIN_STAR_AS)
		do
			if not is_matching_finished then
				match_ast (bin_star)
				process_binary_as (l_as)
			end
		end

	process_bin_and_as (l_as: BIN_AND_AS)
		do
			if not is_matching_finished then
				match_ast (bin_and)
				process_binary_as (l_as)
			end
		end

	process_bin_eq_as (l_as: BIN_EQ_AS)
		do
			if not is_matching_finished then
				match_ast (bin_eq)
				process_binary_as (l_as)
			end
		end

	process_bin_ne_as (l_as: BIN_NE_AS)
		do
			if not is_matching_finished then
				match_ast (bin_ne)
				process_binary_as (l_as)
			end
		end

	process_bin_tilde_as (l_as: BIN_TILDE_AS)
		do
			if not is_matching_finished then
				match_ast (bin_tilde)
				process_binary_as (l_as)
			end
		end

	process_bin_not_tilde_as (l_as: BIN_NOT_TILDE_AS)
		do
			if not is_matching_finished then
				match_ast (bin_not_tilde)
				process_binary_as (l_as)
			end
		end

	process_object_test_as (l_as: OBJECT_TEST_AS) is
		do
			if not is_matching_finished then
				match_ast (bracket)
				safe_process (l_as.lcurly_symbol)
				safe_process (l_as.name)
				safe_process (l_as.type)
				safe_process (l_as.expression)
			end
		end

	process_bracket_as (l_as: BRACKET_AS)
		do
			if not is_matching_finished then
				match_ast (bracket)
				safe_process (l_as.target)
				safe_process (l_as.lbracket_symbol)
				safe_process (l_as.operands)
				safe_process (l_as.rbracket_symbol)
			end
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS)
		do
			if not is_matching_finished then
				match_ast (external_lang)
				l_as.language_name.process (Current)
			end
		end

	process_feature_as (l_as: FEATURE_AS)
		do
			if not is_matching_finished then
				match_ast (feature_as)
				safe_process (l_as.feature_names)
				safe_process (l_as.body)
			end
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS)
		do
			if not is_matching_finished then
				match_ast (infix_prefix)
				safe_process (l_as.frozen_keyword)
				safe_process (l_as.infix_prefix_keyword)
				safe_process (l_as.alias_name)
			end
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS)
		do
			if not is_matching_finished then
				match_ast (feat_name_id)
				safe_process (l_as.frozen_keyword)
				safe_process (l_as.feature_name)
			end
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS)
		do
			if not is_matching_finished then
				match_ast (feature_name_alias)
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
		end

	process_feature_list_as (l_as: FEATURE_LIST_AS)
		do
			if not is_matching_finished then
				match_ast (feature_list)
				safe_process (l_as.features)
			end
		end

	process_all_as (l_as: ALL_AS)
		do
			if not is_matching_finished then
				match_ast (all_as)
				safe_process (l_as.all_keyword)
			end
		end

	process_assign_as (l_as: ASSIGN_AS)
		do
			if not is_matching_finished then
				match_ast (assign_as)
				safe_process (l_as.target)
				safe_process (l_as.assignment_symbol)
				safe_process (l_as.source)
			end
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS)
		do
			if not is_matching_finished then
				match_ast (assigner_call)
				safe_process (l_as.target)
				safe_process (l_as.assignment_symbol)
				safe_process (l_as.source)
			end
		end

	process_reverse_as (l_as: REVERSE_AS)
		do
			if not is_matching_finished then
				match_ast (reverse)
				safe_process (l_as.target)
				safe_process (l_as.assignment_symbol)
				safe_process (l_as.source)
			end
		end

	process_check_as (l_as: CHECK_AS)
		do
			if not is_matching_finished then
				match_ast (check_as)
				safe_process (l_as.check_keyword)
				safe_process (l_as.full_assertion_list)
				safe_process (l_as.end_keyword)
			end
		end

	process_creation_as (l_as: CREATION_AS)
		do
		end

	process_debug_as (l_as: DEBUG_AS)
		do
			if not is_matching_finished then
				match_ast (debug_as)
				safe_process (l_as.debug_keyword)
				safe_process (l_as.internal_keys)
				safe_process (l_as.compound)
				safe_process (l_as.end_keyword)
			end
		end

	process_if_as (l_as: IF_AS)
		do
			if not is_matching_finished then
				match_ast (if_as)
				safe_process (l_as.if_keyword)
				safe_process (l_as.condition)
				safe_process (l_as.then_keyword)
				safe_process (l_as.compound)
				safe_process (l_as.elsif_list)
				safe_process (l_as.else_keyword)
				safe_process (l_as.else_part)
				safe_process (l_as.end_keyword)
			end
		end

	process_inspect_as (l_as: INSPECT_AS)
		do
			if not is_matching_finished then
				match_ast (inspect_as)
				safe_process (l_as.inspect_keyword)
				safe_process (l_as.switch)
				safe_process (l_as.case_list)
				safe_process (l_as.else_keyword)
				safe_process (l_as.else_part)
				safe_process (l_as.end_keyword)
			end
		end

	process_instr_call_as (l_as: INSTR_CALL_AS)
		do
			if not is_matching_finished then
				match_ast (instr_call)
				l_as.call.process (Current)
			end
		end

	process_loop_as (l_as: LOOP_AS)
		do
			if not is_matching_finished then
				match_ast (loop_as)
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
		end

	process_external_as (l_as: EXTERNAL_AS)
		do
			if not is_matching_finished then
				match_ast (external_as)
				safe_process (l_as.external_keyword)
				safe_process (l_as.language_name)
				safe_process (l_as.alias_keyword)
				safe_process (l_as.alias_name_literal)
			end
		end

	process_do_as (l_as: DO_AS)
		do
			if not is_matching_finished then
				match_ast (do_as)
				safe_process (l_as.do_keyword)
				safe_process (l_as.compound)
			end
		end

	process_once_as (l_as: ONCE_AS)
		do
			if not is_matching_finished then
				match_ast (once_as)
				safe_process (l_as.once_keyword)
				safe_process (l_as.compound)
			end
		end

	process_type_dec_as (l_as: TYPE_DEC_AS)
		local
			id_list: IDENTIFIER_LIST
		do
			if not is_matching_finished then
				match_ast (type_dec)
				id_list ?= l_as.id_list
				safe_process (id_list.id_list)
				safe_process (l_as.colon_symbol)
				safe_process (l_as.type)
			end
		end

	process_class_as (l_as: CLASS_AS)
		local
			s: STRING_AS
		do
			if not is_matching_finished then
				match_ast (class_as)
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
				safe_process (l_as.conforming_parents)
				safe_process (l_as.non_conforming_parents)
				safe_process (l_as.creators)
				safe_process (l_as.convertors)
				safe_process (l_as.features)
				safe_process (l_as.internal_invariant)
				safe_process (l_as.internal_bottom_indexes)
				safe_process (l_as.end_keyword)
			end
		end

	process_parent_as (l_as: PARENT_AS)
		do
			if not is_matching_finished then
				match_ast (parent)
				safe_process (l_as.type)
				safe_process (l_as.internal_renaming)
				safe_process (l_as.internal_exports)
				safe_process (l_as.internal_undefining)
				safe_process (l_as.internal_redefining)
				safe_process (l_as.internal_selecting)
				safe_process (l_as.end_keyword)
			end
		end

	process_like_id_as (l_as: LIKE_ID_AS)
		do
			if not is_matching_finished then
				match_ast (like_id)
				safe_process (l_as.lcurly_symbol)
				safe_process (l_as.attachment_mark)
				safe_process (l_as.like_keyword)
				safe_process (l_as.anchor)
				safe_process (l_as.rcurly_symbol)
			end
		end

	process_like_cur_as (l_as: LIKE_CUR_AS)
		do
			if not is_matching_finished then
				match_ast (like_cur)
				safe_process (l_as.lcurly_symbol)
				safe_process (l_as.attachment_mark)
				safe_process (l_as.like_keyword)
				safe_process (l_as.current_keyword)
				safe_process (l_as.rcurly_symbol)
			end
		end

	process_formal_as (l_as: FORMAL_AS)
		do
			if not is_matching_finished then
				match_ast (formal)
				safe_process (l_as.lcurly_symbol)
				safe_process (l_as.attachment_mark)
				safe_process (l_as.reference_expanded_keyword)
				safe_process (l_as.name)
				safe_process (l_as.rcurly_symbol)
			end
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS)
		do
			if not is_matching_finished then
				match_ast (formal_dec)
				safe_process (l_as.formal)
				safe_process (l_as.constrain_symbol)
				safe_process (l_as.constraints)
				safe_process (l_as.create_keyword)
				safe_process (l_as.creation_feature_list)
				safe_process (l_as.end_keyword)
			end
		end

	process_constraining_type_as (l_as: CONSTRAINING_TYPE_AS)
		do
			if not is_matching_finished then
				match_ast (constraining_type)
				l_as.type.process (Current)
				safe_process (l_as.renaming)
				safe_process (l_as.end_of_renaming)
			end
		end
	process_class_type_as (l_as: CLASS_TYPE_AS)
		do
			if not is_matching_finished then
				match_ast (class_type)
				safe_process (l_as.lcurly_symbol)
				safe_process (l_as.attachment_mark)
				safe_process (l_as.expanded_keyword)
				safe_process (l_as.separate_keyword)
				safe_process (l_as.class_name)
				safe_process (l_as.internal_generics)
				safe_process (l_as.rcurly_symbol)
			end
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS)
		do
			if not is_matching_finished then
				match_ast (named_tuple_type)
				safe_process (l_as.lcurly_symbol)
				safe_process (l_as.separate_keyword)
				safe_process (l_as.class_name)
				safe_process (l_as.parameters)
				safe_process (l_as.rcurly_symbol)
			end
		end

	process_none_type_as (l_as: NONE_TYPE_AS)
		do
			if not is_matching_finished then
				match_ast (none_type)
				safe_process (l_as.lcurly_symbol)
				safe_process (l_as.class_name_literal)
				safe_process (l_as.rcurly_symbol)
			end
		end

	process_bits_as (l_as: BITS_AS)
		do
			if not is_matching_finished then
				match_ast (bits)
				safe_process (l_as.lcurly_symbol)
				safe_process (l_as.bit_keyword)
				safe_process (l_as.bits_value)
				safe_process (l_as.rcurly_symbol)
			end
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS)
		do
			if not is_matching_finished then
				match_ast (bits_symbol)
				safe_process (l_as.lcurly_symbol)
				safe_process (l_as.bit_keyword)
				safe_process (l_as.bits_symbol)
				safe_process (l_as.rcurly_symbol)
			end
		end

	process_rename_as (l_as: RENAME_AS)
		do
			if not is_matching_finished then
				match_ast (rename_as)
				safe_process (l_as.old_name)
				safe_process (l_as.as_keyword)
				safe_process (l_as.new_name)
			end
		end

	process_invariant_as (l_as: INVARIANT_AS)
		do
			if not is_matching_finished then
				match_ast (invariant_as)
				safe_process (l_as.invariant_keyword)
				safe_process (l_as.full_assertion_list)
			end
		end

	process_interval_as (l_as: INTERVAL_AS)
		do
			if not is_matching_finished then
				match_ast (interval)
				safe_process (l_as.lower)
				safe_process (l_as.dotdot_symbol)
				safe_process (l_as.upper)
			end
		end

	process_index_as (l_as: INDEX_AS)
		do
			if not is_matching_finished then
				match_ast (index)
				safe_process (l_as.tag)
				safe_process (l_as.colon_symbol)
				safe_process (l_as.index_list)
			end
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS)
		do
			if not is_matching_finished then
				match_ast (export_item)
				safe_process (l_as.clients)
				safe_process (l_as.features)
			end
		end

	process_elseif_as (l_as: ELSIF_AS)
		do
			if not is_matching_finished then
				match_ast (elseif_as)
				safe_process (l_as.elseif_keyword)
				safe_process (l_as.expr)
				safe_process (l_as.then_keyword)
				safe_process (l_as.compound)
			end
		end

	process_create_as (l_as: CREATE_AS)
		do
			if not is_matching_finished then
				match_ast (create_as)
				safe_process (l_as.create_creation_keyword)
				safe_process (l_as.clients)
				safe_process (l_as.feature_list)
			end
		end

	process_client_as (l_as: CLIENT_AS)
		do
			if not is_matching_finished then
				match_ast (client)
				safe_process (l_as.clients)
			end
		end

	process_case_as (l_as: CASE_AS)
		do
			if not is_matching_finished then
				match_ast (case)
				safe_process (l_as.when_keyword)
				safe_process (l_as.interval)
				safe_process (l_as.then_keyword)
				safe_process (l_as.compound)
			end
		end

	process_ensure_as (l_as: ENSURE_AS)
		do
			if not is_matching_finished then
				match_ast (ensure_as)
				safe_process (l_as.ensure_keyword)
				safe_process (l_as.full_assertion_list)
			end
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS)
		do
			if not is_matching_finished then
				match_ast (ensure_then)
				safe_process (l_as.ensure_keyword)
				safe_process (l_as.then_keyword)
				safe_process (l_as.full_assertion_list)
			end
		end

	process_require_as (l_as: REQUIRE_AS)
		do
			if not is_matching_finished then
				match_ast (require_as)
				safe_process (l_as.require_keyword)
				safe_process (l_as.full_assertion_list)
			end
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS)
		do
			if not is_matching_finished then
				match_ast (require_else)
				safe_process (l_as.require_keyword)
				safe_process (l_as.else_keyword)
				safe_process (l_as.full_assertion_list)
			end
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS)
		do
			if not is_matching_finished then
				match_ast (convert_feat)
				safe_process (l_as.feature_name)
				safe_process (l_as.colon_symbol)
				safe_process (l_as.lparan_symbol)
				safe_process (l_as.lcurly_symbol)
				safe_process (l_as.conversion_types)
				safe_process (l_as.rcurly_symbol)
				safe_process (l_as.rparan_symbol)
			end
		end

	process_type_list_as (l_as: TYPE_LIST_AS)
		do
			if not is_matching_finished then
				match_ast (type_list)
				safe_process (l_as.opening_bracket_as)
				process_eiffel_list (l_as)
				safe_process (l_as.closing_bracket_as)
			end
		end

	process_type_dec_list_as (l_as: TYPE_DEC_LIST_AS)
		do
			if not is_matching_finished then
				match_ast (type_dec_list)
				safe_process (l_as.opening_bracket_as)
				process_eiffel_list (l_as)
				safe_process (l_as.closing_bracket_as)
			end
		end

	process_convert_feat_list_as (l_as: CONVERT_FEAT_LIST_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (convert_feat_list)
				safe_process (l_as.convert_keyword)
				process_eiffel_list (l_as)
			end
		end

	process_class_list_as (l_as: CLASS_LIST_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (class_list)
				safe_process (l_as.lcurly_symbol)
				process_eiffel_list (l_as)
				safe_process (l_as.rcurly_symbol)
			end
		end

	process_parent_list_as (l_as: PARENT_LIST_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (parent_list)
				safe_process (l_as.inherit_keyword)
				safe_process (l_as.left_curly_symbol)
				safe_process (l_as.none_id_as)
				safe_process (l_as.right_curly_symbol)
				process_eiffel_list (l_as)
			end
		end

	process_local_dec_list_as (l_as: LOCAL_DEC_LIST_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (local_dec_list)
				safe_process (l_as.local_keyword)
				safe_process (l_as.locals)
			end
		end

	process_formal_argu_dec_list_as (l_as: FORMAL_ARGU_DEC_LIST_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (formal_argu_dec_list)
				safe_process (l_as.lparan_symbol)
				safe_process (l_as.arguments)
				safe_process (l_as.rparan_symbol)
			end
		end

	process_debug_key_list_as (l_as: DEBUG_KEY_LIST_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (debug_key_list)
				safe_process (l_as.lparan_symbol)
				safe_process (l_as.keys)
				safe_process (l_as.rparan_symbol)
			end
		end

	process_delayed_actual_list_as (l_as: DELAYED_ACTUAL_LIST_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (delayed_actual_list)
				safe_process (l_as.lparan_symbol)
				safe_process (l_as.operands)
				safe_process (l_as.rparan_symbol)
			end
		end

	process_parameter_list_as (l_as: PARAMETER_LIST_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (parameter_list)
				safe_process (l_as.lparan_symbol)
				safe_process (l_as.parameters)
				safe_process (l_as.rparan_symbol)
			end
		end

	process_rename_clause_as (l_as: RENAME_CLAUSE_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (rename_clause)
				safe_process (l_as.rename_keyword)
				safe_process (l_as.content)
			end
		end

	process_export_clause_as (l_as: EXPORT_CLAUSE_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (export_clause)
				safe_process (l_as.export_keyword)
				safe_process (l_as.content)
			end
		end

	process_undefine_clause_as (l_as: UNDEFINE_CLAUSE_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (undefine_clause)
				safe_process (l_as.undefine_keyword)
				safe_process (l_as.content)
			end
		end

	process_redefine_clause_as (l_as: REDEFINE_CLAUSE_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (redefine_clause)
				safe_process (l_as.redefine_keyword)
				safe_process (l_as.content)
			end
		end

	process_select_clause_as (l_as: SELECT_CLAUSE_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (select_clause)
				safe_process (l_as.select_keyword)
				safe_process (l_as.content)
			end
		end

	process_formal_generic_list_as (l_as: FORMAL_GENERIC_LIST_AS)
			-- Process `l_as'.
		do
			if not is_matching_finished then
				match_ast (formal_generic_list)
				safe_process (l_as.lsqure_symbol)
				process_eiffel_list (l_as)
				safe_process (l_as.rsqure_symbol)
			end
		end

invariant
	ast_array_attached: ast_array /= Void

indexing
        copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
