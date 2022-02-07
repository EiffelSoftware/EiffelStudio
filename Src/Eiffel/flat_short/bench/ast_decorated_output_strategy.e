note
	description: "Process ast to decorated output text."

class
	AST_DECORATED_OUTPUT_STRATEGY

inherit
	AST_OUTPUT_STRATEGY
		rename
			text_formatter as text_formatter_decorator
		redefine
			text_formatter_decorator
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_AST_CONTEXT
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

	SHARED_SERVER
		export
			{NONE} all
		end

	SHARED_FORMAT_INFO
		export
			{NONE} all
		end

	SHARED_TYPES
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		export
			{NONE} all
		end

create
	make, make_for_inline_agent

feature {NONE} -- Initialization

	make (a_text_formatter: like text_formatter_decorator)
		require
			a_text_not_void: a_text_formatter /= Void
		do
			text_formatter_decorator := a_text_formatter
			create locals_for_current_feature.make (10)
			create object_test_locals_for_current_feature.make (0)
			create separate_argument_locals_for_current_scope.make (0)
			create error_message.make (5)
		end

	make_for_inline_agent (parent_strategy: AST_DECORATED_OUTPUT_STRATEGY; a_as: INLINE_AGENT_CREATION_AS)
		do
			make (parent_strategy.text_formatter_decorator)
			source_class := parent_strategy.source_class
			current_class := parent_strategy.current_class

			source_feature := source_class.eiffel_class_c.inline_agent_of_rout_id (a_as.inl_rout_id)
			current_feature := source_feature
		end

feature -- Formatting

	format (a_node: AST_EIFFEL)
		require
			a_node_not_void: a_node /= Void
		do
			a_node.process (Current)
		end

	format_indexing_with_no_keyword (l_as: INDEXING_CLAUSE_AS)
		require
			l_as_not_void: l_as /= Void
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.set_separator (Void)
			l_text_formatter_decorator.set_new_line_between_tokens
			process_eiffel_list (l_as)
		end

feature -- Element change

	set_text_formatter (a_text: like text_formatter_decorator)
		require
			a_text_not_void: a_text /= Void
		do
			text_formatter_decorator := a_text
		ensure
			text_is_not_void: text_formatter_decorator = a_text
		end

	set_source_feature (a_feature: like source_feature)
		do
			source_feature := a_feature
		ensure
			source_feature_set: source_feature = a_feature
		end

	set_current_feature (a_feature: like current_feature)
		do
			current_feature := a_feature
		end

	set_source_class (a_class: like source_class)
		do
			source_class := a_class
		end

	set_current_class (a_class: like current_class)
		do
			current_class := a_class
		end

	reset_last_class_and_type
		do
			last_type := Void
			last_class := Void
		end

	wipe_out_error
			-- Wipe out errors.
		do
			has_error_internal := False
			error_message.wipe_out
		ensure
			not_has_error: not has_error_internal
			error_message_is_empty: error_message.is_empty
		end

feature -- Access

	current_class: CLASS_C
			-- The class user viewing.

	source_class: CLASS_C
			-- Written class of current feature.
			-- or other part of `current_class' we are processing.

	source_feature, current_feature: FEATURE_I
			-- The feature being processed. `source_feature' is the feature from `source_class',
			-- whereas `current_feature' is the feature from `current_class'.

	last_parent: CLASS_C
			-- For rename clause, save the written class for old name.

	last_class: CLASS_C
			-- Class from `last_type'.

	last_type: TYPE_A
			-- Last type we explained.

	error_message: ARRAYED_LIST [STRING]
			-- Error message.

	has_error: BOOLEAN
			-- Did an error happen?
		do
			Result := not error_message.is_empty
		end

feature {AST_DECORATED_OUTPUT_STRATEGY} -- Access

	text_formatter_decorator: TEXT_FORMATTER_DECORATOR

	last_actual_local_type: TYPE_A

	locals_for_current_feature: HASH_TABLE [TYPE_A, STRING_32]
	object_test_locals_for_current_feature: HASH_TABLE [TYPE_A, STRING_32]
	separate_argument_locals_for_current_scope: HASH_TABLE [TYPE_A, STRING_32]

	renamed_feature: E_FEATURE
			-- Saved renamed feature for formal declaration renaming.

	processing_locals: BOOLEAN;

	processing_creation_target: BOOLEAN

	processing_parents: BOOLEAN
			-- rename, redefine clause etc.

	processing_none_feature_part: BOOLEAN

	processing_formal_dec: BOOLEAN
			-- Processing formal declaration?

	has_error_internal: BOOLEAN
			-- If error when processing.
			-- For the case we only have old AST,
			-- `last_type' cannot be evaluated correctly.
			-- If `has_error', we give up type evaluating and send
			-- simple text to output.

feature {AST_DECORATED_OUTPUT_STRATEGY} -- Error handling

	set_error_message (a_str: STRING)
			-- Setup `error_message'.
		require
			a_str_not_void: a_str /= Void
		do
			error_message.extend (a_str)
		ensure
			error_message_extended: error_message.has (a_str)
		end

feature -- Roundtrip

	process_none_id_as (l_as: NONE_ID_AS)
		do
			process_id_as (l_as)
		end

	process_typed_char_as (l_as: TYPED_CHAR_AS)
		do
			process_char_as (l_as)
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS)
		do
			process_routine_creation_as (l_as)
		end

	process_inline_agent_creation_as (l_as: INLINE_AGENT_CREATION_AS)
		local
			l_strategy: AST_DECORATED_OUTPUT_STRATEGY
			l_old_feature_comments: EIFFEL_COMMENTS
			l_old_arguments: AST_EIFFEL
			l_old_target_feature: FEATURE_I
			l_old_source_feature: FEATURE_I
			l_old_e_feature: E_FEATURE
			l_old_breakpoint_index: INTEGER
			l_feat: FEATURE_I
			l_leaf_list: LEAF_AS_LIST
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				if l_as.inl_rout_id > 0 then
					l_text_formatter_decorator.process_keyword_text (ti_agent_keyword, Void)

					create l_strategy.make_for_inline_agent (Current, l_as)

					l_old_feature_comments := l_text_formatter_decorator.feature_comments
					l_old_arguments := l_text_formatter_decorator.arguments
					l_old_target_feature := l_text_formatter_decorator.target_feature
					l_old_source_feature := l_text_formatter_decorator.source_feature
					l_old_e_feature := l_text_formatter_decorator.e_feature
					l_old_breakpoint_index := l_text_formatter_decorator.breakpoint_index

					l_feat := l_strategy.current_feature

					l_text_formatter_decorator.restore_attributes ( Void, l_as.body.arguments, l_feat,
																  l_strategy.source_feature, l_strategy, 0,
																  l_feat.api_feature (l_feat.written_in))

					l_as.body.process (l_strategy)

					l_text_formatter_decorator.restore_attributes ( l_old_feature_comments, l_old_arguments,
																  l_old_target_feature, l_old_source_feature, Current,
																  l_old_breakpoint_index, l_old_e_feature)

					if l_as.operands /= Void then
						reset_last_class_and_type
						l_text_formatter_decorator.process_symbol_text (ti_space)
						l_text_formatter_decorator.begin
						l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
						l_text_formatter_decorator.set_separator (ti_comma)
						l_text_formatter_decorator.set_space_between_tokens
						l_as.operands.process (Current)
						l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
						l_text_formatter_decorator.commit
					end
					last_type := expr_type (l_as)
				else
					has_error_internal := True
					l_leaf_list	:= match_list_server.item (current_class.class_id)
					if l_leaf_list /= Void and then l_as.is_text_available (l_leaf_list) then
						l_text_formatter_decorator.add (l_as.text_32 (l_leaf_list))
					else
						l_text_formatter_decorator.add ("unable_to_show_inline_agent")
					end
				end
			else
				if not has_error_internal then
					last_type := agent_type (l_as)
				end
			end
		end

