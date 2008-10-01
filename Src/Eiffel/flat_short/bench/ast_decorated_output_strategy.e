indexing
	description: "Process ast to decorated output text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

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

create
	make, make_for_inline_agent

feature {NONE} -- Initialization

	make (a_text_formatter: like text_formatter_decorator) is
		require
			a_text_not_void: a_text_formatter /= Void
		do
			text_formatter_decorator := a_text_formatter
			create locals_for_current_feature.make (10)
			create object_test_locals_for_current_feature.make (0)
			create error_message.make (5)
		end

	make_for_inline_agent (parent_strategy: AST_DECORATED_OUTPUT_STRATEGY; a_as: INLINE_AGENT_CREATION_AS) is
		do
			make (parent_strategy.text_formatter_decorator)
			source_class := parent_strategy.source_class
			current_class := parent_strategy.current_class

			source_feature := source_class.eiffel_class_c.inline_agent_of_rout_id (a_as.inl_rout_id)
			current_feature := source_feature
		end

feature -- Formatting

	format (a_node: AST_EIFFEL) is
		require
			a_node_not_void: a_node /= Void
		do
			a_node.process (Current)
		end

	format_indexing_with_no_keyword (l_as: INDEXING_CLAUSE_AS) is
		require
			l_as_not_void: l_as /= Void
		do
			text_formatter_decorator.set_separator (Void)
			text_formatter_decorator.set_new_line_between_tokens
			process_eiffel_list (l_as)
		end

feature -- Element change

	set_text_formatter (a_text: like text_formatter_decorator) is
		require
			a_text_not_void: a_text /= Void
		do
			text_formatter_decorator := a_text
		ensure
			text_is_not_void: text_formatter_decorator = a_text
		end

	set_source_feature (a_feature: like source_feature) is
		do
			source_feature := a_feature
		ensure
			source_feature_set: source_feature = a_feature
		end

	set_current_feature (a_feature: like current_feature) is
		do
			current_feature := a_feature
		end

	set_source_class (a_class: like source_class) is
		do
			source_class := a_class
		end

	set_current_class (a_class: like current_class) is
		do
			current_class := a_class
		end

	reset_last_class_and_type is
		do
			last_type := Void
			last_class := Void
		end

	wipe_out_error is
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

	has_error: BOOLEAN is
			-- Did an error happen?
		do
			Result := not error_message.is_empty
		end

