indexing

	description: "AST node factories"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class AST_FACTORY

feature -- Access

	new_access_assert_as (f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): ACCESS_ASSERT_AS is
			-- New ACCESS_ASSERT AST node
		require
			f_not_void: f /= Void
		do
			create Result
			Result.initialize (f, p)
		ensure
			access_assert_as_not_void: Result /= Void
			feature_name_set: Result.feature_name = f
			parameters_set: Result.parameters = p
		end

	new_access_feat_as (f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): ACCESS_FEAT_AS is
			-- New ACCESS_FEAT AST node
		require
			f_not_void: f /= Void
		do
			create Result
			Result.initialize (f, p)
		ensure
			access_feat_as_not_void: Result /= Void
			feature_name_set: Result.feature_name = f
			parameters_set: Result.parameters = p
		end

	new_access_id_as (f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): ACCESS_ID_AS is
			-- New ACCESS_ID AST node
		require
			f_not_void: f /= Void
		do
			create Result
			Result.initialize (f, p)
		ensure
			access_id_as_not_void: Result /= Void
			feature_name_set: Result.feature_name = f
			parameters_set: Result.parameters = p
		end

	new_access_inv_as (f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): ACCESS_INV_AS is
			-- New ACCESS_INV AST node
		require
			f_not_void: f /= Void
		do
			create Result
			Result.initialize (f, p)
		ensure
			access_inv_as_not_void: Result /= Void
			feature_name_set: Result.feature_name = f
			parameters_set: Result.parameters = p
		end

	new_address_as (f: FEATURE_NAME): ADDRESS_AS is
			-- New ADDRESS AST node
		require
			f_not_void: f /= Void
		do
			create Result
			Result.initialize (f)
		ensure
			address_as_not_void: Result /= Void
			feature_name_set: Result.feature_name = f
		end

	new_address_current_as: ADDRESS_CURRENT_AS is
			-- New ADDRESS_CURRENT AST node
		do
			create Result
			Result.initialize
		ensure
			address_current_as_not_void: Result /= Void
		end

	new_address_result_as: ADDRESS_RESULT_AS is
			-- New ADDRESS_RESULT AST node
		do
			create Result
			Result.initialize
		ensure
			address_result_as_not_void: Result /= Void
		end

	new_all_as: ALL_AS is
			-- New ALL AST node
		do
			create Result
			Result.initialize
		ensure
			all_as_not_void: Result /= Void
		end

	new_array_as (exp: EIFFEL_LIST [EXPR_AS]): ARRAY_AS is
			-- New Manifest ARRAY AST node
		require
			exp_not_void: exp /= Void
		do
			create Result
			Result.initialize (exp)
		ensure
			array_as_not_void: Result /= Void
			expressions_set: Result.expressions = exp
		end

	new_assign_as (t: ACCESS_AS; s: EXPR_AS; p, l: INTEGER): ASSIGN_AS is
			-- New ASSIGN AST node
		require
			t_not_void: t /= Void
			s_not_void: s /= Void
		do
			create Result
			Result.initialize (t, s, p, l)
		ensure
			assign_as_not_void: Result /= Void
			target_set: Result.target = t
			source_set: Result.source = s
			start_position_set: Result.start_position = p
			line_number_set: Result.line_number = l
		end

	new_bin_and_as (l, r: EXPR_AS): BIN_AND_AS is
			-- New binary and AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_and_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_and_then_as (l, r: EXPR_AS): BIN_AND_THEN_AS is
			-- New binary and then AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_and_then_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_div_as (l, r: EXPR_AS): BIN_DIV_AS is
			-- New binary // AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_div_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_eq_as (l, r: EXPR_AS): BIN_EQ_AS is
			-- New binary = AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_eq_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_free_as (l: EXPR_AS; op: ID_AS; r: EXPR_AS): BIN_FREE_AS is
			-- New BIN_FREE AST node
		require
			l_not_void: l /= Void
			op_not_void: op /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, op, r)
		ensure
			bin_free_as_not_void: Result /= Void
			left_set: Result.left = l
			op_name_set: Result.op_name = op
			right_set: Result.right = r
		end

	new_bin_ge_as (l, r: EXPR_AS): BIN_GE_AS is
			-- New binary >= AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_ge_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_gt_as (l, r: EXPR_AS): BIN_GT_AS is
			-- New binary > AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_gt_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_implies_as (l, r: EXPR_AS): BIN_IMPLIES_AS is
			-- New binary implies AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_implies_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_le_as (l, r: EXPR_AS): BIN_LE_AS is
			-- New binary <= AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_le_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_lt_as (l, r: EXPR_AS): BIN_LT_AS is
			-- New binary < AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_lt_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_minus_as (l, r: EXPR_AS): BIN_MINUS_AS is
			-- New binary - AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_minus_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_mod_as (l, r: EXPR_AS): BIN_MOD_AS is
			-- New binary \\ AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_mod_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_ne_as (l, r: EXPR_AS): BIN_NE_AS is
			-- New binary /= AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_ne_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_or_as (l, r: EXPR_AS): BIN_OR_AS is
			-- New binary or AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_or_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_or_else_as (l, r: EXPR_AS): BIN_OR_ELSE_AS is
			-- New binary or else AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_or_else_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_plus_as (l, r: EXPR_AS): BIN_PLUS_AS is
			-- New binary + AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_plus_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_power_as (l, r: EXPR_AS): BIN_POWER_AS is
			-- New binary ^ AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_power_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_slash_as (l, r: EXPR_AS): BIN_SLASH_AS is
			-- New binary / AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_slash_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_star_as (l, r: EXPR_AS): BIN_STAR_AS is
			-- New binary * AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_star_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bin_xor_as (l, r: EXPR_AS): BIN_XOR_AS is
			-- New binary xor AST node
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (l, r)
		ensure
			bin_xor_as_not_void: Result /= Void
			left_set: Result.left = l
			right_set: Result.right = r
		end

	new_bit_const_as (b: ID_AS): BIT_CONST_AS is
			-- New BIT_CONSTANT AST node with
			-- with bit sequence contained in `b'
		require
			b_not_void: b /= Void
		do
			create Result
			Result.initialize (b)
		ensure
			bit_const_as_not_void: Result /= Void
			value_set: Result.value = b
		end

	new_bits_as (v: INTEGER_AS): BITS_AS is
			-- New BITS AST node
		require
			v_not_void: v /= Void
		do
			create Result
			Result.initialize (v)
		ensure
			bits_as_not_void: Result /= Void
			bits_value_set: Result.bits_value = v
		end

	new_bits_symbol_as (s: ID_AS): BITS_SYMBOL_AS is
			-- New BITS_SYMBOL AST node
		require
			s_not_void: s /= Void
		do
			create Result
			Result.initialize (s)
		ensure
			bits_symbol_as_not_void: Result /= Void
			bits_symbol_set: Result.bits_symbol = s
		end

	new_body_as (a: EIFFEL_LIST [TYPE_DEC_AS]; t: TYPE; c: CONTENT_AS): BODY_AS is
			-- New BODY AST node
		do
			create Result
			Result.initialize (a, t, c)
		ensure
			body_as_not_void: Result /= Void
			arguments_set: Result.arguments = a
			type_set: Result.type = t
			content_set: Result.content = c
		end

	new_boolean_as (b: BOOLEAN): BOOL_AS is
			-- New BOOLEAN AST node
		do
			create Result
			Result.initialize (b)
		ensure
			boolean_as_not_void: Result /= Void
			value_set: Result.value = b
		end

	new_boolean_type_as: BOOL_TYPE_AS is
			-- New type AST node for "BOOLEAN"
		do
			create Result
			Result.initialize
		ensure
			type_as_not_void: Result /= Void
		end

	new_case_as (i: EIFFEL_LIST [INTERVAL_AS];
		c: EIFFEL_LIST [INSTRUCTION_AS]; l: INTEGER): CASE_AS is
			-- New WHEN AST node
		require
			i_not_void: i /= Void
		do
			create Result
			Result.initialize (i, c, l)
		ensure
			case_as_not_void: Result /= Void
			interval_set: Result.interval = i
			compound_set: Result.compound = c
			line_number_set: Result.line_number = l
		end

	new_character_as (c: CHARACTER): CHAR_AS is
			-- New CHARACTER AST node
		do
			create Result
			Result.initialize (c)
		ensure
			character_as_not_void: Result /= Void
			value_set: Result.value = c
		end

	new_character_type_as (is_wide: BOOLEAN): CHAR_TYPE_AS is
			-- New type AST node for "CHARACTER"
		do
			create Result.make (is_wide)
			Result.initialize
		ensure
			type_as_not_void: Result /= Void
		end

	new_check_as (c: EIFFEL_LIST [TAGGED_AS]; s, l: INTEGER): CHECK_AS is
			-- New CHECK AST node
		do
			create Result
			Result.initialize (c, s, l)
		ensure
			check_as_not_void: Result /= Void
			check_list_set: Result.check_list = c
			start_postion_set: Result.start_position = s
			line_number_set: Result.line_number = l
		end

	new_class_as (n: ID_AS; ext_name: STRING;
		is_d, is_e, is_s, is_fc, is_ex: BOOLEAN;
		top_ind, bottom_ind: INDEXING_CLAUSE_AS;
		g: EIFFEL_LIST [FORMAL_DEC_AS];
		p: EIFFEL_LIST [PARENT_AS];
		c: EIFFEL_LIST [CREATE_AS];
		f: EIFFEL_LIST [FEATURE_CLAUSE_AS];
		inv: INVARIANT_AS;
		s: SUPPLIERS_AS;
		o: STRING_AS;
		cl: CLICK_LIST): CLASS_AS is
			-- New CLASS AST node
		require
			n_not_void: n /= Void
			s_not_void: s /= Void
			cl_not_void: cl /= Void
		do
			create Result
			Result.initialize (n, ext_name, is_d, is_e, is_s, is_fc, is_ex, top_ind, bottom_ind, g, p, c, f, inv, s, o, cl)
		ensure
			class_as_not_void: Result /= Void
			class_name_set: Result.class_name = n
			external_class_name_set: Result.external_class_name = ext_name
			is_deferred_set: Result.is_deferred = is_d
			is_expanded_set: Result.is_expanded = is_e
			is_separate_set: Result.is_separate = is_s
			is_frozen_set: Result.is_frozen = is_fc
			is_external_set: Result.is_external = is_ex
			first_indexes_set: Result.top_indexes = top_ind
			last_indexes_set: Result.bottom_indexes = bottom_ind
			generics_set: Result.generics = g
			parents_set: Result.parents = p
			creators_set: Result.creators = c
			features_set: Result.features = f
			empty_invariant_part: Result.invariant_part = Void implies inv = Void or else inv.assertion_list = Void
			invariant_part_set: Result.invariant_part /= Void implies Result.invariant_part = inv

			suppliers_set: Result.suppliers = s
			obsolete_message_set: Result.obsolete_message = o
			click_list_set: Result.click_list = cl
		end

	new_class_type_as (n: ID_AS; g: EIFFEL_LIST [TYPE]): CLASS_TYPE_AS is
			-- New CLASS_TYPE AST node
		require
			n_not_void: n /= Void
		do
			create Result
			Result.initialize (n, g)
		ensure
			class_type_as_not_void: Result /= Void
			class_name_set: Result.class_name = n
			generics_set: Result.generics = g
		end

	new_click_ast (n: CLICKABLE_AST; s, e: INTEGER): CLICK_AST is
			-- New clickable element for `n'
		require
			n_not_void: n /= Void
		do
			create Result
			Result.initialize (n, s, e)
		ensure
			click_ast_not_void: Result /= Void
			node_set: Result.node = n
			start_position_set: Result.start_position = s
			end_position_set: Result.end_position = e
		end

	new_client_as (c: EIFFEL_LIST [ID_AS]): CLIENT_AS is
			-- New CLIENT AST node
		require
			c_not_void: c /= Void
			c_not_empty: not c.is_empty
		do
			create Result
			Result.initialize (c)
		ensure
			client_as_not_void: Result /= Void
			clients_set: Result.clients = c
		end

	new_constant_as (v: EXPR_AS): CONSTANT_AS is
			-- New CONSTANT AST node
		require
			v_not_void: v /= Void
		do
			create Result
			Result.initialize (v)
		ensure
			constant_as_not_void: Result /= Void
			value_set: Result.value = v
		end

	new_create_as (c: CLIENT_AS; f: EIFFEL_LIST [FEATURE_NAME]): CREATE_AS is
			-- New creation clause AST node
		do
			create Result
			Result.initialize (c, f)
		ensure
			create_as_not_void: Result /= Void
			clients_set: Result.clients = c
			feature_list_set: Result.feature_list = f
		end

	new_creation_as (tp: TYPE; tg: ACCESS_AS; c: ACCESS_INV_AS; s, l: INTEGER): CREATION_AS is
			-- New creation instruction AST node
		require
			tg_not_void: tg /= Void
		do
			create Result
			Result.initialize (tp, tg, c, s, l)
		ensure
			creation_as_not_void: Result /= Void
			type_set: Result.type = tp
			target_set: Result.target = tg
			call_set: Result.call = c
			start_position_set: Result.start_position = s
			line_number_set: Result.line_number = l
		end

	new_creation_expr_as (t: TYPE; c: ACCESS_INV_AS; s,l: INTEGER): CREATION_EXPR_AS is
			-- New creation expression AST node
		require
			t_not_void: t /= Void
		do
			create Result
			Result.initialize (t, c, s, l)
		ensure
			creation_expr_as_not_void: Result /= Void
			type_set: Result.type = t
			call_set: Result.call = c
		end

	new_current_as: CURRENT_AS is
			-- New CURRENT AST node
		do
			create Result
			Result.initialize
		ensure
			current_as_not_void: Result /= Void
		end

	new_debug_as (k: EIFFEL_LIST [STRING_AS]; c: EIFFEL_LIST [INSTRUCTION_AS]; s, l: INTEGER): DEBUG_AS is
			-- New DEBUG AST node
		do
			create Result
			Result.initialize (k, c, s, l)
		ensure
			debug_as_not_void: Result /= Void
			keys_set: Result.keys = k
			compound_set: Result.compound = c
			start_position_set: Result.start_position = s
			line_number_set: Result.line_number = l
		end

	new_deferred_as: DEFERRED_AS is
			-- New DEFERRED AST node
		do
			create Result
			Result.initialize
		ensure
			deferred_as_not_void: Result /= Void
		end

	new_do_as (c: EIFFEL_LIST [INSTRUCTION_AS]): DO_AS is
			-- New DO AST node
		do
			create Result
			Result.initialize (c)
		ensure
			do_as_not_void: Result /= Void
			compound_set: Result.compound = c
		end

	new_double_type_as: DOUBLE_TYPE_AS is
			-- New type AST node for "DOUBLE"
		do
			create Result
			Result.initialize
		ensure
			type_as_not_void: Result /= Void
		end

	new_eiffel_list_atomic_as (n: INTEGER): EIFFEL_LIST [ATOMIC_AS] is
			-- New empty list of ATOMIC_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_case_as (n: INTEGER): EIFFEL_LIST [CASE_AS] is
			-- New empty list of CASE_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_create_as (n: INTEGER): EIFFEL_LIST [CREATE_AS] is
			-- New empty list of CREATE_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_elseif_as (n: INTEGER): EIFFEL_LIST [ELSIF_AS] is
			-- New empty list of ELSIF_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_export_item_as (n: INTEGER): EIFFEL_LIST [EXPORT_ITEM_AS] is
			-- New empty list of EXPORT_ITEM_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_expr_as (n: INTEGER): EIFFEL_LIST [EXPR_AS] is
			-- New empty list of EXPR_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_feature_as (n: INTEGER): EIFFEL_LIST [FEATURE_AS] is
			-- New empty list of FEATURE_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_feature_clause_as (n: INTEGER): EIFFEL_LIST [FEATURE_CLAUSE_AS] is
			-- New empty list of FEATURE_CLAUSE_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_feature_name (n: INTEGER): EIFFEL_LIST [FEATURE_NAME] is
			-- New empty list of FEATURE_NAME
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_formal_dec_as (n: INTEGER): EIFFEL_LIST [FORMAL_DEC_AS] is
			-- New empty list of FORMAL_DEC_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_id_as (n: INTEGER): EIFFEL_LIST [ID_AS] is
			-- New empty list of ID_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_index_as (n: INTEGER): INDEXING_CLAUSE_AS is
			-- New empty list of INDEX_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_instruction_as (n: INTEGER): EIFFEL_LIST [INSTRUCTION_AS] is
			-- New empty list of INSTRUCTION_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_interval_as (n: INTEGER): EIFFEL_LIST [INTERVAL_AS] is
			-- New empty list of INTERVAL_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_operand_as (n: INTEGER): EIFFEL_LIST [OPERAND_AS] is
			-- New empty list of OPERAND_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_parent_as (n: INTEGER): EIFFEL_LIST [PARENT_AS] is
			-- New empty list of PARENT_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_rename_as (n: INTEGER): EIFFEL_LIST [RENAME_AS] is
			-- New empty list of RENAME_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_string_as (n: INTEGER): EIFFEL_LIST [STRING_AS] is
			-- New empty list of STRING_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_tagged_as (n: INTEGER): EIFFEL_LIST [TAGGED_AS] is
			-- New empty list of TAGGED_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_type (n: INTEGER): EIFFEL_LIST [TYPE] is
			-- New empty list of TYPE
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_eiffel_list_type_dec_as (n: INTEGER): EIFFEL_LIST [TYPE_DEC_AS] is
			-- New empty list of TYPE_DEC_AS
		require
			n_positive: n >= 0
		do
			create Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_elseif_as (e: EXPR_AS; c: EIFFEL_LIST [INSTRUCTION_AS]; l: INTEGER): ELSIF_AS is
			-- New ELSIF AST node
		require
			e_not_void: e /= Void
		do
			create Result
			Result.initialize (e, c, l)
		ensure
			elseif_as_not_void: Result /= Void
			expr_set: Result.expr = e
			compound_set: Result.compound = c
			line_number_set: Result.line_number = l
		end

	new_ensure_as (a: EIFFEL_LIST [TAGGED_AS]): ENSURE_AS is
			-- New ENSURE AST node
		do
			create Result
			Result.initialize (a)
		ensure
			ensure_as_not_void: Result /= Void
			assertions_set: Result.assertions = a
		end

	new_ensure_then_as (a: EIFFEL_LIST [TAGGED_AS]): ENSURE_THEN_AS is
			-- New ENSURE THEN AST node
		do
			create Result
			Result.initialize (a)
		ensure
			ensure_then_as_not_void: Result /= Void
			assertions_set: Result.assertions = a
		end

	new_expanded_type_as (n: ID_AS; g: EIFFEL_LIST [TYPE]): EXP_TYPE_AS is
			-- New EXPANDED_CLASS_TYPE AST node
		require
			n_not_void: n /= Void
		do
			create Result
			Result.initialize (n, g)
		ensure
			expanded_type_as_not_void: Result /= Void
			class_name_set: Result.class_name = n
			generics_set: Result.generics = g
		end

	new_export_item_as (c: CLIENT_AS; f: FEATURE_SET_AS): EXPORT_ITEM_AS is
			-- New EXPORT_ITEM AST node
		require
			c_not_void: c /= Void
			f_not_void: f /= Void
		do
			create Result
			Result.initialize (c, f)
		ensure
			export_item_as_not_void: Result /= Void
			clients_set: Result.clients = c
			features_set: Result.features = f
		end

	new_expr_address_as (e: EXPR_AS): EXPR_ADDRESS_AS is
			-- New EXPR_ADDRESS AST node
		require
			e_not_void: e /= Void
		do
			create Result
			Result.initialize (e)
		ensure
			expr_address_as_not_void: Result /= Void
			expr_set: Result.expr = e
		end

	new_expr_call_as (c: CALL_AS): EXPR_CALL_AS is
			-- New EXPR_CALL AST node
		require
			c_not_void: c /= Void
		do
			create Result
			Result.initialize (c)
		ensure
			expr_call_as_not_void: Result /= Void
			call_set: Result.call = c
		end

	new_external_as (l: EXTERNAL_LANG_AS; a: STRING_AS): EXTERNAL_AS is
			-- New EXTERNAL AST node
		require
			l_not_void: l /= Void
		do
			create Result
			Result.initialize (l, a)
		ensure
			external_as_not_void: Result /= Void
			language_name_set: Result.language_name = l
			alias_name_set: a /= Void implies Result.alias_name_id > 0
		end

	new_external_lang_as (l: STRING_AS; s: INTEGER): EXTERNAL_LANG_AS is
			-- New EXTERNAL_LANGUAGE AST node
		require
			l_not_void: l /= Void
		do
			create Result
			Result.initialize (l, s)
		ensure
			external_lang_as_not_void: Result /= Void
			language_name_set: Result.language_name = l
			start_position_set: Result.start_position = s
		end

	new_feature_as (f: EIFFEL_LIST [FEATURE_NAME]; b: BODY_AS; i: INDEXING_CLAUSE_AS; s, e: INTEGER): FEATURE_AS is
			-- New FEATURE AST node
		require
			f_not_void: f /= Void
			f_not_empty: not f.is_empty
			b_not_void: b /= Void
			can_have_indexing_clause: i /= Void implies f.count = 1
		do
			create Result
			Result.initialize (f, b, i, s, e)
		ensure
			feature_as_not_void: Result /= Void
			feature_names_set: Result.feature_names = f
			body_set: Result.body = b
			indexes_set: Result.indexes = i
		end

	new_feature_clause_as (c: CLIENT_AS; f: EIFFEL_LIST [FEATURE_AS]; p: INTEGER): FEATURE_CLAUSE_AS is
			-- New FEATURE_CLAUSE AST node
		require
			f_not_void: f /= Void
			p_non_negative: p > 0
		do
			create Result
			Result.initialize (c, f, p)
		ensure
			feature_clause_as_not_void: Result /= Void
			clients_set: Result.clients = c
			features_set: Result.features = f
			position_set: Result.position = p
		end

	new_feature_list_as (f: EIFFEL_LIST [FEATURE_NAME]): FEATURE_LIST_AS is
			-- New FEATURE_LIST AST node
		require
			f_not_void: f /= Void
		do
			create Result
			Result.initialize (f)
		ensure
			feature_list_not_void: Result /= Void
			features_set: Result.features = f
		end

	new_feature_name_id_as (f: ID_AS; b: BOOLEAN): FEAT_NAME_ID_AS is
			-- New FEAT_NAME_ID AST node
		require
			f_not_void: f /= Void
		do
			create Result
			Result.initialize (f, b)
		ensure
			feature_name_id_as_not_void: Result /= Void
			feature_name_set: Result.feature_name = f
			is_frozen_set: Result.is_frozen = b
		end

	new_formal_as (p: INTEGER): FORMAL_AS is
			-- New FORMAL AST node
		do
			create Result
			Result.initialize (p)
		ensure
			formal_as_not_void: Result /= Void
			position_set: Result.position = p
		end

	new_formal_dec_as (n: ID_AS; c: TYPE;
		cf: EIFFEL_LIST [FEATURE_NAME]; p: INTEGER): FORMAL_DEC_AS is
			-- New FORMAL_DECLARATION AST node
		require
			n_not_void: n /= Void
		do
			create Result
			Result.initialize (n, c, cf, p)
		ensure
			formal_dec_as_not_void: Result /= Void
			formal_name_set: Result.formal_name = n
			constraint_set: Result.constraint = c
			creation_feature_list_set: Result.creation_feature_list = cf
			position_set: Result.position = p
		end

	new_id_as (s: STRING): ID_AS is
			-- New ID AST node
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			create Result.initialize (s)
		ensure
			id_as_not_void: Result /= Void
		end

	new_if_as (cnd: EXPR_AS; cmp: EIFFEL_LIST [INSTRUCTION_AS];
		ei: EIFFEL_LIST [ELSIF_AS]; e: EIFFEL_LIST [INSTRUCTION_AS];
		s, l: INTEGER): IF_AS is
			-- New IF AST node
		require
			cnd_not_void: cnd /= Void
		do
			create Result
			Result.initialize (cnd, cmp, ei, e, s, l)
		ensure
			if_as_not_void: Result /= Void
			condition_set: Result.condition = cnd
			compound_set: Result.compound = cmp
			elsif_list_set: Result.elsif_list = ei
			else_part_set: Result.else_part = e
			start_position_set: Result.start_position = s
			line_number_set: Result.line_number = l
		end

	new_index_as (t: ID_AS; i: EIFFEL_LIST [ATOMIC_AS]): INDEX_AS is
			-- Create a new INDEX AST node.
		require
			i_not_void: i /= Void
		do
			create Result
			Result.initialize (t, i)
		ensure
			index_as_not_void: Result /= Void
			tag_set: Result.tag = t
			index_list_set: Result.index_list = i
		end

	new_infix_as (op: STRING_AS; b: BOOLEAN): INFIX_AS is
			-- New INFIX AST node
		require
			op_not_void: op /= Void
		do
			create Result
			Result.initialize (op, b)
		ensure
			infix_as_not_void: Result /= Void
			operator_set: Result.fix_operator = op
			is_frozen_set: Result.is_frozen = b
		end

	new_inspect_as (s: EXPR_AS; c: EIFFEL_LIST [CASE_AS];
		e: EIFFEL_LIST [INSTRUCTION_AS]; p, l: INTEGER): INSPECT_AS is
			-- New INSPECT AST node
		require
			s_not_void: s /= Void
		do
			create Result
			Result.initialize (s, c, e, p, l)
		ensure
			inspect_as_not_void: Result /= Void
			switch_set: Result.switch = s
			case_list_set: Result.case_list = c
			else_part_set: Result.else_part = e
			start_position_set: Result.start_position = p
			line_number_set: Result.line_number = l
		end

	new_instr_call_as (c: CALL_AS; s, l: INTEGER): INSTR_CALL_AS is
			-- New INSTR_CALL AST node
		require
			c_not_void: c /= Void
		do
			create Result
			Result.initialize (c, s, l)
		ensure
			instr_call_as_not_void: Result /= Void
			call_set: Result.call = c
			start_position_set: Result.start_position = s
			line_number_set: Result.line_number = l
		end

	new_integer_as (i: INTEGER): INTEGER_AS is
			-- New INTEGER AST node
		do
			create Result
			Result.initialize (i)
		ensure
			integer_as_not_void: Result /= Void
			value_set: Result.value = i
		end

	new_integer_as_from_hexa (s: STRING): INTEGER_AS is
			-- New INTEGER AST node
		do
			create Result
			Result.initialize_from_hexa (s)
		ensure
			integer_as_not_void: Result /= Void
			-- value_set: Make sure we translated `s'
			-- correctly into correct integer value.
		end

	new_integer_type_as (n: INTEGER): INT_TYPE_AS is
			-- New type AST node for "INTEGER" with `n' bits
		require
			valid_n: n = 8 or n = 16 or n = 32 or n = 64
		do
			create Result.make (n)
			Result.initialize
		ensure
			type_as_not_void: Result /= Void
		end

	new_interval_as (l, u: ATOMIC_AS): INTERVAL_AS is
			-- New INTERVAL AST node
		require
			l_not_void: l /= Void
		do
			create Result
			Result.initialize (l, u)
		ensure
			interval_as_not_void: Result /= Void
			lower_set: Result.lower = l
			upper_set: Result.upper = u
		end

	new_invariant_as (a: EIFFEL_LIST [TAGGED_AS]): INVARIANT_AS is
			-- New INVARIANT AST node
		do
			create Result
			Result.initialize (a)
		ensure
			invariant_as_not_void: Result /= Void
			assertion_list_set: Result.assertion_list = a
		end

	new_like_id_as (a: ID_AS): LIKE_ID_AS is
			-- New LIKE_ID AST node
		require
			a_not_void: a /= Void
		do
			create Result
			Result.initialize (a)
		ensure
			like_id_as_not_void: Result /= Void
			anchor_set: Result.anchor = a
		end

	new_like_current_as: LIKE_CUR_AS is
			-- New LIKE_CURRENT AST node
		do
			create Result
			Result.initialize
		ensure
			like_current_as_not_void: Result /= Void
		end

	new_loop_as (f: EIFFEL_LIST [INSTRUCTION_AS]; i: EIFFEL_LIST [TAGGED_AS];
		v: VARIANT_AS; s: EXPR_AS; c: EIFFEL_LIST [INSTRUCTION_AS];
		p, l: INTEGER): LOOP_AS is
			-- New LOOP AST node
		require
			s_not_void: s /= Void
		do
			create Result
			Result.initialize (f, i, v, s, c, p, l)
		ensure
			loop_as_not_void: Result /= Void
			from_part_set: Result.from_part = f
			invariant_part_set: Result.invariant_part = i
			variant_part_set: Result.variant_part = v
			stop_set: Result.stop = s
			compound_set: Result.compound = c
			start_position_set: Result.start_position = p
			line_number_set: Result.line_number = l
		end

	new_nested_as (t: ACCESS_AS; m: CALL_AS): NESTED_AS is
			-- New NESTED CALL AST node
		require
			t_not_void: t /= Void
			m_not_void: m /= Void
		do
			create Result
			Result.initialize (t, m)
		ensure
			nested_as_not_void: Result /= Void
			target_set: Result.target = t
			message_set: Result.message = m
		end

	new_nested_expr_as (t: EXPR_AS; m: CALL_AS): NESTED_EXPR_AS is
			-- New NESTED_EXPR CALL AST node
		require
			t_not_void: t /= Void
			m_not_void: m /= Void
		do
			create Result
			Result.initialize (t, m)
		ensure
			nested_expr_as_not_void: Result /= Void
			target_set: Result.target = t
			message_set: Result.message = m
		end

	new_none_type_as: NONE_TYPE_AS is
			-- New type AST node for "NONE"
		do
			create Result
			Result.initialize
		ensure
			type_as_not_void: Result /= Void
		end

	new_once_as (c: EIFFEL_LIST [INSTRUCTION_AS]): ONCE_AS is
			-- New ONCE AST node
		do
			create Result
			Result.initialize (c)
		ensure
			once_as_not_void: Result /= Void
			compound_set: Result.compound = c
		end

	new_result_operand_as (c: TYPE; t: ID_AS; e: EXPR_AS): OPERAND_AS is
			-- New OPERAND AST node
		do
			create Result
			Result.initialize_result
		ensure
			operand_as_not_void: Result /= Void
			is_result_set: Result.is_result
			class_type_set: Result.class_type = Void
			target_set: Result.target = Void
			expression_set: Result.expression = Void
		end

	new_operand_as (c: TYPE; t: ID_AS; e: EXPR_AS): OPERAND_AS is
			-- New OPERAND AST node
		do
			create Result
			Result.initialize (c, t, e)
		ensure
			operand_as_not_void: Result /= Void
			class_type_set: Result.class_type = c
			target_set: Result.target = t
			expression_set: Result.expression = e
		end

	new_paran_as (e: EXPR_AS): PARAN_AS is
			-- New PARAN AST node
		require
			e_not_void: e /= Void
		do
			create Result
			Result.initialize (e)
		ensure
			paran_as_not_void: Result /= Void
			expr_set: Result.expr = e
		end

	new_parent_as (t: CLASS_TYPE_AS; rn: EIFFEL_LIST [RENAME_AS];
		e: EIFFEL_LIST [EXPORT_ITEM_AS]; u: EIFFEL_LIST [FEATURE_NAME];
		rd: EIFFEL_LIST [FEATURE_NAME]; s: EIFFEL_LIST [FEATURE_NAME]): PARENT_AS is
			-- New PARENT AST node
		require
			t_not_void: t /= Void
		do
			create Result
			Result.initialize (t, rn, e, u, rd, s)
		ensure
			parent_as_not_void: Result /= Void
			type_set: Result.type = t
			renaming_set: Result.renaming = rn
			exports_set: Result.exports = e
			undefining_set: Result.undefining = u
			redefininig_set: Result.redefining = rd
			selecting_set: Result.selecting = s
		end

	new_pointer_type_as: POINTER_TYPE_AS is
			-- New type AST node for "POINTER"
		do
			create Result
			Result.initialize
		ensure
			type_as_not_void: Result /= Void
		end

	new_precursor_as (n: ID_AS; p: EIFFEL_LIST [EXPR_AS]): PRECURSOR_AS is
			-- New PRECURSOR AST node
		do
			create Result
			Result.initialize (n, p)
		ensure
			precursor_as_not_void: Result /= Void
			parent_name_set: Result.parent_name = n
			parameters_set: Result.parameters = p
		end

	new_static_access_as (c: TYPE; f: ID_AS; p: EIFFEL_LIST [EXPR_AS]): STATIC_ACCESS_AS is
			-- New STATIC_ACCESS AST node
		do
			create Result.initialize (c, f, p)
		ensure
			static_access_as_not_void: Result /= Void
			class_type_set: Result.class_type = c
			feature_name_set: Result.feature_name = f
			parameters_set: Result.parameters = p
		end


	new_prefix_as (op: STRING_AS; b: BOOLEAN): PREFIX_AS is
			-- New PREFIX AST node
		require
			op_not_void: op /= Void
		do
			create Result
			Result.initialize (op, b)
		ensure
			prefix_as_not_void: Result /= Void
			operator_set: Result.fix_operator = op
			is_frozen_set: Result.is_frozen = b
		end

	new_real_as (r: STRING): REAL_AS is
			-- New REAL AST node with `r' containing the
			-- textual representation of the real value
		require
			r_not_void: r /= Void
		do
			create Result
			Result.initialize (r)
		ensure
			real_as_not_void: Result /= Void
			value_set: Result.value = r
		end

	new_real_type_as: REAL_TYPE_AS is
			-- New type AST node for "REAL"
		do
			create Result
			Result.initialize
		ensure
			type_as_not_void: Result /= Void
		end

	new_rename_as (o, n: FEATURE_NAME): RENAME_AS is
			-- New RENAME_PAIR AST node
		require
			o_not_void: o /= Void
			n_not_void: n /= Void
		do
			create Result
			Result.initialize (o, n)
		ensure
			rename_as_not_void: Result /= Void
			old_name_set: Result.old_name = o
			new_name_set: Result.new_name = n
		end

	new_require_as (a: EIFFEL_LIST [TAGGED_AS]): REQUIRE_AS is
			-- New REQUIRE AST node
		do
			create Result
			Result.initialize (a)
		ensure
			require_as_not_void: Result /= Void
			assertions_set: Result.assertions = a
		end

	new_require_else_as (a: EIFFEL_LIST [TAGGED_AS]): REQUIRE_ELSE_AS is
			-- New REQUIRE ELSE AST node
		do
			create Result
			Result.initialize (a)
		ensure
			require_else_as_not_void: Result /= Void
			assertions_set: Result.assertions = a
		end

	new_result_as: RESULT_AS is
			-- New RESULT AST node
		do
			create Result
			Result.initialize
		ensure
			result_as_not_void: Result /= Void
		end

	new_retry_as (l: INTEGER): RETRY_AS is
			-- New RETRY AST node
		do
			create Result
			Result.initialize (l)
		ensure
			retry_as_not_void: Result /= Void
		end

	new_reverse_as (t: ACCESS_AS; s: EXPR_AS; p, l: INTEGER): REVERSE_AS is
			-- New assignment attempt AST node
		require
			t_not_void: t /= Void
			s_not_void: s /= Void
		do
			create Result
			Result.initialize (t, s, p, l)
		ensure
			reverse_as_not_void: Result /= Void
			target_set: Result.target = t
			source_set: Result.source = s
			start_position_set: Result.start_position = p
			line_number_set: Result.line_number = l
		end

	new_routine_as (o: STRING_AS; pr: REQUIRE_AS;
		l: EIFFEL_LIST [TYPE_DEC_AS]; b: ROUT_BODY_AS; po: ENSURE_AS;
		r: EIFFEL_LIST [INSTRUCTION_AS]; p: INTEGER): ROUTINE_AS is
			-- New ROUTINE AST node
		require
			b_not_void: b /= Void
		do
			create Result
			Result.initialize (o, pr, l, b, po, r, p)
		ensure
			routine_as_not_void: Result /= Void
			obsolete_message_set: Result.obsolete_message = o
			precondition_set: Result.precondition = pr
			locals_set: Result.locals = l
			routine_body_set: Result.routine_body = b
			postcondition_set: Result.postcondition = po
			rescue_clause_set: Result.rescue_clause = r
			body_start_position_set: Result.body_start_position = p
		end

	new_routine_creation_as (t: OPERAND_AS; f: ID_AS; o: EIFFEL_LIST [OPERAND_AS]): ROUTINE_CREATION_AS is
			-- New ROUTINE_CREATION AST node
		require
			f_not_void: f /= Void
		do
			create Result
			Result.initialize (t, f, o)
		ensure
			routine_creation_as_not_void: Result /= Void
			target_set: Result.target = t
			feature_name_set: Result.feature_name = f
			operands_set: Result.operands = o
		end

	new_separate_type_as (n: ID_AS; g: EIFFEL_LIST [TYPE]): SEPARATE_TYPE_AS is
			-- New SEPARATE_CLASS_TYPE AST node
		require
			n_not_void: n /= Void
		do
			create Result
			Result.initialize (n, g)
		ensure
			separate_type_as_not_void: Result /= Void
			class_name_set: Result.class_name = n
			generics_set: Result.generics = g
		end

	new_string_as (s: STRING): STRING_AS is
			-- New STRING AST node
		require
			s_not_void: s /= Void
		do
			create Result
			Result.initialize (s)
		ensure
			string_as_not_void: Result /= Void
			value_set: Result.value = s
		end

	new_verbatim_string_as (s, marker: STRING): VERBATIM_STRING_AS is
			-- New VERBATIM_STRING AST node
		require
			s_not_void: s /= Void
			marker_not_void: marker /= Void
		do
			create Result
			Result.initialize (s, marker)
		ensure
			verbatim_string_as_not_void: Result /= Void
			value_set: Result.value = s
			marker_set: Result.verbatim_marker = marker
		end

	new_tagged_as (t: ID_AS; e: EXPR_AS; s, l: INTEGER): TAGGED_AS is
			-- New TAGGED AST node
		require
			e_not_void: e /= Void
		do
			create Result
			Result.initialize (t, e, s, l)
		ensure
			tagged_as_not_void: Result /= Void
			tag_set: Result.tag = t
			expr_set: Result.expr = e
			start_position_set: Result.start_position = s
			line_number_set: Result.line_number = l
		end

	new_tuple_as (exp: EIFFEL_LIST [EXPR_AS]): TUPLE_AS is
			-- New Manifest TUPLE AST node
		require
			exp_not_void: exp /= Void
		do
			create Result
			Result.initialize (exp)
		ensure
			tuple_as_not_void: Result /= Void
			expressions_set: Result.expressions = exp
		end

	new_type_dec_as (i: ARRAYED_LIST [INTEGER]; t: TYPE): TYPE_DEC_AS is
			-- New TYPE_DEC AST node
		require
			i_not_void: i /= Void
			t_not_void: t /= Void
		do
			create Result
			Result.initialize (i, t)
		ensure
			type_dec_as_not_void: Result /= Void
			id_list_set: Result.id_list = i
			type_set: Result.type = t
		end

	new_un_free_as (op: ID_AS; e: EXPR_AS): UN_FREE_AS is
			-- New UN_FREE AST node
		require
			op_not_void: op /= Void
			e_not_void: e /= Void
		do
			create Result
			Result.initialize (op, e)
		ensure
			un_free_as_not_void: Result /= Void
			op_name_set: Result.op_name = op
			expr_set: Result.expr = e
		end

	new_un_minus_as (e: EXPR_AS): UN_MINUS_AS is
			-- New unary - AST node
		require
			e_not_void: e /= Void
		do
			create Result
			Result.initialize (e)
		ensure
			un_minus_as_not_void: Result /= Void
			expr_set: Result.expr = e
		end

	new_un_not_as (e: EXPR_AS): UN_NOT_AS is
			-- New unary not AST node
		require
			e_not_void: e /= Void
		do
			create Result
			Result.initialize (e)
		ensure
			un_not_as_not_void: Result /= Void
			expr_set: Result.expr = e
		end

	new_un_old_as (e: EXPR_AS): UN_OLD_AS is
			-- New unary old AST node
		require
			e_not_void: e /= Void
		do
			create Result
			Result.initialize (e)
		ensure
			un_old_as_not_void: Result /= Void
			expr_set: Result.expr = e
		end

	new_un_plus_as (e: EXPR_AS): UN_PLUS_AS is
			-- New unary + AST node
		require
			e_not_void: e /= Void
		do
			create Result
			Result.initialize (e)
		ensure
			un_plus_as_not_void: Result /= Void
			expr_set: Result.expr = e
		end

	new_un_strip_as (i: ARRAYED_LIST [INTEGER]): UN_STRIP_AS is
			-- New UN_STRIP AST node
		require
			i_not_void: i /= Void
		do
			create Result
			Result.initialize (i)
		ensure
			un_strip_as_not_void: Result /= Void
			id_list_set: Result.id_list = i
		end

	new_unique_as: UNIQUE_AS is
			-- New UNIQUE AST node
		do
			create Result
			Result.initialize
		ensure
			unique_as_not_void: Result /= Void
		end

	new_value_as (t: ATOMIC_AS): VALUE_AS is
			-- New VALUE AST node
		require
			t_not_void: t /= Void
		do
			create Result
			Result.initialize (t)
		ensure
			value_as_not_void: Result /= Void
			terminal_set: Result.terminal = t
		end

	new_variant_as (t: ID_AS; e: EXPR_AS; s, l: INTEGER): VARIANT_AS is
			-- New VARIANT AST node
		require
			e_not_void: e /= Void
		do
			create Result
			Result.initialize (t, e, s, l)
		ensure
			variant_as_not_void: Result /= Void
			tag_set: Result.tag = t
			expr_set: Result.expr = e
			start_position_set: Result.start_position = s
			line_number_set: Result.line_number = l
		end

end -- class AST_FACTORY


--|----------------------------------------------------------------
--| Copyright (C) 1999, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