feature -- Roundtrip: no processing

	process_keyword_as (l_as: KEYWORD_AS)
		do
		end

	process_symbol_as (l_as: SYMBOL_AS)
		do
		end

	process_break_as (l_as: BREAK_AS)
		do
		end

	process_leaf_stub_as (l_as: LEAF_STUB_AS)
		do
		end

	process_symbol_stub_as (l_as: SYMBOL_STUB_AS)
		do
		end

	process_keyword_stub_as (l_as: KEYWORD_STUB_AS)
			-- Process `l_as'.
		do
		end

feature {NONE} -- Implementation

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS)
		do
			l_as.creation_expr.process (Current)
		end

	process_id_as (l_as: ID_AS)
		do
			if is_local_id then
				text_formatter_decorator.process_local_text (l_as, l_as.name_32)
			else
				text_formatter_decorator.process_basic_text (l_as.name_32)
			end
		end

	process_integer_as (l_as: INTEGER_CONSTANT)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if l_as.constant_type /= Void then
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_l_curly)
				end
				l_as.constant_type.process (Current)
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_r_curly)
					l_text_formatter_decorator.put_space
				end
			end
			if not expr_type_visiting then
				l_text_formatter_decorator.process_number_text (l_as.string_value_32)
			end
			last_type := l_as.manifest_type
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS)
		local
			l_feat: E_FEATURE
			l_rout_ids: ID_SET
			l_type: TYPE_A
			l_static_type: TYPE_A
			l_actual_argument_typs: like expr_types
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				l_text_formatter_decorator.begin
				l_text_formatter_decorator.process_symbol_text (ti_l_curly)
			end
			l_as.class_type.process (Current)
			l_static_type := last_type
			if not expr_type_visiting then
				l_text_formatter_decorator.process_symbol_text (ti_r_curly)
			end
			l_rout_ids := l_as.routine_ids
			if not has_error_internal and l_as.class_id /= 0 and l_rout_ids /= Void then
				l_feat := feature_in_class (system.class_of_id (l_as.class_id), l_rout_ids)
			else
				has_error_internal := True
			end
			if not expr_type_visiting then
				l_text_formatter_decorator.process_symbol_text (ti_dot)
				if not has_error_internal then
					l_text_formatter_decorator.process_feature_text (l_as.feature_name.name_32, l_feat, False)
				else
					l_text_formatter_decorator.process_basic_text (l_as.feature_name.name_32)
				end
			end
			if l_as.parameter_count > 0 then
				if not expr_type_visiting then
					l_text_formatter_decorator.put_space
					l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
					l_text_formatter_decorator.set_separator (ti_comma)
					l_text_formatter_decorator.set_space_between_tokens
				end
				l_as.internal_parameters.process (Current)
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
				end
			end
			if not expr_type_visiting then
				l_text_formatter_decorator.commit
			end
			if not has_error_internal then
				if l_feat.is_procedure then
					reset_last_class_and_type
				else
					l_type := l_feat.type
							-- If it has an like argument type, we solve the type from the arguments.
					if l_type.has_like_argument then
						check
							parameters_not_void: l_as.parameters /= Void
						end
						l_actual_argument_typs := expr_types (l_as.parameters)
						if l_actual_argument_typs /= Void then
							l_type := l_type.actual_argument_type (l_actual_argument_typs)
						end
						if l_type = Void then
							l_type := l_feat.type
						end
					end
					l_type := l_type.actual_type
						-- FIXME: check why `last_class` can be Void [2018-08-16].
					if l_type.is_loose and attached last_class as l_last_class then
						last_type := l_type.instantiation_in (l_static_type, l_last_class.class_id)
					else
						last_type := l_type
					end
				end
			end

		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
		local
			comments: EIFFEL_COMMENTS
			i, l_count: INTEGER
			f: EIFFEL_LIST [FEATURE_AS]
			next_feat, feat: FEATURE_AS
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.process_symbol_text (ti_feature_keyword)
			l_text_formatter_decorator.put_space
			if l_as.clients /= Void then
				l_text_formatter_decorator.set_separator (ti_comma)
				l_text_formatter_decorator.set_space_between_tokens
				l_as.clients.process (Current)
			end
			comments := l_as.comment (l_text_formatter_decorator.match_list)
			if comments = Void then
				l_text_formatter_decorator.put_new_line
			else
				if comments.count > 1 then
					l_text_formatter_decorator.indent
					l_text_formatter_decorator.indent
					l_text_formatter_decorator.put_new_line
					l_text_formatter_decorator.put_comments (comments)
					l_text_formatter_decorator.exdent
					l_text_formatter_decorator.exdent
				else
					l_text_formatter_decorator.put_space
					l_text_formatter_decorator.put_comments (comments)
				end
			end
			l_text_formatter_decorator.put_new_line
			l_text_formatter_decorator.indent
			l_text_formatter_decorator.put_new_line
			l_text_formatter_decorator.set_new_line_between_tokens
			l_text_formatter_decorator.set_separator (ti_empty)
			f := l_as.features
			l_text_formatter_decorator.begin
			from
				i := 1
				l_count := f.count
				if l_count > 0 then
					feat := f.i_th (1)
				end
			until
				i > l_count
			loop
				l_text_formatter_decorator.new_expression
				if i > 1 then
					l_text_formatter_decorator.put_separator
				end
				l_text_formatter_decorator.new_expression
				l_text_formatter_decorator.begin
				i := i + 1
				feat.process (Current)
				feat := next_feat
				l_text_formatter_decorator.commit
			end
			l_text_formatter_decorator.commit
			l_text_formatter_decorator.exdent
		end

	process_unique_as (l_as: UNIQUE_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_keyword_text (ti_unique_keyword, Void)
			end
		end

	process_tuple_as (l_as: TUPLE_AS)
		local
			l_tuple_type: TUPLE_TYPE_A
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				l_text_formatter_decorator.process_symbol_text (ti_l_bracket)
				l_text_formatter_decorator.set_separator (ti_comma)
				l_text_formatter_decorator.set_space_between_tokens
			end
			l_as.expressions.process (Current)
			if not expr_type_visiting then
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_r_bracket)
			end
			if not has_error_internal then
				create l_tuple_type.make (system.tuple_id, expr_types (l_as.expressions))
				l_tuple_type.set_frozen_mark
				last_type := l_tuple_type
			end
		end

	process_real_as (l_as: REAL_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				if l_as.constant_type /= Void then
					l_text_formatter_decorator.process_symbol_text (ti_l_curly)
					l_as.constant_type.process (Current)
					l_text_formatter_decorator.process_symbol_text (ti_r_curly)
					l_text_formatter_decorator.put_space
				end
				l_text_formatter_decorator.process_number_text (l_as.value)
			end

			if l_as.constant_type = Void then
				last_type := manifest_real_64_type
			elseif expr_type_visiting then
				l_as.constant_type.process (Current)
				if attached {REAL_A} last_type as l_real then
					last_type :=  if l_real.size = 32 then manifest_real_32_type else manifest_real_64_type end
				end
			else
				-- Nothing to be done, done above when process `l_as.constant_type'.
			end
		end

	process_bool_as (l_as: BOOL_AS)
		do
			if not expr_type_visiting then
				if l_as.value then
					text_formatter_decorator.process_keyword_text (ti_true_keyword, Void)
				else
					text_formatter_decorator.process_keyword_text (ti_false_keyword, Void)
				end
			end
			last_type := Boolean_type
		end

	process_array_as (l_as: COMPILER_ARRAY_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			reset_last_class_and_type
			if not expr_type_visiting then
				if attached l_as.type as t then
					t.process (Current)
					l_text_formatter_decorator.put_space
				end
				l_text_formatter_decorator.process_symbol_text (ti_l_array)
			end
			if not l_as.expressions.is_empty then
				if not expr_type_visiting then
					l_text_formatter_decorator.set_separator (ti_comma)
					l_text_formatter_decorator.set_space_between_tokens
				end
				l_as.expressions.process (Current)
			end
			if not expr_type_visiting then
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_r_array)
			end
			last_type := l_as.array_type
		end

	process_char_as (l_as: CHAR_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if attached l_as.type as l_type then
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_l_curly)
				end
				l_type.process (Current)
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_r_curly)
					l_text_formatter_decorator.put_space
				end
			else
				last_type := character_type
			end
			if not expr_type_visiting then
				l_text_formatter_decorator.process_character_text (l_as.string_value_32)
			end
		end

	process_string_as (l_as: STRING_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting and then l_as.is_once_string then
				l_text_formatter_decorator.process_keyword_text (ti_once_keyword, Void)
				l_text_formatter_decorator.put_space
			end

			if attached l_as.type as l_type then
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_l_curly)
				end
				l_type.process (Current)
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_r_curly)
					l_text_formatter_decorator.put_space
				end
			else
				last_type := string_type
			end

			if not expr_type_visiting then
				l_text_formatter_decorator.put_string_item_with_as (l_as.string_value_32, l_as)
			end
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting and then l_as.is_once_string then
				l_text_formatter_decorator.process_keyword_text (ti_once_keyword, Void)
				l_text_formatter_decorator.put_space
			end

			if attached l_as.type as l_type then
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_l_curly)
				end
				l_type.process (Current)
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_r_curly)
				end
			else
				last_type := string_type
			end

			if not expr_type_visiting then
				l_text_formatter_decorator.put_string_item ("%"" + l_as.verbatim_marker)
				if l_as.is_indentable then
					l_text_formatter_decorator.put_string_item ("[")
				else
					l_text_formatter_decorator.put_string_item ("{")
				end
				l_text_formatter_decorator.put_new_line
				if attached l_as.value_32 as l_value and then not l_value.is_empty then
					append_format_multilined (l_value, l_as.is_indentable)
				end
				if l_as.is_indentable then
					l_text_formatter_decorator.put_string_item ("]")
				else
					l_text_formatter_decorator.put_string_item ("}")
				end
				l_text_formatter_decorator.process_string_text (l_as.verbatim_marker + "%"", Void)
			end
		end

	process_body_as (l_as: BODY_AS)
		local
			l_feat: E_FEATURE
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if l_as.arguments /= Void and then not l_as.arguments.is_empty then
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
				l_text_formatter_decorator.set_separator (ti_semi_colon)
				l_text_formatter_decorator.set_space_between_tokens
				l_as.arguments.process (Current)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
			end
			if l_as.type /= Void then
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_colon)
				l_text_formatter_decorator.put_space
				l_as.type.process (Current)
			end
			l_text_formatter_decorator.set_separator (ti_empty)
			if l_as.assigner /= Void then
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_keyword_text (ti_assign_keyword, Void)
				l_text_formatter_decorator.put_space
				if not has_error_internal then
					l_feat := current_assigner_feature
				end
				if not has_error_internal then
					l_feat.append_name (l_text_formatter_decorator)
				else
					l_text_formatter_decorator.process_basic_text (l_as.assigner.name_8)
				end
			end
			safe_process (l_as.content)
		end

	process_built_in_as (l_as: BUILT_IN_AS)
			-- Process `l_as'.
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if l_as.body = Void then
				process_external_as (l_as)
			else
				if attached {ROUTINE_AS} l_as.body.body.content as l_routine then
					if l_routine.locals /= Void then
						l_text_formatter_decorator.process_keyword_text (ti_local_keyword, Void)
						l_text_formatter_decorator.put_new_line
						if l_routine.locals.count > 0 then
							l_text_formatter_decorator.indent
							l_text_formatter_decorator.set_separator (Void)
							l_text_formatter_decorator.set_new_line_between_tokens
							processing_locals := True
							l_routine.locals.process (Current)
							processing_locals := False
							l_text_formatter_decorator.put_new_line
							l_text_formatter_decorator.exdent
						end
					end
					safe_process (l_routine.routine_body)
					if l_routine.rescue_clause /= Void then
						l_text_formatter_decorator.process_keyword_text (ti_rescue_keyword, Void)
						l_text_formatter_decorator.indent
						l_text_formatter_decorator.put_new_line
						l_text_formatter_decorator.set_separator (Void)
						l_text_formatter_decorator.set_new_line_between_tokens
						if not l_routine.rescue_clause.is_empty then
							format_compound (l_routine.rescue_clause)
							l_text_formatter_decorator.put_new_line
						end
						l_text_formatter_decorator.exdent
					end
				end
			end
		end

	process_result_as (l_as: RESULT_AS)
		local
			l_feat: E_FEATURE
		do
			if not expr_type_visiting then
				text_formatter_decorator.process_keyword_text (ti_result, Void)
			end
			if not has_error_internal then
				l_feat := feature_in_class (current_class, current_feature.rout_id_set)
				if not has_error_internal then
					if not processing_creation_target or else last_type = Void then
						last_type := l_feat.type
					end
					check
						last_type_not_void: last_type /= Void
					end
				end
			end
		end

	process_current_as (l_as: CURRENT_AS)
		do
			if not expr_type_visiting then
				text_formatter_decorator.process_keyword_text (ti_current, Void)
			end
			last_type := current_class.actual_type
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS)
		local
			l_feat: E_FEATURE
			l_feat_result: like feature_from_type_set
			l_rout_id_set: ID_SET
			l_last_class: like last_class
			l_last_type: like last_type
			l_last_type_set: TYPE_SET_A
			l_is_multiconstraint_formal: BOOLEAN
			l_type: TYPE_A
			l_actual_argument_typs: like expr_types
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if l_as.is_argument then
				if not expr_type_visiting then
					format_local_with_as (create {ID_AS}.initialize_from_id (current_feature.arguments.item_id (l_as.argument_position)))
				end
			elseif l_as.is_local or l_as.is_inline_local then
				if not expr_type_visiting then
					format_local_with_as (l_as.feature_name)
				end
			elseif l_as.is_tuple_access then
				if not expr_type_visiting then
						-- Named tuple is neither a local nor an argument, we simply use local style.
					l_text_formatter_decorator.process_symbol_text (ti_dot)
					l_text_formatter_decorator.process_local_text (l_as, l_as.access_name_32)
				end
			else
				if not has_error_internal then
					if last_type /= Void then
						last_type := last_type.actual_type
						if attached {FORMAL_A} last_type as l_formal then
							if l_formal.is_multi_constrained (current_class) then
								l_is_multiconstraint_formal := True
								l_last_type_set := last_type.to_type_set.constraining_types (current_class)
								check multi_constraint_implies_existence_of_type_set: l_is_multiconstraint_formal implies l_last_type_set /= Void end
							else
								last_type := l_formal.constrained_type (current_class)
								check not_formal: not last_type.is_formal end
							end
						end
						if last_type.is_none or l_is_multiconstraint_formal then
							last_class := Void
						else
							check not last_type.is_formal end
							last_class := last_type.base_class
						end
					end
					l_rout_id_set := l_as.routine_ids
					if l_rout_id_set /= Void then
						if processing_creation_target then
								-- We are processing something like: create l.make
							if l_is_multiconstraint_formal then
								l_feat_result := feature_from_type_set (l_last_type_set, l_rout_id_set)
								if l_feat_result /= Void and then not l_feat_result.is_empty then
										-- `l_feat_result' may be Void due to an incomplete compilation.
										-- FIXME: We still can have more than feature.
										-- See wiki topic multi constraints and flat view for more information.
									l_feat := l_feat_result.first.feature_item
									last_class := l_feat_result.first.class_type.base_class
									if l_feat_result.count > 1 then
										set_error_message ("Multi constraint formal: More than one feature available for feature with routine id: " + l_rout_id_set.first.out)
									end
								else
									l_feat := Void
									last_class := current_class
								end
							else
									-- When processing creation target, `last_class' should always be `current_class'.
								l_feat := feature_in_class (current_class, l_rout_id_set)
								last_class := current_class
							end
						else
							if last_type /= Void then
									-- We are already in a nested call like: xyz.a.f.*
									-- So `last_type', last_class are the ones from "a" and
									-- `l_rout_id_set' is the one of f
								if last_type.is_none and then l_as.class_id /= 0 then
										-- The target has been redefined as {NONE}.
										-- We use the written class gotten from `l_as.class_id'.
										-- Class ID may be zero if an incomplete compilation has occurred.
										-- Protection prevents infinitely looping and memory usage (see bug#13300)
									last_class := system.class_of_id (l_as.class_id)
								end
								if last_class /= Void then
									l_feat := feature_in_class (last_class, l_rout_id_set)
								else
										-- last_class is void: it could be a multi constrained formal
									if l_is_multiconstraint_formal then
										l_feat_result := feature_from_type_set (l_last_type_set, l_rout_id_set)
										if l_feat_result /= Void and then not l_feat_result.is_empty then
												-- May be Void due to an incomplete compilation.
											l_feat := l_feat_result.first.feature_item
											last_type := l_feat_result.first.class_type.type
											last_class := last_type.base_class
											if l_feat_result.count > 1 then
												set_error_message ("Multi constraint formal: More than one feature available for feature with routine id: " + l_rout_id_set.first.out)
											end
										else
											last_class := current_class
										end
									else
										last_class := current_class
									end
								end
							else
									-- We are at the beginning of a nested call: a.f.*
									-- `l_rout_id_set' is the one of "a"
								l_feat := feature_in_class (current_class, l_rout_id_set)
								last_type := current_class.actual_type
								last_class := current_class
							end
						end
						check last_class_not_void: last_class /= Void end
					end
				end
				if not expr_type_visiting then
					if l_feat /= Void then
							-- This includes the case where a qualified call on a feature which was renamed into an alias).
						if l_as.is_qualified or l_text_formatter_decorator.dot_needed then
							l_text_formatter_decorator.process_symbol_text (ti_dot)
						end
						if not has_error_internal then
							l_feat.append_name (l_text_formatter_decorator)
						else
							l_text_formatter_decorator.process_basic_text (l_as.access_name_32)
						end
					else
						if l_as.is_qualified or l_text_formatter_decorator.dot_needed then
							l_text_formatter_decorator.process_symbol_text (ti_dot)
						end
						l_text_formatter_decorator.process_local_text (l_as, l_as.access_name_32)
					end
				end
			end
			if l_as.parameter_count > 0 and not expr_type_visiting then
				l_last_type := last_type
				l_last_class := last_class
				reset_last_class_and_type
				l_text_formatter_decorator.process_symbol_text (ti_space)
				l_text_formatter_decorator.begin
				l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
				l_text_formatter_decorator.set_separator (ti_comma)
				l_text_formatter_decorator.set_space_between_tokens
				l_as.internal_parameters.process (Current)
				l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
				l_text_formatter_decorator.commit
				last_type := l_last_type
				last_class := l_last_class
			end
			if l_as.is_argument then
				last_type := current_feature.arguments.i_th (l_as.argument_position)
			elseif l_as.is_local then
				if last_type = Void and then locals_for_current_feature.has_key (l_as.access_name_32) then
					last_type := locals_for_current_feature.found_item
				end
			elseif l_as.is_inline_local then
				if object_test_locals_for_current_feature.has_key (l_as.access_name_32) then
					last_type := object_test_locals_for_current_feature.found_item
				elseif attached separate_argument_locals_for_current_scope.item (l_as.access_name_32) as l_separate_type then
					last_type := l_separate_type
				end
			elseif l_as.is_tuple_access then
				if not has_error_internal then
					if attached {TUPLE_TYPE_A} last_type.actual_type as l_tuple_type then
						last_type := l_tuple_type.generics.i_th (l_as.label_position)
					else
						check compiler_bug: False end
					end
				else
					last_type := Void
				end
			else
				if l_feat /= Void then
					if l_feat.is_procedure then
						reset_last_class_and_type
					else
						if processing_creation_target then
							if last_type = Void then
								l_type := l_feat.type.actual_type
							else
									-- A static type in creation as.
								l_type := last_type
							end
							last_type := current_class.actual_type
						else
							l_type := l_feat.type
									-- If it has a like argument type, we solve the type from the arguments.
							if l_type.has_like_argument then
								check
									parameters_not_void: l_as.parameters /= Void
								end
								l_actual_argument_typs := expr_types (l_as.parameters)
								if l_actual_argument_typs /= Void then
									l_type := l_type.actual_argument_type (l_actual_argument_typs)
								end
								if l_type = Void then
									l_type := l_feat.type
								end
							end
							l_type := l_type.actual_type
						end
						if l_type.is_loose then
							last_type := l_type.instantiation_in (last_type, last_class.class_id)
						else
							last_type := l_type
						end
					end
				else
					last_type := Void
				end
			end
		end

	process_access_inv_as (l_as: ACCESS_INV_AS)
		do
			process_access_feat_as (l_as)
		end

	process_access_id_as (l_as: ACCESS_ID_AS)
		do
			process_access_feat_as (l_as)
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS)
		do
			process_access_feat_as (l_as)
		end

	process_precursor_as (l_as: PRECURSOR_AS)
		local
			real_feature: E_FEATURE
			l_parent_class: CLASS_C
			l_parent_class_i: CLASS_I
			l_current_feature: E_FEATURE
			l_type: TYPE_A
			l_actual_argument_typs: like expr_types
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				l_text_formatter_decorator.begin
			end
			check
				current_feature.rout_id_set /= Void
			end
			l_current_feature := feature_in_class (current_class, current_feature.rout_id_set)
			if not has_error_internal then
				if l_as.parent_base_class /= Void then
					l_parent_class_i := universe.safe_class_named (l_as.parent_base_class.class_name.name_8, current_class.group)
					if l_parent_class_i /= Void then
						l_parent_class := l_parent_class_i.compiled_class
					else
						if not has_error_internal then
							has_error_internal := True
							set_error_message ("Precursor class locating failed.")
						end
					end
				elseif l_current_feature.precursors /= Void then
					l_parent_class := l_current_feature.precursors.last
				end
				if l_parent_class /= Void then
					real_feature := l_current_feature.ancestor_version (l_parent_class)
				end
			end
			if not expr_type_visiting then
				if real_feature /= Void then
					l_text_formatter_decorator.process_keyword_text (ti_precursor_keyword, real_feature)
				else
					l_text_formatter_decorator.process_keyword_text (ti_precursor_keyword, Void)
				end
				if l_as.parent_base_class /= Void then
					l_text_formatter_decorator.put_space
					l_text_formatter_decorator.process_symbol_text (ti_l_curly)
					if not has_error_internal then
						l_text_formatter_decorator.add_class (l_parent_class.lace_class)
					else
						l_text_formatter_decorator.process_basic_text (l_as.parent_base_class.class_name.name_32)
					end
					l_text_formatter_decorator.process_symbol_text (ti_r_curly)
				end
				if l_as.parameter_count > 0 then
					l_text_formatter_decorator.process_symbol_text (ti_space)
					l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
					l_text_formatter_decorator.set_separator (ti_comma)
					l_text_formatter_decorator.set_space_between_tokens
					l_as.internal_parameters.process (Current)
					l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
				end
			end
			if real_feature /= Void then
				l_type := real_feature.type
			else
					-- Could not find an ancestor version, most likely code where Precursor appears
					-- has been replicated. We simply use the `current_feature' type as best approximation.
					-- This should not happen when replication is properly implemented in compiler.
				l_type := current_feature.type
			end
			if l_type /= Void then
						-- If it has an like argument type, we solve the type from the arguments.
				if l_type.has_like_argument then
					check
						parameters_not_void: l_as.parameters /= Void
					end
					l_actual_argument_typs := expr_types (l_as.parameters)
					if l_actual_argument_typs /= Void then
						l_type := l_type.actual_argument_type (l_actual_argument_typs)
					end
				end
				if l_type /= Void then
					last_type := l_type.actual_type
				else
					last_type := Void
				end
			else
				last_type := Void
			end

			if not expr_type_visiting then
				l_text_formatter_decorator.commit
			end
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				l_text_formatter_decorator.begin
			end
			l_as.target.process (Current)
			if not expr_type_visiting then
				l_text_formatter_decorator.need_dot
			end
			l_as.message.process (Current)
			if not expr_type_visiting then
				l_text_formatter_decorator.commit
			end
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS)
		local
			l_type: TYPE_A
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				l_text_formatter_decorator.process_keyword_text (ti_create_keyword, Void)
				l_text_formatter_decorator.process_symbol_text (ti_space)
				if not l_as.is_active then
					l_text_formatter_decorator.process_symbol_text (ti_less_than)
					l_text_formatter_decorator.process_basic_text (ti_none_class)
					l_text_formatter_decorator.process_symbol_text (ti_greater_than)
					l_text_formatter_decorator.put_space
				end
				l_text_formatter_decorator.process_symbol_text (ti_l_curly)
			end
			l_as.type.process (Current)
			l_type := last_type
			if not expr_type_visiting then
				l_text_formatter_decorator.process_symbol_text (ti_r_curly)
			end
			if l_as.call /= Void then
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_dot)
				end
				l_as.call.process (Current)
			end
			last_type := l_type
		end

	process_type_expr_as (l_as: TYPE_EXPR_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
			l_generics: ARRAYED_LIST [TYPE_A]
			l_type: GEN_TYPE_A
		do
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.process_symbol_text (ti_l_curly)
				l_as.type.process (Current)
				l_text_formatter_decorator.process_symbol_text (ti_r_curly)
			else
				l_as.type.process (Current)
			end
			create l_generics.make (1)
			l_generics.extend (last_type)
			create l_type.make (system.type_class.compiled_class.class_id, l_generics)
				-- Type of a manifest type is frozen.			
			l_type.set_frozen_mark
			last_type := l_type
		end

	process_routine_as (l_as: ROUTINE_AS)
		local
			comments: EIFFEL_COMMENTS
			l_indexing_clause: INDEXING_CLAUSE_AS
			l_has_option_note: BOOLEAN
			chained_assert: CHAINED_ASSERTIONS
			is_inline_agent: BOOLEAN
			inline_agent_assertion: ROUTINE_ASSERTIONS
			l_text_formatter_decorator: like text_formatter_decorator
			is_next_option: BOOLEAN
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator := text_formatter_decorator

			is_inline_agent := current_feature.is_inline_agent

			locals_for_current_feature.wipe_out
			object_test_locals_for_current_feature.wipe_out
			separate_argument_locals_for_current_scope.wipe_out
			l_text_formatter_decorator.put_new_line
			if not l_text_formatter_decorator.is_feature_short and then l_as.obsolete_message /= Void then
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.process_keyword_text (ti_obsolete_keyword, Void)
				l_text_formatter_decorator.put_space
				l_as.obsolete_message.process (Current)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
			l_text_formatter_decorator.indent

			if not is_inline_agent then
				l_text_formatter_decorator.indent
				comments := l_text_formatter_decorator.feature_comments
				if comments /= Void then
					l_text_formatter_decorator.put_comments (comments)
				end
				l_text_formatter_decorator.put_origin_comment
				l_text_formatter_decorator.exdent
				if
					attached current_feature.body as l_feature_as and then
					attached l_feature_as.body as l_body
				then
					l_indexing_clause := l_body.indexing_clause
				end
				if
					(l_indexing_clause /= Void and then not l_indexing_clause.is_empty)
					or current_feature.is_transient
					or current_feature.is_stable
				then
						-- Transient/stable features always have a body thus we can handle the transient/stable/instance-free
						-- property here by adding a `note' clause just after the comments.
					l_text_formatter_decorator.process_keyword_text (ti_note_keyword, Void)
					l_text_formatter_decorator.indent
					if l_indexing_clause /= Void then
						l_has_option_note := l_indexing_clause.is_stable or else l_indexing_clause.is_transient

						l_text_formatter_decorator.process_filter_item (f_indexing, True)
						l_text_formatter_decorator.put_new_line
						l_text_formatter_decorator.set_separator (Void)
						l_text_formatter_decorator.set_new_line_between_tokens
						process_eiffel_list (l_indexing_clause)
						l_text_formatter_decorator.process_filter_item (f_indexing, False)
					end
					if
						not l_has_option_note and
						(current_feature.is_transient or current_feature.is_stable)
					then
						l_text_formatter_decorator.put_new_line
						l_text_formatter_decorator.add_string ("option:")
						if current_feature.is_stable then
							if is_next_option then
								l_text_formatter_decorator.add_char (',')
							end
							l_text_formatter_decorator.add_string (" stable")
							is_next_option := True
						end
						if current_feature.is_transient then
							if is_next_option then
								l_text_formatter_decorator.add_char (',')
							end
							l_text_formatter_decorator.add_string (" transient")
						end
					end
					l_text_formatter_decorator.exdent
					l_text_formatter_decorator.put_new_line
				end
			end
			l_text_formatter_decorator.set_first_assertion (True)

			if is_inline_agent then
				create inline_agent_assertion.make_for_inline_agent (current_feature, l_as)
				if l_as.precondition /= Void then
					inline_agent_assertion.format_precondition (l_text_formatter_decorator,
						not l_text_formatter_decorator.is_with_breakable)
				end
			else
				chained_assert := l_text_formatter_decorator.chained_assertion
				if chained_assert /= Void then
					chained_assert.format_precondition (l_text_formatter_decorator)
				elseif l_as.precondition /= Void then
					l_text_formatter_decorator.set_in_assertion
					l_as.precondition.process (Current)
					l_text_formatter_decorator.set_not_in_assertion
				end
			end
			if not l_text_formatter_decorator.is_feature_short then
				if l_as.locals /= Void then
					l_text_formatter_decorator.process_keyword_text (ti_local_keyword, Void)
					l_text_formatter_decorator.put_new_line
					if l_as.locals.count > 0 then
						l_text_formatter_decorator.indent
						l_text_formatter_decorator.set_separator (Void)
						l_text_formatter_decorator.set_new_line_between_tokens
						processing_locals := True
						l_as.locals.process (Current)
						processing_locals := False
						l_text_formatter_decorator.put_new_line
						l_text_formatter_decorator.exdent
					end
				end
				safe_process (l_as.routine_body)
			end
			l_text_formatter_decorator.set_first_assertion (True)
			if is_inline_agent then
				if l_as.postcondition /= Void then
					inline_agent_assertion.format_postcondition (l_text_formatter_decorator,
						not l_text_formatter_decorator.is_with_breakable)
				end
			else
				if chained_assert /= Void then
					chained_assert.format_postcondition (l_text_formatter_decorator)
				elseif l_as.postcondition /= Void then
					l_text_formatter_decorator.set_in_assertion
					l_as.postcondition.process (Current)
					l_text_formatter_decorator.set_not_in_assertion
				end
			end
			if not l_text_formatter_decorator.is_feature_short then
				if l_as.rescue_clause /= Void then
					l_text_formatter_decorator.process_keyword_text (ti_rescue_keyword, Void)
					l_text_formatter_decorator.indent
					l_text_formatter_decorator.put_new_line
					l_text_formatter_decorator.set_separator (Void)
					l_text_formatter_decorator.set_new_line_between_tokens
					if not l_as.rescue_clause.is_empty then
						format_compound (l_as.rescue_clause)
						l_text_formatter_decorator.put_new_line
					end
					l_text_formatter_decorator.exdent
				end
				if not l_as.is_deferred then
					put_breakable
				end
					-- `end' token should not be printed when the substitution
					-- of a built-in is an attribute.
				if
					attached {BUILT_IN_AS} l_as.routine_body as l_built_in_as implies
					(attached l_built_in_as.body as b implies not b.is_attribute)
				then
					l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
				end
			end
			l_text_formatter_decorator.exdent
		end

	process_constant_as (l_as: CONSTANT_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
				if current_class.lace_class.is_syntax_standard then
					l_text_formatter_decorator.process_symbol_text (ti_equal)
				else
					l_text_formatter_decorator.process_keyword_text (ti_is_keyword, Void)
				end
				l_text_formatter_decorator.put_space
			end
			l_as.value.process (Current)
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL])
		local
			i, l_count: INTEGER
			failure: BOOLEAN
			not_first: BOOLEAN
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				l_text_formatter_decorator.begin
			end
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count or failure
			loop
				if not expr_type_visiting then
					if not_first then
						l_text_formatter_decorator.put_separator
					end
					l_text_formatter_decorator.new_expression
					l_text_formatter_decorator.begin
				end
				l_as.i_th (i).process (Current)
				if not expr_type_visiting then
					l_text_formatter_decorator.commit
				end
				not_first := True
				i := i + 1
			end
			if not expr_type_visiting then
				l_text_formatter_decorator.commit
			end
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.process_filter_item (f_indexing, True)
			if current_class.lace_class.is_syntax_standard then
				l_text_formatter_decorator.process_keyword_text (ti_note_keyword, Void)
			else
				l_text_formatter_decorator.process_keyword_text (ti_indexing_keyword, Void)
			end
			l_text_formatter_decorator.indent
			l_text_formatter_decorator.put_new_line
			l_text_formatter_decorator.set_separator (Void)
			l_text_formatter_decorator.set_new_line_between_tokens
			process_eiffel_list (l_as)
			l_text_formatter_decorator.process_filter_item (f_indexing, False)
			l_text_formatter_decorator.exdent
			l_text_formatter_decorator.put_new_line
			l_text_formatter_decorator.put_new_line
		end

	process_operand_as (l_as: OPERAND_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if attached l_as.class_type as t then
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_l_curly)
				end
				t.process (Current)
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_r_curly)
				end
			elseif attached l_as.expression as e then
				e.process (Current)
			elseif not expr_type_visiting then
				l_text_formatter_decorator.process_symbol_text (ti_question)
			else
				fixme ("Currently we only handle ? for targets, current code does not handle ? for arguments")
				last_type := current_class.actual_type
			end
		end

	process_tagged_as (l_as: TAGGED_AS)
		do
			if not expr_type_visiting then
				format_tagged_as (l_as, not text_formatter_decorator.is_with_breakable)
			end
		end

	process_variant_as (l_as: VARIANT_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_tagged_as (l_as)
		end

	process_un_strip_as (l_as: UN_STRIP_AS)
		local
			first_printed: BOOLEAN
			l_feature: FEATURE_I
			l_feat: E_FEATURE
			l_text_formatter_decorator: like text_formatter_decorator
		do
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.process_keyword_text (ti_strip_keyword, Void)
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
				from
					l_as.id_list.start
				until
					l_as.id_list.after
				loop
					l_text_formatter_decorator.new_expression
					if first_printed then
						l_text_formatter_decorator.set_without_tabs
						l_text_formatter_decorator.process_symbol_text (ti_comma)
						l_text_formatter_decorator.put_space
					end
					l_feature := feature_from_ancestors (source_class, l_as.id_list.item)
						check
							l_feature /= Void
							l_feature.rout_id_set /= Void
						end
					l_feat := feature_in_class (current_class, l_feature.rout_id_set)
					if not has_error_internal then
						l_feat.append_name (l_text_formatter_decorator)
					else
						l_text_formatter_decorator.process_basic_text (l_feature.feature_name_32)
					end
					first_printed := True
					l_as.id_list.forth
				end
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
			end
			last_type := strip_type
		end

	process_converted_expr_as (l_as: CONVERTED_EXPR_AS)
		local
			l_feat: E_FEATURE
			l_type: TYPE_A
			l_old_expr_type_visiting: like expr_type_visiting
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_old_expr_type_visiting := expr_type_visiting
			expr_type_visiting := True
			reset_last_class_and_type
			l_as.expr.process (Current)
			expr_type_visiting := l_old_expr_type_visiting

			if attached {PARENT_CONVERSION_INFO} l_as.data as l_info then
					-- If we have some data about the above with a conversion, we need
					-- to extract it so that we can recheck the code in the descendant.
				l_text_formatter_decorator := text_formatter_decorator
				if l_info.is_null_conversion then
					l_type := l_info.creation_type.evaluated_type_in_descendant (source_class, current_class, current_feature)
					if not expr_type_visiting then
						l_as.expr.process (Current)
					end
				elseif l_info.is_from_conversion then
					l_type := l_info.creation_type.evaluated_type_in_descendant (source_class, current_class, current_feature)
					if not expr_type_visiting then
						l_text_formatter_decorator.process_keyword_text (ti_create_keyword, Void)
						l_text_formatter_decorator.put_space
						l_text_formatter_decorator.process_symbol_text (ti_l_curly)
						type_output_strategy.process (l_type, l_text_formatter_decorator, current_class, current_feature)
						l_text_formatter_decorator.process_symbol_text (ti_r_curly)
						l_text_formatter_decorator.process_symbol_text (ti_dot)
						l_feat := l_type.base_class.feature_with_rout_id (l_info.routine_id)
						l_feat.append_name (l_text_formatter_decorator)
						l_text_formatter_decorator.process_symbol_text (ti_space)
						l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
						l_as.expr.process (Current)
						l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
					end
				else
					l_feat := last_type.base_class.feature_with_rout_id (l_info.routine_id)
					if l_feat /= Void then
						l_type := l_feat.type
						if not expr_type_visiting then
							l_as.expr.process (Current)
							l_text_formatter_decorator.process_symbol_text (ti_dot)
							l_feat.append_name (l_text_formatter_decorator)
						end
					else
						set_error_message ("Could not find routine of a given routine ID in an inherited conversion")
					end
				end
				last_type := l_type
			else
				if not expr_type_visiting then
					l_as.expr.process (Current)
				end
			end
		end

	process_paran_as (l_as: PARAN_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator

			if not expr_type_visiting then
				l_text_formatter_decorator.begin
				l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
			end
			l_as.expr.process (Current)
			if not expr_type_visiting then
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
				l_text_formatter_decorator.commit
			end
		end

	process_expr_call_as (l_as: EXPR_CALL_AS)
		do
			reset_last_class_and_type
			l_as.call.process (Current)
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.begin
				l_text_formatter_decorator.process_symbol_text (ti_dollar)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
				l_as.expr.process (Current)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
				l_text_formatter_decorator.commit
			end
			last_type := pointer_type
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_dollar)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_keyword_text (ti_result, Void)
			end
			if attached current_feature.type as l_type then
				create {TYPED_POINTER_A} last_type.make_typed (l_type)
			end
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_dollar)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_keyword_text (ti_current, Void)
			end
			create {TYPED_POINTER_A} last_type.make_typed (current_class.actual_type)
		end

	process_address_as (l_as: ADDRESS_AS)
		local
			l_feat: E_FEATURE
			l_text_formatter_decorator: like text_formatter_decorator
		do
			reset_last_class_and_type
			if not has_error_internal then
				if l_as.is_argument then
					create {TYPED_POINTER_A} last_type.make_typed (current_feature.arguments.i_th (l_as.argument_position))
				elseif l_as.is_local then
					if locals_for_current_feature.has_key (l_as.feature_name.feature_name.name_32) then
						create {TYPED_POINTER_A} last_type.make_typed (locals_for_current_feature.found_item)
					end
				elseif l_as.is_object_test_local then
					if object_test_locals_for_current_feature.has_key (l_as.feature_name.feature_name.name_32) then
						create {TYPED_POINTER_A} last_type.make_typed (object_test_locals_for_current_feature.found_item)
					end
				else
					l_feat := feature_in_class (current_class, l_as.routine_ids)
					if l_feat /= Void and then l_feat.is_attribute then
						create {TYPED_POINTER_A} last_type.make_typed (l_feat.type.actual_type)
					else
						last_type := Pointer_type
					end
				end
				if not expr_type_visiting then
					l_text_formatter_decorator := text_formatter_decorator
					l_text_formatter_decorator.begin
					l_text_formatter_decorator.set_without_tabs
					l_text_formatter_decorator.process_symbol_text (ti_dollar)
					if l_feat /= Void then
						format_feature_name (l_as.feature_name.feature_name.name_32, l_feat, False)
					else
						format_local_with_as (l_as.feature_name.feature_name)
					end
					l_text_formatter_decorator.commit
				end
			end
		end

	process_predecessor_as (a: PREDECESSOR_AS)
			-- <Precursor>
		local
			i: like {ID_SET_ACCESSOR}.class_id
		do
			reset_last_class_and_type
			if not has_error_internal then
				if not expr_type_visiting then
					text_formatter_decorator.set_without_tabs
					text_formatter_decorator.process_symbol_text (ti_at)
					format_local_with_as (a.name)
				end
				i := a.class_id
				if
					i /= 0 and then
					system.has_class_of_id (i) and then
					attached system.class_of_id (i) as c
				then
					last_class := c
					last_type := object_test_locals_for_current_feature [a.name.name]
				else
					last_class := current_class
					last_type := last_class.actual_type
				end
			end
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS)
		local
			l_feat: E_FEATURE
			l_text_formatter_decorator: like text_formatter_decorator
			l_class: CLASS_C
		do
				-- No type set for this expression?
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.process_keyword_text (ti_agent_keyword, Void)
				l_text_formatter_decorator.put_space
				if l_as.target /= Void then
					l_as.target.process (Current)
					l_text_formatter_decorator.process_symbol_text (ti_dot)
				end

				if l_as.class_id /= 0 and l_as.routine_ids /= Void then
					if l_as.target /= Void then
						l_class := system.class_of_id (l_as.class_id)
					else
						l_class := current_class
					end
					l_feat := feature_in_class (l_class, l_as.routine_ids)
				else
					has_error_internal := True
				end
				if not has_error_internal then
					l_feat.append_name (l_text_formatter_decorator)
				else
					l_text_formatter_decorator.process_basic_text (l_as.feature_name.name_32)
				end

				if l_as.operands /= Void then
					reset_last_class_and_type
					l_text_formatter_decorator.process_symbol_text (ti_space)
					l_text_formatter_decorator.begin
					l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
					l_text_formatter_decorator.set_separator (ti_comma)
					l_text_formatter_decorator.set_space_between_tokens
					l_as.operands.process (Current)
					l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
					l_text_formatter_decorator.commit
				end
				if not has_error_internal then
					last_type := expr_type (l_as)
				end
			else
				if not has_error_internal then
					last_type := agent_type (l_as)
				end
			end
		end

	process_unary_as (l_as: UNARY_AS)
		local
			l_feat: E_FEATURE
			l_type: TYPE_A
			l_last_type: TYPE_A
			l_name: STRING_32
			l_expr_type: TYPE_A
			l_feature_list: like feature_from_type_set
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				l_text_formatter_decorator.begin
			end
			check
				routine_id_is_zero: l_as.routine_ids.first /= 0
			end
			if not has_error_internal then
				l_expr_type := expr_type (l_as.expr)
				if not has_error_internal then
					check
						l_expr_type_not_void: l_expr_type /= Void
					end
					l_expr_type := l_expr_type.actual_type
				end
			end
			if not has_error_internal then
				if attached {FORMAL_A} l_expr_type as l_formal then
					if l_formal.is_multi_constrained (current_class) then
						l_feature_list := feature_from_type_set (l_formal.constrained_types (current_class), l_as.routine_ids)
						if not has_error_internal then
								-- TODO: We simply pick the first even though there could be more than one.
								-- In the future one could display them all on right click.
							l_feat := l_feature_list.first.feature_item
							l_last_type := l_feature_list.first.class_type.type
						end
					else
						l_last_type := l_formal.constrained_type (current_class)
						l_feat := feature_in_class (l_last_type.base_class, l_as.routine_ids)
					end
				else
					l_last_type := l_expr_type.actual_type
					l_feat := feature_in_class (l_last_type.base_class, l_as.routine_ids)
				end
			end
			if not has_error_internal then
				if l_feat.has_alias_name then
					if not expr_type_visiting then
						l_name := l_as.operator_name_32
						if in_bench_mode then
							l_text_formatter_decorator.process_operator_text (l_name, l_feat)
						elseif l_name [1].is_character_8 and then l_name [1].to_character_8.is_alpha then
							l_text_formatter_decorator.process_keyword_text (l_name, Void)
						else
							l_text_formatter_decorator.process_symbol_text (l_name)
						end
						l_text_formatter_decorator.put_space
					end
					l_as.expr.process (Current)
				else
					l_as.expr.process (Current)
					if not expr_type_visiting then
						l_text_formatter_decorator.process_symbol_text (ti_dot)
						l_feat.append_name (l_text_formatter_decorator)
					end
				end
			else
				if not expr_type_visiting then
					l_text_formatter_decorator.process_basic_text (l_as.operator_name_32)
					l_text_formatter_decorator.put_space
				end
				l_as.expr.process (Current)
			end
			if not expr_type_visiting then
				l_text_formatter_decorator.commit
			end
			if not has_error_internal then
				check l_feat_is_not_procedure: not l_feat.is_procedure end
				l_type := l_feat.type.actual_type
				check l_last_type_not_void: l_last_type /= Void end
				last_class := l_last_type.base_class
				if l_type.is_loose then
					last_type := l_type.instantiation_in (l_last_type, last_class.class_id)
				else
					last_type := l_type
				end
			end
		end

	process_un_free_as (l_as: UN_FREE_AS)
		do
			process_unary_as (l_as)
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
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				l_text_formatter_decorator.begin
				l_text_formatter_decorator.process_keyword_text (ti_old_keyword, Void)
				l_text_formatter_decorator.put_space
			end
			l_as.expr.process (Current)
			if not expr_type_visiting then
				l_text_formatter_decorator.commit
			end
		end

	process_un_plus_as (l_as: UN_PLUS_AS)
		do
			process_unary_as (l_as)
		end

	process_binary_as (l_as: BINARY_AS)
		local
			l_feat: E_FEATURE
			l_name: STRING_32
					-- Temporary usage only!
			l_type: TYPE_A
			l_left_type: TYPE_A
			l_is_left_multi_constrained: BOOLEAN
			l_left_type_set: TYPE_SET_A
			l_left_class: CLASS_C
			l_right_type: TYPE_A
			l_feature_list: like feature_from_type_set
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				l_text_formatter_decorator.begin
			end
			reset_last_class_and_type
			l_as.left.process (Current)
			if not has_error_internal then
				check
					last_type /= Void
				end
				last_type := last_type.actual_type
					-- Find correct left type.
				l_left_type := last_type
				if attached {FORMAL_A} l_left_type as l_formal then
					if l_formal.is_multi_constrained (current_class) then
						l_is_left_multi_constrained := True
						l_left_type_set := l_formal.constrained_types (current_class)
					else
						l_left_type := l_formal.constrained_type (current_class)
					end
				end

				check l_left_type_valid: (not l_is_left_multi_constrained) implies (l_left_type /= Void and l_left_type.has_associated_class) end

				l_right_type := expr_type (l_as.right)
				if not has_error_internal then
					if l_is_left_multi_constrained then
						check
							l_left_type_set_not_void: l_left_type_set /= Void
							l_left_type_is_formal: l_left_type.is_formal
						end
						l_feature_list := feature_from_type_set (l_left_type_set, l_as.routine_ids)
						if not has_error_internal then
								-- TODO: We simply pick the first even though there could be more than one.
								-- In the future one could display them all on right click.
							l_feat := l_feature_list.first.feature_item
							l_left_type := l_feature_list.first.class_type.type
						end
					else
						check
							l_left_type_set_void: l_left_type_set = Void
							l_left_type_has_associated_class: l_left_type.has_associated_class
						end
						l_feat := feature_in_class (l_left_type.base_class, l_as.routine_ids)
					end
					check not has_error_internal implies l_left_type /= Void end
					if not has_error_internal then
						l_left_class := l_left_type.base_class
						last_type := l_left_type
					end
				end
			end
			if not expr_type_visiting then
				if not has_error_internal then
					check l_feat_not_void: l_feat /= Void end
					if l_feat.has_alias_name then
						l_name := l_as.operator_name_32
						l_text_formatter_decorator.put_space
						if in_bench_mode then
							l_text_formatter_decorator.process_operator_text (l_name, l_feat)
						elseif l_name [1].is_character_8 and then l_name [1].to_character_8.is_alpha then
							l_text_formatter_decorator.process_keyword_text (l_name, Void)
						else
							l_text_formatter_decorator.process_symbol_text (l_name)
						end
						l_text_formatter_decorator.put_space
						check l_feat_is_not_procedure: not l_feat.is_procedure end
						l_as.right.process (Current)
					else
						l_text_formatter_decorator.process_symbol_text (ti_dot)
						l_feat.append_name (l_text_formatter_decorator)
						l_text_formatter_decorator.put_space
						l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
						l_as.right.process (Current)
						l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
					end
				else
					l_text_formatter_decorator.put_space
					l_text_formatter_decorator.process_basic_text (l_as.op_name.name_32)
					l_text_formatter_decorator.put_space
					l_as.right.process (Current)
				end
			end
			if not has_error_internal then
				check l_feat_not_void: l_feat /= Void end
				check l_feat_is_not_procedure: not l_feat.is_procedure end
				l_type := l_feat.type.actual_type
				if l_type.is_loose then
					last_type := l_type.instantiation_in (l_left_type, l_left_class.class_id)
				else
					last_type := l_type
				end
			else
					-- An error occurred, we reset `last_type' to Void.
				last_type := Void
			end
			if not expr_type_visiting then
				l_text_formatter_decorator.commit
			end
		end

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS)
		do
			process_binary_as (l_as)
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
			process_binary_as (l_as)
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
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_as.left.process (Current)
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.process_symbol_text (l_as.op_name.name_32)
				l_text_formatter_decorator.put_space
			end
			l_as.right.process (Current)
			last_type := boolean_type
		end

	process_bin_ne_as (l_as: BIN_NE_AS)
		do
			process_bin_eq_as (l_as)
		end

	process_bin_tilde_as (l_as: BIN_TILDE_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_as.left.process (Current)
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.process_symbol_text (l_as.op_name.name_32)
				l_text_formatter_decorator.put_space
			end
			l_as.right.process (Current)
			last_type := boolean_type
		end

	process_bin_not_tilde_as (l_as: BIN_NOT_TILDE_AS)
		do
			process_bin_tilde_as (l_as)
		end

	process_bracket_as (l_as: BRACKET_AS)
		local
			l_feat: E_FEATURE
			l_type: TYPE_A
			l_last_type: TYPE_A
			l_last_type_set: TYPE_SET_A
			l_last_class: CLASS_C
			l_result: LIST[TUPLE[feature_item: E_FEATURE; type: RENAMED_TYPE_A]]
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				l_text_formatter_decorator.begin
			end
			l_as.target.process (Current)
			check
				routine_id_is_zero: l_as.routine_ids.first /= 0
				last_type_not_void: last_type /= Void
			end
			if not has_error_internal then
				last_type := last_type.actual_type
				if attached {FORMAL_A} last_type as l_formal then
					if l_formal.is_multi_constrained (current_class) then
						l_last_type_set := l_formal.constrained_types (current_class)
							-- Here we get back the feature and the renamed type where the feature is from (it means that it includes a possible renaming)
						l_result := l_last_type_set.e_feature_list_by_rout_id (l_as.routine_ids.first)
						last_class := l_result.first.type.base_class
						l_feat := l_result.first.feature_item
					else
						last_class := l_formal.constrained_type (current_class).base_class
						l_feat := feature_in_class (last_class, l_as.routine_ids)
					end
				else
					last_class := last_type.base_class
					l_feat := feature_in_class (last_class, l_as.routine_ids)
				end
			end
			if not expr_type_visiting then
				l_text_formatter_decorator.put_space
				if not has_error_internal then
					l_text_formatter_decorator.process_operator_text (ti_l_bracket, l_feat)
				else
					l_text_formatter_decorator.process_basic_text (ti_l_bracket)
				end
				if l_as.operands /= Void then
					l_last_type := last_type
					l_last_class := last_class
					l_text_formatter_decorator.begin
					l_text_formatter_decorator.set_separator (ti_comma)
					l_text_formatter_decorator.set_space_between_tokens
					l_as.operands.process (Current)
					l_text_formatter_decorator.commit
					last_type := l_last_type
					last_class := l_last_class
				end
				if not has_error_internal then
					l_text_formatter_decorator.process_operator_text (ti_r_bracket, l_feat)
				else
					l_text_formatter_decorator.process_basic_text (ti_r_bracket)
				end
			end
			if not has_error_internal then
				check
					l_feat /= Void
				end
				check l_feat_is_not_procedure: not l_feat.is_procedure end
				l_type := l_feat.type.actual_type
				if l_type.is_loose then
					last_type := l_type.instantiation_in (last_type, last_class.class_id)
				else
					last_type := l_type
				end
			end
			if not expr_type_visiting then
				l_text_formatter_decorator.commit
			end
		end

	process_object_test_as (l_as: OBJECT_TEST_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
			l_ot_type: detachable TYPE_A
			l_ot_name: detachable ID_AS
		do
			l_text_formatter_decorator := text_formatter_decorator
				-- Regardless of the syntax used for object test, we always use the most recent
				-- one for the formatting.
			if not expr_type_visiting then
				l_text_formatter_decorator.process_keyword_text (ti_attached_keyword, Void)
				l_text_formatter_decorator.put_space
			end
			if l_as.type /= Void then
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_l_curly)
					l_as.type.process (Current)
					l_text_formatter_decorator.process_symbol_text (ti_r_curly)
					l_text_formatter_decorator.put_space
				else
					l_as.type.process (Current)
				end
				l_ot_type := last_type
			end
			l_as.expression.process (Current)

				-- If no `l_as.type' presents, we take type from the expression evaluation.
			if l_ot_type = Void then
				l_ot_type := last_type
			end
			l_ot_name := l_as.name
			if not expr_type_visiting and l_ot_name /= Void then
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.process_keyword_text (ti_as_keyword, Void)
				l_text_formatter_decorator.put_space
				l_ot_name.process (Current)
			end

				-- Remember found OT locals.
			if l_ot_name /= Void and l_ot_type /= Void then
				object_test_locals_for_current_feature.force (l_ot_type, l_ot_name.name_32)
			end
			last_type := boolean_type
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.language_name.process (Current)
		end

	process_feature_as (l_as: FEATURE_AS)
		local
			comments: EIFFEL_COMMENTS
			cont: CONTENT_AS
			is_const_or_att: BOOLEAN
			l_text_formatter_decorator: like text_formatter_decorator
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			check
				current_class /= Void
			end
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.begin
			l_text_formatter_decorator.set_separator (ti_comma)
			l_text_formatter_decorator.set_space_between_tokens
			l_text_formatter_decorator.process_feature_dec_item (l_as.feature_names.first.feature_name.name_32, True)
			l_text_formatter_decorator.set_separator (ti_comma)
			l_text_formatter_decorator.set_space_between_tokens
			l_as.feature_names.process (Current)
			l_as.body.process (Current)
			l_text_formatter_decorator.set_without_tabs
			l_text_formatter_decorator.process_feature_dec_item (l_as.feature_names.first.feature_name.name_32, False)
			if not l_text_formatter_decorator.is_feature_short then
				l_text_formatter_decorator.put_new_line
			end
			cont := l_as.body.content
				-- Are we handling a constant or an attribute without a body?
			is_const_or_att := cont = Void or else cont.is_constant
			if is_const_or_att then
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.indent
				if l_text_formatter_decorator.is_feature_short then
					l_text_formatter_decorator.put_new_line
				end
				comments := l_text_formatter_decorator.feature_comments
				if comments /= Void then
					l_text_formatter_decorator.put_comments (comments)
				end
				l_text_formatter_decorator.put_origin_comment
				l_text_formatter_decorator.exdent
				l_text_formatter_decorator.exdent
			end
			l_text_formatter_decorator.commit
		end

	process_feature_name (l_as: FEATURE_NAME)
		local
			l_feat: E_FEATURE
			l_new_name: BOOLEAN
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if not has_error_internal then
				if current_feature = Void then
						-- Processing other part of a class, not in a feature.
					if last_parent /= Void then
						l_feat := last_parent.feature_with_name_id (l_as.feature_name.name_id)
					else
						l_feat := current_class.feature_with_name_id (l_as.feature_name.name_id)
							-- Renaming in formal declaration.
						if processing_formal_dec then
							if renamed_feature = Void then
									-- Old name
								check old_name_feature_not_void: l_feat /= Void end
								renamed_feature := l_feat
							else
									-- New name
								l_feat := renamed_feature
								renamed_feature := Void
								l_new_name := True
							end
						end
					end
					if l_feat = Void then
						has_error_internal := True
					end
				else
						-- Processing name of a feature.
					l_feat := feature_in_class (current_class, current_feature.rout_id_set)
					check l_Feat_not_void: l_feat /= Void end
				end

				if not has_error_internal and then not processing_parents then
					check
						l_feat_not_void: l_feat /= Void
					end
					if not processing_none_feature_part and then l_feat.is_frozen then
						l_text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
						l_text_formatter_decorator.put_space
					end
					if processing_formal_dec then
						l_text_formatter_decorator.process_feature_text (l_as.visual_name_32, l_feat, False)
					else
						l_feat.append_name (l_text_formatter_decorator)
					end
				else
					if not processing_none_feature_part and then l_as.is_frozen then
						l_text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
						l_text_formatter_decorator.put_space
					end
					if not has_error_internal then
						l_feat.append_name (l_text_formatter_decorator)
					else
						l_text_formatter_decorator.process_basic_text (l_as.visual_name_32)
					end
				end
			else
				l_text_formatter_decorator.process_basic_text (l_as.visual_name_32)
			end
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS)
		local
			l_feat: E_FEATURE
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if not has_error_internal then
				if current_feature = Void then
						-- Processing other part of a class, not in a feature.
					if last_parent /= Void then
						l_feat := last_parent.feature_with_name_id (l_as.feature_name.name_id)
					else
						l_feat := current_class.feature_with_name_id (l_as.feature_name.name_id)
							-- Renaming in formal declaration.
						if processing_formal_dec then
							if renamed_feature = Void then
									-- Old name
								check old_name_feature_not_void: l_feat /= Void end
								renamed_feature := l_feat
							else
									-- New name
								l_feat := renamed_feature
								renamed_feature := Void
							end
						end
					end
				else
						-- Processing name of a feature.
					l_feat := feature_in_class (current_class, current_feature.rout_id_set)
				end
			end
			if l_as.is_frozen then
				l_text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
				l_text_formatter_decorator.put_space
			end
			if not has_error_internal then
				l_feat.append_name (l_text_formatter_decorator)
			else
				l_text_formatter_decorator.process_basic_text (l_as.visual_name_32)
			end

			if
				(has_error_internal or else l_feat.has_alias_name) and then
				attached l_feat.aliases as l_aliases
			then
				across
					l_aliases as ic
				loop
					l_text_formatter_decorator.put_space
					l_text_formatter_decorator.process_keyword_text (ti_alias_keyword, Void)
					l_text_formatter_decorator.put_space
					l_text_formatter_decorator.process_symbol_text (ti_double_quote)
					if not has_error_internal then
						l_text_formatter_decorator.process_operator_text (l_as.extract_alias_name_32 (ic.item.alias_name_32), l_feat)
					else
						l_text_formatter_decorator.process_basic_text (l_as.extract_alias_name_32 (ic.item.alias_name_32))
					end
					l_text_formatter_decorator.process_symbol_text (ti_double_quote)
				end
			end
		end

	process_feature_list_as (l_as: FEATURE_LIST_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.set_separator (ti_comma)
				l_text_formatter_decorator.set_space_between_tokens
			end
			l_as.features.process (Current)
		end

	process_all_as (l_as: ALL_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.process_keyword_text (ti_all_keyword, Void)
		end

	process_assign_as (l_as: ASSIGN_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			reset_last_class_and_type
			if not expr_type_visiting then
				put_breakable
				l_text_formatter_decorator.new_expression
			end
			l_as.target.process (Current)
			if not expr_type_visiting then
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_assign)
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.new_expression
			end
			reset_last_class_and_type
			l_as.source.process (Current)
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				reset_last_class_and_type
				put_breakable
				l_text_formatter_decorator.new_expression
			end
			l_as.target.process (Current)
			if not expr_type_visiting then
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_assign)
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.new_expression
			end
			l_as.source.process (Current)
		end

	process_reverse_as (l_as: REVERSE_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				put_breakable
				l_text_formatter_decorator.new_expression
			end
			l_as.target.process (Current)
			if not expr_type_visiting then
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_reverse_assign)
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.new_expression
			end
			l_as.source.process (Current)
		end

	process_check_as (l_as: CHECK_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.process_keyword_text (ti_check_keyword, Void)
			if l_as.check_list /= Void then
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.set_new_line_between_tokens
				l_as.check_list.process (Current)
				l_text_formatter_decorator.exdent
			end
			l_text_formatter_decorator.put_new_line
			l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
		end

	process_creation_as (l_as: CREATION_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not expr_type_visiting then
				put_breakable
				l_text_formatter_decorator.process_keyword_text (ti_create_keyword, Void)
				l_text_formatter_decorator.put_space
				if not l_as.is_active then
					l_text_formatter_decorator.process_symbol_text (ti_less_than)
					l_text_formatter_decorator.process_basic_text (ti_none_class)
					l_text_formatter_decorator.process_symbol_text (ti_greater_than)
					l_text_formatter_decorator.put_space
				end
			end
			if l_as.type /= Void then
				if not expr_type_visiting then
					l_text_formatter_decorator.process_symbol_text (ti_l_curly)
				end
				l_as.type.process (Current)
				if not expr_type_visiting then
					l_text_formatter_decorator.set_without_tabs
					l_text_formatter_decorator.process_symbol_text (ti_r_curly)
					l_text_formatter_decorator.put_space
				end
			end
			processing_creation_target := True
			l_as.target.process (Current)
			processing_creation_target := False
			if l_as.call /= Void then
				if not expr_type_visiting then
					l_text_formatter_decorator.need_dot
				end
				l_as.call.process (Current)
			end

		end

	process_debug_as (l_as: DEBUG_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.process_keyword_text (ti_debug_keyword, Void)
			if l_as.keys /= Void and then not l_as.keys.is_empty then
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
				l_text_formatter_decorator.set_separator (ti_comma)
				l_text_formatter_decorator.set_no_new_line_between_tokens
				l_as.keys.process (Current)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
			end
			if l_as.compound /= Void then
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.set_separator (Void)
				l_text_formatter_decorator.set_new_line_between_tokens
				format_compound (l_as.compound)
				l_text_formatter_decorator.exdent
			end
			l_text_formatter_decorator.put_new_line
			l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
		end

	process_guard_as (l_as: GUARD_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.process_keyword_text (ti_check_keyword, Void)
			if l_as.check_list /= Void then
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.set_new_line_between_tokens
				l_as.check_list.process (Current)
				l_text_formatter_decorator.exdent
				l_text_formatter_decorator.put_new_line
			else
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
			end
			l_text_formatter_decorator.process_keyword_text (ti_then_keyword, Void)
			l_text_formatter_decorator.put_new_line
			if attached l_as.compound as c then
				l_text_formatter_decorator.indent
				format_compound (c)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
			l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
		end

	process_if_as (l_as: IF_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			put_breakable
			l_text_formatter_decorator.process_keyword_text (ti_if_keyword, Void)
			l_text_formatter_decorator.put_space
			l_text_formatter_decorator.new_expression
			l_as.condition.process (Current)
			l_text_formatter_decorator.put_space
			l_text_formatter_decorator.set_without_tabs
			l_text_formatter_decorator.process_keyword_text (ti_then_keyword, Void)
			l_text_formatter_decorator.put_new_line
			if l_as.compound /= Void then
				l_text_formatter_decorator.indent
				format_compound (l_as.compound)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
			if l_as.elsif_list /= Void then
				l_text_formatter_decorator.set_separator (ti_empty)
				l_text_formatter_decorator.set_no_new_line_between_tokens
				l_as.elsif_list.process (Current)
				l_text_formatter_decorator.set_separator (Void)
			end
			if l_as.else_part /= Void then
				l_text_formatter_decorator.process_keyword_text (ti_else_keyword, Void)
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.set_new_line_between_tokens
				format_compound (l_as.else_part)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
			l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
		end

	process_if_expression_as (l_as: IF_EXPRESSION_AS)
			-- <Precursor>
		local
			l_text_formatter_decorator: like text_formatter_decorator
			indent: PROCEDURE
			exdent: PROCEDURE
		do
			if
				true
				-- Use multiline format all the time to facilitate debugging
				-- Otherwise it would be possible to use single line format
				-- depending on the complexity of the nested expressions.
				-- attached l_as.elsif_list
			then
				indent := agent
					do
						text_formatter_decorator.indent
						text_formatter_decorator.put_new_line
					end
				exdent := agent
					do
						text_formatter_decorator.put_new_line
						text_formatter_decorator.exdent
					end
			else
				indent := agent text_formatter_decorator.put_space
				exdent := indent
			end
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.set_separator (Void)
				l_text_formatter_decorator.set_new_line_between_tokens
				l_text_formatter_decorator.process_keyword_text (ti_if_keyword, Void)
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.new_expression
				l_as.condition.process (Current)
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_keyword_text (ti_then_keyword, Void)
				indent.call (Void)
				l_text_formatter_decorator.new_expression
				put_breakable
			end
			l_as.then_expression.process (Current)
			if not expr_type_visiting then
				exdent.call (Void)
				if attached l_as.elsif_list as l then
					l_text_formatter_decorator.set_separator (ti_empty)
					l_text_formatter_decorator.set_no_new_line_between_tokens
					l.process (Current)
					l_text_formatter_decorator.set_separator (Void)
				end
				l_text_formatter_decorator.process_keyword_text (ti_else_keyword, Void)
				indent.call (Void)
				l_text_formatter_decorator.new_expression
				put_breakable
			end
			l_as.else_expression.process (Current)
			if not expr_type_visiting then
				exdent.call (Void)
				l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
			end
		end

	process_inspect_abstraction
		(a: INSPECT_ABSTRACTION_AS [CASE_ABSTRACTION_AS [detachable AST_EIFFEL], detachable AST_EIFFEL];
			a_is_expression: BOOLEAN;
			format_else_part_content: PROCEDURE)
		require
			not expr_type_visiting
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if not a_is_expression then
				put_breakable
			end
			l_text_formatter_decorator.process_keyword_text (ti_inspect_keyword, Void)
			l_text_formatter_decorator.put_space
			l_text_formatter_decorator.indent
			a.switch.process (Current)
			l_text_formatter_decorator.exdent
			l_text_formatter_decorator.put_new_line
			if attached a.case_list as l then
				l_text_formatter_decorator.set_separator (ti_empty)
				l_text_formatter_decorator.set_no_new_line_between_tokens
				l.process (Current)
			end
			if attached a.else_part as e then
				l_text_formatter_decorator.process_keyword_text (ti_else_keyword, Void)
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.set_separator (Void)
				l_text_formatter_decorator.set_new_line_between_tokens
				format_else_part_content.call
				l_text_formatter_decorator.exdent
			end
			l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
		end

	process_inspect_as (a: INSPECT_AS)
		do
			process_inspect_abstraction (a, False, agent (e: detachable EIFFEL_LIST [INSTRUCTION_AS])
				do
					if attached e and then not e.is_empty then
						format_compound (e)
						text_formatter_decorator.put_new_line
					end
				end (a.else_part))
		end

	process_inspect_expression_as (a: INSPECT_EXPRESSION_AS)
		do
			if expr_type_visiting then
				if attached a.case_list as l then
						-- Bypass "when" parts and process only expressions.
					⟳ c: l ¦ c.content.process (Current) ⟲
				end
				if attached a.else_part as e then
					e.process (Current)
				end
			else
				process_inspect_abstraction (a, True, agent (e: detachable EXPR_AS)
					do
						if attached e then
							put_breakable
							e.process (Current)
							text_formatter_decorator.put_new_line
						end
					end (a.else_part))
			end
		end

	process_instr_call_as (l_as: INSTR_CALL_AS)
		do
			reset_last_class_and_type
			if not expr_type_visiting then
				put_breakable
			end
			l_as.call.process (Current)
		end

	process_loop_as (l_as: LOOP_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
			l_variant_after_body: BOOLEAN
			has_iteration: BOOLEAN
		do
			if attached l_as.iteration as i then
				i.process (Current)
				has_iteration := True
			end
				--| for now, the debugger supports only previous declaration
			l_variant_after_body := not is_with_breakable and then current_class.lace_class.is_syntax_standard
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
				-- Avoid generating empty initialization part if iteration part is present.
			if l_as.from_part /= Void or else not has_iteration then
				l_text_formatter_decorator.process_keyword_text (ti_from_keyword, Void)
				l_text_formatter_decorator.set_separator (Void)
				l_text_formatter_decorator.set_new_line_between_tokens
				if l_as.from_part /= Void then
					l_text_formatter_decorator.indent
					l_text_formatter_decorator.put_new_line
					format_compound (l_as.from_part)
					l_text_formatter_decorator.put_new_line
					l_text_formatter_decorator.exdent
				else
					l_text_formatter_decorator.put_new_line
				end
			end
			if l_as.invariant_part /= Void then
				l_text_formatter_decorator.process_keyword_text (ti_invariant_keyword, Void)
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_as.invariant_part.process (Current)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
			if l_as.variant_part /= Void and then not l_variant_after_body then
				l_text_formatter_decorator.process_keyword_text (ti_variant_keyword, Void)
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_as.variant_part.process (Current)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
			if attached l_as.stop as s then
				l_text_formatter_decorator.process_keyword_text (ti_until_keyword, Void)
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.new_expression
				put_breakable
				s.process (Current)
				l_text_formatter_decorator.exdent
				l_text_formatter_decorator.put_new_line
			end
			l_text_formatter_decorator.process_keyword_text (ti_loop_keyword, Void)
			if l_as.compound /= Void then
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				format_compound (l_as.compound)
				l_text_formatter_decorator.exdent
			end
			l_text_formatter_decorator.put_new_line
			if l_as.variant_part /= Void and then l_variant_after_body then
				l_text_formatter_decorator.process_keyword_text (ti_variant_keyword, Void)
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_as.variant_part.process (Current)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
			if has_iteration then
				put_breakable
			end
			l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
		end

	process_loop_expr_as (l_as: LOOP_EXPR_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
			iteration: ITERATION_AS
			indent: PROCEDURE
			exdent: PROCEDURE
			exdent_no_wrap: PROCEDURE
		do
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				if
					true
					-- Use multiline format all the time to facilitate debugging
					-- Otherwise it would be possible to use single or multiline format
					-- depending on what parts are present in the loop expression
--					l_as.invariant_part /= Void or else
--					l_as.exit_condition /= Void or else
--					l_as.variant_part /= Void
				then
					indent := agent
						do
							text_formatter_decorator.indent
							text_formatter_decorator.put_new_line
						end
					exdent := agent
						do
							text_formatter_decorator.put_new_line
							text_formatter_decorator.exdent
						end
					exdent_no_wrap := agent text_formatter_decorator.exdent
				else
					indent := agent text_formatter_decorator.put_space
					exdent := indent
					exdent_no_wrap := agent do_nothing
				end
				l_text_formatter_decorator.set_separator (Void)
				l_text_formatter_decorator.set_new_line_between_tokens
				iteration := l_as.iteration
				if iteration.is_symbolic then
					l_text_formatter_decorator.process_keyword_text
						(if l_as.is_all then ti_for_all else ti_there_exists end, Void)
					l_text_formatter_decorator.put_space
					iteration.identifier.process (Current)
					l_text_formatter_decorator.process_symbol_text (ti_colon)
					l_text_formatter_decorator.put_space
					l_text_formatter_decorator.new_expression
					process_loop_iteration_expression (iteration)
					l_text_formatter_decorator.put_space
					l_text_formatter_decorator.process_keyword_text (ti_broken_bar, Void)
					indent.call
					l_text_formatter_decorator.new_expression
					put_breakable
					l_as.expression.process (Current)
					exdent_no_wrap.call
				else
					append_iteration_as (iteration, indent, exdent)
					if attached l_as.invariant_part as p then
						l_text_formatter_decorator.process_keyword_text (ti_invariant_keyword, Void)
						indent.call
						p.process (Current)
						exdent.call
					end
					if attached l_as.exit_condition as e then
						l_text_formatter_decorator.process_keyword_text (ti_until_keyword, Void)
						indent.call
						l_text_formatter_decorator.new_expression
						put_breakable
						e.process (Current)
						exdent.call
					end
					l_text_formatter_decorator.process_keyword_text
						(if l_as.is_all then ti_all_keyword else ti_some_keyword end, Void)
					indent.call
					l_text_formatter_decorator.new_expression
					put_breakable
					l_as.expression.process (Current)
					exdent.call
					if attached l_as.variant_part as p then
						l_text_formatter_decorator.process_keyword_text (ti_variant_keyword, Void)
						indent.call
						p.process (Current)
						exdent.call
					end
					put_breakable
					l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
				end
			end
			last_type := boolean_type
		end

	process_retry_as (l_as: RETRY_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			put_breakable
			text_formatter_decorator.process_keyword_text (ti_retry_keyword, Void)
		end

	process_separate_instruction_as (a: SEPARATE_INSTRUCTION_AS)
			-- <Precursor>
		do
			text_formatter_decorator.process_keyword_text (ti_separate_keyword, Void)
			text_formatter_decorator.set_separator (ti_comma)
			if a.arguments.count = 1 then
					-- One argument is formatted inline.
				text_formatter_decorator.put_space
				text_formatter_decorator.set_space_between_tokens
				a.arguments.process (Current)
				text_formatter_decorator.put_space
				text_formatter_decorator.set_without_tabs
			else
					-- Multiple arguments are formatted on separate lines.
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				text_formatter_decorator.set_new_line_between_tokens
				a.arguments.process (Current)
				text_formatter_decorator.exdent
				text_formatter_decorator.put_new_line
			end
			text_formatter_decorator.process_keyword_text (ti_do_keyword, Void)
			text_formatter_decorator.put_new_line
			text_formatter_decorator.indent
			format_compound (a.compound)
			text_formatter_decorator.exdent
			text_formatter_decorator.put_new_line
			text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
		end

	process_external_as (l_as: EXTERNAL_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.process_keyword_text (ti_external_keyword, Void)
			l_text_formatter_decorator.indent
			l_text_formatter_decorator.put_new_line
			l_as.language_name.process (Current)
			l_text_formatter_decorator.exdent
			l_text_formatter_decorator.put_new_line
			if attached l_as.alias_name_literal as l_alias_name_literal then
				l_text_formatter_decorator.process_keyword_text (ti_alias_keyword, Void)
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_alias_name_literal.process (Current)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
		end

	process_deferred_as (l_as: DEFERRED_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.process_keyword_text (ti_deferred_keyword, Void)
			l_text_formatter_decorator.put_new_line
		end

	process_attribute_as (l_as: ATTRIBUTE_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.process_keyword_text (ti_attribute_keyword, Void)
			l_text_formatter_decorator.put_new_line
			if l_as.compound /= Void then
				l_text_formatter_decorator.indent
				format_compound (l_as.compound)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
		end

	process_do_as (l_as: DO_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.process_keyword_text (ti_do_keyword, Void)
			l_text_formatter_decorator.put_new_line
			if l_as.compound /= Void then
				l_text_formatter_decorator.indent
				format_compound (l_as.compound)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
		end

	process_once_as (l_as: ONCE_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.process_keyword_text (ti_once_keyword, Void)
			if attached l_as.keys as k and then not k.is_empty then
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
				l_text_formatter_decorator.set_separator (ti_comma)
				l_text_formatter_decorator.set_no_new_line_between_tokens
				k.process (Current)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
			end
			l_text_formatter_decorator.put_new_line
			if l_as.compound /= Void then
				l_text_formatter_decorator.indent
				format_compound (l_as.compound)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
		end

	process_list_dec_as (l_as: LIST_DEC_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.set_separator (ti_comma)
			l_text_formatter_decorator.set_space_between_tokens
			from
				l_as.id_list.start
			until
				l_as.id_list.after
			loop
				format_local_with_id (l_as.id_list.item)
				l_as.id_list.forth
				if not l_as.id_list.after then
					l_text_formatter_decorator.put_separator
				end
			end
		end

	process_type_dec_as (l_as: TYPE_DEC_AS)
		local
			l_names_heap: like names_heap
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.set_separator (ti_comma)
			l_text_formatter_decorator.set_space_between_tokens
			from
				l_as.id_list.start
			until
				l_as.id_list.after
			loop
				format_local_with_id (l_as.id_list.item)
				l_as.id_list.forth
				if not l_as.id_list.after then
					l_text_formatter_decorator.put_separator
				end
			end
			l_text_formatter_decorator.set_without_tabs
			l_text_formatter_decorator.process_symbol_text (ti_colon)
			l_text_formatter_decorator.put_space
			l_as.type.process (Current)
			if processing_locals and last_actual_local_type /= Void then
				from
					l_names_heap := names_heap
					l_as.id_list.start
				until
					l_as.id_list.after
				loop
					locals_for_current_feature.put (last_actual_local_type, l_names_heap.item_32 (l_as.id_list.item))
					l_as.id_list.forth
				end
			end
		end

	process_class_as (l_as: CLASS_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.process_filter_item (f_class_declaration, True)
			share_class_processing (l_as)
			l_text_formatter_decorator.process_filter_item (f_class_declaration, False)
			l_text_formatter_decorator.put_new_line
		end

	share_class_processing (l_as: CLASS_AS)
			-- Shared part of `'processing_class_as' for both normal flat views and doc.
		local
			l_creators: EIFFEL_LIST [CREATE_AS]
			l_features: EIFFEL_LIST [FEATURE_NAME]
			l_feat: FEATURE_I
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			processing_none_feature_part := True
			l_text_formatter_decorator.process_before_class (current_class)
			safe_process (l_as.top_indexes)
			format_header (l_as)
			if l_text_formatter_decorator.is_clickable_format and l_as.obsolete_message /= Void then
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.process_filter_item (f_obsolete, True)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_keyword_text (ti_obsolete_keyword, Void)
				l_text_formatter_decorator.put_space
				l_as.obsolete_message.process (Current)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_filter_item (f_obsolete, False)
				l_text_formatter_decorator.put_new_line
			end
				-- Process conforming inheritance.
			if l_text_formatter_decorator.is_clickable_format and l_as.conforming_parents /= Void then
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.process_filter_item (f_inheritance, True)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_keyword_text (ti_inherit_keyword, Void)
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.set_new_line_between_tokens
				l_text_formatter_decorator.set_separator (ti_new_line)
				processing_parents := True
				l_as.conforming_parents.process (Current)
				processing_parents := False
				l_text_formatter_decorator.process_filter_item (f_inheritance, False)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end

				-- Process non-conforming inheritance.
			if l_text_formatter_decorator.is_clickable_format and l_as.non_conforming_parents /= Void then
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.process_filter_item (f_inheritance, True)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_keyword_text (ti_inherit_keyword, Void)
				l_text_formatter_decorator.process_basic_text (ti_space)
				l_text_formatter_decorator.process_symbol_text (ti_l_curly)
				l_text_formatter_decorator.process_basic_text (ti_none_class)
				l_text_formatter_decorator.process_symbol_text (ti_r_curly)
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.set_new_line_between_tokens
				l_text_formatter_decorator.set_separator (ti_new_line)
				processing_parents := True
				l_as.non_conforming_parents.process (Current)
				processing_parents := False
				l_text_formatter_decorator.process_filter_item (f_inheritance, False)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
			l_text_formatter_decorator.put_new_line

			l_creators := l_as.creators
			if l_creators = Void and then not l_as.is_deferred and then current_class.has_feature_table then
				l_feat := current_class.default_create_feature
				if l_feat /= Void then
					create l_creators.make (1)
					create l_features.make (1)
					l_features.extend (create {FEATURE_NAME}.initialize (create {ID_AS}.initialize_from_id (l_feat.feature_name_id)))
					l_creators.extend (create {CREATE_AS}.initialize (Void, l_features, Void))
				end
			end
			if l_creators /= Void then
				check
					class_not_deferred: not l_as.is_deferred
				end
				l_text_formatter_decorator.process_filter_item (f_creators, True)
				l_text_formatter_decorator.set_separator (ti_empty)
				l_text_formatter_decorator.set_new_line_between_tokens
				l_creators.process (Current)
				l_text_formatter_decorator.process_filter_item (f_creators, False)
			end
			format_convert_clause (l_as.convertors)
			processing_none_feature_part := False
			l_text_formatter_decorator.format_categories
			l_text_formatter_decorator.format_invariants
			safe_process (l_as.bottom_indexes)
			l_text_formatter_decorator.process_filter_item (f_class_end, False)
			l_text_formatter_decorator.set_without_tabs
			l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
			l_text_formatter_decorator.process_after_class (current_class)
			l_text_formatter_decorator.process_filter_item (f_class_end, False)
		end

	process_parent_as (l_as: PARENT_AS)
		local
			end_to_print: BOOLEAN
			l_text_formatter_decorator: like text_formatter_decorator
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.type.process (Current)
			check
				last_type_not_void: last_type /= Void
			end
			last_parent := last_type.base_class
			check
				last_parent_not_void: last_parent /= Void
			end
			if l_as.renaming /= Void then
				format_clause (ti_rename_keyword, l_as.renaming, True)
				end_to_print := True
			end
			last_parent := Void
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
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
				l_text_formatter_decorator.exdent
			end
		end

	process_type_as (l_as: TYPE_AS)
			-- Process `l_as'
		require
			l_as_not_void: l_as /= Void
		do
			check_type (l_as)
			if processing_locals then
				last_actual_local_type := last_type
			end
			if not expr_type_visiting then
				if last_type /= Void then
					type_output_strategy.process (last_type, text_formatter_decorator, current_class, current_feature)
				else
						-- TODO: check if Void is ok for now [2017-04-15].
					text_formatter_decorator.process_local_text (Void, l_as.dump)
				end
			end
		end

	process_like_id_as (l_as: LIKE_ID_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			check_type (l_as)
			if processing_locals then
				last_actual_local_type := last_type
			end
			if not expr_type_visiting then
				if last_type /= Void then
					type_output_strategy.process (last_type, text_formatter_decorator, current_class, current_feature)
				else
					l_text_formatter_decorator := text_formatter_decorator
					if l_as.has_frozen_mark then
						l_text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
						l_text_formatter_decorator.add_space
					elseif l_as.has_variant_mark then
						l_text_formatter_decorator.process_keyword_text (ti_variant_keyword, Void)
						l_text_formatter_decorator.add_space
					end
					if l_as.has_attached_mark then
						l_text_formatter_decorator.process_keyword_text (ti_attached_keyword, Void)
						l_text_formatter_decorator.add_space
					elseif l_as.has_detachable_mark then
						l_text_formatter_decorator.process_keyword_text (ti_detachable_keyword, Void)
						l_text_formatter_decorator.add_space
					end
					if l_as.has_separate_mark then
						l_text_formatter_decorator.process_keyword_text (ti_separate_keyword, Void)
						l_text_formatter_decorator.add_space
					end
					l_text_formatter_decorator.process_keyword_text (ti_like_keyword, Void)
					l_text_formatter_decorator.add_space
					format_local_with_id (l_as.anchor.name_id)
				end
			end
		end

	process_like_cur_as (l_as: LIKE_CUR_AS)
		do
			check_type (l_as)
			if processing_locals then
				last_actual_local_type := last_type
			end
			if not expr_type_visiting then
				type_output_strategy.process (last_type, text_formatter_decorator, current_class, current_feature)
			end
		end

	process_qualified_anchored_type_as (l_as: QUALIFIED_ANCHORED_TYPE_AS)
			-- <Precursor>
		local
			l_text_formatter_decorator: like text_formatter_decorator
			is_implicit: BOOLEAN
		do
			check_type (l_as)
			if processing_locals then
				last_actual_local_type := last_type
			end
			if not expr_type_visiting then
				if last_type /= Void then
					type_output_strategy.process (last_type, text_formatter_decorator, current_class, current_feature)
				else
					l_text_formatter_decorator := text_formatter_decorator
						-- Figure out if qualifier can be used without adding an additional "like" keyword.
					is_implicit := attached {LIKE_CUR_AS} l_as.qualifier or else attached {LIKE_ID_AS} l_as.qualifier
					if l_as.has_frozen_mark then
						l_text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
						l_text_formatter_decorator.add_space
							-- The type is of the form "frozen like {T}.something"
						is_implicit := False
					elseif l_as.has_variant_mark then
						l_text_formatter_decorator.process_keyword_text (ti_variant_keyword, Void)
						l_text_formatter_decorator.add_space
							-- The type is of the form "variant like {T}.something"
						is_implicit := False
					end
					if l_as.has_attached_mark then
						l_text_formatter_decorator.process_keyword_text (ti_attached_keyword, Void)
						l_text_formatter_decorator.add_space
							-- The type is of the form "attached like {T}.something"
						is_implicit := False
					elseif l_as.has_detachable_mark then
						l_text_formatter_decorator.process_keyword_text (ti_detachable_keyword, Void)
						l_text_formatter_decorator.add_space
							-- The type is of the form "detachable like {T}.something"
						is_implicit := False
					end
					if l_as.has_separate_mark then
						l_text_formatter_decorator.process_keyword_text (ti_separate_keyword, Void)
						l_text_formatter_decorator.add_space
							-- The type is of the form "separate like {T}.something"
						is_implicit := False
					end
					if is_implicit then
						l_as.qualifier.process (Current)
					else
						l_text_formatter_decorator.process_keyword_text (ti_like_keyword, Void)
						l_text_formatter_decorator.add_space
						l_text_formatter_decorator.process_symbol_text (ti_l_curly)
						l_as.qualifier.process (Current)
						l_text_formatter_decorator.process_symbol_text (ti_r_curly)
					end
					l_text_formatter_decorator.set_separator (ti_dot)
					l_text_formatter_decorator.set_no_new_line_between_tokens
					l_text_formatter_decorator.process_symbol_text (ti_dot)
					l_as.chain.process (Current)
				end
			end
		end

	process_feature_id_as (l_as: FEATURE_ID_AS)
			-- <Precursor>
		do
			l_as.name.process (Current)
		end

	process_formal_as (l_as: FORMAL_AS)
		do
			process_type_as (l_as)
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS)
		local
			feature_name: FEATURE_NAME
			l_constrained_type: TYPE_A
			l_constrained_type_set: TYPE_SET_A
			l_is_multi_constrained: BOOLEAN
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
				not_processing_locals: not processing_locals
			end
			if l_as.is_frozen then
				l_text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
				l_text_formatter_decorator.put_space
			end
			if l_as.is_reference then
				l_text_formatter_decorator.process_keyword_text (ti_reference_keyword, Void)
				l_text_formatter_decorator.put_space
			elseif l_as.is_expanded then
				l_text_formatter_decorator.process_keyword_text (ti_expanded_keyword, Void)
				l_text_formatter_decorator.put_space
			end
			processing_formal_dec := True
			l_text_formatter_decorator.process_generic_text (l_as.name.name_32)
			if attached {FORMAL_CONSTRAINT_AS} l_as as l_formal_dec then
				if l_formal_dec.has_multi_constraints then
						-- We're in the multi constrained case: G -> {A, B, C}
					l_is_multi_constrained := True
					l_constrained_type_set := l_formal_dec.constraint_types_if_possible (current_class)
				else
					l_constrained_type := l_formal_dec.constraint_type_if_possible (current_class).type
				end
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_constraint)
				l_text_formatter_decorator.put_space
				if l_is_multi_constrained then
					l_text_formatter_decorator.process_symbol_text (ti_l_curly)
				end
				l_as.constraints.process (Current)
				if l_is_multi_constrained then
					l_text_formatter_decorator.process_symbol_text (ti_r_curly)
				end
				if l_as.has_creation_constraint then
					from
						l_as.creation_feature_list.start
						l_text_formatter_decorator.put_space
						l_text_formatter_decorator.process_keyword_text (ti_create_keyword, Void)
						l_text_formatter_decorator.put_space
						feature_name := l_as.creation_feature_list.item
						append_feature_by_id (feature_name, l_constrained_type, l_constrained_type_set)
						l_as.creation_feature_list.forth
					until
						l_as.creation_feature_list.after
					loop
						l_text_formatter_decorator.process_symbol_text (ti_comma)
						l_text_formatter_decorator.put_space
						feature_name := l_as.creation_feature_list.item
						append_feature_by_id (feature_name, l_constrained_type, l_constrained_type_set)
						l_as.creation_feature_list.forth
					end
					l_text_formatter_decorator.put_space
					l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
				end
			end
			processing_formal_dec := False
		end

	process_constraining_type_as (l_as: CONSTRAINING_TYPE_AS)
		local
			l_renaming: RENAME_CLAUSE_AS
			l_type: TYPE_AS
			l_tmp_current_class: like current_class
			l_class_c: CLASS_C
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_type := l_as.type
			process_type_as (l_type)
			l_renaming := l_as.renaming
			if l_renaming /= Void then
					-- If we have a class type we try to find the class and set it as the `current_class'
					-- in order to make sure that feature lookups are done one the propper class.
				if attached {CLASS_TYPE_AS} l_type as l_cl_type_as then
					l_tmp_current_class := current_class
					l_class_c := universe.class_named (l_cl_type_as.class_name.name_8, l_tmp_current_class.group).compiled_class
					if l_class_c /= Void then
						set_current_class (l_class_c)
					else
							-- If this class is not compiled we cannot to any feature linking for possible renaming clauses
						has_error_internal := True
					end
				end
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.add_space
				l_text_formatter_decorator.process_keyword_text (ti_rename_keyword, Void)
				l_text_formatter_decorator.add_space
				process_rename_clause_as (l_renaming)
				l_text_formatter_decorator.add_space
				l_text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
					-- If we changed the current_class set it back.
				if l_class_c /= Void then
					check l_tmp_current_class_not_void: l_tmp_current_class /= Void end
					set_current_class (l_tmp_current_class)
				end
			end
		end

	process_class_type_as (l_as: CLASS_TYPE_AS)
		do
			process_type_as (l_as)
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS)
		do
			process_type_as (l_as)
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS)
			-- Process `l_as'.
		do
			process_type_as (l_as)
		end

	process_none_type_as (l_as: NONE_TYPE_AS)
		do
			process_type_as (l_as)
		end

	process_rename_as (l_as: RENAME_AS)
		local
			l_last_parent: like last_parent
			l_tmp_has_error_internal: BOOLEAN
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_tmp_has_error_internal := has_error_internal
			l_as.old_name.process (Current)
			l_text_formatter_decorator.put_space
			l_text_formatter_decorator.set_without_tabs
			l_text_formatter_decorator.process_keyword_text (ti_as_keyword, Void)
			l_text_formatter_decorator.put_space
			l_last_parent := last_parent
			last_parent := Void
			l_as.new_name.process (Current)
			last_parent := l_last_parent
			has_error_internal := l_tmp_has_error_internal
		end

	process_invariant_as (l_as: INVARIANT_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.begin
			l_text_formatter_decorator.set_new_line_between_tokens
			if l_as.assertion_list /= Void then
				invariant_format_assertions (l_as.assertion_list)
			end
			l_text_formatter_decorator.commit
		end

	process_interval_as (l_as: INTERVAL_AS)
		local
			l_feat: E_FEATURE
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
				-- Only ID_AS can be a constant access in current class.
			if attached {ID_AS} l_as.lower as l_id then
				l_feat := feature_from_id_as (l_id)
			end
			if l_feat /= Void then
				l_feat.append_name (l_text_formatter_decorator)
			else
				l_as.lower.process (Current)
			end
			if l_as.upper /= Void then
				if not expr_type_visiting then
					l_text_formatter_decorator.set_without_tabs
					l_text_formatter_decorator.process_symbol_text (ti_dotdot)
				end
				l_feat := Void
				if attached {ID_AS} l_as.upper as l_id then
					l_feat := feature_from_id_as (l_id)
				end
				if l_feat /= Void then
					l_feat.append_name (l_text_formatter_decorator)
				else
					l_as.upper.process (Current)
				end
			end
		end

	process_index_as (l_as: INDEX_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if l_as.tag /= Void then
				l_text_formatter_decorator.process_indexing_tag_text (l_as.tag.name_32)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_colon)
				l_text_formatter_decorator.put_space
			end
			l_text_formatter_decorator.set_in_indexing_clause (True)
			l_text_formatter_decorator.search_eis_entry_in_note_clause (l_as, current_class.original_class, source_feature)
			l_text_formatter_decorator.process_filter_item (f_indexing_content, True)
			l_text_formatter_decorator.set_space_between_tokens
			l_text_formatter_decorator.set_separator (ti_comma)
			l_as.index_list.process (Current)
			l_text_formatter_decorator.process_filter_item (f_indexing_content, False)
			l_text_formatter_decorator.set_in_indexing_clause (False)
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.set_separator (ti_comma)
			l_text_formatter_decorator.set_space_between_tokens
			l_as.clients.process (Current)
			l_text_formatter_decorator.put_space
			safe_process (l_as.features)
		end

	process_elseif_as (l_as: ELSIF_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			put_breakable
			l_text_formatter_decorator.process_keyword_text (ti_elseif_keyword, Void)
			l_text_formatter_decorator.put_space
			l_text_formatter_decorator.new_expression
			l_as.expr.process (Current)
			l_text_formatter_decorator.put_space
			l_text_formatter_decorator.set_without_tabs
			l_text_formatter_decorator.process_keyword_text (ti_then_keyword, Void)
			l_text_formatter_decorator.put_new_line
			if l_as.compound /= Void then
				l_text_formatter_decorator.indent
				format_compound (l_as.compound)
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
		end

	process_elseif_expression_as (l_as: ELSIF_EXPRESSION_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			put_breakable
			l_text_formatter_decorator.process_keyword_text (ti_elseif_keyword, Void)
			l_text_formatter_decorator.put_space
			l_text_formatter_decorator.new_expression
			l_as.condition.process (Current)
			l_text_formatter_decorator.put_space
			l_text_formatter_decorator.set_without_tabs
			l_text_formatter_decorator.process_keyword_text (ti_then_keyword, Void)
			l_text_formatter_decorator.put_new_line
			l_text_formatter_decorator.indent
			put_breakable
			l_as.expression.process (Current)
			l_text_formatter_decorator.put_new_line
			l_text_formatter_decorator.exdent
		end

	process_create_as (l_as: CREATE_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.begin
			l_text_formatter_decorator.process_keyword_text (ti_create_keyword, Void)
			l_text_formatter_decorator.put_space
			if l_as.clients /= Void then
				l_as.clients.process (Current)
			end
			l_text_formatter_decorator.put_new_line
			if l_as.feature_list /= Void then
				l_text_formatter_decorator.indent
				if l_text_formatter_decorator.is_flat_short then
					format_creation_features (l_as.feature_list)
				else
					l_text_formatter_decorator.set_new_line_between_tokens
					l_text_formatter_decorator.set_separator (ti_comma)
					l_as.feature_list.process (Current)
					l_text_formatter_decorator.put_new_line
					l_text_formatter_decorator.put_new_line
				end
			end
			l_text_formatter_decorator.commit
		end

	process_client_as (l_as: CLIENT_AS)
		local
			temp: STRING
			cluster: CONF_GROUP
			client_classi: CLASS_I
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			cluster := system.class_of_id (current_class.class_id).group
			l_text_formatter_decorator.begin
			l_text_formatter_decorator.process_symbol_text (ti_l_curly)
			l_text_formatter_decorator.set_separator (ti_comma)
			l_text_formatter_decorator.set_space_between_tokens
			from
				l_as.clients.start
			until
				l_as.clients.after
			loop
				temp := l_as.clients.item.name_8
				client_classi := universe.safe_class_named (temp, cluster)
				if client_classi /= Void then
					l_text_formatter_decorator.put_classi (client_classi)
				else
					l_text_formatter_decorator.add (temp.as_upper)
				end
				l_as.clients.forth
				if not l_as.clients.after then
					l_text_formatter_decorator.set_without_tabs
					l_text_formatter_decorator.process_symbol_text (ti_comma)
					l_text_formatter_decorator.put_space
				end
			end
			l_text_formatter_decorator.set_without_tabs
			l_text_formatter_decorator.process_symbol_text (ti_r_curly)
			l_text_formatter_decorator.commit
		end

	process_case_abstraction
		(a: CASE_ABSTRACTION_AS [detachable AST_EIFFEL];
		format_content: PROCEDURE)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_text_formatter_decorator.process_keyword_text (ti_when_keyword, Void)
			l_text_formatter_decorator.put_space
			l_text_formatter_decorator.set_separator (ti_comma)
			l_text_formatter_decorator.set_space_between_tokens
			a.interval.process (Current)
			l_text_formatter_decorator.put_space
			l_text_formatter_decorator.set_without_tabs
			l_text_formatter_decorator.process_keyword_text (ti_then_keyword, Void)
			l_text_formatter_decorator.put_new_line
			if attached a.content as c then
				l_text_formatter_decorator.indent
				format_content.call
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.exdent
			end
		end

	process_case_as (a: CASE_AS)
		do
			process_case_abstraction (a, agent (c: detachable EIFFEL_LIST [INSTRUCTION_AS])
				do
					if attached c then
						format_compound (c)
					end
				end (a.compound))
		end

	process_case_expression_as (a: CASE_EXPRESSION_AS)
		do
			process_case_abstraction (a, agent (c: detachable EXPR_AS)
				do
					if c /= Void then
						put_breakable
						c.process (Current)
					end
				end (a.content))
		end

	process_ensure_as (l_as: ENSURE_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			format_assert_list_as (l_as, ti_ensure_keyword)
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			format_assert_list_as (l_as, ti_ensure_then_keyword)
		end

	process_require_as (l_as: REQUIRE_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			format_assert_list_as (l_as, ti_require_keyword)
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			format_assert_list_as (l_as, ti_require_else_keyword)
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.feature_name.process (Current)
			if l_as.is_creation_procedure then
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
			else
				l_text_formatter_decorator.process_symbol_text (ti_colon)
				l_text_formatter_decorator.put_space
			end
			l_text_formatter_decorator.process_symbol_text (ti_l_curly)
			l_text_formatter_decorator.indent
			l_as.conversion_types.process (Current)
			l_text_formatter_decorator.exdent
			l_text_formatter_decorator.process_symbol_text (ti_r_curly)
			if l_as.is_creation_procedure then
				l_text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
			end
		end

	process_void_as (l_as: VOID_AS)
		do
			if not expr_type_visiting then
				text_formatter_decorator.process_keyword_text (ti_void, Void)
			end
			last_type := detachable_none_type
		end

	process_type_list_as (l_as: TYPE_LIST_AS)
		do
			process_eiffel_list (l_as)
		end

	process_list_dec_list_as (l_as: LIST_DEC_LIST_AS)
		do
			process_eiffel_list (l_as)
		end

	process_type_dec_list_as (l_as: TYPE_DEC_LIST_AS)
		do
			process_eiffel_list (l_as)
		end

	process_convert_feat_list_as (l_as: CONVERT_FEAT_LIST_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

	process_class_list_as (l_as: CLASS_LIST_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

	process_parent_list_as (l_as: PARENT_LIST_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

	process_local_dec_list_as (l_as: LOCAL_DEC_LIST_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.locals.process (Current)
		end

	process_formal_argu_dec_list_as (l_as: FORMAL_ARGU_DEC_LIST_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.arguments.process (Current)
		end

	process_key_list_as (l_as: KEY_LIST_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.keys.process (Current)
		end

	process_delayed_actual_list_as (l_as: DELAYED_ACTUAL_LIST_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.operands.process (Current)
		end

	process_parameter_list_as (l_as: PARAMETER_LIST_AS)
		do
				-- Add indentation in case some arguments are multi-line.
			text_formatter_decorator.indent
			l_as.parameters.process (Current)
			text_formatter_decorator.exdent
		end

	process_named_expression_as (a_as: NAMED_EXPRESSION_AS)
			-- <Precursor>
		local
			t: like last_type
		do
			put_breakable
			a_as.expression.process (Current)
			t := last_type
			if not expr_type_visiting then
				text_formatter_decorator.put_space
				text_formatter_decorator.process_keyword_text (ti_as_keyword, Void)
				text_formatter_decorator.put_space
			end
			a_as.name.process (Current)
				-- Remember separate instruction argument.
			if attached t then
				separate_argument_locals_for_current_scope.force (t, a_as.name.name_32)
			end
			last_type := Void
		end

	process_rename_clause_as (l_as: RENAME_CLAUSE_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_export_clause_as (l_as: EXPORT_CLAUSE_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_undefine_clause_as (l_as: UNDEFINE_CLAUSE_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_redefine_clause_as (l_as: REDEFINE_CLAUSE_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_select_clause_as (l_as: SELECT_CLAUSE_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_formal_generic_list_as (l_as: FORMAL_GENERIC_LIST_AS)
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

	process_iteration_as (l_as: ITERATION_AS)
		do
			append_iteration_as (
				l_as,
				agent
					do
						text_formatter_decorator.put_new_line
						text_formatter_decorator.indent
					end,
				agent
					do
						text_formatter_decorator.exdent
						text_formatter_decorator.put_new_line
					end
			)
		end

feature -- Expression visitor

	expr_type (a_expr: EXPR_AS): TYPE_A
			-- Type of `a_expr'
			-- `last_type' is not modified.
		local
			l_last_type: like last_type
			l_last_class: like last_class
			l_ex_visiting: BOOLEAN
		do
			l_ex_visiting := expr_type_visiting
			expr_type_visiting := True
			l_last_type := last_type
			l_last_class := last_class
			last_type := Void
			a_expr.process (Current)
			Result := last_type
			last_type := l_last_type
			last_class := l_last_class
			expr_type_visiting := l_ex_visiting
			if not has_error_internal and Result = Void then
				has_error_internal := True
				set_error_message ("Expression type evaluating failed.")
			end
		ensure
			no_error_implies_result_is_not_void: not has_error_internal implies Result /= Void
		end

	expr_types (a_exprs: EIFFEL_LIST [EXPR_AS]): ARRAYED_LIST [TYPE_A]
			-- Types of `expr_types'
			-- `last_type' is not modified.
		local
			i, l_count: INTEGER
			l_last_type: like last_type
			l_last_class: like last_class
			l_expr_visiting: BOOLEAN
		do
			l_expr_visiting := expr_type_visiting
			expr_type_visiting := True
			l_last_type := last_type
			l_last_class := last_class
			last_type := Void
			create Result.make (a_exprs.count)
			from
				i := 1
				l_count := a_exprs.count
			until
				i > l_count
			loop
				a_exprs.i_th (i).process (Current)
				Result.extend (last_type)
				i := i + 1
			end
			last_type := l_last_type
			last_class := l_last_class
			expr_type_visiting := l_expr_visiting
		end

feature {NONE} -- Expression visitor

	expr_type_visiting: BOOLEAN
			-- Visiting only for expression type checking.

feature {NONE} -- Implementation: helpers

	append_feature_by_id (a_feature_name: FEATURE_NAME; a_type: TYPE_A; a_type_set: TYPE_SET_A)
			-- Append feature.
			--
			-- `a_feature_name_id' is the `NAMES_HEAP' ID of the feature name.
			-- `l_type' is the type where we lookup the feature
			--| The code has 2 arguments as it suites the actual code better. (May be changed.)
		require
			not_both_void: a_type /= Void or a_type_set /= Void
		local
			l_feat: E_FEATURE
			l_result: TUPLE [feature_item: E_FEATURE; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]
		do
			if a_type_set /= Void then
				l_result := a_type_set.e_feature_state_by_name_id (a_feature_name.feature_name.name_id)
				l_feat := l_result.feature_item
			elseif a_type /= Void then
				if not a_type.is_formal then
					l_feat := a_type.base_class.feature_with_name_id (a_feature_name.feature_name.name_id)
				end
			end

			if l_feat /= Void then
				text_formatter_decorator.process_feature_text (a_feature_name.visual_name_32, l_feat, False)
			else
					-- TODO: check if Void is ok for now [2017-04-15].
				text_formatter_decorator.process_local_text (Void, a_feature_name.visual_name_32)
			end
		end

	append_format_multilined (s: STRING_32; indentable: BOOLEAN)
		require
			string_not_void: s /= Void
			string_not_empty: not s.is_empty
			context_not_void: text_formatter_decorator /= Void
		local
			l: INTEGER
			n: INTEGER
			m: INTEGER
			l_depth: INTEGER
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if indentable then
				l_text_formatter_decorator.indent
			else
				l_depth := l_text_formatter_decorator.indent_depth
				l_text_formatter_decorator.set_indent_depth (0)
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
				l_text_formatter_decorator.put_string_item (s.substring (n, m - 1))
				l_text_formatter_decorator.put_new_line
				n := m + 1
			end
			if indentable then
				l_text_formatter_decorator.exdent
			else
				l_text_formatter_decorator.set_indent_depth (l_depth)
			end
		end

	format_compound (lc: EIFFEL_LIST [INSTRUCTION_AS])
		require
			lc_not_void: lc /= Void
		local
			semicolon_candidate: BOOLEAN
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.begin
			from
				lc.start
			until
				lc.after
			loop
				has_error_internal := False
				reset_last_class_and_type
				l_text_formatter_decorator.new_expression
				l_text_formatter_decorator.begin
				lc.item.process (Current)
				l_text_formatter_decorator.commit
				semicolon_candidate := True
				lc.forth
				if not lc.after then
					if semicolon_candidate and then lc.item.starts_with_parenthesis then
						l_text_formatter_decorator.process_symbol_text (ti_semi_colon)
					end
					l_text_formatter_decorator.put_new_line
				end
			end
			l_text_formatter_decorator.commit
		end

	Carriage_return_char: CHARACTER = '%N'

	format_header (l_as: CLASS_AS)
		require
			l_as_not_void: l_as /= Void
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.process_filter_item (f_class_header, True)
			if l_as.is_frozen then
				l_text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
				l_text_formatter_decorator.put_space
			end
			if l_as.is_expanded then
				l_text_formatter_decorator.process_keyword_text (ti_expanded_keyword, Void)
				l_text_formatter_decorator.put_space
			elseif l_as.is_deferred then
				l_text_formatter_decorator.process_keyword_text (ti_deferred_keyword, Void)
				l_text_formatter_decorator.put_space
			end
			if l_as.is_once then
				l_text_formatter_decorator.process_keyword_text (ti_once_keyword, Void)
				l_text_formatter_decorator.put_space
			end
			l_text_formatter_decorator.process_keyword_text (ti_class_keyword, Void)
			l_text_formatter_decorator.put_space
			if l_text_formatter_decorator.is_short then
				l_text_formatter_decorator.process_keyword_text (ti_interface_keyword, Void)
			end
			l_text_formatter_decorator.indent
			l_text_formatter_decorator.put_new_line
			l_text_formatter_decorator.put_classi (current_class.lace_class)
			l_text_formatter_decorator.process_filter_item (f_class_header, False)
			l_text_formatter_decorator.exdent
			format_generics (l_as.generics)
			l_text_formatter_decorator.put_new_line
		end

	format_generics (l_as: EIFFEL_LIST [FORMAL_DEC_AS])
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			if l_as /= Void then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_l_bracket)
				l_text_formatter_decorator.set_space_between_tokens
				l_text_formatter_decorator.set_separator (ti_comma)
				l_as.process (Current)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_r_bracket)
			end
		end

	format_convert_clause (l_as: EIFFEL_LIST [CONVERT_FEAT_AS])
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			if l_as /= Void then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.process_keyword_text (ti_convert_keyword, Void)
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.set_new_line_between_tokens
				l_text_formatter_decorator.set_separator (ti_comma)
				l_as.process (Current)
				l_text_formatter_decorator.set_separator (ti_empty)
				l_text_formatter_decorator.exdent
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.put_new_line
			end
		end

	features_simple_format (l_as: EIFFEL_LIST [FEATURE_CLAUSE_AS])
		require
			l_as_not_void: l_as /= Void
		local
			i, l_count: INTEGER
			fc, next_fc: FEATURE_CLAUSE_AS
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.begin
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
					l_text_formatter_decorator.put_separator
				end
				l_text_formatter_decorator.new_expression
				l_text_formatter_decorator.begin
				i := i + 1
				if i <= l_count then
					next_fc := l_as.i_th (i)
				end
				fc.process (Current)
				fc := next_fc
				l_text_formatter_decorator.commit
			end
			l_text_formatter_decorator.commit
		end

	format_clause (a_keyword: STRING; a_clause: EIFFEL_LIST [AST_EIFFEL]; has_separator: BOOLEAN)
		require
			a_keyword_not_void: a_keyword /= Void
			a_clause_not_void: a_clause /= Void
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.indent
			l_text_formatter_decorator.put_new_line
			l_text_formatter_decorator.process_keyword_text (a_keyword, Void)
			l_text_formatter_decorator.indent
			l_text_formatter_decorator.put_new_line
			l_text_formatter_decorator.set_new_line_between_tokens
			if has_separator then
				l_text_formatter_decorator.set_separator (ti_comma)
			else
				l_text_formatter_decorator.set_separator (ti_empty)
			end
			a_clause.process (Current)
			l_text_formatter_decorator.exdent
			l_text_formatter_decorator.exdent
		end

	format_tagged_as (l_as: TAGGED_AS; hide_breakable_marks: BOOLEAN)
		require
			l_as_not_void: l_as /= Void
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.new_expression
			l_text_formatter_decorator.begin
			if not hide_breakable_marks then
				put_breakable
			end
			if attached l_as.tag then
				l_text_formatter_decorator.process_assertion_tag_text (l_as.tag.name_32)
				l_text_formatter_decorator.set_without_tabs
				l_text_formatter_decorator.process_symbol_text (ti_colon)
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.indent
			end
			l_text_formatter_decorator.new_expression
			if attached l_as.expr as e then
				e.process (Current)
			elseif l_as.is_class then
				l_text_formatter_decorator.process_keyword_text (ti_class_keyword, Void)
			end
			l_text_formatter_decorator.commit
			if attached l_as.tag then
				l_text_formatter_decorator.exdent
			end
		end

	invariant_format_assertions (l_as: EIFFEL_LIST [TAGGED_AS])
		require
			l_as_not_vod: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			from
				l_text_formatter_decorator.begin
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				l_text_formatter_decorator.begin
				if not_first then
					l_text_formatter_decorator.put_separator
				end
				l_text_formatter_decorator.new_expression
				l_as.i_th (i).process (Current)
				not_first := True
				l_text_formatter_decorator.commit
				i := i + 1
			end
			if not_first then
				l_text_formatter_decorator.exdent
			end
			l_text_formatter_decorator.commit
		end

	invariant_simple_format_assertions (l_as: EIFFEL_LIST [TAGGED_AS])
		require
			l_as_not_vod: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.begin
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				if not_first then
					l_text_formatter_decorator.put_separator
				end
				l_text_formatter_decorator.new_expression
				l_as.i_th (i).process (Current)
				not_first := True
				i := i + 1
			end
			l_text_formatter_decorator.commit
		end

	format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]; hide_breakable_marks: BOOLEAN)
		require
			l_as_not_void: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
			l_text_formatter_decorator: like text_formatter_decorator
			l_tagged_as: TAGGED_AS
		do
			l_text_formatter_decorator := text_formatter_decorator
			from
				l_text_formatter_decorator.begin
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				if not_first then
					l_text_formatter_decorator.put_separator
				end
				l_text_formatter_decorator.begin
				l_text_formatter_decorator.new_expression
				l_tagged_as := l_as.i_th (i)
				if
					hide_breakable_marks
					or l_tagged_as.is_class
				then
					format_tagged_as (l_tagged_as, True)
				else
					l_tagged_as.process (Current)
				end
				not_first := True
				l_text_formatter_decorator.commit
				i := i + 1
			end
			if not_first then
				l_text_formatter_decorator.exdent
				l_text_formatter_decorator.put_new_line
			end
			l_text_formatter_decorator.commit
		end

	simple_format_assertions (l_as: EIFFEL_LIST [TAGGED_AS])
		require
			l_as_not_void: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.begin
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				if not_first then
					l_text_formatter_decorator.put_separator
				end
				l_text_formatter_decorator.new_expression
				l_text_formatter_decorator.begin
				l_as.i_th (i).process (Current)
				l_text_formatter_decorator.commit
				not_first := True
				i := i + 1
			end
			if l_count > 0 then
				l_text_formatter_decorator.put_new_line
			end
			l_text_formatter_decorator.commit
		end

	format_assert_list_as (l_as: ASSERT_LIST_AS; a_keyword: STRING)
		require
			l_as_not_void: l_as /= Void
			a_keyword_not_void: a_keyword /= Void
		local
			source_cl, target_cl: CLASS_C
			l_text_formatter_decorator: like text_formatter_decorator
		do
			if attached l_as.full_assertion_list as l_assertions then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.begin
				l_text_formatter_decorator.process_keyword_text (a_keyword, Void)
				source_cl := l_text_formatter_decorator.source_class
				target_cl := current_class
				if source_cl /= target_cl then
					l_text_formatter_decorator.put_space
					l_text_formatter_decorator.process_comment_text (ti_dashdash, Void)
					l_text_formatter_decorator.put_space
					l_text_formatter_decorator.process_comment_text ("from ", Void)
					l_text_formatter_decorator.put_classi (source_cl.lace_class)
				end
				l_text_formatter_decorator.indent
				l_text_formatter_decorator.put_new_line
				l_text_formatter_decorator.set_new_line_between_tokens
				format_assertions (l_assertions, False)
				l_text_formatter_decorator.exdent
				l_text_formatter_decorator.set_first_assertion (False)
				l_text_formatter_decorator.commit
			end
		end

	format_creation_features (a_list: EIFFEL_LIST [FEATURE_NAME])
		require
			list_not_void: a_list /= Void
		local
			i, l_count: INTEGER
			creators: STRING_TABLE [FEATURE_ADAPTER]
			feat_adapter: FEATURE_ADAPTER
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			l_text_formatter_decorator.begin
			creators := l_text_formatter_decorator.format_registration.creation_table
			from
				i := 1
				l_count := a_list.count
			until
				i > l_count
			loop
				feat_adapter := creators.item (a_list [i].feature_name.name_32)
				if feat_adapter /= Void then
					feat_adapter.format (l_text_formatter_decorator)
					l_text_formatter_decorator.put_new_line
				end
				i := i + 1
			end
			l_text_formatter_decorator.commit
		end

	current_assigner_feature: E_FEATURE
		local
			l_feature: FEATURE_I
		do
			l_feature := feature_from_ancestors (source_class, current_feature.assigner_name_id)
			Result := feature_in_class (current_class, l_feature.rout_id_set)
		end

	feature_from_id_as (a_as: ID_AS): E_FEATURE
			-- Feature in current class with written name `a_as'.
		require
			a_as_not_void: a_as /= Void
		local
			l_feature: FEATURE_I
		do
			l_feature := feature_from_ancestors (source_class, a_as.name_id)
			if l_feature /= Void then
				Result := feature_in_class (current_class, l_feature.rout_id_set)
			end
		end

	feature_from_ancestors (a_current_class: CLASS_C; a_name_id: INTEGER): FEATURE_I
		require
			a_current_class_not_void: a_current_class /= Void
		do
			Result := a_current_class.feature_table.item_id (a_name_id)
		end

	feature_from_type_set (a_type_set: TYPE_SET_A;	a_id_set: ID_SET): LIST[TUPLE[feature_item: E_FEATURE; class_type: RENAMED_TYPE_A]]
			-- Feature with `a_id_set' in `a_class_c'
		require
			a_type_set_not_void: a_type_set /= Void
			a_id_set_not_void: a_id_set /= Void
		do
			if not has_error_internal and a_id_set.first = 0 then
				has_error_internal := True
				set_error_message ("Feature with routine id of 0!!!")
			else
				if not has_error_internal then
					Result := a_type_set.e_feature_list_by_rout_id (a_id_set.first)
				end
			end
			if not has_error_internal and Result.is_empty then
				has_error_internal := True
				set_error_message ("Feature with routine id " + a_id_set.first.out + " could not be found.")
			end
		ensure
			feature_in_class_not_void: not has_error_internal implies (Result /= Void and then not Result.is_empty)
		end

	feature_in_class (a_class_c: CLASS_C; a_id_set: ID_SET): E_FEATURE
			-- Feature with `a_id_set' in `a_class_c'
		require
			a_classs_c_not_void: a_class_c /= Void
			a_id_set_not_void: a_id_set /= Void
		do
			if not has_error_internal and (a_id_set.first <= 0) then
				has_error_internal := True
				set_error_message ("Feature with routine id of 0!!!")
			else
				if not has_error_internal then
					Result := a_class_c.feature_with_rout_id (a_id_set.first)
				end
			end
			if not has_error_internal and Result = Void then
				has_error_internal := True
				set_error_message ("Feature with routine id " + a_id_set.first.out + " could not be found.")
			end
		ensure
			feature_in_class_not_void: not has_error_internal implies Result /= Void
		end

	type_feature_i_from_ancestor (a_ancestor: CLASS_C; a_formal: FORMAL_A): TYPE_FEATURE_I
			-- Formal constraint class from `a_ancestor'
		do
			Result := a_ancestor.formal_at_position (a_formal.position)
		end

	type_from_ancestor (a_ancestor: CLASS_C; a_formal: FORMAL_A): TYPE_A
			-- Type from ancestor
		local
			l_feature_i: TYPE_FEATURE_I
		do
				-- Get TYPE_FEATURE_I from ancestor.
			l_feature_i := type_feature_i_from_ancestor (a_ancestor, a_formal)
				-- Find its version in descendant.
			l_feature_i := current_class.generic_features.item (l_feature_i.rout_id_set.first)
			check
				l_feature_i_not_void: l_feature_i /= Void
			end
			Result := l_feature_i.type
		end

	formal_constraint_class (a_type_feature_i: TYPE_FEATURE_I): CLASS_C
			-- Formal constraint class from `a_type_feature_i'.
		local
			l_type: TYPE_A
		do
			l_type := a_type_feature_i.type
			if attached {FORMAL_A} l_type as l_formal then
				check
					current_class_has_generics: current_class.generics /= Void
				end
				if attached {FORMAL_CONSTRAINT_AS} current_class.generics.i_th (l_formal.position) as l_formal_dec then
					Result := l_formal_dec.constraint_type (current_class).type.base_class
				else
					check is_formal_constraint: False end
				end
			else
				Result := l_type.base_class
			end
		end

	strip_type: GEN_TYPE_A
			-- Strip type
		require
			any_compiled: system.any_class.is_compiled
			array_compiled: system.array_class.is_compiled
		local
			generics: ARRAYED_LIST [TYPE_A]
		once
			create generics.make (1)
			generics.extend (create {CL_TYPE_A}.make (system.any_id))
			create Result.make (system.array_id, generics)
				-- Type of a strip is a frozen array.
			Result.set_frozen_mark
		end

	string_type: CL_TYPE_A
			-- Actual string type
		once
			Result := system.string_8_class.compiled_class.actual_type
		end

	check_type (a_type: TYPE_AS)
			-- Evaluate `a_type' into a TYPE_A instance if valid.
			-- If not valid, raise a compiler error and return Void.
		require
			a_type_not_void: a_type /= Void
		local
			l_type: TYPE_A
		do
				-- Convert TYPE_AS into TYPE_A in the context of `source_class'.
			l_type := type_a_generator.evaluate_type (a_type, source_class)

				-- An error occurs when a class was renamed.
			if not has_error_internal and l_type = Void then
				has_error_internal := True
				set_error_message ("Type evaluating failed.")
			end

			if not has_error_internal then
				-- If `source_feature' is Void, it means that we are outside of
				-- a feature, and therefore `l_type' must be valid because it should
				-- not have any anchors in `a_type'.
				if source_feature /= Void then
						-- Perform simple update of TYPE_A in context of `source_class'.
					type_a_checker.init_with_feature_table (source_feature, source_class.feature_table, Void)
					l_type := type_a_checker.solved (l_type, a_type)

					if source_class /= current_class then
							-- We need to update `l_type' to the context of `current_class'
						l_type := l_type.instantiation_in (current_class.actual_type, source_class.class_id)
					end
				else
					check
						l_type_is_valid: l_type.is_valid
					end
				end
			end
				-- Update `last_type' with found type.
			last_type := l_type
		end

	agent_type (l_as: ROUTINE_CREATION_AS): GEN_TYPE_A
			-- Compute type of `l_as'.
		require
			l_as_not_void: l_as /= Void
		local
			l_target_type: TYPE_A;
			l_arg_type:TYPE_A
			l_generics: ARRAYED_LIST [TYPE_A]
			l_feat_args: E_FEATURE_ARGUMENTS
			l_oargtypes: ARRAYED_LIST [TYPE_A]
			l_tuple: TUPLE_TYPE_A
			l_count, l_idx, l_oidx: INTEGER
			l_operand: OPERAND_AS
			l_is_open: BOOLEAN
			l_result_type: GEN_TYPE_A
			l_actual_target_type: TYPE_A
			l_feat: E_FEATURE
			l_query_type: detachable TYPE_A
		do
			l_feat := feature_in_class (system.class_of_id (l_as.class_id), l_as.routine_ids)
			if not has_error_internal then
				l_query_type := l_feat.type
				if attached l_query_type then
					l_query_type := l_query_type.actual_type
				end
				if not l_feat.has_return_value then
						-- generics are: open_types
					create l_generics.make (1)
					create l_result_type.make (System.procedure_class_id, l_generics)
					l_query_type := Void
				elseif l_query_type.is_boolean then
						-- generics are: open_types
					create l_generics.make (1)
					create l_result_type.make (System.predicate_class_id, l_generics)
					l_query_type := Void
				else
						-- generics are: open_types, result_type
					create l_generics.make (2)
					create l_result_type.make (System.function_class_id, l_generics)
				end
					-- The type of an agent is frozen.				
				l_result_type.set_frozen_mark

				if l_as.target = Void then
						-- Target is the closed operand `Current'.
					l_target_type := current_class.actual_type
				else
					l_as.target.process (Current)
					l_target_type := last_type
				end

				l_actual_target_type := l_target_type.actual_type

				l_feat_args := l_feat.arguments

					-- Compute `operands_tuple' and type of TUPLE needed to determine current
					-- ROUTINE type.

					-- Create `l_oargtypes'. But first we need to find the `l_count', number
					-- of open operands.
				if l_as.target /= Void and then l_as.target.is_open then
						-- No target is specified, or just a class type is specified.
						-- Therefore there is at least one argument
					l_count := 1
					l_oidx := 2
				else
						-- Target was specified
					l_count := 0
					l_oidx  := 1
				end

					-- Compute number of open positions.
				if l_as.operands /= Void then
					from
						l_as.operands.start
					until
						l_as.operands.after
					loop
						if l_as.operands.item.is_open then
							l_count := l_count + 1
						end
						l_as.operands.forth
					end
				else
					if l_feat_args /= Void then
						l_count := l_count + l_feat_args.count
					end
				end

					-- Create `oargytpes' with `l_count' parameters. This array
					-- is used to create current ROUTINE type.
				create l_oargtypes.make (l_count)

				if l_count > 0 and then l_oidx > 1 then
						-- Target is open, so insert it.
					l_oargtypes.extend (l_target_type)
				end

					-- Create argument types
				if l_feat_args /= Void then
					from
							-- `l_idx' is 2, because at position `1' we have target of call.
						l_idx := 2
						l_feat_args.start
						if l_as.operands /= Void then
							l_as.operands.start
						end
					until
						l_feat_args.after
					loop
						l_arg_type := Void

							-- Let's find out if this is really an open operand.
						if l_as.operands /= Void then
							l_operand := l_as.operands.item
							if l_operand.is_open then
								l_is_open := True
								if l_operand.class_type /= Void then
									l_operand.process (Current)
									l_arg_type := last_type
								end
							else
								l_is_open := False
							end
						else
							l_is_open := True
						end

							-- Get type of operand.
						if l_is_open then
							if l_arg_type = Void then
								l_arg_type := l_feat_args.item.actual_type
							end
						else
							l_arg_type := l_feat_args.item.actual_type
						end

							-- Evaluate type of operand in current context
						l_arg_type := l_arg_type.instantiation_in (l_actual_target_type, l_as.class_id).deep_actual_type

							-- If it is open insert it in `l_oargtypes'
						if l_is_open then
							l_oargtypes.extend (l_arg_type)
							l_oidx := l_oidx + 1
						end

						l_idx := l_idx + 1
						l_feat_args.forth

						if l_as.operands /= Void then
							l_as.operands.forth
						end
					end
				end

					-- Create open argument type tuple
				create l_tuple.make (System.tuple_id, l_oargtypes)
				l_tuple.set_frozen_mark

					-- Insert it as argument generic parameter of ROUTINE.
				l_generics.extend (l_tuple)

				if attached l_query_type then
						-- Insert it as result generic parameter of ROUTINE.
					l_generics.extend (l_query_type)
				end
				Result := l_result_type
			end
		ensure
			agent_type_not_void_if_no_error: not has_error_internal implies Result /= Void
		end

	put_breakable
			-- Puts a breakable if needed.
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			l_text_formatter_decorator := text_formatter_decorator
			if l_text_formatter_decorator.is_with_breakable then
				l_text_formatter_decorator.put_breakable
			end
		end

	append_iteration_as (l_as: ITERATION_AS; indent: PROCEDURE; exdent: PROCEDURE)
		local
			l_text_formatter_decorator: like text_formatter_decorator
		do
			if not expr_type_visiting then
				l_text_formatter_decorator := text_formatter_decorator
				l_text_formatter_decorator.process_keyword_text (ti_across_keyword, Void)
				indent.call (Void)
				l_text_formatter_decorator.new_expression
				put_breakable
			end
			process_loop_iteration_expression (l_as)
			if not expr_type_visiting then
				l_text_formatter_decorator.put_space
				l_text_formatter_decorator.process_keyword_text
					(if l_as.is_restricted and then current_class.lace_class.is_explicit_iteration_cursor then ti_is_keyword else ti_as_keyword end, Void)
				l_text_formatter_decorator.put_space
				l_as.identifier.process (Current)
				exdent.call (Void)
			end
		end

	process_loop_iteration_expression (a: ITERATION_AS)
			-- Process loop iteration expression of iteration part `a` and record type information about its cursor variable for future use.
		local
			old_expr_type_visiting: BOOLEAN
		do
			a.expression.process (Current)
				-- Compute type of the cursor and associate cursor name with this type.
			if attached last_type then
				context.find_iteration_classes (source_class)
				if
					attached last_type.base_class as b and then
					attached context.iterable_class as i and then
					attached i.feature_of_name_id (names_heap.new_cursor_name_id) as n and then
					attached b.feature_of_rout_id (n.rout_id_set.first) as f and then
					attached f.type.instantiation_in (last_type, last_type.base_class.class_id) as t
				then
					object_test_locals_for_current_feature.force (t.as_attached_in (current_class), a.identifier.name_32)
						-- The cursor variable type depends on the loop kind. If it is restricted,
						-- the cursor type shoud be replaced with the type of feature "item".
					if a.is_restricted then
						old_expr_type_visiting := expr_type_visiting
						expr_type_visiting := True
						a.item.process (Current)
						expr_type_visiting := old_expr_type_visiting
						if attached last_type as item_type then
								-- Use the item type instead.
							object_test_locals_for_current_feature.force (item_type, a.identifier.name_32)
						end
					end
				end
			end
		end

	format_local_with_id (a_id: INTEGER)
			-- Format local with id `a_id'.
		do
			is_local_id := True
			;(create {ID_AS}.initialize_from_id (a_id)).process (Current)
			is_local_id := False
		end

	format_local_with_as (a: ID_AS)
			-- Format local with name `a`.
		do
			is_local_id := True
			a.process (Current)
			is_local_id := False
		end

	format_feature_name (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN)
			-- Process feature text
		do
			text_formatter_decorator.process_feature_text (text, a_feature, a_quote)
		end

	is_local_id: BOOLEAN
			-- Is formatting local ids?

invariant
	text_formatter_not_void: text_formatter_decorator /= Void
	error_message_not_void: error_message /= Void
	has_error_implies_error_message_not_empty: has_error implies not error_message.is_empty
	locals_for_current_feature_not_void: locals_for_current_feature /= Void
	object_test_locals_for_current_feature_not_void: object_test_locals_for_current_feature /= Void
	separate_argument_locals_for_current_scope_not_void: separate_argument_locals_for_current_scope /= Void

note
	ca_ignore: "CA033", "CA033: very long class"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
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