feature {AST_DECORATED_OUTPUT_STRATEGY} -- Access

	text_formatter_decorator: TEXT_FORMATTER_DECORATOR

	last_actual_local_type: TYPE_A

	locals_for_current_feature: HASH_TABLE [TYPE_A, STRING]
	object_test_locals_for_current_feature: HASH_TABLE [TYPE_A, STRING]

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

	set_error_message (a_str: STRING) is
			-- Setup `error_message'.
		require
			a_str_not_void: a_str /= Void
		do
			error_message.extend (a_str)
		ensure
			error_message_extended: error_message.has (a_str)
		end

feature -- Roundtrip

	process_none_id_as (l_as: NONE_ID_AS) is
		do
			process_id_as (l_as)
		end

	process_typed_char_as (l_as: TYPED_CHAR_AS) is
		do
			process_char_as (l_as)
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS) is
		do
			process_routine_creation_as (l_as)
		end

	process_tilda_routine_creation_as (l_as: TILDA_ROUTINE_CREATION_AS) is
		do
			process_routine_creation_as (l_as)
		end

	process_inline_agent_creation_as (l_as: INLINE_AGENT_CREATION_AS) is
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
		do
			if not expr_type_visiting then
				if l_as.inl_rout_id > 0 then
					text_formatter_decorator.process_keyword_text (ti_agent_keyword, Void)

					create l_strategy.make_for_inline_agent (Current, l_as)

					l_old_feature_comments := text_formatter_decorator.feature_comments
					l_old_arguments := text_formatter_decorator.arguments
					l_old_target_feature := text_formatter_decorator.target_feature
					l_old_source_feature := text_formatter_decorator.source_feature
					l_old_e_feature := text_formatter_decorator.e_feature
					l_old_breakpoint_index := text_formatter_decorator.breakpoint_index

					l_feat := l_strategy.current_feature

					text_formatter_decorator.restore_attributes ( Void, l_as.body.arguments, l_feat,
																  l_strategy.source_feature, l_strategy, 0,
																  l_feat.api_feature (l_feat.written_in))

					l_as.body.process (l_strategy)

					text_formatter_decorator.restore_attributes ( l_old_feature_comments, l_old_arguments,
																  l_old_target_feature, l_old_source_feature, Current,
																  l_old_breakpoint_index, l_old_e_feature)

					if l_as.operands /= Void then
						reset_last_class_and_type
						text_formatter_decorator.process_symbol_text (ti_space)
						text_formatter_decorator.begin
						text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
						text_formatter_decorator.set_separator (ti_comma)
						text_formatter_decorator.set_space_between_tokens
						l_as.operands.process (Current)
						text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
						text_formatter_decorator.commit
					end
					last_type := expr_type (l_as)
				else
					has_error_internal := True
					l_leaf_list	:= match_list_server.item (current_class.class_id)
					if l_leaf_list /= Void and then l_as.is_text_available (l_leaf_list) then
						text_formatter_decorator.add (l_as.text (l_leaf_list))
					else
						text_formatter_decorator.add ("unable_to_show_inline_agent")
					end
				end
			else
				if not has_error_internal then
					last_type := agent_type (l_as)
				end
			end
		end

	process_create_creation_as (l_as: CREATE_CREATION_AS) is
		do
			process_creation_as (l_as)
		end

	process_bang_creation_as (l_as: BANG_CREATION_AS) is
		do
			process_creation_as (l_as)
		end

	process_create_creation_expr_as (l_as: CREATE_CREATION_EXPR_AS) is
		do
			process_creation_expr_as (l_as)
		end

	process_bang_creation_expr_as (l_as: BANG_CREATION_EXPR_AS) is
		do
			process_creation_expr_as (l_as)
		end

feature -- Roundtrip

	process_keyword_as (l_as: KEYWORD_AS) is
		do
		end

	process_symbol_as (l_as: SYMBOL_AS) is
		do
		end

	process_break_as (l_as: BREAK_AS) is
		do
		end

	process_leaf_stub_as (l_as: LEAF_STUB_AS) is
		do
		end

	process_symbol_stub_as (l_as: SYMBOL_STUB_AS) is
		do
		end

	process_keyword_stub_as (l_as: KEYWORD_STUB_AS) is
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
			text_formatter_decorator.process_basic_text (l_as.name)
		end

	process_integer_as (l_as: INTEGER_CONSTANT) is
		do
			if l_as.constant_type /= Void then
				if not expr_type_visiting then
					text_formatter_decorator.process_symbol_text (ti_l_curly)
				end
				l_as.constant_type.process (Current)
				if not expr_type_visiting then
					text_formatter_decorator.process_symbol_text (ti_r_curly)
					text_formatter_decorator.process_basic_text (ti_space)
				end
			end
			if not expr_type_visiting then
				text_formatter_decorator.process_number_text (l_as.string_value)
			end
			last_type := l_as.manifest_type
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
		local
			l_feat: E_FEATURE
			l_rout_ids: ID_SET
			l_type: TYPE_A
			l_static_type: TYPE_A
			l_actual_argument_typs: like expr_types
		do
			if not expr_type_visiting then
				text_formatter_decorator.begin
				text_formatter_decorator.process_symbol_text (ti_l_curly)
			end
			l_as.class_type.process (Current)
			l_static_type := last_type
			if not expr_type_visiting then
				text_formatter_decorator.process_symbol_text (ti_r_curly)
			end
			l_rout_ids := l_as.routine_ids
			check
				l_rout_ids_not_void: l_rout_ids /= Void
				l_class_id_not_zero: l_as.class_id /= 0
			end
			if not has_error_internal then
				l_feat := feature_in_class (system.class_of_id (l_as.class_id), l_rout_ids)
			end
			if not expr_type_visiting then
				text_formatter_decorator.process_symbol_text (ti_dot)
				if not has_error_internal then
					text_formatter_decorator.process_feature_text (l_as.feature_name.name, l_feat, False)
				else
					text_formatter_decorator.process_basic_text (l_as.feature_name.name)
				end
			end
			if l_as.parameter_count > 0 then
				if not expr_type_visiting then
					text_formatter_decorator.put_space
					text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
					text_formatter_decorator.set_separator (ti_comma)
					text_formatter_decorator.set_space_between_tokens
				end
				l_as.parameters.process (Current)
				if not expr_type_visiting then
					text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
				end
			end
			if not expr_type_visiting then
				text_formatter_decorator.commit
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
					if l_type.is_loose then
						last_type := l_type.instantiation_in (l_static_type, last_class.class_id)
					else
						last_type := l_type
					end
				end
			end

		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS) is
		local
			comments: EIFFEL_COMMENTS
			i, l_count: INTEGER
			f: EIFFEL_LIST [FEATURE_AS]
			next_feat, feat: FEATURE_AS
		do
			text_formatter_decorator.process_symbol_text (ti_feature_keyword)
			text_formatter_decorator.put_space
			if l_as.clients /= Void then
				text_formatter_decorator.set_separator (ti_comma)
				text_formatter_decorator.set_space_between_tokens
				l_as.clients.process (Current)
			end
			comments := l_as.comment (text_formatter_decorator.match_list)
			if comments = Void then
				text_formatter_decorator.put_new_line
			else
				if comments.count > 1 then
					text_formatter_decorator.indent
					text_formatter_decorator.indent
					text_formatter_decorator.put_new_line
					text_formatter_decorator.put_comments (comments)
					text_formatter_decorator.exdent
					text_formatter_decorator.exdent
				else
					text_formatter_decorator.put_space
					text_formatter_decorator.put_comments (comments)
				end
			end
			text_formatter_decorator.put_new_line
			text_formatter_decorator.indent
			text_formatter_decorator.put_new_line
			text_formatter_decorator.set_new_line_between_tokens
			text_formatter_decorator.set_separator (ti_empty)
			f := l_as.features
			text_formatter_decorator.begin
			from
				i := 1
				l_count := f.count
				if l_count > 0 then
					feat := f.i_th (1)
				end
			until
				i > l_count
			loop
				text_formatter_decorator.new_expression
				if i > 1 then
					text_formatter_decorator.put_separator
				end
				text_formatter_decorator.new_expression
				text_formatter_decorator.begin
				i := i + 1
				feat.process (Current)
				feat := next_feat
				text_formatter_decorator.commit
			end
			text_formatter_decorator.commit
			text_formatter_decorator.exdent
		end

	process_unique_as (l_as: UNIQUE_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_keyword_text (ti_unique_keyword, Void)
			end
		end

	process_tuple_as (l_as: TUPLE_AS) is
		local
			l_tuple_type: TUPLE_TYPE_A
		do
			if not expr_type_visiting then
				text_formatter_decorator.process_symbol_text (ti_l_bracket)
				text_formatter_decorator.set_separator (ti_comma)
				text_formatter_decorator.set_space_between_tokens
			end
			l_as.expressions.process (Current)
			if not expr_type_visiting then
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_r_bracket)
			end
			if not has_error_internal then
				create l_tuple_type.make (system.tuple_id, expr_types (l_as.expressions))
				last_type := l_tuple_type
			end
		end

	process_real_as (l_as: REAL_AS) is
		do
			if not expr_type_visiting then
				if l_as.constant_type /= Void then
					text_formatter_decorator.process_symbol_text (ti_l_curly)
					l_as.constant_type.process (Current)
					text_formatter_decorator.process_symbol_text (ti_r_curly)
					text_formatter_decorator.put_space
				end
				text_formatter_decorator.process_number_text (l_as.value)
			end

			if l_as.constant_type = Void then
				last_type := Real_64_type
			elseif expr_type_visiting then
				l_as.constant_type.process (Current)
			else
				-- Nothing to be done, done above when process `l_as.constant_type'.
			end
		end

	process_bool_as (l_as: BOOL_AS) is
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

	process_bit_const_as (l_as: BIT_CONST_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.process_string_text (l_as.value.name, Void)
				text_formatter_decorator.process_string_text ("B", Void)
			end
			create {BITS_A} last_type.make (l_as.value.name.count)
		end

	process_array_as (l_as: COMPILER_ARRAY_AS) is
		do
			reset_last_class_and_type
			if not expr_type_visiting then
				text_formatter_decorator.process_symbol_text (ti_l_array)
				text_formatter_decorator.put_space
			end
			if not l_as.expressions.is_empty then
				if not expr_type_visiting then
					text_formatter_decorator.set_separator (ti_comma)
					text_formatter_decorator.set_space_between_tokens
				end
				l_as.expressions.process (Current)
				if not expr_type_visiting then
					text_formatter_decorator.put_space
				end
			end
			if not expr_type_visiting then
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_r_array)
			end
			last_type := l_as.array_type
		end

	process_char_as (l_as: CHAR_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.process_character_text (l_as.string_value)
			end
			last_type := character_type
		end

	process_string_as (l_as: STRING_AS) is
		do
			if not expr_type_visiting then
				if l_as.is_once_string then
					text_formatter_decorator.process_keyword_text (ti_once_keyword, Void)
					text_formatter_decorator.put_space
				end
				text_formatter_decorator.put_string_item (l_as.string_value)
			end
			last_type := string_type
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS) is
		do
			if not expr_type_visiting then
				if l_as.is_once_string then
					text_formatter_decorator.process_keyword_text (ti_once_keyword, Void)
					text_formatter_decorator.put_space
				end
				text_formatter_decorator.put_string_item ("%"" + l_as.verbatim_marker)
				if l_as.is_indentable then
					text_formatter_decorator.put_string_item ("[")
				else
					text_formatter_decorator.put_string_item ("{")
				end
				text_formatter_decorator.put_new_line
				if not l_as.value.is_empty then
					append_format_multilined (l_as.value.twin, l_as.is_indentable)
				end
				if l_as.is_indentable then
					text_formatter_decorator.put_string_item ("]")
				else
					text_formatter_decorator.put_string_item ("}")
				end
				text_formatter_decorator.process_string_text (l_as.verbatim_marker + "%"", Void)
			end
			last_type := string_type
		end

	process_body_as (l_as: BODY_AS) is
		local
			l_feat: E_FEATURE
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if l_as.arguments /= Void and then not l_as.arguments.is_empty then
				text_formatter_decorator.put_space
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
				text_formatter_decorator.set_separator (ti_semi_colon)
				text_formatter_decorator.set_space_between_tokens
				l_as.arguments.process (Current)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
			end
			if l_as.type /= Void then
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_colon)
				text_formatter_decorator.put_space
				l_as.type.process (Current)
			end
			text_formatter_decorator.set_separator (ti_empty)
			if l_as.assigner /= Void then
				text_formatter_decorator.put_space
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_keyword_text (ti_assign_keyword, Void)
				text_formatter_decorator.put_space
				if not has_error_internal then
					l_feat := current_assigner_feature
				end
				if not has_error_internal then
					text_formatter_decorator.process_feature_text (l_feat.name, l_feat, False)
				else
					text_formatter_decorator.process_basic_text (l_as.assigner.name)
				end
			end
			safe_process (l_as.content)
		end

	process_built_in_as (l_as: BUILT_IN_AS) is
			-- Process `l_as'.
		local
			l_routine: ROUTINE_AS
		do
			if l_as.body = Void then
				process_external_as (l_as)
			else
				l_routine ?= l_as.body.body.content
				if l_routine /= Void then
					if l_routine.locals /= Void then
						text_formatter_decorator.process_keyword_text (ti_local_keyword, Void)
						text_formatter_decorator.put_new_line
						if l_routine.locals.count > 0 then
							text_formatter_decorator.indent
							text_formatter_decorator.set_separator (Void)
							text_formatter_decorator.set_new_line_between_tokens
							processing_locals := True
							l_routine.locals.process (Current)
							processing_locals := False
							text_formatter_decorator.put_new_line
							text_formatter_decorator.exdent
						end
					end
					safe_process (l_routine.routine_body)
					if l_routine.rescue_clause /= Void then
						text_formatter_decorator.process_keyword_text (ti_rescue_keyword, Void)
						text_formatter_decorator.indent
						text_formatter_decorator.put_new_line
						text_formatter_decorator.set_separator (Void)
						text_formatter_decorator.set_new_line_between_tokens
						if not l_routine.rescue_clause.is_empty then
							format_compound (l_routine.rescue_clause)
							text_formatter_decorator.put_new_line
						end
						text_formatter_decorator.exdent
					end
				end
			end
		end

	process_result_as (l_as: RESULT_AS) is
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

	process_current_as (l_as: CURRENT_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.process_keyword_text (ti_current, Void)
			end
			last_type := current_class.actual_type
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
		local
			l_feat: E_FEATURE
			l_feat_result: like feature_from_type_set
			l_rout_id_set: ID_SET
			l_last_class: like last_class
			l_last_type: like last_type
			l_formal: FORMAL_A
			l_last_type_set: TYPE_SET_A
			l_is_multiconstraint_formal: BOOLEAN
			l_named_tuple_type: NAMED_TUPLE_TYPE_A
			l_type: TYPE_A
			l_pos: INTEGER
			l_actual_argument_typs: like expr_types
			l_right_parenthesis_needed: BOOLEAN
		do
			if l_as.is_argument then
				if not expr_type_visiting then
					text_formatter_decorator.process_local_text (current_feature.arguments.item_name (l_as.argument_position))
				end
			elseif l_as.is_local then
				if not expr_type_visiting then
					text_formatter_decorator.process_local_text (l_as.access_name)
				end
			elseif l_as.is_object_test_local then
				if not expr_type_visiting then
					text_formatter_decorator.process_local_text (l_as.access_name)
				end
			elseif l_as.is_tuple_access then
				if not expr_type_visiting then
					text_formatter_decorator.process_symbol_text (ti_dot)
						text_formatter_decorator.process_local_text (l_as.access_name)
					end
			else
				if not has_error_internal then
					if last_type /= Void then
						last_type := last_type.actual_type
						if last_type.is_formal then
							l_formal ?= last_type
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
							last_class := last_type.associated_class
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
									last_class := l_feat_result.first.class_type.associated_class
									if l_feat_result.count > 1 then
										set_error_message ("Multi constraint formal: More than one feature available for feature with routine id: " + l_rout_id_set.first.out)
									end
								else
									l_feat := Void
									last_class := current_class
								end
							else
								l_feat := feature_in_class (current_class, l_rout_id_set)
								if last_type /= Void then
									last_class := last_type.associated_class
								else
									last_class := current_class
								end
							end
						else
							if last_type /= Void then
									-- We are already in a nested call like: xyz.a.f.*
									-- So `last_type', last_class are the ones from "a" and
									-- `l_rout_id_set' is the one of f
								if not last_type.is_none then
									if l_as.class_id /= 0 then
											-- Class ID may be zero if an incomplete compilation has occurred.
											-- Protection prevents infinitely looping and memory usage (see bug#13300)
										last_class := system.class_of_id (l_as.class_id)
									end
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
											last_type := l_feat_result.first.class_type
											last_class := last_type.associated_class
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
						if l_feat.is_infix and then not l_as.is_qualified  then
								-- We are in the case where a feature was renamed into an infix. It is an unqualified call so
								-- we print (Current + b) for example.
							text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
							l_right_parenthesis_needed := True
							text_formatter_decorator.process_keyword_text (ti_current, Void)
							text_formatter_decorator.put_space
							text_formatter_decorator.process_operator_text (l_feat.extract_symbol_from_infix (l_feat.name), l_feat)
						elseif l_feat.is_prefix then
							text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
							l_right_parenthesis_needed := True
							text_formatter_decorator.process_operator_text (l_feat.extract_symbol_from_prefix (l_feat.name), l_feat)
							text_formatter_decorator.put_space
							if l_feat.is_function then
								text_formatter_decorator.process_keyword_text (ti_current, Void)
							end
						else
								-- This includes the case where a qualified call on a feature which was renamed into an infix (or aliased).
							if l_as.is_qualified or text_formatter_decorator.dot_needed then
								text_formatter_decorator.process_symbol_text (ti_dot)
							end
							if not has_error_internal then
								text_formatter_decorator.process_feature_text (l_feat.name, l_feat, False)
							else
								text_formatter_decorator.process_basic_text (l_as.access_name)
							end
						end
					else
						if l_as.is_qualified or text_formatter_decorator.dot_needed then
							text_formatter_decorator.process_symbol_text (ti_dot)
						end
						text_formatter_decorator.process_local_text (l_as.access_name)
					end
				end
			end
			if l_as.parameters /= Void and not expr_type_visiting then
				l_last_type := last_type
				l_last_class := last_class
				reset_last_class_and_type
				text_formatter_decorator.process_symbol_text (ti_space)
				text_formatter_decorator.begin
				text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
				text_formatter_decorator.set_separator (ti_comma)
				text_formatter_decorator.set_space_between_tokens
				l_as.parameters.process (Current)
				text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
				text_formatter_decorator.commit
				last_type := l_last_type
				last_class := l_last_class
			end
			if l_right_parenthesis_needed then
				check not_expr_type_visiting: not expr_type_visiting end
				text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
			end
			if l_as.is_argument then
				last_type := current_feature.arguments.i_th (l_as.argument_position)
			elseif l_as.is_local then
				if last_type = Void then
					if locals_for_current_feature.has_key (l_as.access_name) then
						last_type := locals_for_current_feature.found_item
					end
				end
			elseif l_as.is_object_test_local then
				if object_test_locals_for_current_feature.has_key (l_as.access_name) then
					last_type := object_test_locals_for_current_feature.found_item
				end
			elseif l_as.is_tuple_access then
				if not has_error_internal then
					l_named_tuple_type ?= last_type.actual_type
					check
						l_named_tuple_type /= Void
					end
					l_pos := l_named_tuple_type.label_position (l_as.access_name)
					if l_pos > 0 then
						last_type := l_named_tuple_type.generics.item (l_pos)
					else
						last_type := Void
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
								last_type := current_class.actual_type
							else
									-- A static type in creation as.
								l_type := last_type
							end
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
			l_parent_class_i: CLASS_I
			l_current_feature: E_FEATURE
			l_type: TYPE_A
			l_actual_argument_typs: like expr_types
		do
			if not expr_type_visiting then
				text_formatter_decorator.begin
			end
			check
				current_feature.rout_id_set /= Void
			end
			l_current_feature := feature_in_class (current_class, current_feature.rout_id_set)
			if not has_error_internal then
				if l_as.parent_base_class /= Void then
					l_parent_class_i := universe.safe_class_named (l_as.parent_base_class.class_name.name, current_class.group)
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
					text_formatter_decorator.process_keyword_text (ti_precursor_keyword, real_feature)
				else
					text_formatter_decorator.process_keyword_text (ti_precursor_keyword, Void)
				end
				if l_as.parent_base_class /= Void then
					text_formatter_decorator.put_space
					text_formatter_decorator.process_symbol_text (ti_l_curly)
					if not has_error_internal then
						text_formatter_decorator.add_class (l_parent_class.lace_class)
					else
						text_formatter_decorator.process_basic_text (l_as.parent_base_class.class_name.name)
					end
					text_formatter_decorator.process_symbol_text (ti_r_curly)
				end
				if l_as.parameter_count > 0 then
					text_formatter_decorator.process_symbol_text (ti_space)
					text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
					text_formatter_decorator.set_separator (ti_comma)
					text_formatter_decorator.set_space_between_tokens
					l_as.parameters.process (Current)
					text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
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
				text_formatter_decorator.commit
			end
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.begin
				if l_as.has_lparan then
					text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
				end
			end
			l_as.target.process (Current)
			if not expr_type_visiting then
				if l_as.has_rparan then
					text_formatter_decorator.set_without_tabs
					text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
				end
				text_formatter_decorator.need_dot
			end
			l_as.message.process (Current)
			if not expr_type_visiting then
				text_formatter_decorator.commit
			end
		end

	process_nested_as (l_as: NESTED_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.begin
			end
			l_as.target.process (Current)
			if not expr_type_visiting then
				text_formatter_decorator.need_dot
			end
			l_as.message.process (Current)
			if not expr_type_visiting then
				text_formatter_decorator.commit
			end
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS) is
		local
			l_type: TYPE_A
		do
			if not expr_type_visiting then
				text_formatter_decorator.process_keyword_text (ti_create_keyword, Void)
				text_formatter_decorator.process_symbol_text (ti_space)
				text_formatter_decorator.process_symbol_text (ti_l_curly)
			end
			l_as.type.process (Current)
			l_type := last_type
			if not expr_type_visiting then
				text_formatter_decorator.process_symbol_text (ti_r_curly)
			end
			if l_as.call /= Void then
				if not expr_type_visiting then
					text_formatter_decorator.process_symbol_text (ti_dot)
				end
				l_as.call.process (Current)
			end
			last_type := l_type
		end

	process_type_expr_as (l_as: TYPE_EXPR_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.process_symbol_text (ti_l_curly)
				l_as.type.process (Current)
				text_formatter_decorator.process_symbol_text (ti_r_curly)
			else
				l_as.type.process (Current)
			end
			create {GEN_TYPE_A} last_type.make (system.type_class.compiled_class.class_id, << last_type >>)
		end

	process_routine_as (l_as: ROUTINE_AS) is
		local
			comments: EIFFEL_COMMENTS
			chained_assert: CHAINED_ASSERTIONS
			is_inline_agent: BOOLEAN
			inline_agent_assertion: ROUTINE_ASSERTIONS
			l_built_in_as: BUILT_IN_AS
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end

			is_inline_agent := current_feature.is_inline_agent

			locals_for_current_feature.wipe_out
			object_test_locals_for_current_feature.wipe_out
			text_formatter_decorator.put_new_line
			if not text_formatter_decorator.is_feature_short then
				if l_as.obsolete_message /= Void then
					text_formatter_decorator.indent
					text_formatter_decorator.process_keyword_text (ti_obsolete_keyword, Void)
					text_formatter_decorator.put_space
					l_as.obsolete_message.process (Current)
					text_formatter_decorator.put_new_line
					text_formatter_decorator.exdent
				end
			end
			text_formatter_decorator.indent

			if not is_inline_agent then
				text_formatter_decorator.indent
				comments := text_formatter_decorator.feature_comments
				if comments /= Void then
					text_formatter_decorator.put_comments (comments)
				end
				text_formatter_decorator.put_origin_comment
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.set_first_assertion (True)

			if is_inline_agent then
				create inline_agent_assertion.make_for_inline_agent (current_feature, l_as)
				if l_as.precondition /= Void then
					inline_agent_assertion.format_precondition (text_formatter_decorator,
						not text_formatter_decorator.is_with_breakable)
				end
			else
				chained_assert := text_formatter_decorator.chained_assertion

				if chained_assert /= Void then
					chained_assert.format_precondition (text_formatter_decorator)
				elseif l_as.precondition /= Void then
					text_formatter_decorator.set_in_assertion
					l_as.precondition.process (Current)
					text_formatter_decorator.set_not_in_assertion
				end
			end
			if l_as.object_test_locals /= Void then
					-- We do not need to remember the previous value of
					-- expr_type_visiting, because there is an earlier check
					-- statement stating that it should be False.
					-- Here we enable it, because we don't want the object test
					-- locals to be printed while evaluating their type.
				expr_type_visiting := True
				from
					l_as.object_test_locals.start
				until
					l_as.object_test_locals.after
				loop
					l_as.object_test_locals.item.type.process (Current)
					if last_type /= Void then
						object_test_locals_for_current_feature.put (last_type,
							l_as.object_test_locals.item.name.name)
					end
					l_as.object_test_locals.forth
				end
				expr_type_visiting := False
			end
			if not text_formatter_decorator.is_feature_short then
				if l_as.locals /= Void then
					text_formatter_decorator.process_keyword_text (ti_local_keyword, Void)
					text_formatter_decorator.put_new_line
					if l_as.locals.count > 0 then
						text_formatter_decorator.indent
						text_formatter_decorator.set_separator (Void)
						text_formatter_decorator.set_new_line_between_tokens
						processing_locals := True
						l_as.locals.process (Current)
						processing_locals := False
						text_formatter_decorator.put_new_line
						text_formatter_decorator.exdent
					end
				end
				safe_process (l_as.routine_body)
			end
			text_formatter_decorator.set_first_assertion (True)
			if is_inline_agent then
				if l_as.postcondition /= Void then
					inline_agent_assertion.format_postcondition (text_formatter_decorator,
						not text_formatter_decorator.is_with_breakable)
				end
			else
				if chained_assert /= Void then
					chained_assert.format_postcondition (text_formatter_decorator)
				elseif l_as.postcondition /= Void then
					text_formatter_decorator.set_in_assertion
					l_as.postcondition.process (Current)
					text_formatter_decorator.set_not_in_assertion
				end
			end
			if not text_formatter_decorator.is_feature_short then
				if l_as.rescue_clause /= Void then
					text_formatter_decorator.process_keyword_text (ti_rescue_keyword, Void)
					text_formatter_decorator.indent
					text_formatter_decorator.put_new_line
					text_formatter_decorator.set_separator (Void)
					text_formatter_decorator.set_new_line_between_tokens
					if not l_as.rescue_clause.is_empty then
						format_compound (l_as.rescue_clause)
						text_formatter_decorator.put_new_line
					end
					text_formatter_decorator.exdent
				end
				if not l_as.is_deferred then
					put_breakable
				end
					 -- `end' token should not be printed when the substitution
					 -- of a built-in is an attribute.
				if not l_as.is_built_in then
					text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
				else
					l_built_in_as ?= l_as.routine_body
					check l_built_in_as_not_void: l_built_in_as /= Void end
					if l_built_in_as.body /= Void implies not l_built_in_as.body.is_attribute then
						text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
					end
				end
			end
			text_formatter_decorator.exdent
		end

	process_constant_as (l_as: CONSTANT_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.put_space
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_keyword_text (ti_is_keyword, Void)
				text_formatter_decorator.put_space
			end
			l_as.value.process (Current)
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL]) is
		local
			i, l_count: INTEGER
			failure: BOOLEAN
			not_first: BOOLEAN
		do
			if not expr_type_visiting then
				text_formatter_decorator.begin
			end
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count or failure
			loop
				if not expr_type_visiting then
					if not_first then
						text_formatter_decorator.put_separator
					end
					text_formatter_decorator.new_expression
					text_formatter_decorator.begin
				end
				l_as.i_th (i).process (Current)
				if not expr_type_visiting then
					text_formatter_decorator.commit
				end
				not_first := True
				i := i + 1
			end
			if not expr_type_visiting then
				text_formatter_decorator.commit
			end
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.process_filter_item (f_indexing, True)
			if current_class.lace_class.is_syntax_standard then
				text_formatter_decorator.process_keyword_text (ti_note_keyword, Void)
			else
				text_formatter_decorator.process_keyword_text (ti_indexing_keyword, Void)
			end
			text_formatter_decorator.indent
			text_formatter_decorator.put_new_line
			text_formatter_decorator.set_separator (Void)
			text_formatter_decorator.set_new_line_between_tokens
			process_eiffel_list (l_as)
			text_formatter_decorator.process_filter_item (f_indexing, False)
			text_formatter_decorator.exdent
			text_formatter_decorator.put_new_line
			text_formatter_decorator.put_new_line
		end

	process_operand_as (l_as: OPERAND_AS) is
		do
			if l_as.class_type /= Void then
				if not expr_type_visiting then
					text_formatter_decorator.process_symbol_text (ti_l_curly)
				end
				l_as.class_type.process (Current)
				if not expr_type_visiting then
					text_formatter_decorator.process_symbol_text (ti_r_curly)
				end
			else
				if l_as.expression /= Void then
					l_as.expression.process (Current)
				else
					if l_as.target /= Void then
						reset_last_class_and_type
						l_as.target.process (Current)
					else
						if not expr_type_visiting then
							text_formatter_decorator.process_symbol_text (ti_question)
						else
							create {OPEN_TYPE_A} last_type
						end
					end
				end
			end
		end

	process_tagged_as (l_as: TAGGED_AS) is
		do
			if not expr_type_visiting then
				format_tagged_as (l_as, not text_formatter_decorator.is_with_breakable)
			end
		end

	process_variant_as (l_as: VARIANT_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_tagged_as (l_as)
		end

	process_un_strip_as (l_as: UN_STRIP_AS) is
		local
			first_printed: BOOLEAN
			l_names_heap: like names_heap
			l_id: INTEGER
			l_feature: FEATURE_I
			l_feat: E_FEATURE
		do
			if not expr_type_visiting then
				text_formatter_decorator.process_keyword_text (ti_strip_keyword, Void)
				text_formatter_decorator.put_space
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
				from
					l_names_heap := names_heap
					l_as.id_list.start
				until
					l_as.id_list.after
				loop
					text_formatter_decorator.new_expression
					if first_printed then
						text_formatter_decorator.set_without_tabs
						text_formatter_decorator.process_symbol_text (ti_comma)
						text_formatter_decorator.put_space
					end
					l_id := l_as.id_list.item
					l_feature := feature_from_ancestors (source_class, l_id)
						check
							l_feature /= Void
							l_feature.rout_id_set /= Void
						end
					l_feat := feature_in_class (current_class, l_feature.rout_id_set)
					if not has_error_internal then
						text_formatter_decorator.process_feature_text (l_feat.name, l_feat, False)
					else
						text_formatter_decorator.process_basic_text (l_feature.feature_name)
					end
					first_printed := True
					l_as.id_list.forth
				end
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
			end
			last_type := strip_type
		end

	process_converted_expr_as (l_as: CONVERTED_EXPR_AS) is
		local
			l_feat: E_FEATURE
			l_type: TYPE_A
			l_old_expr_type_visiting: like expr_type_visiting
		do
			l_old_expr_type_visiting := expr_type_visiting
			expr_type_visiting := True
			reset_last_class_and_type
			l_as.expr.process (Current)
			expr_type_visiting := l_old_expr_type_visiting

			if {l_info: PARENT_CONVERSION_INFO} l_as.data then
					-- If we have some data about the above with a conversion, we need
					-- to extract it so that we can recheck the code in the descendant.
				if l_info.is_from_conversion then
					l_type := l_info.creation_type.evaluated_type_in_descendant (source_class, current_class, current_feature)
					if not expr_type_visiting then
						text_formatter_decorator.process_keyword_text (ti_create_keyword, Void)
						text_formatter_decorator.put_space
						text_formatter_decorator.process_symbol_text (ti_l_curly)
						type_output_strategy.process (l_type, text_formatter_decorator, current_class, current_feature)
						text_formatter_decorator.process_symbol_text (ti_r_curly)
						text_formatter_decorator.process_symbol_text (ti_dot)
						l_feat := l_type.associated_class.feature_with_rout_id (l_info.routine_id)
						text_formatter_decorator.add_feature (l_feat, l_feat.name)
						text_formatter_decorator.process_symbol_text (ti_space)
						text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
						l_as.expr.process (Current)
						text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
					end
				else
					l_feat := last_type.associated_class.feature_with_rout_id (l_info.routine_id)
					if l_feat /= Void then
						l_type := l_feat.type
						if not expr_type_visiting then
							l_as.expr.process (Current)
							text_formatter_decorator.process_symbol_text (ti_dot)
							text_formatter_decorator.add_feature (l_feat, l_feat.name)
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

	process_paran_as (l_as: PARAN_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.begin
				text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
			end
			l_as.expr.process (Current)
			if not expr_type_visiting then
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
				text_formatter_decorator.commit
			end
		end

	process_expr_call_as (l_as: EXPR_CALL_AS) is
		do
			reset_last_class_and_type
			l_as.call.process (Current)
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.begin
				text_formatter_decorator.process_symbol_text (ti_dollar)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
				l_as.expr.process (Current)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
				text_formatter_decorator.commit
			end
			last_type := pointer_type
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS) is
		local
			l_type: TYPE_A
		do
			if not expr_type_visiting then
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_dollar)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_keyword_text (ti_result, Void)
			end
			l_type ?= current_feature.type
			create {TYPED_POINTER_A} last_type.make_typed (l_type)
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS) is
		local
			l_type: TYPE_A
		do
			if not expr_type_visiting then
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_dollar)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_keyword_text (ti_current, Void)
			end
			l_type ?= current_class.actual_type
			create {TYPED_POINTER_A} last_type.make_typed (l_type)
		end

	process_address_as (l_as: ADDRESS_AS) is
		local
			l_feat: E_FEATURE
		do
			reset_last_class_and_type
			if not has_error_internal then
				if l_as.is_argument then
					create {TYPED_POINTER_A} last_type.make_typed (current_feature.arguments.i_th (l_as.argument_position))
				elseif l_as.is_local then
					if locals_for_current_feature.has_key (l_as.feature_name.internal_name.name) then
						create {TYPED_POINTER_A} last_type.make_typed (locals_for_current_feature.found_item)
					end
				elseif l_as.is_object_test_local then
					if object_test_locals_for_current_feature.has_key (l_as.feature_name.internal_name.name) then
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
					text_formatter_decorator.begin
					text_formatter_decorator.set_without_tabs
					text_formatter_decorator.process_symbol_text (ti_dollar)
					if l_feat /= Void then
						text_formatter_decorator.process_feature_text (l_as.feature_name.internal_name.name, l_feat, False)
					else
						text_formatter_decorator.process_local_text (l_as.feature_name.internal_name.name)
					end
					text_formatter_decorator.commit
				end
			end
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS) is
		local
			l_feat: E_FEATURE
		do
				-- No type set for this expression?
			if not expr_type_visiting then
				text_formatter_decorator.process_keyword_text (ti_agent_keyword, Void)
				text_formatter_decorator.put_space
				if l_as.target /= Void then
					l_as.target.process (Current)
					text_formatter_decorator.process_symbol_text (ti_dot)
				end
				if l_as.class_id /= 0 and l_as.routine_ids /= Void then
					l_feat := feature_in_class (system.class_of_id (l_as.class_id), l_as.routine_ids)
				else
					has_error_internal := True
				end
				if not has_error_internal then
					text_formatter_decorator.process_feature_text (l_feat.name, l_feat, False)
				else
					text_formatter_decorator.process_basic_text (l_as.feature_name.name)
				end

				if l_as.operands /= Void then
					reset_last_class_and_type
					text_formatter_decorator.process_symbol_text (ti_space)
					text_formatter_decorator.begin
					text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
					text_formatter_decorator.set_separator (ti_comma)
					text_formatter_decorator.set_space_between_tokens
					l_as.operands.process (Current)
					text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
					text_formatter_decorator.commit
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

	process_unary_as (l_as: UNARY_AS) is
		local
			l_feat: E_FEATURE
			l_type: TYPE_A
			l_last_type: TYPE_A
			l_name: STRING
			l_expr_type: TYPE_A
			l_formal: FORMAL_A
			l_feature_list: like feature_from_type_set
		do
			if not expr_type_visiting then
				text_formatter_decorator.begin
			end
			check
				routine_id_is_zero: l_as.routine_ids.first /= 0
			end
			if not has_error_internal then
				l_expr_type := expr_type (l_as.expr)
			end
			if not has_error_internal then
				if l_expr_type.is_formal then
					l_formal ?= l_expr_type
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
						l_feat := feature_in_class (l_last_type.associated_class, l_as.routine_ids)
					end
				else
					l_last_type := l_expr_type.actual_type
					l_feat := feature_in_class (l_last_type.associated_class, l_as.routine_ids)
				end
			end
			if not has_error_internal then
				if l_feat.is_prefix or l_feat.has_alias_name then
					if not expr_type_visiting then
						if l_feat.is_prefix then
							l_name := l_feat.prefix_symbol
						else
							l_name := l_feat.alias_symbol
						end
						if in_bench_mode then
							text_formatter_decorator.process_operator_text (l_name, l_feat)
						elseif (l_name @ 1).is_alpha then
							text_formatter_decorator.process_keyword_text (l_name, Void)
						else
							text_formatter_decorator.process_symbol_text (l_name)
						end
						text_formatter_decorator.put_space
					end
					l_as.expr.process (Current)
				elseif l_feat.is_infix then
					check
						is_infix: False
					end
				else
					l_as.expr.process (Current)
					if not expr_type_visiting then
						text_formatter_decorator.process_symbol_text (ti_dot)
						text_formatter_decorator.process_feature_text (l_feat.name, l_feat, False)
					end
				end
			else
				if not expr_type_visiting then
					text_formatter_decorator.process_basic_text (l_as.operator_name)
					text_formatter_decorator.put_space
				end
				l_as.expr.process (Current)
			end
			if not expr_type_visiting then
				text_formatter_decorator.commit
			end
			if not has_error_internal then
				check l_feat_is_not_procedure: not l_feat.is_procedure end
				l_type := l_feat.type.actual_type
				check l_last_type_not_void: l_last_type /= Void end
				last_class := l_last_type.associated_class
				if l_type.is_loose then
					last_type := l_type.instantiation_in (l_last_type, last_class.class_id)
				else
					last_type := l_type
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
			if not expr_type_visiting then
				text_formatter_decorator.begin
				text_formatter_decorator.process_keyword_text (ti_old_keyword, Void)
				text_formatter_decorator.put_space
			end
			l_as.expr.process (Current)
			if not expr_type_visiting then
				text_formatter_decorator.commit
			end
		end

	process_un_plus_as (l_as: UN_PLUS_AS) is
		do
			process_unary_as (l_as)
		end

	process_binary_as (l_as: BINARY_AS) is
		local
			l_feat: E_FEATURE
			l_name: STRING
			l_formal: FORMAL_A
					-- Temporary usage only!
			l_type: TYPE_A
			l_left_type: TYPE_A
			l_is_left_multi_constrained, l_is_right_multi_constrained: BOOLEAN
			l_left_type_set, l_right_type_set: TYPE_SET_A
			l_left_class: CLASS_C
			l_right_type: TYPE_A
			l_feature_list: like feature_from_type_set
		do
			if not expr_type_visiting then
				text_formatter_decorator.begin
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
				if l_left_type.is_formal then
					l_formal ?= l_left_type
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
					check
						l_right_type_not_void: l_right_type /= Void
					end
					l_right_type := l_right_type.actual_type
					if l_right_type.is_formal then
						l_formal ?= l_right_type
						if l_formal.is_multi_constrained (current_class) then
							l_is_right_multi_constrained := True
							l_right_type_set := l_formal.constrained_types (current_class)
						else
							l_right_type := l_formal.constrained_type (current_class)
						end
					end

						-- Was the left type converted to the right type?
					if l_as.is_left_type_converted then
						l_left_type := l_right_type
						l_is_left_multi_constrained := l_is_right_multi_constrained
						l_left_type_set := l_right_type_set
					end

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
						l_feat := feature_in_class (l_left_type.associated_class, l_as.routine_ids)
					end
					check not has_error_internal implies l_left_type /= Void end
					if not has_error_internal then
						l_left_class := l_left_type.associated_class
						last_type := l_left_type
					end
				end
			end
			if not expr_type_visiting then
				if not has_error_internal then
					check l_feat_not_void: l_feat /= Void end
					if l_feat.is_infix or l_feat.has_alias_name then
						if l_feat.is_infix then
							l_name := l_feat.infix_symbol
						else
							l_name := l_feat.alias_symbol
						end
						text_formatter_decorator.put_space
						if in_bench_mode then
							text_formatter_decorator.process_operator_text (l_name, l_feat)
						elseif (l_name @ 1).is_alpha then
							text_formatter_decorator.process_keyword_text (l_name, Void)
						else
							text_formatter_decorator.process_symbol_text (l_name)
						end
						text_formatter_decorator.put_space
						check l_feat_is_not_procedure: not l_feat.is_procedure end
						l_as.right.process (Current)
					else
						l_name := l_feat.name
						text_formatter_decorator.process_symbol_text (ti_dot)
						text_formatter_decorator.process_feature_text (l_name, l_feat, False)
						text_formatter_decorator.put_space
						text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
						l_as.right.process (Current)
						text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
					end
				else
					text_formatter_decorator.put_space
					text_formatter_decorator.process_basic_text (l_as.op_name.name)
					text_formatter_decorator.put_space
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
				text_formatter_decorator.commit
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
			l_as.left.process (Current)
			if not expr_type_visiting then
				text_formatter_decorator.put_space
				text_formatter_decorator.process_symbol_text (l_as.op_name.name)
				text_formatter_decorator.put_space
			end
			l_as.right.process (Current)
			last_type := boolean_type
		end

	process_bin_ne_as (l_as: BIN_NE_AS) is
		do
			process_bin_eq_as (l_as)
		end

	process_bin_tilde_as (l_as: BIN_TILDE_AS) is
		do
			l_as.left.process (Current)
			if not expr_type_visiting then
				text_formatter_decorator.put_space
				text_formatter_decorator.process_symbol_text (l_as.op_name.name)
				text_formatter_decorator.put_space
			end
			l_as.right.process (Current)
			last_type := boolean_type
		end

	process_bin_not_tilde_as (l_as: BIN_NOT_TILDE_AS) is
		do
			process_bin_tilde_as (l_as)
		end

	process_bracket_as (l_as: BRACKET_AS) is
		local
			l_feat: E_FEATURE
			l_type: TYPE_A
			l_formal: FORMAL_A
			l_last_type: TYPE_A
			l_last_type_set: TYPE_SET_A
			l_last_class: CLASS_C
			l_result: LIST[TUPLE[feature_item: E_FEATURE; type: RENAMED_TYPE_A [TYPE_A]]]
		do
			if not expr_type_visiting then
				text_formatter_decorator.begin
			end
			l_as.target.process (Current)
			check
				routine_id_is_zero: l_as.routine_ids.first /= 0
				last_type_not_void: last_type /= Void
			end
			if not has_error_internal then
				last_type := last_type.actual_type
				if last_type.is_formal then
					l_formal ?= last_type
					if l_formal.is_multi_constrained (current_class) then
						l_last_type_set := l_formal.constrained_types (current_class)
							-- Here we get back the feature and the renamed type where the feature is from (it means that it includes a possible renaming)
						l_result := l_last_type_set.e_feature_list_by_rout_id (l_as.routine_ids.first)
						last_class := l_result.first.type.associated_class
						l_feat := l_result.first.feature_item
					else
						last_class := l_formal.constrained_type (current_class).associated_class
						l_feat := feature_in_class (last_class, l_as.routine_ids)
					end
				else
					last_class := last_type.associated_class
					l_feat := feature_in_class (last_class, l_as.routine_ids)
				end
			end
			if not expr_type_visiting then
				text_formatter_decorator.put_space
				if not has_error_internal then
					text_formatter_decorator.process_operator_text (ti_l_bracket, l_feat)
				else
					text_formatter_decorator.process_basic_text (ti_l_bracket)
				end
				if l_as.operands /= Void then
					l_last_type := last_type
					l_last_class := last_class
					text_formatter_decorator.begin
					text_formatter_decorator.set_separator (ti_comma)
					text_formatter_decorator.set_space_between_tokens
					l_as.operands.process (Current)
					text_formatter_decorator.commit
					last_type := l_last_type
					last_class := l_last_class
				end
				if not has_error_internal then
					text_formatter_decorator.process_operator_text (ti_r_bracket, l_feat)
				else
					text_formatter_decorator.process_basic_text (ti_r_bracket)
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
				text_formatter_decorator.commit
			end
		end

	process_object_test_as (l_as: OBJECT_TEST_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.process_symbol_text (ti_l_curly)
				l_as.name.process (Current)
				text_formatter_decorator.process_symbol_text (ti_colon)
				text_formatter_decorator.put_space
			end
			l_as.type.process (Current)
			if not expr_type_visiting then
				text_formatter_decorator.process_symbol_text (ti_r_curly)
				text_formatter_decorator.put_space
			end
			l_as.expression.process (Current)
			last_type := boolean_type
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.language_name.process (Current)
		end

	process_feature_as (l_as: FEATURE_AS) is
		local
			comments: EIFFEL_COMMENTS
			cont: CONTENT_AS
			is_const_or_att: BOOLEAN
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			check
				current_class /= Void
			end
			text_formatter_decorator.begin
			text_formatter_decorator.set_separator (ti_comma)
			text_formatter_decorator.set_space_between_tokens
			text_formatter_decorator.process_feature_dec_item (l_as.feature_names.first.internal_name.name, True)
			text_formatter_decorator.set_separator (ti_comma)
			text_formatter_decorator.set_space_between_tokens
			l_as.feature_names.process (Current)
			l_as.body.process (Current)
			text_formatter_decorator.set_without_tabs
			text_formatter_decorator.process_feature_dec_item (l_as.feature_names.first.internal_name.name, False)
			if not text_formatter_decorator.is_feature_short then
				text_formatter_decorator.put_new_line
			end
			cont := l_as.body.content
			is_const_or_att := cont = Void or else cont.is_constant
			if is_const_or_att then
				text_formatter_decorator.indent
				text_formatter_decorator.indent
				if text_formatter_decorator.is_feature_short then
					text_formatter_decorator.put_new_line
				end
				comments := text_formatter_decorator.feature_comments
				if comments /= Void then
					text_formatter_decorator.put_comments (comments)
				end
				text_formatter_decorator.put_origin_comment
				text_formatter_decorator.exdent
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.commit
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS) is
		local
			l_feat: E_FEATURE
			l_is_infix, l_is_prefix: BOOLEAN
			l_new_name: BOOLEAN
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if not has_error_internal then
				if current_feature = Void then
						-- Processing other part of a class, not in a feature.
					if last_parent /= Void then
						l_feat := last_parent.feature_with_id (l_as.internal_name)
					else
						l_feat := current_class.feature_with_id (l_as.internal_name)
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
				else
						-- Processing name of a feature.
					l_feat := feature_in_class (current_class, current_feature.rout_id_set)
				end
			end

			if not has_error_internal and then not processing_parents then
				check
					l_feat_not_void: l_feat /= Void
				end
				if not processing_none_feature_part and then l_feat.is_frozen then
					text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
					text_formatter_decorator.put_space
				end
				if processing_formal_dec and then l_new_name then
						-- Print visual name of the new renamed feature in formal declaration.
					l_is_infix := l_as.is_infix
					l_is_prefix := l_as.is_prefix
				else
					l_is_infix := l_feat.is_infix
					l_is_prefix := l_feat.is_prefix
				end
				if l_is_infix then
					text_formatter_decorator.process_keyword_text (ti_infix_keyword, Void)
					text_formatter_decorator.put_space
					text_formatter_decorator.set_without_tabs
					text_formatter_decorator.process_symbol_text (ti_double_quote)
					if processing_formal_dec then
						text_formatter_decorator.process_operator_text (l_as.visual_name, l_feat)
					else
						text_formatter_decorator.process_operator_text (l_feat.extract_symbol_from_infix (l_feat.name), l_feat)
					end
					text_formatter_decorator.process_symbol_text (ti_double_quote)
				elseif l_is_prefix then
					text_formatter_decorator.process_keyword_text (ti_prefix_keyword, Void)
					text_formatter_decorator.put_space
					text_formatter_decorator.set_without_tabs
					text_formatter_decorator.process_symbol_text (ti_double_quote)
					if processing_formal_dec then
						text_formatter_decorator.process_operator_text (l_as.visual_name, l_feat)
					else
						text_formatter_decorator.process_operator_text (l_feat.extract_symbol_from_prefix (l_feat.name), l_feat)
					end
					text_formatter_decorator.process_symbol_text (ti_double_quote)
				else
					if processing_formal_dec then
						text_formatter_decorator.process_feature_text (l_as.visual_name, l_feat, False)
					else
						text_formatter_decorator.process_feature_text (l_feat.name, l_feat, False)
					end
				end
			else
				if not processing_none_feature_part and then l_as.is_frozen then
					text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
					text_formatter_decorator.put_space
				end
				if l_as.is_infix then
					text_formatter_decorator.process_keyword_text (ti_infix_keyword, Void)
					text_formatter_decorator.put_space
					text_formatter_decorator.set_without_tabs
					text_formatter_decorator.process_symbol_text (ti_double_quote)
					if not has_error_internal then
						text_formatter_decorator.process_operator_text (l_as.visual_name, l_feat)
					else
						text_formatter_decorator.process_basic_text (l_as.visual_name)
					end
					text_formatter_decorator.process_symbol_text (ti_double_quote)
				elseif l_as.is_prefix then
					text_formatter_decorator.process_keyword_text (ti_prefix_keyword, Void)
					text_formatter_decorator.put_space
					text_formatter_decorator.set_without_tabs
					text_formatter_decorator.process_symbol_text (ti_double_quote)
					if not has_error_internal then
						text_formatter_decorator.process_operator_text (l_as.visual_name, l_feat)
					else
						text_formatter_decorator.process_basic_text (l_as.visual_name)
					end
					text_formatter_decorator.process_symbol_text (ti_double_quote)
				else
					if not has_error_internal then
						text_formatter_decorator.process_feature_text (l_feat.name, l_feat, False)
					else
						text_formatter_decorator.process_basic_text (l_as.visual_name)
					end
				end
			end
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS) is
		local
			l_feat: E_FEATURE
			l_is_infix, l_is_prefix: BOOLEAN
			l_new_name: BOOLEAN
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if not has_error_internal then
				if current_feature = Void then
						-- Processing other part of a class, not in a feature.
					if last_parent /= Void then
						l_feat := last_parent.feature_with_name (l_as.feature_name.name)
					else
						l_feat := current_class.feature_with_name (l_as.feature_name.name)
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
						text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
						text_formatter_decorator.put_space
					end
					if processing_formal_dec and then l_new_name then
							-- Print visual name of the new renamed feature in formal declaration.
						l_is_infix := l_as.is_infix
						l_is_prefix := l_as.is_prefix
					else
						l_is_infix := l_feat.is_infix
						l_is_prefix := l_feat.is_prefix
					end
					if l_is_infix then
						text_formatter_decorator.process_keyword_text (ti_infix_keyword, Void)
						text_formatter_decorator.put_space
						text_formatter_decorator.set_without_tabs
						text_formatter_decorator.process_symbol_text (ti_double_quote)
						if processing_formal_dec then
							text_formatter_decorator.process_operator_text (l_as.visual_name, l_feat)
						else
							text_formatter_decorator.process_operator_text (l_feat.extract_symbol_from_infix (l_feat.name), l_feat)
						end
						text_formatter_decorator.process_symbol_text (ti_double_quote)
					elseif l_is_prefix then
						text_formatter_decorator.process_keyword_text (ti_prefix_keyword, Void)
						text_formatter_decorator.put_space
						text_formatter_decorator.set_without_tabs
						text_formatter_decorator.process_symbol_text (ti_double_quote)
						if processing_formal_dec then
							text_formatter_decorator.process_operator_text (l_as.visual_name, l_feat)
						else
							text_formatter_decorator.process_operator_text (l_feat.extract_symbol_from_prefix (l_feat.name), l_feat)
						end
						text_formatter_decorator.process_symbol_text (ti_double_quote)
					else
						if processing_formal_dec then
							text_formatter_decorator.process_feature_text (l_as.visual_name, l_feat, False)
						else
							text_formatter_decorator.process_feature_text (l_feat.name, l_feat, False)
						end
					end
				else
					if not processing_none_feature_part and then l_as.is_frozen then
						text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
						text_formatter_decorator.put_space
					end
					if l_as.is_infix then
						text_formatter_decorator.process_keyword_text (ti_infix_keyword, Void)
						text_formatter_decorator.put_space
						text_formatter_decorator.set_without_tabs
						text_formatter_decorator.process_symbol_text (ti_double_quote)
						if not has_error_internal then
							text_formatter_decorator.process_operator_text (l_as.visual_name, l_feat)
						else
							text_formatter_decorator.process_basic_text (l_as.visual_name)
						end
						text_formatter_decorator.process_symbol_text (ti_double_quote)
					elseif l_as.is_prefix then
						text_formatter_decorator.process_keyword_text (ti_prefix_keyword, Void)
						text_formatter_decorator.put_space
						text_formatter_decorator.set_without_tabs
						text_formatter_decorator.process_symbol_text (ti_double_quote)
						if not has_error_internal then
							text_formatter_decorator.process_operator_text (l_as.visual_name, l_feat)
						else
							text_formatter_decorator.process_basic_text (l_as.visual_name)
						end
						text_formatter_decorator.process_symbol_text (ti_double_quote)
					else
						if not has_error_internal then
							text_formatter_decorator.process_feature_text (l_feat.name, l_feat, False)
						else
							text_formatter_decorator.process_basic_text (l_as.visual_name)
						end
					end
				end
			else
				text_formatter_decorator.process_basic_text (l_as.visual_name)
			end
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS) is
		local
			l_feat: E_FEATURE
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if not has_error_internal then
				if current_feature = Void then
						-- Processing other part of a class, not in a feature.
					if last_parent /= Void then
						l_feat := last_parent.feature_with_name (l_as.feature_name.name)
					else
						l_feat := current_class.feature_with_name (l_as.feature_name.name)
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
				text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
				text_formatter_decorator.put_space
			end
			if not has_error_internal then
				text_formatter_decorator.process_feature_text (l_as.visual_name, l_feat, False)
			else
				text_formatter_decorator.process_basic_text (l_as.visual_name)
			end
			text_formatter_decorator.put_space
			text_formatter_decorator.process_keyword_text (ti_alias_keyword, Void)
			text_formatter_decorator.put_space
			text_formatter_decorator.process_symbol_text (ti_double_quote)
			if not has_error_internal then
				text_formatter_decorator.process_operator_text (l_as.alias_name.value, l_feat)
			else
				text_formatter_decorator.process_basic_text (l_as.alias_name.value)
			end
			text_formatter_decorator.process_symbol_text (ti_double_quote)
			if l_as.has_convert_mark then
				text_formatter_decorator.put_space
				text_formatter_decorator.process_keyword_text (ti_convert_keyword, Void)
			end
		end

	process_feature_list_as (l_as: FEATURE_LIST_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.set_separator (ti_comma)
				text_formatter_decorator.set_space_between_tokens
			end
			l_as.features.process (Current)
		end

	process_all_as (l_as: ALL_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.process_keyword_text (ti_all_keyword, Void)
		end

	process_assign_as (l_as: ASSIGN_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			reset_last_class_and_type
			if not expr_type_visiting then
				put_breakable
				text_formatter_decorator.new_expression
			end
			l_as.target.process (Current)
			if not expr_type_visiting then
				text_formatter_decorator.put_space
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_assign)
				text_formatter_decorator.put_space
				text_formatter_decorator.new_expression
			end
			reset_last_class_and_type
			l_as.source.process (Current)
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS) is
		do
			if not expr_type_visiting then
				reset_last_class_and_type
				put_breakable
				text_formatter_decorator.new_expression
			end
			l_as.target.process (Current)
			if not expr_type_visiting then
				text_formatter_decorator.put_space
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_assign)
				text_formatter_decorator.put_space
				text_formatter_decorator.new_expression
			end
			l_as.source.process (Current)
		end

	process_reverse_as (l_as: REVERSE_AS) is
		do
			if not expr_type_visiting then
				put_breakable
				text_formatter_decorator.new_expression
			end
			l_as.target.process (Current)
			if not expr_type_visiting then
				text_formatter_decorator.put_space
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_reverse_assign)
				text_formatter_decorator.put_space
				text_formatter_decorator.new_expression
			end
			l_as.source.process (Current)
		end

	process_check_as (l_as: CHECK_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.process_keyword_text (ti_check_keyword, Void)
			if l_as.check_list /= Void then
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				text_formatter_decorator.set_new_line_between_tokens
				l_as.check_list.process (Current)
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.put_new_line
			text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
		end

	process_creation_as (l_as: CREATION_AS) is
		do
			if not expr_type_visiting then
				put_breakable
				text_formatter_decorator.process_keyword_text (ti_create_keyword, Void)
				text_formatter_decorator.put_space
			end
			if l_as.type /= Void then
				if not expr_type_visiting then
					text_formatter_decorator.process_symbol_text (ti_l_curly)
				end
				l_as.type.process (Current)
				if not expr_type_visiting then
					text_formatter_decorator.set_without_tabs
					text_formatter_decorator.process_symbol_text (ti_r_curly)
					text_formatter_decorator.put_space
				end
			end
			processing_creation_target := True
			l_as.target.process (Current)
			processing_creation_target := False
			if l_as.call /= Void then
				if not expr_type_visiting then
					text_formatter_decorator.need_dot
				end
				l_as.call.process (Current)
			end

		end

	process_debug_as (l_as: DEBUG_AS) is
		do
			text_formatter_decorator.process_keyword_text (ti_debug_keyword, Void)
			text_formatter_decorator.put_space
			if l_as.keys /= Void and then not l_as.keys.is_empty then
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
				text_formatter_decorator.set_separator (ti_comma)
				text_formatter_decorator.set_no_new_line_between_tokens
				l_as.keys.process (Current)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
			end
			if l_as.compound /= Void then
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				text_formatter_decorator.set_separator (Void)
				text_formatter_decorator.set_new_line_between_tokens
				format_compound (l_as.compound)
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.put_new_line
			text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
		end

	process_if_as (l_as: IF_AS) is
		do
			put_breakable
			text_formatter_decorator.process_keyword_text (ti_if_keyword, Void)
			text_formatter_decorator.put_space
			text_formatter_decorator.new_expression
			l_as.condition.process (Current)
			text_formatter_decorator.put_space
			text_formatter_decorator.set_without_tabs
			text_formatter_decorator.process_keyword_text (ti_then_keyword, Void)
			text_formatter_decorator.put_new_line
			if l_as.compound /= Void then
				text_formatter_decorator.indent
				format_compound (l_as.compound)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
			if l_as.elsif_list /= Void then
				text_formatter_decorator.set_separator (ti_empty)
				text_formatter_decorator.set_no_new_line_between_tokens
				l_as.elsif_list.process (Current)
				text_formatter_decorator.set_separator (Void)
			end
			if l_as.else_part /= Void then
				text_formatter_decorator.process_keyword_text (ti_else_keyword, Void)
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				text_formatter_decorator.set_new_line_between_tokens
				format_compound (l_as.else_part)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
		end

	process_inspect_as (l_as: INSPECT_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			put_breakable
			text_formatter_decorator.process_keyword_text (ti_inspect_keyword, Void)
			text_formatter_decorator.put_space
			text_formatter_decorator.indent
			l_as.switch.process (Current)
			text_formatter_decorator.exdent
			text_formatter_decorator.put_new_line
			if l_as.case_list /= Void then
				text_formatter_decorator.set_separator (ti_empty)
				text_formatter_decorator.set_no_new_line_between_tokens
				l_as.case_list.process (Current)
			end
			if l_as.else_part /= Void then
				text_formatter_decorator.process_keyword_text (ti_else_keyword, Void)
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				text_formatter_decorator.set_separator (Void)
				text_formatter_decorator.set_new_line_between_tokens
				if not l_as.else_part.is_empty then
					format_compound (l_as.else_part)
					text_formatter_decorator.put_new_line
				end
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
		end

	process_instr_call_as (l_as: INSTR_CALL_AS) is
		do
			reset_last_class_and_type
			if not expr_type_visiting then
				put_breakable
			end
			l_as.call.process (Current)
		end

	process_loop_as (l_as: LOOP_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.process_keyword_text (ti_from_keyword, Void)
			text_formatter_decorator.set_separator (Void)
			text_formatter_decorator.set_new_line_between_tokens
			if l_as.from_part /= Void then
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				format_compound (l_as.from_part)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			else
				text_formatter_decorator.put_new_line
			end
			if l_as.invariant_part /= Void then
				text_formatter_decorator.process_keyword_text (ti_invariant_keyword, Void)
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				l_as.invariant_part.process (Current)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
			if l_as.variant_part /= Void and then not current_class.lace_class.is_syntax_standard then
				text_formatter_decorator.process_keyword_text (ti_variant_keyword, Void)
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				l_as.variant_part.process (Current)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.process_keyword_text (ti_until_keyword, Void)
			text_formatter_decorator.indent
			text_formatter_decorator.put_new_line
			text_formatter_decorator.new_expression
			put_breakable
			l_as.stop.process (Current)
			text_formatter_decorator.exdent
			text_formatter_decorator.put_new_line
			text_formatter_decorator.process_keyword_text (ti_loop_keyword, Void)
			if l_as.compound /= Void then
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				format_compound (l_as.compound)
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.put_new_line
			if l_as.variant_part /= Void and then current_class.lace_class.is_syntax_standard then
				text_formatter_decorator.process_keyword_text (ti_variant_keyword, Void)
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				l_as.variant_part.process (Current)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
		end

	process_retry_as (l_as: RETRY_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			put_breakable
			text_formatter_decorator.process_keyword_text (ti_retry_keyword, Void)
		end

	process_external_as (l_as: EXTERNAL_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.process_keyword_text (ti_external_keyword, Void)
			text_formatter_decorator.indent
			text_formatter_decorator.put_new_line
			l_as.language_name.process (Current)
			text_formatter_decorator.exdent
			text_formatter_decorator.put_new_line
			if l_as.alias_name_literal /= Void then
				text_formatter_decorator.process_keyword_text (ti_alias_keyword, Void)
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				l_as.alias_name_literal.process (Current)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
		end

	process_deferred_as (l_as: DEFERRED_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.process_keyword_text (ti_deferred_keyword, Void)
			text_formatter_decorator.put_new_line
		end

	process_attribute_as (l_as: ATTRIBUTE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.process_keyword_text (ti_attribute_keyword, Void)
			text_formatter_decorator.put_new_line
			if l_as.compound /= Void then
				text_formatter_decorator.indent
				format_compound (l_as.compound)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
		end

	process_do_as (l_as: DO_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.process_keyword_text (ti_do_keyword, Void)
			text_formatter_decorator.put_new_line
			if l_as.compound /= Void then
				text_formatter_decorator.indent
				format_compound (l_as.compound)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
		end

	process_once_as (l_as: ONCE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.process_keyword_text (ti_once_keyword, Void)
			text_formatter_decorator.put_new_line
			if l_as.compound /= Void then
				text_formatter_decorator.indent
				format_compound (l_as.compound)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
		end

	process_type_dec_as (l_as: TYPE_DEC_AS) is
		local
			l_names_heap: like names_heap
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.set_separator (ti_comma)
			text_formatter_decorator.set_space_between_tokens
			from
				l_names_heap := names_heap
				l_as.id_list.start
			until
				l_as.id_list.after
			loop
				text_formatter_decorator.process_local_text (l_names_heap.item (l_as.id_list.item))
				l_as.id_list.forth
				if not l_as.id_list.after then
					text_formatter_decorator.put_separator
				end
			end
			text_formatter_decorator.set_without_tabs
			text_formatter_decorator.process_symbol_text (ti_colon)
			text_formatter_decorator.put_space
			l_as.type.process (Current)
			if processing_locals and last_actual_local_type /= Void then
				from
					l_as.id_list.start
				until
					l_as.id_list.after
				loop
					locals_for_current_feature.put (last_actual_local_type, l_names_heap.item (l_as.id_list.item))
					l_as.id_list.forth
				end
			end
		end

	process_class_as (l_as: CLASS_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.process_filter_item (f_class_declaration, True)
			share_class_processing (l_as)
			text_formatter_decorator.process_filter_item (f_class_declaration, False)
			text_formatter_decorator.put_new_line
		end

	share_class_processing (l_as: CLASS_AS) is
			-- Shared part of `'processing_class_as' for both normal flat views and doc.
		local
			l_creators: EIFFEL_LIST [CREATE_AS]
			l_create: CREATE_AS
			l_features: EIFFEL_LIST [FEATURE_NAME]
			l_feat: FEATURE_I
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			processing_none_feature_part := True
			text_formatter_decorator.process_before_class (current_class)
			safe_process (l_as.top_indexes)
			format_header (l_as)
			if text_formatter_decorator.is_clickable_format and l_as.obsolete_message /= Void then
				text_formatter_decorator.put_new_line
				text_formatter_decorator.process_filter_item (f_obsolete, True)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_keyword_text (ti_obsolete_keyword, Void)
				text_formatter_decorator.put_space
				l_as.obsolete_message.process (Current)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_filter_item (f_obsolete, False)
				text_formatter_decorator.put_new_line
			end
				-- Process conforming inheritance.
			if text_formatter_decorator.is_clickable_format and l_as.conforming_parents /= Void then
				text_formatter_decorator.put_new_line
				text_formatter_decorator.process_filter_item (f_inheritance, True)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_keyword_text (ti_inherit_keyword, Void)
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				text_formatter_decorator.set_new_line_between_tokens
				text_formatter_decorator.set_separator (ti_new_line)
				processing_parents := True
				l_as.conforming_parents.process (Current)
				processing_parents := False
				text_formatter_decorator.process_filter_item (f_inheritance, False)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.put_new_line

				-- Process non-conforming inheritance.
			if text_formatter_decorator.is_clickable_format and l_as.non_conforming_parents /= Void then
				text_formatter_decorator.process_filter_item (f_inheritance, True)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_keyword_text (ti_inherit_keyword, Void)
				text_formatter_decorator.process_basic_text (ti_space)
				text_formatter_decorator.process_symbol_text (ti_l_curly)
				text_formatter_decorator.process_basic_text (ti_none_class)
				text_formatter_decorator.process_symbol_text (ti_r_curly)
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				text_formatter_decorator.set_new_line_between_tokens
				text_formatter_decorator.set_separator (ti_new_line)
				processing_parents := True
				l_as.non_conforming_parents.process (Current)
				processing_parents := False
				text_formatter_decorator.process_filter_item (f_inheritance, False)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.put_new_line

			l_creators := l_as.creators
			if l_creators = Void and then not l_as.is_deferred and then current_class.has_feature_table then
				l_feat := current_class.default_create_feature
				if l_feat /= Void then
					create l_creators.make (1)
					create l_features.make (1)
					l_features.extend (create {FEAT_NAME_ID_AS}.initialize (create {ID_AS}.initialize_from_id (l_feat.feature_name_id)))
					create l_create.initialize (Void, l_features, Void)
					l_creators.extend (l_create)
				end
			end
			if l_creators /= Void then
				check
					class_not_deferred: not l_as.is_deferred
				end
				text_formatter_decorator.process_filter_item (f_creators, True)
				text_formatter_decorator.set_separator (ti_empty)
				text_formatter_decorator.set_new_line_between_tokens
				l_creators.process (Current)
				text_formatter_decorator.process_filter_item (f_creators, False)
			end
			format_convert_clause (l_as.convertors)
			processing_none_feature_part := False
			text_formatter_decorator.format_categories
			text_formatter_decorator.format_invariants
			safe_process (l_as.bottom_indexes)
			text_formatter_decorator.process_filter_item (f_class_end, False)
			text_formatter_decorator.set_without_tabs
			text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
			text_formatter_decorator.process_after_class (current_class)
			text_formatter_decorator.process_filter_item (f_class_end, False)
		end

	process_parent_as (l_as: PARENT_AS) is
		local
			end_to_print: BOOLEAN
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.type.process (Current)
			check
				last_type_not_void: last_type /= Void
			end
			last_parent := last_type.associated_class
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
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
				text_formatter_decorator.exdent
			end
		end

	process_type_as (l_as: TYPE_AS) is
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
					text_formatter_decorator.process_local_text (l_as.dump)
				end
			end
		end

	process_like_id_as (l_as: LIKE_ID_AS) is
		do
			check_type (l_as)
			if processing_locals then
				last_actual_local_type := last_type
			end
			if not expr_type_visiting then
				if last_type /= Void then
					type_output_strategy.process (last_type, text_formatter_decorator, current_class, current_feature)
				else
					if l_as.has_attached_mark then
						text_formatter_decorator.process_symbol_text (ti_exclamation)
					elseif l_as.has_detachable_mark then
						text_formatter_decorator.process_symbol_text (ti_question)
					end
					text_formatter_decorator.process_keyword_text (ti_like_keyword, Void)
					text_formatter_decorator.add_space
					text_formatter_decorator.process_local_text (l_as.anchor.name)
				end
			end
		end

	process_like_cur_as (l_as: LIKE_CUR_AS) is
		do
			check_type (l_as)
			if processing_locals then
				last_actual_local_type := last_type
			end
			if not expr_type_visiting then
				type_output_strategy.process (last_type, text_formatter_decorator, current_class, current_feature)
			end
		end

	process_formal_as (l_as: FORMAL_AS) is
		do
			process_type_as (l_as)
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS) is
		local
			feature_name: FEAT_NAME_ID_AS
			l_constrained_type: TYPE_A
			l_constrained_type_set: TYPE_SET_A
			l_is_multi_constrained: BOOLEAN
			l_formal_dec: FORMAL_CONSTRAINT_AS
		do
			check
				not_expr_type_visiting: not expr_type_visiting
				not_processing_locals: not processing_locals
			end
			if l_as.is_self_initializing then
				text_formatter_decorator.process_symbol_text (ti_question)
			end
			if l_as.is_reference then
				text_formatter_decorator.process_keyword_text (ti_reference_keyword, Void)
				text_formatter_decorator.put_space
			elseif l_as.is_expanded then
				text_formatter_decorator.process_keyword_text (ti_expanded_keyword, Void)
				text_formatter_decorator.put_space
			end
			processing_formal_dec := True
			text_formatter_decorator.process_generic_text (l_as.name.name)
			if l_as.has_constraint then
				l_formal_dec ?= l_as
				check l_formal_dec_not_void: l_formal_dec /= Void end

				if l_formal_dec.has_multi_constraints then
						-- We're in the multi constrained case: G -> {A, B, C}
					l_is_multi_constrained := True
					l_constrained_type_set := l_formal_dec.constraint_types_if_possible (current_class)
				else
					l_constrained_type := l_formal_dec.constraint_type_if_possible (current_class)
				end

				text_formatter_decorator.put_space
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_constraint)
				text_formatter_decorator.put_space
				if l_is_multi_constrained then
					text_formatter_decorator.process_symbol_text (ti_l_curly)
				end
				l_as.constraints.process (Current)
				if l_is_multi_constrained then
					text_formatter_decorator.process_symbol_text (ti_r_curly)
				end

				if l_as.has_creation_constraint then
					from
						l_as.creation_feature_list.start
						text_formatter_decorator.put_space
						text_formatter_decorator.process_keyword_text (ti_create_keyword, Void)
						text_formatter_decorator.put_space
						feature_name ?= l_as.creation_feature_list.item
						append_feature_by_id (feature_name, l_constrained_type, l_constrained_type_set)
						l_as.creation_feature_list.forth
					until
						l_as.creation_feature_list.after
					loop
						text_formatter_decorator.process_symbol_text (ti_comma)
						text_formatter_decorator.put_space
						feature_name ?= l_as.creation_feature_list.item
						append_feature_by_id (feature_name, l_constrained_type, l_constrained_type_set)
						l_as.creation_feature_list.forth
					end
					text_formatter_decorator.put_space
					text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
				end
			end
			processing_formal_dec := False
		end

	process_constraining_type_as (l_as: CONSTRAINING_TYPE_AS) is
		local
			l_renaming: RENAME_CLAUSE_AS
			l_type: TYPE_AS
			l_cl_type_as: CLASS_TYPE_AS
			l_tmp_current_class: like current_class
			l_class_c: CLASS_C
		do
			l_type := l_as.type
			process_type_as (l_type)
			l_renaming := l_as.renaming
			if l_renaming /= Void then
				l_cl_type_as ?= l_type
					-- If we have a class type we try to find the class and set it as the `current_class'
					-- in order to make sure that feature lookups are done one the propper class.
				if l_cl_type_as /= Void then
					l_tmp_current_class := current_class
					l_class_c := universe.class_named (l_cl_type_as.class_name.name, l_tmp_current_class.group).compiled_class
					if l_class_c /= Void then
						set_current_class (l_class_c)
					else
							-- If this class is not compiled we cannot to any feature linking for possible renaming clauses
						has_error_internal := True
					end
				end
				text_formatter_decorator.add_space
				text_formatter_decorator.process_keyword_text (ti_rename_keyword, Void)
				text_formatter_decorator.add_space
				process_rename_clause_as (l_renaming)
				text_formatter_decorator.add_space
				text_formatter_decorator.process_keyword_text (ti_end_keyword, Void)
					-- If we changed the current_class set it back.
				if l_class_c /= Void then
					check l_tmp_current_class_not_void: l_tmp_current_class /= Void end
					set_current_class (l_tmp_current_class)
				end
			end
		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		do
			process_type_as (l_as)
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS) is
		do
			process_type_as (l_as)
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS) is
			-- Process `l_as'.
		do
			process_type_as (l_as)
		end

	process_none_type_as (l_as: NONE_TYPE_AS) is
		do
			process_type_as (l_as)
		end

	process_bits_as (l_as: BITS_AS) is
		do
			process_type_as (l_as)
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS) is
		do
			process_type_as (l_as)
		end

	process_rename_as (l_as: RENAME_AS) is
		local
			l_last_parent: like last_parent
			l_tmp_has_error_internal: BOOLEAN
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_tmp_has_error_internal := has_error_internal
			l_as.old_name.process (Current)
			text_formatter_decorator.put_space
			text_formatter_decorator.set_without_tabs
			text_formatter_decorator.process_keyword_text (ti_as_keyword, Void)
			text_formatter_decorator.put_space
			l_last_parent := last_parent
			last_parent := Void
			l_as.new_name.process (Current)
			last_parent := l_last_parent
			has_error_internal := l_tmp_has_error_internal
		end

	process_invariant_as (l_as: INVARIANT_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.begin
			text_formatter_decorator.set_new_line_between_tokens
			if l_as.assertion_list /= Void then
				invariant_format_assertions (l_as.assertion_list)
			end
			text_formatter_decorator.commit
		end

	process_interval_as (l_as: INTERVAL_AS) is
		do
			l_as.lower.process (Current)
			if l_as.upper /= Void then
				if not expr_type_visiting then
					text_formatter_decorator.set_without_tabs
					text_formatter_decorator.process_symbol_text (ti_dotdot)
				end
				l_as.upper.process (Current)
			end
		end

	process_index_as (l_as: INDEX_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if l_as.tag /= Void then
				text_formatter_decorator.process_indexing_tag_text (l_as.tag.name.twin)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_colon)
				text_formatter_decorator.put_space
			end
			text_formatter_decorator.set_in_indexing_clause (True)
			text_formatter_decorator.process_filter_item (f_indexing_content, True)
			text_formatter_decorator.set_space_between_tokens
			text_formatter_decorator.set_separator (ti_comma)
			l_as.index_list.process (Current)
			text_formatter_decorator.process_filter_item (f_indexing_content, False)
			text_formatter_decorator.set_in_indexing_clause (False)
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.set_separator (ti_comma)
			text_formatter_decorator.set_space_between_tokens
			l_as.clients.process (Current)
			text_formatter_decorator.put_space
			l_as.features.process (Current)
		end

	process_elseif_as (l_as: ELSIF_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			put_breakable
			text_formatter_decorator.process_keyword_text (ti_elseif_keyword, Void)
			text_formatter_decorator.put_space
			text_formatter_decorator.new_expression
			l_as.expr.process (Current)
			text_formatter_decorator.put_space
			text_formatter_decorator.set_without_tabs
			text_formatter_decorator.process_keyword_text (ti_then_keyword, Void)
			text_formatter_decorator.put_new_line
			if l_as.compound /= Void then
				text_formatter_decorator.indent
				format_compound (l_as.compound)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
		end

	process_create_as (l_as: CREATE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.begin
			text_formatter_decorator.process_keyword_text (ti_create_keyword, Void)
			text_formatter_decorator.put_space
			if l_as.clients /= Void then
				l_as.clients.process (Current)
			end
			text_formatter_decorator.put_new_line
			if l_as.feature_list /= Void then
				text_formatter_decorator.indent
				if text_formatter_decorator.is_flat_short then
					format_creation_features (l_as.feature_list)
				else
					text_formatter_decorator.set_new_line_between_tokens
					text_formatter_decorator.set_separator (ti_comma)
					l_as.feature_list.process (Current)
					text_formatter_decorator.put_new_line
					text_formatter_decorator.put_new_line
				end
			end
			text_formatter_decorator.commit
		end

	process_client_as (l_as: CLIENT_AS) is
		local
			temp: STRING
			cluster: CONF_GROUP
			client_classi: CLASS_I
			l_export_status: EXPORT_I
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			cluster := system.class_of_id (current_class.class_id).group
			text_formatter_decorator.begin
			text_formatter_decorator.process_symbol_text (ti_l_curly)
			text_formatter_decorator.set_separator (ti_comma)
			text_formatter_decorator.set_space_between_tokens
			l_export_status := export_status_generator.export_status (system, current_class, l_as)
			from
				l_as.clients.start
			until
				l_as.clients.after
			loop
				temp := l_as.clients.item.name
				client_classi := universe.safe_class_named (temp, cluster)
				if client_classi /= Void then
					text_formatter_decorator.put_classi (client_classi)
				else
					text_formatter_decorator.add (temp.as_upper)
				end
				l_as.clients.forth
				if not l_as.clients.after then
					text_formatter_decorator.set_without_tabs
					text_formatter_decorator.process_symbol_text (ti_comma)
					text_formatter_decorator.put_space
				end
			end
			text_formatter_decorator.set_without_tabs
			text_formatter_decorator.process_symbol_text (ti_r_curly)
			text_formatter_decorator.commit
		end

	process_case_as (l_as: CASE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			text_formatter_decorator.process_keyword_text (ti_when_keyword, Void)
			text_formatter_decorator.put_space
			text_formatter_decorator.set_separator (ti_comma)
			text_formatter_decorator.set_space_between_tokens
			l_as.interval.process (Current)
			text_formatter_decorator.put_space
			text_formatter_decorator.set_without_tabs
			text_formatter_decorator.process_keyword_text (ti_then_keyword, Void)
			text_formatter_decorator.put_space
			text_formatter_decorator.put_new_line
			if l_as.compound /= Void then
				text_formatter_decorator.indent
				format_compound (l_as.compound)
				text_formatter_decorator.put_new_line
				text_formatter_decorator.exdent
			end
		end

	process_ensure_as (l_as: ENSURE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			format_assert_list_as (l_as, ti_ensure_keyword)
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			format_assert_list_as (l_as, ti_ensure_then_keyword)
		end

	process_require_as (l_as: REQUIRE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			format_assert_list_as (l_as, ti_require_keyword)
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			format_assert_list_as (l_as, ti_require_else_keyword)
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.feature_name.process (Current)
			if l_as.is_creation_procedure then
				text_formatter_decorator.put_space
				text_formatter_decorator.process_symbol_text (ti_l_parenthesis)
			else
				text_formatter_decorator.process_symbol_text (ti_colon)
				text_formatter_decorator.put_space
			end
			text_formatter_decorator.process_symbol_text (ti_l_curly)
			l_as.conversion_types.process (Current)
			text_formatter_decorator.process_symbol_text (ti_r_curly)
			if l_as.is_creation_procedure then
				text_formatter_decorator.process_symbol_text (ti_r_parenthesis)
			end
		end

	process_void_as (l_as: VOID_AS) is
		do
			if not expr_type_visiting then
				text_formatter_decorator.process_keyword_text (ti_void, Void)
			end
			last_type := none_type
		end

	process_type_list_as (l_as: TYPE_LIST_AS) is
		do
			process_eiffel_list (l_as)
		end

	process_type_dec_list_as (l_as: TYPE_DEC_LIST_AS) is
		do
			process_eiffel_list (l_as)
		end

	process_convert_feat_list_as (l_as: CONVERT_FEAT_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

	process_class_list_as (l_as: CLASS_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

	process_parent_list_as (l_as: PARENT_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

	process_local_dec_list_as (l_as: LOCAL_DEC_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.locals.process (Current)
		end

	process_formal_argu_dec_list_as (l_as: FORMAL_ARGU_DEC_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.arguments.process (Current)
		end

	process_debug_key_list_as (l_as: DEBUG_KEY_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.keys.process (Current)
		end

	process_delayed_actual_list_as (l_as: DELAYED_ACTUAL_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.operands.process (Current)
		end

	process_parameter_list_as (l_as: PARAMETER_LIST_AS) is
		do
			l_as.parameters.process (Current)
		end

	process_rename_clause_as (l_as: RENAME_CLAUSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_export_clause_as (l_as: EXPORT_CLAUSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_undefine_clause_as (l_as: UNDEFINE_CLAUSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_redefine_clause_as (l_as: REDEFINE_CLAUSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_select_clause_as (l_as: SELECT_CLAUSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_formal_generic_list_as (l_as: FORMAL_GENERIC_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

feature -- Expression visitor

	expr_type (a_expr: EXPR_AS): TYPE_A is
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
			Result_is_not_a_type_set: not has_error_internal implies (not Result.is_type_set)
		end

	expr_types (a_exprs: EIFFEL_LIST [EXPR_AS]): ARRAY [TYPE_A] is
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
			create Result.make (1, a_exprs.count)
			from
				i := 1
				l_count := a_exprs.count
			until
				i > l_count
			loop
				a_exprs.i_th (i).process (Current)
				Result.put (last_type, i)
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

	append_feature_by_id (a_feature_name: FEAT_NAME_ID_AS; a_type: TYPE_A; a_type_set: TYPE_SET_A) is
			-- Append feature.
			--
			-- `a_feature_name_id' is the `NAMES_HEAP' ID of the feature name.
			-- `l_type' is the type where we lookup the feautre
			--| The code has 2 arguments as it suites the actual code better. (May be changed.)
		require
			not_both_void: a_type /= Void or a_type_set /= Void
		local
			l_feat: E_FEATURE
			l_result: TUPLE [feature_item: E_FEATURE; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]
			l_name_id: INTEGER
		do
			if a_type_set /= Void then
				l_result := a_type_set.e_feature_state_by_name_id (a_feature_name.feature_name.name_id)
				l_feat := l_result.feature_item
			elseif a_type /= Void then
				check a_type_not_void: a_type /= Void end
				if not a_type.is_formal then
					l_feat := a_type.associated_class.feature_with_name (a_feature_name.visual_name)
						-- Renaming situation
					if l_feat = Void and then a_type.has_renaming then
						l_name_id := a_type.renaming.renamed (a_feature_name.feature_name.name_id)
						if l_name_id /= -1 then
							l_feat := a_type.associated_class.feature_with_name_id (l_name_id)
						end
					end
				end
			end

			if l_feat /= Void then
				text_formatter_decorator.process_feature_text (a_feature_name.visual_name, l_feat, False)
			else
				text_formatter_decorator.process_local_text (a_feature_name.visual_name)
			end
		end

	append_format_multilined (s: STRING; indentable: BOOLEAN) is
		require
			string_not_void: s /= Void
			string_not_empty: not s.is_empty
			context_not_void: text_formatter_decorator /= Void
		local
			in_index: BOOLEAN
			sb: STRING
			l: INTEGER
			n: INTEGER
			m: INTEGER
		do
			in_index := text_formatter_decorator.in_indexing_clause
			if indentable then
				text_formatter_decorator.indent
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
					text_formatter_decorator.put_string_item (sb)
				elseif in_index then
					text_formatter_decorator.add_indexing_string (sb)
				else
					text_formatter_decorator.add_manifest_string (sb)
				end
				text_formatter_decorator.put_new_line
				n := m + 1
			end
			if indentable then
				text_formatter_decorator.exdent
			end
		end

	format_compound (lc: EIFFEL_LIST [INSTRUCTION_AS]) is
		require
			lc_not_void: lc /= Void
		local
			semicolon_candidate: BOOLEAN
		do
			text_formatter_decorator.begin
			from
				lc.start
			until
				lc.after
			loop
				has_error_internal := False
				reset_last_class_and_type
				text_formatter_decorator.new_expression
				text_formatter_decorator.begin
				lc.item.process (Current)
				text_formatter_decorator.commit
				semicolon_candidate := True
				lc.forth
				if not lc.after then
					if semicolon_candidate and then lc.item.starts_with_parenthesis then
						text_formatter_decorator.process_symbol_text (ti_semi_colon)
					end
					text_formatter_decorator.put_new_line
				end
			end
			text_formatter_decorator.commit
		end

	Carriage_return_char: CHARACTER is '%N'

	format_header (l_as: CLASS_AS) is
		require
			l_as_not_void: l_as /= Void
		do
			text_formatter_decorator.process_filter_item (f_class_header, True)
			if l_as.is_frozen then
				text_formatter_decorator.process_keyword_text (ti_frozen_keyword, Void)
				text_formatter_decorator.put_space
			end
			if l_as.is_expanded then
				text_formatter_decorator.process_keyword_text (ti_expanded_keyword, Void)
				text_formatter_decorator.put_space
			elseif l_as.is_deferred then
				text_formatter_decorator.process_keyword_text (ti_deferred_keyword, Void)
				text_formatter_decorator.put_space
			end
			text_formatter_decorator.process_keyword_text (ti_class_keyword, Void)
			text_formatter_decorator.put_space
			if text_formatter_decorator.is_short then
				text_formatter_decorator.process_keyword_text (ti_interface_keyword, Void)
			end
			text_formatter_decorator.indent
			text_formatter_decorator.put_new_line
			text_formatter_decorator.put_classi (current_class.lace_class)
			text_formatter_decorator.process_filter_item (f_class_header, False)
			text_formatter_decorator.exdent
			format_generics (l_as.generics)
			text_formatter_decorator.put_new_line
		end

	format_generics (l_as: EIFFEL_LIST [FORMAL_DEC_AS]) is
		do
			if l_as /= Void then
				text_formatter_decorator.put_space
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_l_bracket)
				text_formatter_decorator.set_space_between_tokens
				text_formatter_decorator.set_separator (ti_comma)
				l_as.process (Current)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_r_bracket)
			end
		end

	format_convert_clause (l_as: EIFFEL_LIST [CONVERT_FEAT_AS]) is
		do
			if l_as /= Void then
				text_formatter_decorator.process_keyword_text (ti_convert_keyword, Void)
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				text_formatter_decorator.set_new_line_between_tokens
				text_formatter_decorator.set_separator (ti_comma)
				l_as.process (Current)
				text_formatter_decorator.set_separator (ti_empty)
				text_formatter_decorator.exdent
				text_formatter_decorator.put_new_line
				text_formatter_decorator.put_new_line
			end
		end

	features_simple_format (l_as: EIFFEL_LIST [FEATURE_CLAUSE_AS]) is
		require
			l_as_not_void: l_as /= Void
		local
			i, l_count: INTEGER
			fc, next_fc: FEATURE_CLAUSE_AS
			feature_list: EIFFEL_LIST [FEATURE_AS]
		do
			text_formatter_decorator.begin
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
					text_formatter_decorator.put_separator
				end
				text_formatter_decorator.new_expression
				text_formatter_decorator.begin
				i := i + 1
				if i <= l_count then
					next_fc := l_as.i_th (i)
				end
				feature_list := fc.features
				fc.process (Current)
				fc := next_fc
				text_formatter_decorator.commit
			end
			text_formatter_decorator.commit
		end

	format_clause (a_keyword: STRING; a_clause: EIFFEL_LIST [AST_EIFFEL]; has_separator: BOOLEAN) is
		require
			a_keyword_not_void: a_keyword /= Void
			a_clause_not_void: a_clause /= Void
		do
			text_formatter_decorator.indent
			text_formatter_decorator.put_new_line
			text_formatter_decorator.process_keyword_text (a_keyword, Void)
			text_formatter_decorator.indent
			text_formatter_decorator.put_new_line
			text_formatter_decorator.set_new_line_between_tokens
			if has_separator then
				text_formatter_decorator.set_separator (ti_comma)
			else
				text_formatter_decorator.set_separator (ti_empty)
			end
			a_clause.process (Current)
			text_formatter_decorator.exdent
			text_formatter_decorator.exdent
		end

	format_tagged_as (l_as: TAGGED_AS; hide_breakable_marks: BOOLEAN) is
		require
			l_as_not_void: l_as /= Void
		do
			text_formatter_decorator.new_expression
			text_formatter_decorator.begin
			if not hide_breakable_marks then
				put_breakable
			end
			if l_as.tag /= Void then
				text_formatter_decorator.process_assertion_tag_text (l_as.tag.name.twin)
				text_formatter_decorator.set_without_tabs
				text_formatter_decorator.process_symbol_text (ti_colon)
				text_formatter_decorator.put_space
			end
			text_formatter_decorator.new_expression
			l_as.expr.process (Current)
			text_formatter_decorator.commit
		end

	invariant_format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]) is
		require
			l_as_not_vod: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			from
				text_formatter_decorator.begin
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				text_formatter_decorator.begin
				if not_first then
					text_formatter_decorator.put_separator
				end
				text_formatter_decorator.new_expression
				l_as.i_th (i).process (Current)
				not_first := True
				text_formatter_decorator.commit
				i := i + 1
			end
			if not_first then
				text_formatter_decorator.exdent
			end
			text_formatter_decorator.commit
		end

	invariant_simple_format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]) is
		require
			l_as_not_vod: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			text_formatter_decorator.begin
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				if not_first then
					text_formatter_decorator.put_separator
				end
				text_formatter_decorator.new_expression
				l_as.i_th (i).process (Current)
				not_first := True
				i := i + 1
			end
			text_formatter_decorator.commit
		end

	format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]; hide_breakable_marks: BOOLEAN) is
		require
			l_as_not_void: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			from
				text_formatter_decorator.begin
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				if not_first then
					text_formatter_decorator.put_separator
				end
				text_formatter_decorator.begin
				text_formatter_decorator.new_expression
				if hide_breakable_marks then
					format_tagged_as (l_as.i_th (i), True)
				else
					l_as.i_th (i).process (Current)
				end
				not_first := True
				text_formatter_decorator.commit
				i := i + 1
			end
			if not_first then
				text_formatter_decorator.exdent
				text_formatter_decorator.put_new_line
			end
			text_formatter_decorator.commit
		end

	simple_format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]) is
		require
			l_as_not_void: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			text_formatter_decorator.begin
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				if not_first then
					text_formatter_decorator.put_separator
				end
				text_formatter_decorator.new_expression
				text_formatter_decorator.begin
				l_as.i_th (i).process (Current)
				text_formatter_decorator.commit
				not_first := True
				i := i + 1
			end
			if l_count > 0 then
				text_formatter_decorator.put_new_line
			end
			text_formatter_decorator.commit
		end

	format_assert_list_as (l_as: ASSERT_LIST_AS; a_keyword: STRING) is
		require
			l_as_not_void: l_as /= Void
			a_keyword_not_void: a_keyword /= Void
		local
			source_cl, target_cl: CLASS_C
		do
			if l_as.assertions /= Void then
				text_formatter_decorator.begin
				text_formatter_decorator.process_keyword_text (a_keyword, Void)
				source_cl := text_formatter_decorator.source_class
				target_cl := current_class
				if source_cl /= target_cl then
					text_formatter_decorator.put_space
					text_formatter_decorator.process_comment_text (ti_dashdash, Void)
					text_formatter_decorator.put_space
					text_formatter_decorator.process_comment_text ("from ", Void)
					text_formatter_decorator.put_classi (source_cl.lace_class)
				end
				text_formatter_decorator.indent
				text_formatter_decorator.put_new_line
				text_formatter_decorator.set_new_line_between_tokens
				format_assertions (l_as.assertions, False)
				text_formatter_decorator.exdent
				text_formatter_decorator.set_first_assertion (False)
				text_formatter_decorator.commit
			end
		end

	format_creation_features (a_list: EIFFEL_LIST [FEATURE_NAME]) is
		require
			list_not_void: a_list /= Void
		local
			i, l_count: INTEGER
			item: FEATURE_NAME
			creators: HASH_TABLE [FEATURE_ADAPTER, STRING]
			feat_adapter: FEATURE_ADAPTER
		do
			text_formatter_decorator.begin
			creators := text_formatter_decorator.format_registration.creation_table
			from
				i := 1
				l_count := a_list.count
			until
				i > l_count
			loop
				item := a_list.i_th (i)
				feat_adapter := creators.item (item.internal_name.name)
				if feat_adapter /= Void then
					feat_adapter.format (text_formatter_decorator)
					text_formatter_decorator.put_new_line
				end
				i := i + 1
			end
			text_formatter_decorator.commit
		end

	current_assigner_feature: E_FEATURE is
		local
			l_feature: FEATURE_I
		do
			l_feature := feature_from_ancestors (source_class, current_feature.assigner_name_id)
			Result := feature_in_class (current_class, l_feature.rout_id_set)
		end

	feature_from_ancestors (a_current_class: CLASS_C; a_name_id: INTEGER): FEATURE_I is
		require
			a_current_class_not_void: a_current_class /= Void
		do
			Result := a_current_class.feature_table.item_id (a_name_id)
		end

	feature_from_type_set (a_type_set: TYPE_SET_A;	a_id_set: ID_SET): LIST[TUPLE[feature_item: E_FEATURE; class_type: RENAMED_TYPE_A [TYPE_A]]]
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

	feature_in_class (a_class_c: CLASS_C; a_id_set: ID_SET): E_FEATURE is
			-- Feature with `a_id_set' in `a_class_c'
		require
			a_classs_c_not_void: a_class_c /= Void
			a_id_set_not_void: a_id_set /= Void
		do
			if not has_error_internal and a_id_set.first = 0 then
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

	type_feature_i_from_ancestor (a_ancestor: CLASS_C; a_formal: FORMAL_A): TYPE_FEATURE_I is
			-- Formal constraint class from `a_ancestor'
		local
			l_type_feature_i: TYPE_FEATURE_I
		do
			l_type_feature_i := a_ancestor.formal_at_position (a_formal.position)
			Result := l_type_feature_i
		end

	type_from_ancestor (a_ancestor: CLASS_C; a_formal: FORMAL_A): TYPE_A is
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

	formal_constraint_class (a_type_feature_i: TYPE_FEATURE_I): CLASS_C is
			-- Formal constraint class from `a_type_feature_i'.
		local
			l_type: TYPE_A
			l_formal: FORMAL_A
			l_formal_dec: FORMAL_CONSTRAINT_AS
		do
			l_type := a_type_feature_i.type
			l_formal ?= l_type
			if l_formal /= Void then
				check
					current_class_has_generics: current_class.generics /= Void
				end
				l_formal_dec ?= current_class.generics.i_th (l_formal.position)
				check l_formal_dec_not_void: l_formal_dec /= Void end
				Result := l_formal_dec.constraint_type (current_class).type.associated_class
			else
				Result := l_type.associated_class
			end
		end

	strip_type: GEN_TYPE_A is
			-- Strip type
		require
			any_compiled: system.any_class.is_compiled
			array_compiled: system.array_class.is_compiled
		local
			generics: ARRAY [TYPE_A]
			any_type: CL_TYPE_A
		once
			create generics.make (1, 1)
			create any_type.make (system.any_id)
			generics.put (any_type, 1)
			create Result.make (system.array_id, generics)
		end

	string_type: CL_TYPE_A is
			-- Actual string type
		once
			Result := system.string_8_class.compiled_class.actual_type
		end

	check_type (a_type: TYPE_AS) is
			-- Evaluate `a_type' into a TYPE_A instance if valid.
			-- If not valid, raise a compiler error and return Void.
		require
			a_type_not_void: a_type /= Void
		local
			l_type: TYPE_A
		do
				-- Convert TYPE_AS into TYPE_A in the context of `source_class'.
			l_type := type_a_generator.evaluate_type_if_possible (a_type, source_class)

				-- An error occurs when a class was renamed.
			if not has_error_internal and l_type = Void then
				has_error_internal := True
				set_error_message ("Type evaluating failed.")
			end

			if not has_error_internal then
				-- If `source_feature' is Void, it means that we are outside of
				-- a feature, and therefore `l_type' must be valid because it should
				-- not have any anchors or bit symbols in `a_type'.
				if source_feature /= Void then
						-- Perform simple update of TYPE_A in context of `source_class'.
					type_a_checker.init_with_feature_table (source_feature, source_class.feature_table, Void, Void)
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

	agent_type (l_as: ROUTINE_CREATION_AS): GEN_TYPE_A is
			-- Compute type of `l_as'.
		require
			l_as_not_void: l_as /= Void
		local
			l_target_type: TYPE_A;
			l_arg_type:TYPE_A
			l_generics: ARRAY [TYPE_A]
			l_feat_args: E_FEATURE_ARGUMENTS
			l_oargtypes, l_argtypes: ARRAY [TYPE_A]
			l_tuple: TUPLE_TYPE_A
			l_count, l_idx, l_oidx: INTEGER
			l_operand: OPERAND_AS
			l_is_open: BOOLEAN
			l_result_type: GEN_TYPE_A
			l_actual_target_type: TYPE_A
			l_feat: E_FEATURE
			l_open: OPEN_TYPE_A
		do
			l_feat := feature_in_class (system.class_of_id (l_as.class_id), l_as.routine_ids)
			if not has_error_internal then
				if l_feat.has_return_value then
						-- generics are: base_type, open_types, result_type
					create l_generics.make (1, 3)
					l_generics.put (l_feat.type.actual_type, 3)
					create l_result_type.make (System.function_class_id, l_generics)
				else
						-- generics are: base_type, open_types
					create l_generics.make (1, 2)
					create l_result_type.make (System.procedure_class_id, l_generics)
				end

				if l_as.target = Void then
						-- Target is the closed operand `Current'.
					l_target_type := current_class.actual_type
				else
					l_as.target.process (Current)
					l_target_type := last_type
					l_open ?= l_target_type
					if l_open /= Void then
							-- Target is actually an open operand.
						l_target_type := current_class.actual_type
					end
				end

				l_actual_target_type := l_target_type.actual_type
				l_generics.put (l_target_type, 1)

				l_feat_args := l_feat.arguments

					-- Compute `operands_tuple' and type of TUPLE needed to determine current
					-- ROUTINE type.

					-- Create `l_argtypes', array used to initialize type of `operands_tuple'.
					-- This array can hold all arguments of the routine plus Current.
				if l_feat_args /= Void then
					l_count := l_feat_args.count + 1
				else
					l_count := 1
				end
				create l_argtypes.make (1, l_count)

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
				create l_oargtypes.make (1, l_count)

				if l_count > 0 then
					if l_oidx > 1 then
							-- Target is open, so insert it.
						l_oargtypes.put (l_target_type, 1)
					end
				end

					-- Always insert target's type in `l_argtypes' as first argument.
				l_argtypes.put (l_target_type, 1)

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
							l_oargtypes.put (l_arg_type, l_oidx)
							l_oidx := l_oidx + 1
						end

							-- Add type to `l_argtypes'.
						l_argtypes.put (l_arg_type, l_idx)

						l_idx := l_idx + 1
						l_feat_args.forth

						if l_as.operands /= Void then
							l_as.operands.forth
						end
					end
				end

					-- Create open argument type tuple
				create l_tuple.make (System.tuple_id, l_oargtypes)
					-- Insert it as second generic parameter of ROUTINE.
				l_generics.put (l_tuple, 2)

				Result := l_result_type
			end
		ensure
			agent_type_not_void_if_no_error: not has_error_internal implies Result /= Void
		end

	put_breakable
			-- Puts a breakable if needed.
		do
			if text_formatter_decorator.is_with_breakable then
				text_formatter_decorator.put_breakable
			end
		end

invariant
	text_formatter_not_void: text_formatter_decorator /= Void
	error_message_not_void: error_message /= Void
	has_error_implies_error_message_not_empty: has_error implies not error_message.is_empty
	locals_for_current_feature_not_void: locals_for_current_feature /= Void
	object_test_locals_for_current_feature_not_void: object_test_locals_for_current_feature /= Void

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class AST_DECORATED_OUTPUT_STRATEGY
