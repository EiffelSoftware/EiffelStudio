indexing
	description: "Format Eiffel class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_FORMATTER_VISITOR

inherit
	AST_VISITOR
		redefine
			process_type_a
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_ctxt: FORMAT_CONTEXT) is
			-- Format `a_node' in `a_ctxt' in `a_is_simple' mode.
		require
			a_ctxt_not_void: a_ctxt /= Void
		do
			ctxt := a_ctxt
			is_simple_formatting := a_ctxt.is_for_case
			create export_status_generator
		end

feature -- Formatting

	format (a_node: AST_EIFFEL) is
			-- Format `a_node'.
		require
			a_node_not_void: a_node /= Void
		do
			a_node.process (Current)
		end

	format_indexing_with_no_keyword (l_as: INDEXING_CLAUSE_AS) is
			-- Format `l_as' without inserting the `indexing' keyword.
		require
			l_as_not_void: l_as /= Void
		do
			ctxt.set_separator (Void)
			ctxt.set_new_line_between_tokens
			process_eiffel_list (l_as)
		end

feature {NONE} -- Implementation: Access

	ctxt: FORMAT_CONTEXT
			-- Context in which formatting is done

	is_simple_formatting: BOOLEAN
			-- Is `simple' formatting enabled?

	export_status_generator: AST_EXPORT_STATUS_GENERATOR
			-- To generate EXPORT_I instance for CLIENT_AS nodes

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

	process_separator_as (l_as: SEPARATOR_AS) is
			-- Process `l_as'.
		do
		end

	process_new_line_as (l_as: NEW_LINE_AS) is
			-- Process `l_as'.
		do
		end

	process_comment_as (l_as: COMMENT_AS) is
			-- Process `l_as'.
		do
		end

	process_break_as (l_as: BREAK_AS) is
			-- Process `l_as'.
		do
		end

feature {NONE} -- Implementation

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS) is
		do
			l_as.creation_expr.process (Current)
		end

	process_id_as (l_as: ID_AS) is
		do
			ctxt.put_string (l_as)
		end

	process_integer_as (l_as: INTEGER_AS) is
		do
			if l_as.constant_type /= Void then
				ctxt.put_text_item (ti_l_curly)
				l_as.constant_type.process (Current)
				ctxt.put_text_item (ti_r_curly)
				ctxt.put_space
			end
			ctxt.put_text_item (create {NUMBER_TEXT}.make (l_as.string_value))
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
		do
			if not is_simple_formatting then
				ctxt.begin
			end

			ctxt.put_text_item (ti_l_curly)
			l_as.class_type.process (Current)
			ctxt.put_text_item (ti_r_curly)

			ctxt.put_text_item (ti_dot)
			ctxt.prepare_for_creation_expression_or_static_access (l_as.class_type, l_as.feature_name, l_as.parameters)
			ctxt.put_current_feature
			if not is_simple_formatting then
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback
				end
			end
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS) is
		local
			comments: EIFFEL_COMMENTS
			i, l_count: INTEGER
			f: EIFFEL_LIST [FEATURE_AS]
			next_feat, feat: FEATURE_AS
			e_file: EIFFEL_FILE
		do
			ctxt.put_text_item (ti_feature_keyword)
			ctxt.put_space
			if l_as.clients /= Void then
				ctxt.set_separator (ti_comma)
				ctxt.set_space_between_tokens
				l_as.clients.process (Current)
			end
			e_file := ctxt.eiffel_file
			comments := e_file.current_feature_clause_comments
			if comments = Void then
				ctxt.put_new_line
			else
				if comments.count > 1 then
					ctxt.indent
					ctxt.indent
					ctxt.put_new_line
					ctxt.put_comments (comments)
					ctxt.exdent
					ctxt.exdent
				else
					ctxt.put_space
					ctxt.put_comments (comments)
				end
			end
			ctxt.put_new_line
			ctxt.indent
			ctxt.set_new_line_between_tokens
			ctxt.set_separator (ti_empty)

			f := l_as.features
			ctxt.begin
			from
				i := 1
				l_count := f.count
				if l_count > 0 then
					feat := f.i_th (1)
				end
			until
				i > l_count
			loop
				ctxt.new_expression
				if i > 1 then
					ctxt.put_separator
				end
				ctxt.new_expression
				ctxt.begin
				i := i + 1
				if i > l_count then
					e_file.set_next_feature (Void)
				else
					next_feat := f.i_th (i)
					e_file.set_next_feature (next_feat)
				end
				e_file.set_current_feature (feat)
				feat.process (Current)
				feat := next_feat
				ctxt.commit
			end
			ctxt.commit
			ctxt.exdent
		end

	process_unique_as (l_as: UNIQUE_AS) is
		do
			ctxt.put_text_item_without_tabs (ti_unique_keyword)
		end

	process_tuple_as (l_as: TUPLE_AS) is
		do
			ctxt.put_text_item (ti_l_bracket)
			ctxt.set_separator (ti_comma)
			ctxt.set_space_between_tokens
			l_as.expressions.process (Current)
			ctxt.put_text_item_without_tabs (ti_r_bracket)
		end

	process_real_as (l_as: REAL_AS) is
		do
			if l_as.constant_type /= Void then
				ctxt.put_text_item (ti_l_curly)
				l_as.constant_type.process (Current)
				ctxt.put_text_item (ti_r_curly)
				ctxt.put_space
			end
			ctxt.put_text_item (create {NUMBER_TEXT}.make (l_as.value))
		end

	process_bool_as (l_as: BOOL_AS) is
		do
			if l_as.value then
				ctxt.put_text_item (ti_true_keyword)
			else
				ctxt.put_text_item (ti_false_keyword)
			end
		end

	process_bit_const_as (l_as: BIT_CONST_AS) is
		do
			ctxt.put_string (l_as.value)
			ctxt.put_string ("B")
		end

	process_array_as (l_as: ARRAY_AS) is
		do
			ctxt.put_text_item (ti_l_array)
			ctxt.put_space
			if not l_as.expressions.is_empty then
				ctxt.set_separator (ti_comma)
				ctxt.set_space_between_tokens
				l_as.expressions.process (Current)
				ctxt.put_space
			end
			ctxt.put_text_item_without_tabs (ti_r_array)
		end

	process_char_as (l_as: CHAR_AS) is
		do
			ctxt.put_text_item (create {CHARACTER_TEXT}.make (l_as.string_value))
		end

	process_string_as (l_as: STRING_AS) is
		do
			if l_as.is_once_string then
				ctxt.put_text_item (ti_once_keyword)
				ctxt.put_space
			end
			ctxt.put_string_item (l_as.string_value)
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS) is
		do
			if l_as.is_once_string then
				ctxt.put_text_item (ti_once_keyword)
				ctxt.put_space
			end
			ctxt.put_string_item ("%"" + l_as.verbatim_marker)
			if l_as.is_indentable then
				ctxt.put_string_item ("[")
			else
				ctxt.put_string_item ("{")
			end
			ctxt.put_new_line
			if not l_as.value.is_empty then
				append_format_multilined (l_as.value.twin, l_as.is_indentable)
			end
			if l_as.is_indentable then
				ctxt.put_string_item ("]")
			else
				ctxt.put_string_item ("}")
			end
			ctxt.text.add_manifest_string (l_as.verbatim_marker + "%"")
		end

	process_body_as (l_as: BODY_AS) is
		do
			if l_as.arguments /= Void and then not l_as.arguments.is_empty then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_l_parenthesis)
				ctxt.set_separator (ti_semi_colon)
				ctxt.set_space_between_tokens
				l_as.arguments.process (Current)
				ctxt.put_text_item_without_tabs (ti_r_parenthesis)
			end
			if l_as.type /= Void then
				ctxt.put_text_item_without_tabs (ti_colon)
				ctxt.put_space
				if l_as.type.has_like then
					ctxt.new_expression
				end
				l_as.type.process (Current)
			end
			ctxt.set_separator (ti_empty)
			if l_as.assigner /= Void then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_Assign_keyword)
				ctxt.put_space
				ctxt.prepare_for_feature (l_as.assigner, Void)
				ctxt.put_current_feature
			end
			safe_process (l_as.content)
		end

	process_result_as (l_as: RESULT_AS) is
		do
			ctxt.prepare_for_result
			ctxt.put_text_item (ti_result)
		end

	process_current_as (l_as: CURRENT_AS) is
		do
			ctxt.prepare_for_current
			ctxt.put_text_item (ti_current)
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
		do
			if not is_simple_formatting then
				ctxt.begin
			end
			ctxt.prepare_for_feature (l_as.feature_name, l_as.parameters)
			ctxt.put_current_feature
			if not is_simple_formatting then
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback
				end
			end
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
		local
			real_feature: E_FEATURE
			l_parent_class: CLASS_C
			current_feature: E_FEATURE
		do
			ctxt.begin
			current_feature := ctxt.global_adapt.target_enclosing_feature.api_feature (ctxt.class_c.class_id)
			if l_as.parent_base_class /= Void then
				l_parent_class := universe.class_named (l_as.parent_base_class.class_name, ctxt.class_c.cluster).compiled_class
			else
				l_parent_class := current_feature.precursors.last
			end
			if l_parent_class /= Void then
				real_feature := current_feature.ancestor_version (l_parent_class)
			end
			if real_feature /= Void then
				ctxt.put_text_item (create {PRECURSOR_KEYWORD_TEXT}.make (real_feature))
			else
				ctxt.put_text_item (create {KEYWORD_TEXT}.make (ti_precursor_keyword.image))
			end
			if l_as.parent_base_class /= Void then
				ctxt.put_text_item (ti_space)
				ctxt.put_text_item (ti_l_curly)
				ctxt.put_class_name (l_as.parent_base_class.class_name)
				ctxt.put_text_item (ti_r_curly)
			end
			if l_as.parameter_count > 0 then
				ctxt.prepare_for_feature ("", l_as.parameters)
				ctxt.put_current_feature
			end
			ctxt.commit
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS) is
		local
			paran_as: PARAN_AS
		do
			if is_simple_formatting then
				paran_as ?= l_as.target
				if paran_as = Void then
					ctxt.put_text_item (ti_l_parenthesis)
				end
				l_as.target.process (Current)
				if paran_as = Void then
					ctxt.put_text_item_without_tabs (ti_r_parenthesis)
				end
				ctxt.need_dot
				l_as.message.process (Current)
			else
				ctxt.begin
				ctxt.put_text_item (ti_l_parenthesis)
				l_as.target.process (Current)
				if ctxt.last_was_printed then
					ctxt.put_text_item_without_tabs (ti_r_parenthesis)
					ctxt.need_dot
					l_as.message.process (Current)
					if ctxt.last_was_printed then
						ctxt.commit
					else
						ctxt.rollback
					end
				else
					ctxt.rollback
				end
			end
		end

	process_nested_as (l_as: NESTED_AS) is
		do
			if is_simple_formatting then
				l_as.target.process (Current)
				ctxt.need_dot
				l_as.message.process (Current)
			else
				ctxt.begin
				l_as.target.process (Current)
				if ctxt.last_was_printed then
					ctxt.need_dot
					l_as.message.process (Current)
					if ctxt.last_was_printed then
						ctxt.commit
					else
						ctxt.rollback
					end
				else
					ctxt.rollback
				end
			end
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS) is
		do
			ctxt.new_expression
			if not is_simple_formatting then
				ctxt.begin
			end
			ctxt.put_text_item (ti_create_keyword)
			ctxt.put_space
			ctxt.put_text_item (ti_l_curly)
			l_as.type.process (Current)
			ctxt.put_text_item (ti_r_curly)
			if l_as.call /= Void then
				ctxt.put_text_item (ti_dot)
				if not is_simple_formatting then
					ctxt.begin
				end
				ctxt.prepare_for_creation_expression_or_static_access (l_as.type, l_as.call.feature_name, l_as.call.parameters)
				ctxt.put_current_feature
				if not is_simple_formatting then
					if ctxt.last_was_printed then
						ctxt.commit
					else
						ctxt.rollback
					end
				end
			else
				ctxt.prepare_for_creation_expression_or_static_access (l_as.type, "", Void)
			end
			if not is_simple_formatting then
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback
				end
			end
		end

	process_type_expr_as (l_as: TYPE_EXPR_AS) is
		do
			ctxt.put_text_item (ti_l_curly)
			l_as.type.process (Current)
			ctxt.put_text_item (ti_r_curly)
		end

	process_routine_as (l_as: ROUTINE_AS) is
		local
			comments: EIFFEL_COMMENTS
			chained_assert: CHAINED_ASSERTIONS
		do
			if is_simple_formatting then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_is_keyword)
				ctxt.put_new_line
				if l_as.obsolete_message /= Void then
					ctxt.indent
					ctxt.put_text_item (ti_obsolete_keyword)
					ctxt.put_space
					l_as.obsolete_message.process (Current)
					ctxt.put_new_line
					ctxt.exdent
				end
				comments := ctxt.feature_comments
				if comments /= Void then
					ctxt.indent
					ctxt.indent
					ctxt.put_comments (comments)
					ctxt.exdent
					ctxt.exdent
				end
				ctxt.indent
				safe_process (l_as.precondition)
				if l_as.locals /= Void then
					ctxt.put_text_item (ti_local_keyword)
					ctxt.set_separator (ti_empty)
					ctxt.indent
					ctxt.set_new_line_between_tokens
					ctxt.put_new_line
					l_as.locals.process (Current)
					ctxt.put_new_line
					ctxt.exdent
				end
				safe_process (l_as.routine_body)
				safe_process (l_as.postcondition)
				if l_as.rescue_clause /= Void then
					ctxt.put_text_item (ti_rescue_keyword)
					ctxt.indent
					ctxt.put_new_line
					l_as.rescue_clause.process (Current)
					ctxt.put_new_line
					ctxt.exdent
					ctxt.put_breakable
				end
				ctxt.put_text_item (ti_end_keyword)
				ctxt.exdent
			else
				if ctxt.is_feature_short then
					ctxt.put_new_line
				else
					ctxt.put_space
					ctxt.put_text_item_without_tabs (ti_is_keyword)
					ctxt.put_new_line
					if l_as.obsolete_message /= Void then
						ctxt.indent
						ctxt.put_text_item (ti_obsolete_keyword)
						ctxt.put_space
						l_as.obsolete_message.process (Current)
						ctxt.put_new_line
						ctxt.exdent
					end
				end
				ctxt.indent
				ctxt.indent
				comments := ctxt.feature_comments
				if comments /= Void then
					ctxt.put_comments (comments)
				end
				ctxt.put_origin_comment
				ctxt.exdent
				ctxt.set_first_assertion (True)
				chained_assert := ctxt.chained_assertion
				if chained_assert /= Void then
					chained_assert.format_precondition (ctxt)
				elseif l_as.precondition /= Void then
					ctxt.set_in_assertion;
					l_as.precondition.process (Current)
					ctxt.set_not_in_assertion
				end
				if not ctxt.is_feature_short then
					if l_as.locals /= Void then
						ctxt.put_text_item (ti_local_keyword)
						ctxt.set_separator (Void)
						ctxt.indent
						ctxt.set_new_line_between_tokens
						ctxt.put_new_line
						l_as.locals.process (Current)
						ctxt.put_new_line
						ctxt.exdent
					end
					safe_process (l_as.routine_body)
				end
				ctxt.set_first_assertion (True)
				if chained_assert /= Void then
					chained_assert.format_postcondition (ctxt)
				elseif l_as.postcondition /= Void then
					ctxt.set_in_assertion;
					l_as.postcondition.process (Current)
					ctxt.set_not_in_assertion
				end
				if not ctxt.is_feature_short then
					if l_as.rescue_clause /= Void then
						ctxt.put_text_item (ti_rescue_keyword)
						ctxt.indent
						ctxt.put_new_line
						ctxt.set_separator (Void)
						ctxt.set_new_line_between_tokens
						l_as.rescue_clause.process (Current)
						ctxt.exdent
						ctxt.put_new_line
					end
					if not l_as.is_deferred and not l_as.is_external then
						ctxt.put_breakable
					end
					ctxt.put_text_item (ti_end_keyword)
				end
				ctxt.exdent
			end
		end

	process_constant_as (l_as: CONSTANT_AS) is
		do
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_is_keyword)
			ctxt.put_space
			l_as.value.process (Current)
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL]) is
		local
			i, l_count: INTEGER
			failure: BOOLEAN
			not_first: BOOLEAN
			must_abort: BOOLEAN
		do
			if is_simple_formatting then
				ctxt.begin
				from
					i := 1
					l_count := l_as.count
				until
					i > l_count
				loop
					if i > 1 then
						ctxt.put_separator
					end
					ctxt.new_expression
					ctxt.begin
					l_as.i_th (i).process (Current)
					ctxt.commit
					i := i + 1
				end
				ctxt.commit
			else
				ctxt.begin
				must_abort := ctxt.must_abort_on_failure
				from
					i := 1
					l_count := l_as.count
				until
					i > l_count or failure
				loop
					if not_first then
						ctxt.put_separator
					end
					ctxt.new_expression
					ctxt.begin
					l_as.i_th (i).process (Current)
					if not ctxt.last_was_printed then
						ctxt.rollback
						if must_abort then
							failure := True
							not_first := False
						end
					else
						ctxt.commit
						not_first := True
					end
					i := i + 1
				end
				if l_count > 0 and then not not_first then
					ctxt.rollback
				else
					ctxt.commit
				end
			end
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS) is
		do
			ctxt.put_text_item (ti_before_indexing)
			ctxt.put_text_item (ti_indexing_keyword)
			ctxt.indent
			ctxt.put_new_line
			ctxt.set_separator (Void)
			ctxt.set_new_line_between_tokens
			process_eiffel_list (l_as)
			ctxt.put_text_item (ti_after_indexing)
			ctxt.exdent
			ctxt.put_new_line
			ctxt.put_new_line
		end

	process_operand_as (l_as: OPERAND_AS) is
		do
			if l_as.class_type /= Void then
				ctxt.put_text_item (ti_l_curly)
				l_as.class_type.process (Current)
				ctxt.put_text_item (ti_r_curly)
				ctxt.put_space
				ctxt.put_text_item (ti_question)
			else
				if l_as.expression /= Void then
					l_as.expression.process (Current)
				else
					if l_as.target /= Void then
						l_as.target.process (Current)
					else
						ctxt.put_text_item (ti_question)
					end
				end
			end
		end

	process_tagged_as (l_as: TAGGED_AS) is
		do
			format_tagged_as (l_as, not ctxt.is_with_breakable)
		end

	process_variant_as (l_as: VARIANT_AS) is
		do
			process_tagged_as (l_as)
		end

	process_un_strip_as (l_as: UN_STRIP_AS) is
		local
			first_printed: BOOLEAN
			l_names_heap: like names_heap
		do
			ctxt.put_text_item (ti_strip_keyword)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_l_parenthesis)
			from
				l_names_heap := names_heap
				l_as.id_list.start
			until
				l_as.id_list.after
			loop
				ctxt.new_expression
				ctxt.prepare_for_feature (l_names_heap.item (l_as.id_list.item), Void)
				if ctxt.is_feature_visible then
					if first_printed then
						ctxt.put_text_item_without_tabs (ti_comma)
						ctxt.put_space
					end
					ctxt.put_current_feature
					first_printed := True
				end
				l_as.id_list.forth
			end
			ctxt.put_text_item_without_tabs (ti_r_parenthesis)
		end

	process_paran_as (l_as: PARAN_AS) is
		do
			if not is_simple_formatting then
				ctxt.begin
			end

			ctxt.put_text_item (ti_l_parenthesis)
			l_as.expr.process (Current)
			ctxt.put_text_item_without_tabs (ti_r_parenthesis)

			if not is_simple_formatting then
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback
				end
			end
		end

	process_expr_call_as (l_as: EXPR_CALL_AS) is
		do
			l_as.call.process (Current)
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS) is
		do
			if not is_simple_formatting then
				ctxt.begin
			end

			ctxt.put_text_item (ti_dollar)
			ctxt.put_text_item_without_tabs (ti_l_parenthesis)
			l_as.expr.process (Current)
			ctxt.put_text_item_without_tabs (ti_r_parenthesis)

			if not is_simple_formatting then
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback
				end
			end
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS) is
		do
			ctxt.put_text_item_without_tabs (ti_dollar)
			ctxt.put_text_item_without_tabs (ti_result)
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS) is
		do
			ctxt.put_text_item_without_tabs (ti_dollar)
			ctxt.put_text_item_without_tabs (ti_current)
		end

	process_address_as (l_as: ADDRESS_AS) is
		do
			if is_simple_formatting then
				ctxt.prepare_for_feature (l_as.feature_name.internal_name, Void)
				ctxt.put_text_item_without_tabs (ti_dollar)
				ctxt.put_current_feature
			else
				ctxt.begin
				ctxt.prepare_for_feature (l_as.feature_name.internal_name, Void)
				if ctxt.is_feature_visible then
					ctxt.put_text_item_without_tabs (ti_dollar)
					ctxt.put_current_feature
					ctxt.commit
				else
					ctxt.rollback
				end
			end
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS) is
		local
			dummy_call: ACCESS_FEAT_AS
			l_operand: OPERAND_AS
		do
			ctxt.put_text_item (ti_agent_keyword)
			ctxt.put_space
			if l_as.target /= Void then
				l_operand := l_as.target
				if l_operand.class_type /= Void then
					ctxt.put_text_item (ti_l_curly)
					l_operand.class_type.process (Current)
					ctxt.put_text_item (ti_r_curly)
					ctxt.need_dot
				elseif l_operand.expression /= Void then
					ctxt.put_text_item (ti_l_parenthesis)
					l_operand.expression.process (Current)
					ctxt.put_text_item (ti_r_parenthesis)
					ctxt.need_dot
				elseif l_operand.target /= Void then
					l_operand.target.process (Current)
					ctxt.need_dot
				end
			else
				ctxt.put_text_item (ti_question)
				ctxt.need_dot
			end
			create dummy_call.initialize (l_as.feature_name, l_as.operands)
			dummy_call.process (Current)
		end

	process_unary_as (l_as: UNARY_AS) is
		do
			if is_simple_formatting then
				ctxt.prepare_for_prefix (l_as.prefix_feature_name, l_as.operator_name)
				ctxt.put_prefix_feature
				ctxt.put_space
				l_as.expr.process (Current)
			else
				ctxt.begin
				ctxt.set_insertion_point
				l_as.expr.process (Current)
				if not ctxt.last_was_printed then
					ctxt.rollback
				else
					ctxt.need_dot
					ctxt.prepare_for_prefix (l_as.prefix_feature_name, l_as.operator_name)
					ctxt.put_current_feature
					ctxt.put_prefix_space
					if ctxt.last_was_printed then
						ctxt.commit
					else
						ctxt.rollback
					end
				end
			end
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
			if is_simple_formatting then
				ctxt.put_text_item (ti_old_keyword)
				ctxt.put_space
				l_as.expr.process (Current)
			else
				ctxt.begin
				ctxt.put_text_item (ti_old_keyword)
				ctxt.put_space
				l_as.expr.process (Current)
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback
				end
			end
		end

	process_un_plus_as (l_as: UN_PLUS_AS) is
		do
			process_unary_as (l_as)
		end

	process_binary_as (l_as: BINARY_AS) is
		do
			if is_simple_formatting then
				l_as.left.process (Current)
				ctxt.prepare_for_infix (l_as.infix_function_name, l_as.op_name, l_as.right)
				ctxt.put_infix_feature
			else
				ctxt.begin
				l_as.left.process (Current)
				if not ctxt.last_was_printed then
					ctxt.rollback
				else
					ctxt.need_dot
					ctxt.prepare_for_infix (l_as.infix_function_name, l_as.op_name, l_as.right)
					ctxt.put_current_feature
					if not ctxt.last_was_printed then
						ctxt.rollback
					else
						ctxt.commit
					end
				end
			end
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
			if not is_simple_formatting then
				ctxt.begin
			end
			l_as.target.process (Current)
			if not is_simple_formatting and then not ctxt.last_was_printed then
				ctxt.rollback
			else
				ctxt.prepare_for_bracket (l_as.operands)
				ctxt.put_current_feature
				if not is_simple_formatting then
					if ctxt.last_was_printed then
						ctxt.commit
					else
						ctxt.rollback
					end
				end
			end
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS) is
		do
			l_as.language_name.process (Current)
		end

	process_feature_as (l_as: FEATURE_AS) is
		local
			comments: EIFFEL_COMMENTS
			cont: CONTENT_AS
			is_const_or_att: BOOLEAN
			feature_dec: FEATURE_DEC_ITEM
		do
			if is_simple_formatting then
				comments := ctxt.eiffel_file.current_feature_comments
				ctxt.set_feature_comments (comments)
				ctxt.set_separator (ti_comma)
				ctxt.set_space_between_tokens
				l_as.feature_names.process (Current)
				l_as.body.process (Current)
				cont := l_as.body.content
				is_const_or_att := cont = Void or else cont.is_constant
				if is_const_or_att and then comments /= Void then
					ctxt.put_new_line
					ctxt.indent
					ctxt.indent
					ctxt.put_comments (comments)
					ctxt.exdent
					ctxt.exdent
				else
					ctxt.put_new_line
				end
			else
				ctxt.begin
				ctxt.put_new_line
				ctxt.set_separator (ti_comma)
				ctxt.set_space_between_tokens
				ctxt.abort_on_failure
				create feature_dec.make (l_as.feature_names.first.internal_name)
				feature_dec.set_before
				ctxt.put_text_item (feature_dec)
				if ctxt.has_feature_i then
					if ctxt.global_adapt.target_enclosing_feature.is_frozen then
						ctxt.put_text_item (ti_frozen_keyword)
						ctxt.put_space
					end
					ctxt.prepare_for_main_feature
					adapt_main_feature
				else
					l_as.feature_names.process (Current)
				end
				if not ctxt.last_was_printed then
					ctxt.rollback
				else
					l_as.body.process (Current)
					create feature_dec.make (l_as.feature_names.first.internal_name)
					feature_dec.set_after
					ctxt.put_text_item_without_tabs (feature_dec)
					if not ctxt.is_feature_short then
						ctxt.put_new_line
					end
					cont := l_as.body.content
					is_const_or_att := cont = Void or else cont.is_constant
					if is_const_or_att then
						ctxt.indent
						ctxt.indent
						if ctxt.is_feature_short then
							ctxt.put_new_line
						end
						comments := ctxt.feature_comments
						if comments /= Void then
							ctxt.put_comments (comments)
						end
						ctxt.put_origin_comment
						ctxt.exdent
						ctxt.exdent
					end
					ctxt.commit
				end
			end
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
		do
			if l_as.is_frozen then
				ctxt.put_text_item (ti_frozen_keyword)
				ctxt.put_space
			end
			if is_simple_formatting then
				if l_as.is_infix then
					ctxt.put_text_item (ti_infix_keyword)
					ctxt.put_space
					ctxt.put_text_item_without_tabs (ti_double_quote)
					ctxt.prepare_for_infix (l_as.internal_name, l_as.visual_name, Void)
					ctxt.put_infix_feature
				else
					ctxt.put_text_item (ti_prefix_keyword)
					ctxt.put_space
					ctxt.put_text_item_without_tabs (ti_double_quote)
					ctxt.prepare_for_prefix (l_as.internal_name, l_as.visual_name)
					ctxt.put_prefix_feature
				end
				ctxt.put_text_item_without_tabs (ti_double_quote)
			else
				ctxt.local_adapt.set_evaluated_type
				if l_as.is_infix then
					ctxt.prepare_for_infix (l_as.internal_name, l_as.visual_name, Void)
				else
					ctxt.prepare_for_prefix (l_as.internal_name, l_as.visual_name)
				end
				adapt_main_feature
			end
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS) is
		do
			if l_as.is_frozen then
				ctxt.put_text_item (ti_frozen_keyword)
				ctxt.put_space
			end
			if is_simple_formatting then
				ctxt.prepare_for_feature (l_as.feature_name, Void)
				ctxt.put_normal_feature
			else
				ctxt.local_adapt.set_evaluated_type
				ctxt.prepare_for_feature (l_as.feature_name, Void)
				adapt_main_feature
			end
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS) is
		do
			if l_as.is_frozen then
				ctxt.put_text_item (ti_frozen_keyword)
				ctxt.put_space
			end
			if is_simple_formatting then
				ctxt.prepare_for_feature (l_as.feature_name, Void)
				ctxt.put_normal_feature
			else
				ctxt.local_adapt.set_evaluated_type
				ctxt.prepare_for_feature (l_as.feature_name, Void)
				ctxt.local_adapt.set_alias_name (l_as.alias_name.value)
				adapt_main_feature
			end
			if l_as.has_convert_mark then
				ctxt.put_space
				ctxt.put_text_item (ti_convert_keyword)
			end
		end

	process_feature_list_as (l_as: FEATURE_LIST_AS) is
		do
			ctxt.set_separator (ti_comma)
			ctxt.set_space_between_tokens
			if is_simple_formatting then
				ctxt.continue_on_failure
			end
			l_as.features.process (Current)
		end

	process_all_as (l_as: ALL_AS) is
		do
			ctxt.put_text_item (ti_all_keyword)
		end

	process_assign_as (l_as: ASSIGN_AS) is
		do
			ctxt.put_breakable
			ctxt.new_expression
			l_as.target.process (Current)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_assign)
			ctxt.put_space
			ctxt.new_expression
			l_as.source.process (Current)
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS) is
		do
			ctxt.put_breakable
			ctxt.new_expression
			l_as.target.process (Current)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_assign)
			ctxt.put_space
			ctxt.new_expression
			l_as.source.process (Current)
		end

	process_reverse_as (l_as: REVERSE_AS) is
		do
			ctxt.put_breakable
			ctxt.new_expression
			l_as.target.process (Current)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_reverse_assign)
			ctxt.put_space
			ctxt.new_expression
			l_as.source.process (Current)
		end

	process_check_as (l_as: CHECK_AS) is
		do
			ctxt.put_text_item (ti_check_keyword)
			if l_as.check_list /= Void then
				ctxt.indent
				ctxt.put_new_line
				ctxt.set_new_line_between_tokens
				l_as.check_list.process (Current)
				ctxt.exdent
			end
			ctxt.put_new_line
			ctxt.put_text_item (ti_end_keyword)
		end

	process_creation_as (l_as: CREATION_AS) is
		do
			ctxt.put_breakable
			ctxt.put_text_item (ti_create_keyword)
			ctxt.put_space
			if l_as.type /= Void then
				ctxt.put_text_item (ti_l_curly)
				l_as.type.process (Current)
				ctxt.put_text_item_without_tabs (ti_r_curly)
				ctxt.put_space
			end
			l_as.target.process (Current)
			if l_as.type /= Void then
				ctxt.set_type_creation (l_as.type)
			end
			if l_as.call /= Void then
				ctxt.need_dot
				l_as.call.process (Current)
			end
		end

	process_debug_as (l_as: DEBUG_AS) is
		do
			ctxt.put_text_item (ti_debug_keyword)
			ctxt.put_space
			if l_as.keys /= Void and then not l_as.keys.is_empty then
				ctxt.put_text_item_without_tabs (ti_l_parenthesis)
				ctxt.set_separator (ti_comma)
				ctxt.set_no_new_line_between_tokens
				l_as.keys.process (Current)
				ctxt.put_text_item_without_tabs (ti_r_parenthesis)
			end
			if l_as.compound /= Void then
				ctxt.indent
				ctxt.put_new_line
				ctxt.set_separator (Void)
				ctxt.set_new_line_between_tokens
				l_as.compound.process (Current)
				ctxt.exdent
			end
			ctxt.put_new_line
			ctxt.put_text_item (ti_end_keyword)
		end

	process_if_as (l_as: IF_AS) is
		do
			ctxt.put_breakable
			ctxt.put_text_item (ti_if_keyword)
			ctxt.put_space
			ctxt.new_expression
			l_as.condition.process (Current)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_then_keyword)
			if l_as.compound /= Void then
				ctxt.indent
				ctxt.put_new_line
				ctxt.set_new_line_between_tokens
				l_as.compound.process (Current)
				ctxt.exdent
			end
			ctxt.put_new_line
			if l_as.elsif_list /= Void then
				ctxt.set_separator (ti_empty)
				ctxt.set_no_new_line_between_tokens
				l_as.elsif_list.process (Current)
				ctxt.set_separator (Void)
			end
			if l_as.else_part /= Void then
				ctxt.put_text_item (ti_else_keyword)
				ctxt.indent
				ctxt.put_new_line
				ctxt.set_new_line_between_tokens
				l_as.else_part.process (Current)
				ctxt.exdent
				ctxt.put_new_line
			end
			ctxt.put_text_item (ti_end_keyword)
		end

	process_inspect_as (l_as: INSPECT_AS) is
		do
			ctxt.put_breakable
			ctxt.put_text_item (ti_inspect_keyword)
			ctxt.put_space
			ctxt.indent
			l_as.switch.process (Current)
			ctxt.exdent
			ctxt.put_new_line
			if l_as.case_list /= Void then
				ctxt.set_separator (ti_empty)
				ctxt.set_no_new_line_between_tokens
				l_as.case_list.process (Current)
			end
			if l_as.else_part /= Void then
				ctxt.put_text_item (ti_else_keyword)
				ctxt.indent
				ctxt.put_new_line
				ctxt.set_separator (Void)
				ctxt.set_new_line_between_tokens
				l_as.else_part.process (Current)
				ctxt.put_new_line
				ctxt.exdent
			end
			ctxt.put_text_item (ti_end_keyword)
		end

	process_instr_call_as (l_as: INSTR_CALL_AS) is
		do
			ctxt.put_breakable
			l_as.call.process (Current)
		end

	process_loop_as (l_as: LOOP_AS) is
		do
			ctxt.put_text_item (ti_from_keyword)
			ctxt.set_separator (Void)
			ctxt.set_new_line_between_tokens
			if l_as.from_part /= Void then
				ctxt.indent
				ctxt.put_new_line
				l_as.from_part.process (Current)
				ctxt.put_new_line
				ctxt.exdent
			else
				ctxt.put_new_line
			end
			if l_as.invariant_part /= Void then
				ctxt.put_text_item (ti_invariant_keyword)
				ctxt.indent
				ctxt.put_new_line
				l_as.invariant_part.process (Current)
				ctxt.put_new_line
				ctxt.exdent
			end
			if l_as.variant_part /= Void then
				ctxt.put_text_item (ti_variant_keyword)
				ctxt.indent
				ctxt.put_new_line
				l_as.variant_part.process (Current)
				ctxt.put_new_line
				ctxt.exdent
			end
			ctxt.put_text_item (ti_until_keyword)
			ctxt.indent
			ctxt.put_new_line
			ctxt.new_expression
			ctxt.put_breakable
			l_as.stop.process (Current)
			ctxt.exdent
			ctxt.put_new_line
			ctxt.put_text_item (ti_loop_keyword)
			if l_as.compound /= Void then
				ctxt.indent
				ctxt.put_new_line
				l_as.compound.process (Current)
				ctxt.exdent
			end
			ctxt.put_new_line
			ctxt.put_text_item (ti_end_keyword)
		end

	process_retry_as (l_as: RETRY_AS) is
		do
			ctxt.put_breakable
			ctxt.put_text_item (ti_retry_keyword)
		end

	process_external_as (l_as: EXTERNAL_AS) is
		do
			ctxt.put_text_item (ti_external_keyword)
			ctxt.indent
			ctxt.put_new_line
			l_as.language_name.process (Current)
			ctxt.exdent
			ctxt.put_new_line
			if l_as.alias_name_id > 0 then
				ctxt.put_text_item (ti_alias_keyword)
				ctxt.indent
				ctxt.put_new_line
				ctxt.put_quoted_string_item (names_heap.item (l_as.alias_name_id))
				ctxt.put_new_line
				ctxt.exdent
			end
		end

	process_deferred_as (l_as: DEFERRED_AS) is
		do
			ctxt.put_text_item (ti_deferred_keyword)
			ctxt.put_new_line
		end

	process_do_as (l_as: DO_AS) is
		do
			ctxt.put_text_item (ti_do_keyword)
			ctxt.put_new_line
			if l_as.compound /= Void then
				ctxt.indent
				format_compound (l_as.compound)
				ctxt.put_new_line
				ctxt.exdent
			end
		end

	process_once_as (l_as: ONCE_AS) is
		do
			ctxt.put_text_item (ti_once_keyword)
			ctxt.put_new_line
			if l_as.compound /= Void then
				ctxt.indent
				format_compound (l_as.compound)
				ctxt.put_new_line
				ctxt.exdent
			end
		end

	process_type_dec_as (l_as: TYPE_DEC_AS) is
		local
			l_names_heap: like names_heap
		do
			ctxt.set_separator (ti_comma)
			ctxt.set_space_between_tokens
			from
				l_names_heap := names_heap
				l_as.id_list.start
			until
				l_as.id_list.after
			loop
				ctxt.put_text_item (create {LOCAL_TEXT}.make (l_names_heap.item (l_as.id_list.item)))
				l_as.id_list.forth
				if not l_as.id_list.after then
					ctxt.put_separator
				end
			end
			ctxt.put_text_item_without_tabs (ti_colon)
			ctxt.put_space
			l_as.type.process (Current)
		end

	process_class_as (l_as: CLASS_AS) is
		local
			l_creators: EIFFEL_LIST [CREATE_AS]
			l_create: CREATE_AS
			l_features: EIFFEL_LIST [FEATURE_NAME]
			l_feat: FEATURE_I
		do
			if is_simple_formatting then
				safe_process (l_as.top_indexes)
				if l_as.is_expanded then
					ctxt.put_text_item (ti_expanded_keyword)
					ctxt.put_space
				elseif l_as.is_separate then
					ctxt.put_text_item (ti_separate_keyword);
					ctxt.put_space
				elseif l_as.is_deferred then
					ctxt.put_text_item (ti_deferred_keyword);
					ctxt.put_space
				end
				ctxt.put_text_item (ti_class_keyword)
				ctxt.indent
				ctxt.put_new_line
				ctxt.put_class_name (l_as.class_name)
				ctxt.exdent
				format_generics (l_as.generics)
				ctxt.put_new_line
				if l_as.obsolete_message /= Void then
					ctxt.put_new_line
					ctxt.put_text_item (ti_obsolete_keyword)
					ctxt.put_space
					l_as.obsolete_message.process (Current)
					ctxt.put_new_line
				end
				if l_as.parents /= Void then
					ctxt.put_new_line
					ctxt.put_text_item (ti_inherit_keyword)
					ctxt.indent
					ctxt.put_new_line
					ctxt.set_new_line_between_tokens
					ctxt.set_separator (ti_semi_colon)
					l_as.parents.process (Current)
					ctxt.put_new_line
					ctxt.exdent
				end
				ctxt.put_new_line

				l_creators := l_as.creators
				if l_creators = Void and then ctxt.class_c.has_feature_table then
					l_feat := ctxt.class_c.default_create_feature
					if l_feat /= Void then
						create l_creators.make (1)
						create l_features.make (1)
						l_features.extend (create {FEAT_NAME_ID_AS}.initialize (
							create {ID_AS}.initialize (l_feat.feature_name)))
						create l_create.initialize (Void, l_features, Void)
						l_creators.extend (l_create)
					end
				end
				if l_creators /= Void then
					ctxt.set_separator (ti_empty)
					ctxt.set_new_line_between_tokens
					l_creators.process (Current)
					ctxt.put_new_line
				end

				format_convert_clause (l_as.convertors)
				if l_as.features /= Void then
					ctxt.set_new_line_between_tokens
					ctxt.set_separator (ti_empty)
					features_simple_format (l_as.features)
					ctxt.put_new_line
				end
				safe_process (l_as.invariant_part)
				safe_process (l_as.bottom_indexes)
				ctxt.put_text_item (ti_end_keyword)
				ctxt.put_new_line
			else
				ctxt.put_front_text_item (ti_before_class_declaration)
				ctxt.prepare_class_text
				ctxt.set_classes (ctxt.class_c, ctxt.class_c)
				safe_process (l_as.top_indexes)
				ctxt.set_classes (Void, Void)
				format_header (l_as)
				if ctxt.is_clickable_format and l_as.obsolete_message /= Void then
					ctxt.put_new_line
					ctxt.put_text_item (ti_before_obsolete)
					ctxt.put_text_item_without_tabs (ti_obsolete_keyword)
					ctxt.put_space
					l_as.obsolete_message.process (Current)
					ctxt.put_text_item_without_tabs (ti_after_obsolete)
					ctxt.put_new_line
				end
				if ctxt.is_clickable_format and l_as.parents /= Void then
					ctxt.put_new_line
					ctxt.put_text_item (ti_before_inheritance)
					ctxt.put_text_item_without_tabs (ti_inherit_keyword)
					ctxt.indent
					ctxt.put_new_line
					ctxt.set_new_line_between_tokens
					ctxt.set_separator (ti_new_line)
					ctxt.set_classes (ctxt.class_c, ctxt.class_c)
					l_as.parents.process (Current)
					ctxt.set_classes (Void, Void)
					ctxt.put_text_item (ti_after_inheritance)
					ctxt.put_new_line
					ctxt.exdent
				end
				ctxt.put_new_line

				l_creators := l_as.creators
				if l_creators = Void and then ctxt.class_c.has_feature_table then
					l_feat := ctxt.class_c.default_create_feature
					if l_feat /= Void then
						create l_creators.make (1)
						create l_features.make (1)
						l_features.extend (create {FEAT_NAME_ID_AS}.initialize (
							create {ID_AS}.initialize (l_feat.feature_name)))
						create l_create.initialize (Void, l_features, Void)
						l_creators.extend (l_create)
					end
				end
				if l_creators /= Void then
					ctxt.put_text_item (ti_before_creators)
					ctxt.continue_on_failure
					ctxt.set_separator (ti_empty)
					ctxt.set_new_line_between_tokens
					l_creators.process (Current)
					if not ctxt.last_was_printed then
						ctxt.put_text_item (ti_create_keyword)
						ctxt.put_new_line
					end
					ctxt.put_text_item (ti_after_creators)
					ctxt.put_new_line
					ctxt.set_last_was_printed (True)
				end
				format_convert_clause (l_as.convertors)
				ctxt.format_categories
				ctxt.format_invariants
				safe_process (l_as.bottom_indexes)
				ctxt.put_text_item (ti_before_class_end)
				ctxt.put_text_item (ti_end_keyword)
				ctxt.end_class_text
				ctxt.put_text_item (ti_after_class_end)
				ctxt.put_text_item (ti_after_class_declaration)
				ctxt.put_new_line
			end
		end

	process_parent_as (l_as: PARENT_AS) is
		local
			end_to_print: BOOLEAN
		do
			ctxt.set_classes (Void, ctxt.class_c)
			l_as.type.process (Current)
			if l_as.renaming /= Void then
				format_clause (ti_rename_keyword, l_as.renaming, True)
				end_to_print := True
			end
			if l_as.exports /= Void then
				format_clause (ti_export_keyword, l_as.exports, False)
				end_to_print := True
			end
			if l_as.undefining /= Void then
				format_clause (ti_undefine_keyword, l_as.undefining, True)
				end_to_print := True
			end
			if l_as.redefining /= Void then
				format_clause (ti_redefine_keyword, l_as.redefining, True)
				end_to_print := True
			end
			if l_as.selecting /= Void then
				format_clause (ti_select_keyword, l_as.selecting, True)
				end_to_print := True
			end
			if end_to_print then
				ctxt.indent
				ctxt.put_new_line
				ctxt.put_text_item (ti_end_keyword)
				ctxt.exdent
			end
		end

	process_like_id_as (l_as: LIKE_ID_AS) is
		do
			ctxt.put_text_item_without_tabs (ti_like_keyword)
			ctxt.put_space
			ctxt.prepare_for_feature (l_as.anchor, Void)
			ctxt.put_current_feature
		end

	process_like_cur_as (l_as: LIKE_CUR_AS) is
		do
			ctxt.put_text_item_without_tabs (ti_like_keyword)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_current)
		end

	process_formal_as (l_as: FORMAL_AS) is
		local
			l_a: LOCAL_FEAT_ADAPTATION
			new_type: TYPE_A
		do
			if is_simple_formatting then
				ctxt.put_text_item (create {GENERIC_TEXT}.make (ctxt.formal_name (l_as.position)))
			else
				l_a := ctxt.local_adapt
				if l_a /= Void then
					new_type := l_a.adapted_type (l_as)
				end
				if new_type = Void then
					ctxt.put_text_item (create {GENERIC_TEXT}.make (ctxt.formal_name (l_as.position)))
				else
					new_type.format (ctxt)
				end
			end
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS) is
		local
			s: STRING
			feature_name: FEAT_NAME_ID_AS
			l_a: LOCAL_FEAT_ADAPTATION
			new_type: TYPE_A
		do
			if not is_simple_formatting then
				l_a := ctxt.local_adapt
				if l_a /= Void then
					new_type := l_a.adapted_type (l_as)
				end
			end
			if new_type = Void then
				if l_as.is_reference then
					ctxt.put_text_item (ti_reference_keyword)
					ctxt.put_space
				elseif l_as.is_expanded then
					ctxt.put_text_item (ti_expanded_keyword);
					ctxt.put_space
				end
				s := l_as.name.as_upper
				if is_simple_formatting then
					ctxt.put_string (s)
				else
					ctxt.put_text_item (create {GENERIC_TEXT}.make (s))
				end
				if l_as.has_constraint then
					ctxt.put_space
					ctxt.put_text_item_without_tabs (ti_constraint)
					ctxt.put_space
					l_as.constraint.process (Current)
					if l_as.has_creation_constraint then
						from
							l_as.creation_feature_list.start
							ctxt.put_space
							ctxt.put_text_item (ti_create_keyword)
							ctxt.put_space
							feature_name ?= l_as.creation_feature_list.item
							ctxt.put_string (feature_name.feature_name)
							l_as.creation_feature_list.forth
						until
							l_as.creation_feature_list.after
						loop
							ctxt.put_text_item (ti_comma)
							ctxt.put_space
							feature_name ?= l_as.creation_feature_list.item
							ctxt.put_string (feature_name.feature_name)
							l_as.creation_feature_list.forth
						end
						ctxt.put_space
						ctxt.put_text_item (ti_end_keyword)
					end
				end
			else
				new_type.format (ctxt)
			end
		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		do
			if l_as.is_separate then
				ctxt.put_text_item_without_tabs (ti_separate_keyword)
				ctxt.put_space
			end
			if l_as.is_expanded then
				ctxt.put_text_item_without_tabs (ti_expanded_keyword)
				ctxt.put_space
			end
			ctxt.put_class_name (l_as.class_name)
			if l_as.generics /= Void then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_l_bracket)
				ctxt.set_space_between_tokens
				ctxt.set_separator (ti_comma)
				l_as.generics.process (Current)
				ctxt.put_text_item_without_tabs (ti_r_bracket)
			end
		end

	process_none_type_as (l_as: NONE_TYPE_AS) is
		do
			ctxt.put_class_name ("NONE")
		end

	process_bits_as (l_as: BITS_AS) is
		do
			if is_simple_formatting then
				ctxt.put_class_name (l_as.dump)
			else
				ctxt.put_classi (l_as.actual_type.associated_class.lace_class)
			end
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS) is
		do
			ctxt.put_class_name (l_as.dump)
		end

	process_rename_as (l_as: RENAME_AS) is
		do
			l_as.old_name.process (Current)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_as_keyword)
			ctxt.put_space
			l_as.new_name.process (Current)
		end

	process_invariant_as (l_as: INVARIANT_AS) is
		do
			if is_simple_formatting then
				ctxt.put_text_item (ti_invariant_keyword)
				ctxt.indent
				ctxt.put_new_line
				ctxt.set_new_line_between_tokens
				if l_as.assertion_list /= Void then
					invariant_simple_format_assertions (l_as.assertion_list)
					ctxt.put_new_line
					ctxt.put_new_line
				end
				ctxt.exdent
			else
				ctxt.continue_on_failure
				ctxt.set_new_line_between_tokens
				if l_as.assertion_list /= Void then
					invariant_format_assertions (l_as.assertion_list)
				end
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback
				end
			end
		end

	process_interval_as (l_as: INTERVAL_AS) is
		do
			l_as.lower.process (Current)
			if l_as.upper /= Void then
				ctxt.put_text_item_without_tabs (ti_dotdot)
				l_as.upper.process (Current)
			end
		end

	process_index_as (l_as: INDEX_AS) is
		do
			if l_as.tag /= Void then
				ctxt.put_text_item (create {INDEXING_TAG_TEXT}.make (l_as.tag.twin))
				ctxt.put_text_item_without_tabs (ti_colon)
				ctxt.put_space
			end
			ctxt.set_in_indexing_clause (True)
			ctxt.put_text_item (ti_before_indexing_content)
			ctxt.set_space_between_tokens
			ctxt.set_separator (ti_comma)
			l_as.index_list.process (Current)
			ctxt.put_text_item (ti_after_indexing_content)
			ctxt.set_in_indexing_clause (False)
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS) is
		do
			ctxt.set_separator (ti_comma)
			ctxt.set_space_between_tokens
			l_as.clients.process (Current)
			ctxt.put_space
			l_as.features.process (Current)
		end

	process_elseif_as (l_as: ELSIF_AS) is
		do
			ctxt.put_breakable
			ctxt.put_text_item (ti_elseif_keyword)
			ctxt.put_space
			ctxt.new_expression
			l_as.expr.process (Current)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_then_keyword)
			ctxt.put_new_line
			if l_as.compound /= Void then
				ctxt.indent
				format_compound (l_as.compound)
				ctxt.put_new_line
				ctxt.exdent
			end
		end

	process_create_as (l_as: CREATE_AS) is
		local
			last_was_printed: BOOLEAN
		do
			if is_simple_formatting then
				ctxt.put_text_item (ti_create_keyword)
				ctxt.put_space
				safe_process (l_as.clients)
				if l_as.feature_list /= Void then
					ctxt.indent
					ctxt.put_new_line
					ctxt.set_separator (ti_comma)
					ctxt.set_new_line_between_tokens
					l_as.feature_list.process (Current)
					ctxt.put_new_line
				end
			else
				ctxt.begin
				ctxt.put_text_item (ti_create_keyword)
				ctxt.put_space
				if l_as.clients = Void then
					last_was_printed := True
				else
					l_as.clients.process (Current)
					last_was_printed := ctxt.last_was_printed
				end
				if not last_was_printed then
					ctxt.rollback
				else
					if l_as.feature_list /= Void then
						ctxt.indent
						ctxt.put_new_line
						ctxt.set_new_line_between_tokens
						ctxt.set_classes (ctxt.class_c, ctxt.class_c)
						if ctxt.is_flat_short then
							format_creation_features (l_as.feature_list)
						else
							ctxt.set_separator (ti_comma)
							l_as.feature_list.process (Current)
							ctxt.put_new_line
						end
					end
					ctxt.commit
				end
			end
		end

	process_client_as (l_as: CLIENT_AS) is
		local
			temp: STRING
			cluster: CLUSTER_I
			client_classi: CLASS_I
			l_export_status: EXPORT_I
		do
			if is_simple_formatting then
				ctxt.put_text_item (ti_l_curly)
				ctxt.set_separator (ti_comma)
				ctxt.set_space_between_tokens
				from
					l_as.clients.start
				until
					l_as.clients.after
				loop
					l_as.clients.process (Current)
					l_as.clients.forth
					if not l_as.clients.after then
						ctxt.put_text_item_without_tabs (ti_comma)
						ctxt.put_space
					end
				end
				ctxt.put_text_item_without_tabs (ti_r_curly)
			else
				cluster := system.class_of_id (ctxt.class_c.class_id).cluster
				ctxt.begin
				ctxt.put_text_item (ti_l_curly)
				ctxt.set_separator (ti_comma)
				ctxt.set_space_between_tokens
				l_export_status := export_status_generator.export_status (ctxt.class_c, l_as)
				if ctxt.client = Void or else l_export_status.valid_for (ctxt.client) then
					from
						l_as.clients.start
					until
						l_as.clients.after
					loop
						temp := l_as.clients.item
						client_classi := universe.class_named (temp, cluster)
						if client_classi /= Void then
							ctxt.put_classi (client_classi)
						else
							ctxt.put_string (temp.as_upper)
						end
						l_as.clients.forth
						if not l_as.clients.after then
							ctxt.put_text_item_without_tabs (ti_comma)
							ctxt.put_space
						end
					end
					ctxt.put_text_item_without_tabs (ti_r_curly)
					ctxt.commit
				else
					ctxt.rollback
				end
			end
		end

	process_case_as (l_as: CASE_AS) is
		do
			ctxt.put_text_item (ti_when_keyword)
			ctxt.put_space
			ctxt.set_separator (ti_comma)
			ctxt.set_space_between_tokens
			l_as.interval.process (Current)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_then_keyword)
			ctxt.put_space
			ctxt.put_new_line
			if l_as.compound /= Void then
				ctxt.indent
				format_compound (l_as.compound)
				ctxt.put_new_line
				ctxt.exdent
			end
		end

	process_ensure_as (l_as: ENSURE_AS) is
		do
			format_assert_list_as (l_as, ti_ensure_keyword)
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS) is
		do
			format_assert_list_as (l_as, ti_ensure_then_keyword)
		end

	process_require_as (l_as: REQUIRE_AS) is
		do
			format_assert_list_as (l_as, ti_require_keyword)
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS) is
		do
			format_assert_list_as (l_as, ti_require_else_keyword)
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS) is
		do
			l_as.feature_name.process (Current)
			if l_as.is_creation_procedure then
				ctxt.put_space
				ctxt.put_text_item (ti_l_parenthesis)
			else
				ctxt.put_text_item (ti_colon)
				ctxt.put_space
			end
			ctxt.put_text_item (ti_l_curly)
			l_as.conversion_types.process (Current)
			ctxt.put_text_item (ti_r_curly)
			if l_as.is_creation_procedure then
				ctxt.put_text_item (ti_r_parenthesis)
			end
		end

	process_use_list_as (l_as: USE_LIST_AS) is
		do
			process_eiffel_list (l_as)
		end

	process_void_as (l_as: VOID_AS) is
		do
			ctxt.put_text_item (ti_void)
		end

	process_type_a (a_type: TYPE_A) is
		do
			a_type.append_to (ctxt.text)
		end

feature {NONE} -- Implementation: helpers

	append_format_multilined (s: STRING; indentable: BOOLEAN) is
			-- Format on a new line, breaking at every newline.
			-- Do not indent if `indentable' is false.
			-- If `in_index', try to find meaningful substrings (URLs, ...).
			-- Display %N... characters as they were typed.
			-- (export status {NONE})
		require
			string_not_void: s /= Void
			string_not_empty: not s.is_empty
			context_not_void: ctxt /= Void
		local
			st: STRUCTURED_TEXT
			in_index: BOOLEAN
			sb: STRING
			l: INTEGER
			n: INTEGER
			m: INTEGER
		do
			st := ctxt.text
			in_index := ctxt.in_indexing_clause
			if indentable then
				ctxt.indent
			end
			from
				l := s.count + 1
				n := 1
			until
				n > l
			loop
				m := s.index_of ('%N', n)
				if m = 0 then
					m := l
				end
				sb := s.substring (n, m - 1)
				if indentable then
					ctxt.put_string_item (sb)
				elseif in_index then
					st.add_indexing_string (sb)
				else
					st.add_manifest_string (sb)
				end
				ctxt.put_new_line
				n := m + 1
			end
			if indentable then
				ctxt.exdent
			end
		end

	adapt_main_feature is
			-- Adapt the main feature of a class to
			-- take into consideration the source and
			-- target class when reconsituting the text.
			--| An infix can turn into a prefix or normal feature,
			--| A prefix can turn into an infix or normal feature,
			--| A normal feature can turn into an infix or prefix.
		local
			adapt: LOCAL_FEAT_ADAPTATION
		do
			adapt := ctxt.local_adapt
			if adapt.is_infix then
				ctxt.put_text_item (ti_infix_keyword)
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_double_quote)
			elseif adapt.is_prefix then
				ctxt.put_text_item (ti_prefix_keyword);
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_double_quote)
			end
			ctxt.put_main_feature_name
			if not adapt.is_normal then
				ctxt.put_text_item_without_tabs (ti_double_quote)
			end
		end

	format_compound (lc: EIFFEL_LIST [INSTRUCTION_AS]) is
			-- Special formatting for compounds.
			-- A semicolon is needed at the end of a line when current line
			-- ends with a call with no arguments and the next line starts
			-- with an opening parenthesis. Example:
			--		do_nothing;
			--		(create {BOOLEAN_REF}).do_nothing
		require
			lc_not_void: lc /= Void
		local
			semicolon_candidate: BOOLEAN
		do
			ctxt.begin
			from
				lc.start
			until
				lc.after
			loop
				ctxt.new_expression
				ctxt.begin
				lc.item.process (Current)
				ctxt.commit
				semicolon_candidate := True
				lc.forth
				if not lc.after then
					if semicolon_candidate and then lc.item.starts_with_parenthesis then
						ctxt.put_text_item (ti_semi_colon)
					end
					ctxt.put_new_line
				end
			end
			ctxt.commit
		end

	carriage_return_char: CHARACTER is '%N'
			-- Character for newline

	format_header (l_as: CLASS_AS) is
			-- Format header, ie classname and generics.
		require
			l_as_not_void: l_as /= Void
		do
			ctxt.put_text_item (ti_before_class_header)
			if l_as.is_expanded then
				ctxt.put_text_item (ti_expanded_keyword)
				ctxt.put_space
			elseif l_as.is_deferred then
				ctxt.put_text_item (ti_deferred_keyword);
				ctxt.put_space
			end
			ctxt.put_text_item (ti_class_keyword)
			ctxt.put_space
			if ctxt.is_short then
				ctxt.put_text_item (ti_interface_keyword)
			end
			ctxt.indent
			ctxt.put_new_line
			ctxt.put_classi (ctxt.class_c.lace_class)
			ctxt.put_text_item (ti_after_class_header)
			ctxt.exdent
			format_generics (l_as.generics)
			ctxt.put_new_line
		end

	format_generics (l_as: EIFFEL_LIST [FORMAL_DEC_AS]) is
			-- Format formal generics.
		do
			if l_as /= Void then
				ctxt.put_space
				if is_simple_formatting then
					ctxt.put_text_item_without_tabs (ti_before_formal_generics)
				end
				ctxt.put_text_item_without_tabs (ti_l_bracket)
				ctxt.set_space_between_tokens
				ctxt.set_separator (ti_comma)
				l_as.process (Current)
				ctxt.put_text_item_without_tabs (ti_r_bracket)
				if is_simple_formatting then
					ctxt.put_text_item_without_tabs (ti_after_formal_generics)
				end
			end
		end

	format_convert_clause (l_as: EIFFEL_LIST [CONVERT_FEAT_AS]) is
			-- Format convert clause.
		do
			if l_as /= Void then
				ctxt.put_text_item (ti_convert_keyword)
				ctxt.indent
				ctxt.put_new_line
				ctxt.set_new_line_between_tokens
				ctxt.set_classes (ctxt.class_c, ctxt.class_c)
				ctxt.set_separator (ti_comma)
				l_as.process (Current)
				ctxt.set_separator (ti_empty)
				ctxt.exdent
				ctxt.put_new_line
				ctxt.put_new_line
			end
		end

	features_simple_format (l_as: EIFFEL_LIST [FEATURE_CLAUSE_AS]) is
			-- Reconstitute text.
		require
			l_as_not_void: l_as /= Void
		local
			i, l_count: INTEGER
			fc, next_fc: FEATURE_CLAUSE_AS
			feature_list: EIFFEL_LIST [FEATURE_AS]
			e_file: EIFFEL_FILE
		do
			e_file := ctxt.eiffel_file
			ctxt.begin
			from
				i := 1
				l_count := l_as.count
				if l_count > 0 then
					fc := l_as.i_th (1)
				end
			until
				i > l_count
			loop
				if i > 1 then
					ctxt.put_separator
				end
				ctxt.new_expression
				ctxt.begin
				i := i + 1
				if i > l_count then
					e_file.set_next_feature_clause (Void)
				else
					next_fc := l_as.i_th (i)
					e_file.set_next_feature_clause (next_fc)
				end
				e_file.set_current_feature_clause (fc)
				feature_list := fc.features
				if feature_list.is_empty then
					e_file.set_next_feature (Void)
				else
					e_file.set_next_feature (feature_list.i_th (1))
				end
				fc.process (Current)
				fc := next_fc
				ctxt.commit
			end
			ctxt.commit
		end

	format_clause (a_keyword: KEYWORD_TEXT; a_clause: EIFFEL_LIST [AST_EIFFEL]; has_separator: BOOLEAN) is
			-- Format one of rename, export, undefine, redefine or select clauses.
		require
			a_keyword_not_void: a_keyword /= Void
			a_clause_not_void: a_clause /= Void
		do
			ctxt.indent
			ctxt.put_new_line
			ctxt.put_text_item (a_keyword)
			ctxt.indent
			ctxt.put_new_line
			ctxt.set_new_line_between_tokens
			if has_separator then
				ctxt.set_separator (ti_comma)
			else
				ctxt.set_separator (ti_empty)
			end
			a_clause.process (Current)
			ctxt.exdent
			ctxt.exdent
		end

	format_tagged_as (l_as: TAGGED_AS; hide_breakable_marks: BOOLEAN) is
			-- Display `l_as' with breakpoints depending on `hide_breakable_marks'.
		require
			l_as_not_void: l_as /= Void
		do
			if is_simple_formatting then
				ctxt.put_breakable
				if l_as.tag /= Void then
					ctxt.put_text_item (create {ASSERTION_TAG_TEXT}.make (l_as.tag.twin))
					ctxt.put_text_item_without_tabs (ti_colon)
					ctxt.put_space
				end
				ctxt.new_expression
				l_as.expr.process (Current)
			else
				ctxt.new_expression
				ctxt.begin
				if not hide_breakable_marks then
					ctxt.put_breakable
				end
				if l_as.tag /= Void then
					ctxt.put_text_item (create {ASSERTION_TAG_TEXT}.make (l_as.tag.twin))
					ctxt.put_text_item_without_tabs (ti_colon)
					ctxt.put_space
				end
				ctxt.new_expression
				l_as.expr.process (Current)
				if ctxt.last_was_printed then
					ctxt.commit
				else
					ctxt.rollback
				end
			end
		end

	invariant_format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]) is
		require
			l_as_not_vod: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			from
				ctxt.begin
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				ctxt.begin
				if not_first then
					ctxt.put_separator
				end
				ctxt.new_expression
				l_as.i_th (i).process (Current)
				if ctxt.last_was_printed then
					not_first := True
					ctxt.commit
				else
					ctxt.rollback
				end
				i := i + 1
			end
			if not_first then
				ctxt.exdent
				ctxt.commit
			else
				ctxt.rollback
			end
		end

	invariant_simple_format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]) is
		require
			l_as_not_vod: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			ctxt.begin
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				if not_first then
					ctxt.put_separator
				end
				ctxt.new_expression
				l_as.i_th (i).process (Current)
				not_first := True
				i := i + 1
			end
			ctxt.commit
		end

	format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]; hide_breakable_marks: BOOLEAN) is
		require
			l_as_not_void: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			from
				ctxt.begin
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				if not_first then
					ctxt.put_separator
				end
				ctxt.begin
				ctxt.new_expression
				if hide_breakable_marks then
					format_tagged_as (l_as.i_th (i), True)
				else
					l_as.i_th (i).process (Current)
				end
				if ctxt.last_was_printed then
					not_first := True
					ctxt.commit
				else
					ctxt.rollback
				end
				i := i + 1
			end
			if not_first then
				ctxt.exdent
				ctxt.put_new_line
				ctxt.commit
			else
				ctxt.rollback
			end
		end

	simple_format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]) is
			-- Format assertions.
		require
			l_as_not_void: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			ctxt.begin
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				if not_first then
					ctxt.put_separator
				end
				ctxt.new_expression
				ctxt.begin
				l_as.i_th (i).process (Current)
				ctxt.commit
				not_first := True
				i := i + 1
			end
			if l_count > 0 then
				ctxt.put_new_line
			end
			ctxt.commit
		end

	format_assert_list_as (l_as: ASSERT_LIST_AS; a_keyword: KEYWORD_TEXT) is
			-- Process assertions `l_as' with keyword `keyword'.
		require
			l_as_not_void: l_as /= Void
			a_keyword_not_void: a_keyword /= Void
		local
			source_cl, target_cl: CLASS_C
		do
			if is_simple_formatting then
				if l_as.assertions /= Void then
					ctxt.put_text_item (a_keyword)
					ctxt.put_new_line
					ctxt.set_new_line_between_tokens
					ctxt.indent
					simple_format_assertions (l_as.assertions)
					ctxt.exdent
				end
			else
				if l_as.assertions /= Void then
					ctxt.begin
					ctxt.put_text_item (a_keyword)
					source_cl := ctxt.global_adapt.source_enclosing_class
					target_cl := ctxt.global_adapt.target_enclosing_class
					if source_cl /= target_cl then
						ctxt.put_space
						ctxt.put_text_item (ti_dashdash)
						ctxt.put_space
						ctxt.put_comment_text ("from ")
						ctxt.put_classi (source_cl.lace_class)
					end
					ctxt.indent
					ctxt.put_new_line
					ctxt.set_new_line_between_tokens
					ctxt.continue_on_failure
					format_assertions (l_as.assertions, False)
					ctxt.exdent
					if ctxt.last_was_printed then
						ctxt.set_first_assertion (False)
						ctxt.commit
					else
						ctxt.rollback
					end
				end
			end
		end

	format_creation_features (a_list: EIFFEL_LIST [FEATURE_NAME]) is
			-- Format the features in the creation clause,
			-- including header comment and contracts.
		require
			list_not_void: a_list /= Void
		local
			i, l_count: INTEGER
			item: FEATURE_NAME
			creators: HASH_TABLE [FEATURE_ADAPTER, STRING]
			feat_adapter: FEATURE_ADAPTER
		do
			ctxt.begin
			creators := ctxt.format_registration.creation_table
			from
				i := 1
				l_count := a_list.count
			until
				i > l_count
			loop
				item := a_list.i_th (i)
				feat_adapter := creators.item (item.internal_name)
				if feat_adapter /= Void then
					feat_adapter.format (ctxt)
				end
				i := i + 1
			end
			ctxt.commit
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

