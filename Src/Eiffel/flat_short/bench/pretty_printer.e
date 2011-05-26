note
	description: "Eiffel Pretty Printer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PRETTY_PRINTER

inherit
	AST_ROUNDTRIP_ITERATOR
		redefine
			process_leading_leaves,

			-- Leafs
			process_keyword_as,
			process_symbol_as,
			process_break_as,
			process_leaf_stub_as,
			process_symbol_stub_as,
			process_bool_as,
			process_char_as,
			process_result_as,
			process_unique_as,
			process_void_as,
			process_string_as,
			process_verbatim_string_as,
			process_current_as,
			process_integer_as,
			process_real_as,
			process_id_as,

			-- Declarations
			process_class_as,
			process_invariant_as,

			-- Indexing
			process_indexing_clause_as,
			process_index_as,

			-- Inheritance
			process_parent_list_as,
			process_parent_as,
			process_rename_clause_as,
			process_rename_as,
			process_export_clause_as,
			process_export_item_as,
			process_class_list_as,
			process_feature_list_as,
			process_undefine_clause_as,
			process_redefine_clause_as,
			process_select_clause_as,
			process_infix_prefix_as,
			process_feat_name_id_as,
			process_feature_name_alias_as,

			-- Generics
			process_formal_generic_list_as,
			process_formal_dec_as,

			-- Creators
			process_create_as,

			-- Converters
			process_convert_feat_list_as,

			-- Features
			process_feature_clause_as,
			process_feature_as,
			process_body_as,
			process_formal_argu_dec_list_as,
			process_type_dec_as,
			process_constant_as,

			-- Routine
			process_routine_as,
			process_require_as,
			process_require_else_as,
			process_tagged_as,
			process_local_dec_list_as,
			process_deferred_as,
			process_external_as,
			process_attribute_as,
			process_do_as,
			process_once_as,
			process_key_list_as,
			process_ensure_as,
			process_ensure_then_as,

			-- Instructions
			process_assigner_call_as,
			process_assign_as,
			process_reverse_as,
			process_check_as,
			process_bang_creation_as,
			process_create_creation_as,
			process_debug_as,
			process_guard_as,
			process_if_as,
			process_elseif_as,
			process_inspect_as,
			process_case_as,
			process_instr_call_as,
			process_loop_as,
			process_iteration_as,
			process_variant_as,
			process_retry_as,

			-- Expressions
			process_typed_char_as,
			process_custom_attribute_as,
			process_binary_as,
			process_bin_and_then_as,
			process_bin_or_else_as,
			process_bracket_as,
			process_agent_routine_creation_as,
			process_inline_agent_creation_as,
			process_delayed_actual_list_as,
			process_tuple_as,
			process_unary_as,
			process_un_free_as,
			process_un_strip_as,
			process_loop_expr_as,
			process_object_test_as,
			process_array_as,

			-- Calls
			process_access_feat_as,
			process_parameter_list_as,
			process_access_inv_as,
			process_access_id_as,
			process_static_access_as,
			process_precursor_as,
			process_create_creation_expr_as,

			-- Types
			process_bits_as,
			process_bits_symbol_as,
			process_class_type_as,
			process_generic_class_type_as,
			process_formal_as,
			process_like_cur_as,
			process_like_id_as,
			process_named_tuple_type_as,
			process_qualified_anchored_type_as,
			process_constraining_type_as,
			process_type_list_as
		end

create
	make

feature {NONE} -- Initialization

	make (a_out_stream: like out_stream)
			-- Initialization
		require
			out_stream_ready: a_out_stream /= Void and then a_out_stream.is_open_write
		do
			out_stream := a_out_stream
			indent := ""
			set_will_process_leading_leaves (True)
		end

feature -- Access

	out_stream: KI_TEXT_OUTPUT_STREAM
			-- Output stream.

	indent: STRING
			-- Indentation string.

feature {NONE} -- Internal access

	last_printed: CHARACTER
			-- Last printed character.

	is_expr_iteration: BOOLEAN
			-- Flag indicating if an `ITERATION_AS' is used in a loop expression.

feature {NONE} -- Implementation

	print_string (s: STRING)
			-- Print `s' to the output stream.
		do
			if not s.is_empty then
				out_stream.put_string (s)
				last_printed := s.item (s.count)
			end
		end

	print_new_line
			-- Print a new line to the output stream.
		do
			print_string ("%N")
		end

	print_indent
			-- Print an indent to the output stream.
		do
			print_string ("%T")
		end

	safe_process_and_print (l_as: AST_EIFFEL; pre, post: STRING; add_new_line: BOOLEAN)
			-- Process `l_as' safely while printing `pre' before and `post' after processing.
		do
			if l_as /= Void then
				if l_as.first_token (match_list) /= Void then
					process_leading_leaves (l_as.first_token (match_list).index)
				end

					-- Only print a new line if it is not already done.
				if add_new_line and last_printed /= '%N' then
					print_new_line
				end

				if pre /= Void then
					print_string (pre)
				end

				l_as.process (Current)

				if post /= Void then
					print_string (post)
				end
			end
		end

	process_and_print_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL]; pre, post: STRING; exclude_last, add_new_line: BOOLEAN)
			-- Process an eiffel list while printing `pre' and `post' before and after
			-- processing of a list element.
		local
			i: INTEGER
			n: INTEGER
			m: INTEGER
			a: AST_EIFFEL
			l_token: LEAF_AS
		do
			if l_as /= Void then
				n := l_as.count
				if n > 0 then

					l_token := l_as.first_token (match_list)
					if l_token /= Void then
						process_leading_leaves (l_token.index)
					end

					from
						l_as.start
						i := 1
						if l_as.separator_list /= Void then
							m := l_as.separator_list.count
						end
					until
						i > n
					loop
						a := l_as.i_th (i)
						l_token := a.first_token (match_list)

						if l_token /= Void then
							process_leading_leaves (l_token.index)
						end
							-- Leading leaves may include optional delimiters such as semicolons,
							-- so `post' should be printed after them.
						if post /= Void and then i > 1 then
							print_string (post)
						end

						if add_new_line and last_printed /= '%N' then
							print_new_line
						end

						if pre /= Void then
							print_string (pre)
						end

						safe_process (a)
						if i <= m then
							safe_process (l_as.separator_list_i_th (i, match_list))
						end

						l_token := a.last_token (match_list)
						if l_token /= Void then
							process_leading_leaves (l_token.index)
						end

						i := i + 1
					end
					process_leading_leaves (l_as.last_token (match_list).index)
						-- Print `post' for the last item.
					if post /= Void and then not exclude_last then
						print_string (post)
					end
				end
			end
		end

	process_and_print_identifier_list (l_as: IDENTIFIER_LIST; pre, post: STRING; exclude_last, add_new_line: BOOLEAN)
			-- Process the identifier list `l_as' while printing `pre' and `post' before and after
			-- each item.
		local
			i, l_count: INTEGER
			l_index: INTEGER
			l_ids: CONSTRUCT_LIST [INTEGER]
			l_id_as: ID_AS
			l_leaf: LEAF_AS
		do
			if l_as /= Void then
				l_ids := l_as.id_list
				if l_ids /= Void and l_ids.count > 0 then
					from
						l_ids.start
						i := 1
							-- Temporary/reused objects to print identifiers.
						create l_id_as.initialize_from_id (1)
						if l_as.separator_list /= Void then
							l_count := l_as.separator_list.count
						end
					until
						l_ids.after
					loop
						l_index := l_ids.item
						if match_list.valid_index (l_index) then

							if add_new_line and last_printed /= '%N' then
								print_new_line
							end

							if pre /= Void then
								print_string (pre)
							end

							l_leaf := match_list.i_th (l_index)
								-- Note that we do not set the `name_id' for `l_id_as' since it will require
								-- updating the NAMES_HEAP and we do not want to do that. It is assumed in roundtrip
								-- mode that the text is never obtained from the node itself but from the `text' queries.
							l_id_as.set_position (l_leaf.line, l_leaf.column, l_leaf.position, l_leaf.location_count)
							l_id_as.set_index (l_index)
							safe_process (l_id_as)
						end
						if i <= l_count then
							safe_process (l_as.separator_list_i_th (i, match_list))
							i := i + 1
						end
						l_ids.forth

						if post /= Void then
							if not l_ids.after or not exclude_last then
								print_string (post)
							end
						end
					end
				end
			end
		end

	process_leading_leaves (ind: INTEGER_32)
			-- Process all not-processed leading leaves in `match_list' before index `ind'.
		local
			i: INTEGER
			l_as: LEAF_AS
		do
			if will_process_leading_leaves then
				if ind > last_index + 1 then
					from
						i := last_index + 1
					until
						i = ind
					loop
						l_as := match_list.i_th (i)
						if attached {BREAK_AS}l_as as break_as then
							safe_process (break_as)
						else
							safe_process_and_print (l_as, "", "", False)
						end
						i := i + 1
					end
				end
			end
		end

feature {CLASS_AS} -- Process leafs

	process_keyword_as (l_as: KEYWORD_AS)
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
			print_string (l_as.text_32 (match_list))
		end

	process_symbol_as (l_as: SYMBOL_AS)
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
			print_string (l_as.text_32 (match_list))
		end

	format_comment_string (l_as_string: STRING): STRING
			-- Formats the comment string `l_as_string' into a printable format.
		local
			i: INTEGER
			l_start_idx, l_end_idx: INTEGER
			inline_comment: BOOLEAN
		do
			-- The string can hold multiple comments, starting with '--'.
			-- Remove all '%N' and '%R' characters before and after each comment line.
			-- If there is a '%N' before a comment, it is printed on a new line with the
			-- current indent.
			--
			-- Check the preceding characters for newlines characters.
			inline_comment := True
			l_start_idx := l_as_string.substring_index ("--", 1)
			Result := ""

			from
				i := 1
			until
				i >= l_start_idx
			loop
				if l_as_string [i] = '%N' then
					inline_comment := False
					i := l_start_idx
				end
				i := i+1
			end

			from
				i := l_start_idx
			until
				i >= l_as_string.count
			loop
				if inline_comment then
					Result.append_character (' ')
				else
					Result.append ("%N%T" + indent)
				end

				l_end_idx := l_as_string.substring_index ("--", l_start_idx+2)
				if l_end_idx = 0 then
					l_end_idx := l_as_string.count + 1
				end

				from
					i := l_start_idx
				until
					i >= l_end_idx or l_as_string[i] = '%N' or l_as_string[i] = '%R'
				loop
					Result.append_character (l_as_string[i])
					i := i+1
				end

--				if inline_comment and l_end_idx > l_as_string.count then
				if l_end_idx > l_as_string.count then
					Result.append_character ('%N')
				end

				i := l_end_idx
				l_start_idx := l_end_idx
				inline_comment := False
			end
		end

	process_break_as (l_as: BREAK_AS)
			-- Process `l_as'.
		local
			l_text: STRING_32
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
			create l_text.make_from_string (l_as.text_32 (match_list))

			if l_text.has_substring ("--") then
				print_string (format_comment_string (l_text))
			end
		end

	process_leaf_stub_as (l_as: LEAF_STUB_AS)
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
			print_string (l_as.text_32 (match_list))
		end

	process_symbol_stub_as (l_as: SYMBOL_STUB_AS)
			-- Process `l_as'.
		do
			process_symbol_as (l_as)
		end

	process_bool_as (l_as: BOOL_AS)
			-- Process `l_as'.
		do
			process_keyword_as (l_as)
		end

	process_char_as (l_as: CHAR_AS)
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
			print_string (l_as.text_32 (match_list))
		end

	process_result_as (l_as: RESULT_AS)
			-- Process `l_as'.
		do
			process_keyword_as (l_as)
		end

	process_unique_as (l_as: UNIQUE_AS)
			-- Process `l_as'.
		do
			process_keyword_as (l_as)
		end

	process_void_as (l_as: VOID_AS)
			-- Process `l_as'.
		do
			process_keyword_as (l_as)
		end

	process_string_as (l_as: STRING_AS)
			-- Process `l_as'.
		do
			if l_as.is_once_string then
				safe_process_and_print (l_as.once_string_keyword (match_list), "", " ", False)
			end
			safe_process_and_print (l_as.type, "", " ", False)
			process_leading_leaves (l_as.index)
			last_index := l_as.index
			print_string (l_as.string_value_32)
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS)
			-- Process `l_as'.
		local
			s: STRING_32
			i, j, n: INTEGER
		do
			if l_as.is_once_string then
				safe_process_and_print (l_as.once_string_keyword (match_list), "", " ", False)
			end
			safe_process_and_print (l_as.type, "", " ", False)
			process_leading_leaves (l_as.index)
			last_index := l_as.index
			print_string ("%"")
			print_string (l_as.verbatim_marker)
			s := l_as.value_32
			if l_as.is_indentable then
				print_string ("[")
				print_new_line
				indent.append_character ('%T')
				from
					i := 1
					n := s.count
				until
					i > n
				loop
					j := s.index_of ('%N', i)
					if j = 0 then
						j := n + 1
					end
					print_string (indent)
					print_string (s.substring (i, j - 1))
					print_new_line
					i := j + 1
				end
				indent.remove_tail (1)
				print_string (indent)
				print_string ("]")
			else
				print_string ("{")
				print_new_line
				print_string (s)
				print_new_line
				print_string (indent)
				print_string ("}")
			end
			print_string (l_as.verbatim_marker)
			print_string ("%"")
		end

	process_current_as (l_as: CURRENT_AS)
			-- Process `l_as'.
		do
			process_keyword_as (l_as)
		end

	process_integer_as (l_as: INTEGER_AS)
			-- Process `l_as'.
		do
		--	process_leading_leaves (l_as.index)
			last_index := l_as.index
			print_string (l_as.text_32 (match_list))
		end

	process_real_as (l_as: REAL_AS)
			-- Process `l_as'.
		do
			last_index := l_as.index
			-- process_leading_leaves (l_as.index)
			-- last_index := l_as.index
			print_string (l_as.text_32 (match_list))
		end

	process_id_as (l_as: ID_AS)
			-- Process `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index
			print_string (l_as.text_32 (match_list))
		end

feature {CLASS_AS} -- Class Declarations

	process_class_as (l_as: CLASS_AS)
			-- Process class declaration `l_as'.
		do
			-- Indexing
			indent := ""
			safe_process_and_print (l_as.internal_top_indexes, "", "%N%N", False)

			-- Keywords
			safe_process_and_print (l_as.frozen_keyword (match_list), "", " ", False)
			safe_process_and_print (l_as.deferred_keyword (match_list), "", " ", False)
			safe_process_and_print (l_as.expanded_keyword (match_list), "", " ", False)
			safe_process_and_print (l_as.separate_keyword (match_list), "", " ", False)
			safe_process_and_print (l_as.external_keyword (match_list), "", " ", False)

			safe_process_and_print (l_as.class_keyword (match_list), "", "", False)

			-- Class name
			safe_process_and_print (l_as.class_name, "%T", "", True)

			-- Generics
			safe_process_and_print (l_as.internal_generics, " ", "", False)

			-- External
			safe_process_and_print (l_as.alias_keyword (match_list), "%T%T", "", True)
			safe_process_and_print (l_as.external_class_name, " ", "", False)

			-- Obsolete
			safe_process_and_print (l_as.obsolete_keyword (match_list), "%T%T", "", True)
			safe_process_and_print (l_as.obsolete_message, " ", "", False)

			-- Conforming inheritance
			safe_process_and_print (l_as.internal_conforming_parents, "%N", "", True)

			-- Non-conforming inheritance
			safe_process_and_print (l_as.internal_non_conforming_parents, "%N", "", True)

			-- Creators
			process_and_print_eiffel_list (l_as.creators, "%N", "", False, True)

			-- Convertors
			safe_process_and_print (l_as.convertors, "%N", "", True)

			-- Features
			process_and_print_eiffel_list (l_as.features, "%N", "", False, True)

			-- Invariant
			safe_process_and_print (l_as.internal_invariant, "%N", "", True)

			-- Indexes
			indent := ""
			safe_process_and_print (l_as.internal_bottom_indexes, "%N", "", True)

			-- End keyword
			safe_process_and_print (l_as.end_keyword, "%N", "", True)

			-- Ending comments
			if l_as.end_keyword.index < match_list.count then
				end_index := match_list.count+1
				process_leading_leaves (match_list.count+1)
			end
			if last_printed /= '%N' then
				print_new_line
			end
		end

	process_invariant_as (l_as: INVARIANT_AS)
			-- Process invariant clause `l_as'.
		do
			safe_process_and_print (l_as.invariant_keyword (match_list), "", "", True)
			process_and_print_eiffel_list (l_as.full_assertion_list, "%T", "", False, True)
		end

feature {CLASS_AS} -- Indexing

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS)
			-- Process indexing clause `l_as'
		do
			safe_process (l_as.indexing_keyword (match_list))
			indent.append_character ('%T')
			process_and_print_eiffel_list (l_as, indent, "", False, True)
			indent.remove_tail (1)
			safe_process (l_as.end_keyword (match_list))
		end

	process_index_as (l_as: INDEX_AS)
			-- Process index `l_as'
		do
			safe_process (l_as.tag)
			safe_process (l_as.colon_symbol (match_list))
			process_and_print_eiffel_list (l_as.index_list, " ", "", False, False)
		end

feature {CLASS_AS} -- Inheritance

	process_parent_list_as (l_as: PARENT_LIST_AS)
			-- Process parent list `l_as'.
		do
			safe_process (l_as.inherit_keyword (match_list))
			safe_process_and_print (l_as.lcurly_symbol (match_list), " ", "", False)
			safe_process (l_as.none_id_as (match_list))
			safe_process (l_as.rcurly_symbol (match_list))
			process_and_print_eiffel_list (l_as, "%N%T", "", False, True)
		end

	process_parent_as (l_as: PARENT_AS)
			-- Process parent `l_as'.
		do
			safe_process (l_as.type)
			safe_process_and_print (l_as.internal_renaming, "%T%T", "", True)
			safe_process_and_print (l_as.internal_exports, "%T%T", "", True)
			safe_process_and_print (l_as.internal_undefining, "%T%T", "", True)
			safe_process_and_print (l_as.internal_redefining, "%T%T", "", True)
			safe_process_and_print (l_as.internal_selecting, "%T%T", "", True)
			safe_process_and_print (l_as.end_keyword (match_list), "%T%T", "", True)
		end

	process_inherit_clause_as (l_as: INHERIT_CLAUSE_AS [EIFFEL_LIST [AST_EIFFEL]])
			-- Process inherit clause `l_as'.
		do
			safe_process (l_as.clause_keyword (match_list))
			process_and_print_eiffel_list (l_as.content, "%T%T%T", "", False, True)
		end

	process_rename_clause_as (l_as: RENAME_CLAUSE_AS)
			-- Process `l_as'.
		do
			process_inherit_clause_as (l_as)
		end

	process_rename_as (l_as: RENAME_AS)
		do
			safe_process (l_as.old_name)
			safe_process_and_print (l_as.as_keyword (match_list), " ", " ", False)
			safe_process (l_as.new_name)
		end

	process_export_clause_as (l_as: EXPORT_CLAUSE_AS)
			-- Process `l_as'.
		do
			process_inherit_clause_as (l_as)
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS)
		do
			safe_process (l_as.clients)
			safe_process_and_print (l_as.features, " ", "", False)
		end

	process_class_list_as (l_as: CLASS_LIST_AS)
			-- Process `l_as'.
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_and_print_eiffel_list (l_as, "", " ", True, False)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_feature_list_as (l_as: FEATURE_LIST_AS)
		do
			process_and_print_eiffel_list (l_as.features, "", " ", True, False)
		end

	process_undefine_clause_as (l_as: UNDEFINE_CLAUSE_AS)
			-- Process `l_as'.
		do
			process_inherit_clause_as (l_as)
		end

	process_redefine_clause_as (l_as: REDEFINE_CLAUSE_AS)
			-- Process `l_as'.
		do
			process_inherit_clause_as (l_as)
		end

	process_select_clause_as (l_as: SELECT_CLAUSE_AS)
			-- Process `l_as'.
		do
			process_inherit_clause_as (l_as)
		end

	process_infix_prefix_as (l_as: INFIX_PREFIX_AS)
		do
			safe_process_and_print (l_as.frozen_keyword, "", " ", False)
			safe_process_and_print (l_as.infix_prefix_keyword, "", " ", False)
			safe_process (l_as.alias_name)
		end

	process_feat_name_id_as (l_as: FEAT_NAME_ID_AS)
		do
			safe_process_and_print (l_as.frozen_keyword, "", " ", False)
			safe_process (l_as.feature_name)
		end

	process_feature_name_alias_as (l_as: FEATURE_NAME_ALIAS_AS)
		do
			safe_process_and_print (l_as.frozen_keyword, "", " ", False)
			safe_process (l_as.feature_name)
			if l_as.alias_name /= Void then
				safe_process_and_print (l_as.alias_keyword (match_list), " ", " ", False)
				safe_process (l_as.alias_name)
				if l_as.has_convert_mark then
					safe_process_and_print (l_as.convert_keyword (match_list), " ", "", False)
				end
			end
		end

feature {CLASS_AS} -- Generics

	process_formal_generic_list_as (l_as: FORMAL_GENERIC_LIST_AS)
			-- Process generic list `l_as'.
		do
			safe_process (l_as.lsqure_symbol (match_list))
			process_and_print_eiffel_list (l_as, "", " ", True, False)
			safe_process (l_as.rsqure_symbol (match_list))
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS)
			-- Process formal declaration `l_as'.
		do
			safe_process (l_as.formal)
			safe_process_and_print (l_as.constrain_symbol (match_list), " ", " ", False)
			safe_process (l_as.constraints)
			safe_process_and_print (l_as.create_keyword (match_list), " ", "", False)
			safe_process_and_print (l_as.creation_feature_list, " ", "", False)
			safe_process_and_print (l_as.end_keyword (match_list), " ", "", False)
		end

feature {CLASS_AS} -- Creators

	process_create_as (l_as: CREATE_AS)
			-- Process creator list `l_as'.
		do
			safe_process (l_as.create_creation_keyword (match_list))
			safe_process_and_print (l_as.clients, " ", "", False)

			if l_as.feature_list /= Void and then l_as.feature_list.first_token (match_list) /= Void then
				process_leading_leaves (l_as.feature_list.first_token (match_list).index)
			end
			if last_printed /= '%N' then
				print_new_line
			end
			print_indent

			process_and_print_eiffel_list (l_as.feature_list, "", " ", True, False)
		end

feature {CLASS_AS} -- Convertors

	process_convert_feat_list_as (l_as: CONVERT_FEAT_LIST_AS)
			-- Process convertor feature list `l_as'.
		do
			safe_process (l_as.convert_keyword (match_list))

			process_leading_leaves (l_as.i_th (1).first_token (match_list).index)
			if last_printed /= '%N' then
				print_new_line
			end

			print_indent
			process_and_print_eiffel_list (l_as, "", " ", True, False)
		end

feature {CLASS_AS} -- Features

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
			-- Process feature clause `l_as'.
		do
			safe_process (l_as.feature_keyword)
			safe_process_and_print (l_as.clients, " ", "", False)
			process_and_print_eiffel_list (l_as.features, "%N%T", "", False, True)
		end

	process_feature_as (l_as: FEATURE_AS)
			-- Process feature `l_as'.
		do
			process_and_print_eiffel_list (l_as.feature_names, "", " ", True, False)

			indent := "%T%T"
			safe_process (l_as.body)
		end

	process_body_as (l_as: BODY_AS)
			-- Process feature body `l_as'.
		do
			safe_process_and_print (l_as.internal_arguments, " ", "", False)
			safe_process_and_print (l_as.colon_symbol (match_list), "", " ", False)
			safe_process (l_as.type)
			safe_process_and_print (l_as.assign_keyword (match_list), " ", "", False)
			safe_process_and_print (l_as.assigner, " ", "", False)

			-- Ignore the 'is' keyword
			-- safe_process (l_as.is_keyword (match_list))

			if attached {CONSTANT_AS}l_as.content as c_as then
				print_string (" ")
				process_leading_leaves (c_as.first_token (match_list).index)
				print_string (" ")
				last_index := c_as.first_token (match_list).index

				safe_process (c_as)
				safe_process (l_as.indexing_clause)
			else
				safe_process (l_as.indexing_clause)
				safe_process (l_as.content)
			end
		end

	process_formal_argu_dec_list_as (l_as: FORMAL_ARGU_DEC_LIST_AS)
			-- Process argument declaration list `l_as'.
		do
			safe_process (l_as.lparan_symbol (match_list))
			process_and_print_eiffel_list (l_as.arguments, "", " ", True, False)
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_type_dec_as (l_as: TYPE_DEC_AS)
			-- Process type declaration `l_as'.
		do
			process_and_print_identifier_list (l_as.id_list, "", " ", True, False)
			safe_process (l_as.colon_symbol (match_list))
			print_string (" ")
			safe_process (l_as.type)
		end

	process_constant_as (l_as: CONSTANT_AS)
			-- Process constant feature `l_as'.
		do
			safe_process (l_as.value)
		end

feature {CLASS_AS} -- Routine

	process_routine_as (l_as: ROUTINE_AS)
			-- Process routine feature `l_as'.
		do
			safe_process_and_print (l_as.obsolete_keyword (match_list), indent, "", True)
			safe_process_and_print (l_as.obsolete_message, " ", "", False)
			safe_process (l_as.precondition)
			safe_process (l_as.internal_locals)
			safe_process (l_as.routine_body)
			safe_process (l_as.postcondition)

			safe_process_and_print (l_as.rescue_keyword (match_list), indent, "", True)
			indent.append ("%T")
			safe_process (l_as.rescue_clause)
			indent.remove_tail (1)

			safe_process_and_print (l_as.end_keyword, indent, "", True)
		end

	process_require_as (l_as: REQUIRE_AS)
			-- Process precondition clause `l_as'.
		do
			safe_process_and_print (l_as.require_keyword (match_list), indent, "", True)
			process_and_print_eiffel_list (l_as.full_assertion_list, "%T" + indent, "", False, True)
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS)
			-- Process precondition clause `l_as'.
		do
			safe_process_and_print (l_as.require_keyword (match_list), indent, "", True)
			safe_process_and_print (l_as.else_keyword (match_list), " ", "", False)
			process_and_print_eiffel_list (l_as.full_assertion_list, "%T" + indent, "", False, True)
		end

	process_tagged_as (l_as: TAGGED_AS)
			-- Process tagged `l_as'.
		do
			safe_process (l_as.tag)
			safe_process_and_print (l_as.colon_symbol (match_list), "", " ", False)
			safe_process (l_as.expr)
		end

	process_local_dec_list_as (l_as: LOCAL_DEC_LIST_AS)
			-- Process local declaration list `l_as'.
		do
			safe_process_and_print (l_as.local_keyword (match_list), indent, "", True)
			process_and_print_eiffel_list (l_as.locals, "%T" + indent, "", False, True)
		end

	process_deferred_as (l_as: DEFERRED_AS)
			-- Process deferred routine `l_as'.
		do
			process_leading_leaves (l_as.index)
			last_index := l_as.index

			if last_printed /= '%N' then
				print_new_line
			end
			print_string (indent + l_as.text_32 (match_list))
		end

	process_external_as (l_as: EXTERNAL_AS)
			-- Process external routine `l_as'.
		do
			safe_process_and_print (l_as.external_keyword (match_list), indent, "", True)
			safe_process_and_print (l_as.language_name, " ", "", False)
			safe_process_and_print (l_as.alias_keyword (match_list), " ", "", False)
			safe_process_and_print (l_as.alias_name_literal, " ", "", False)
		end

	process_attribute_as (l_as: ATTRIBUTE_AS)
			-- Process attribute routine `l_as'
		do
			safe_process_and_print (l_as.attribute_keyword (match_list), indent, "", True)
			indent.append ("%T")
			safe_process (l_as.compound)
			indent.remove_tail (1)
		end

	process_do_as (l_as: DO_AS)
			-- Process do routine `l_as'.
		do
			safe_process_and_print (l_as.do_keyword (match_list), indent, "", True)
			indent.append ("%T")
			safe_process (l_as.compound)
			indent.remove_tail (1)
		end

	process_once_as (l_as: ONCE_AS)
			-- Process once routine `l_as'.
		do
			safe_process_and_print (l_as.once_keyword (match_list), indent, "", True)
			safe_process_and_print (l_as.internal_keys, " ", "", False)
			indent.append ("%T")
			safe_process (l_as.compound)
			indent.remove_tail (1)
		end

	process_key_list_as (l_as: KEY_LIST_AS)
			-- Process key list `l_as'.
		do
			safe_process (l_as.lparan_symbol (match_list))
			process_and_print_eiffel_list (l_as.keys, "", " ", True, False)
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_ensure_as (l_as: ENSURE_AS)
			-- Process postcondition `l_as'.
		do
			safe_process_and_print (l_as.ensure_keyword (match_list), indent, "", True)
			process_and_print_eiffel_list (l_as.full_assertion_list, "%T" + indent, "", False, True)
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS)
			-- Process postcondition `l_as'.
		do
			safe_process_and_print (l_as.ensure_keyword (match_list), indent, "", True)
			safe_process_and_print (l_as.then_keyword (match_list), " ", "", False)
			process_and_print_eiffel_list (l_as.full_assertion_list, "%T" + indent, "", False, True)
		end

feature {CLASS_AS} -- Instructions

	process_assign_as (l_as: ASSIGN_AS)
			-- Process assign instruction `l_as'.
		do
			safe_process_and_print (l_as.target, indent, "", True)
			safe_process_and_print (l_as.assignment_symbol (match_list), " ", " ", False)
			safe_process (l_as.source)
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS)
			-- Process assigner call instruction `l_as'.
		do
			safe_process_and_print (l_as.target, indent, "", True)
			safe_process_and_print (l_as.assignment_symbol, " ", " ", False)
			safe_process (l_as.source)
		end

	process_reverse_as (l_as: REVERSE_AS)
			-- Process reverse assign instruction `l_as'.
		do
			process_assign_as (l_as)
		end

	process_check_as (l_as: CHECK_AS)
			-- Process check instruction `l_as'.
		do
			safe_process_and_print (l_as.check_keyword (match_list), indent, "", True)
			process_and_print_eiffel_list (l_as.full_assertion_list, "%T" + indent, "", False, True)
			safe_process_and_print (l_as.end_keyword, indent, "", True)
		end

	process_bang_creation_as (l_as: BANG_CREATION_AS)
			-- Process bang creation instruction `l_as'.
		do
			safe_process_and_print (l_as.lbang_symbol, indent, "", True)
			safe_process (l_as.type)
			safe_process (l_as.rbang_symbol)
			safe_process (l_as.target)
			safe_process (l_as.call)
		end

	process_create_creation_as (l_as: CREATE_CREATION_AS)
			-- Process create creation instruction `l_as'.
		do
			safe_process_and_print (l_as.create_keyword (match_list), indent, " ", True)
			safe_process_and_print (l_as.type, "", " ", False)
			safe_process (l_as.target)
			safe_process (l_as.call)
		end

	process_debug_as (l_as: DEBUG_AS)
			-- Process debug instruction `l_as'.
		do
			safe_process_and_print (l_as.debug_keyword (match_list), indent, "", True)
			safe_process_and_print (l_as.internal_keys, " ", "", False)
			indent.append ("%T")
			safe_process (l_as.compound)
			indent.remove_tail (1)
			safe_process_and_print (l_as.end_keyword, indent, "", True)
		end

	process_guard_as (l_as: GUARD_AS)
			-- Process guard instruction `l_as'.
		do
			safe_process_and_print (l_as.check_keyword (match_list), indent, "", True)
			process_and_print_eiffel_list (l_as.full_assertion_list, "%T" + indent, "", False, True)
			safe_process_and_print (l_as.then_keyword (match_list), indent, "", True)
			indent.append ("%T")
			safe_process (l_as.compound)
			indent.remove_tail (1)
			safe_process_and_print (l_as.end_keyword, indent, "", True)
		end

	process_if_as (l_as: IF_AS)
			-- Process if instruction `l_as'.
		do
			safe_process_and_print (l_as.if_keyword (match_list), indent, "", True)
			safe_process_and_print (l_as.condition, " ", "", False)
			safe_process_and_print (l_as.then_keyword (match_list), " ", "", False)

			indent.append ("%T")
			safe_process (l_as.compound)
			indent.remove_tail (1)

			safe_process (l_as.elsif_list)

			safe_process_and_print (l_as.else_keyword (match_list), indent, "", True)
			indent.append ("%T")
			safe_process (l_as.else_part)
			indent.remove_tail (1)

			safe_process_and_print (l_as.end_keyword, indent, "", True)
		end

	process_elseif_as (l_as: ELSIF_AS)
			-- Process elseif-clause `l_as'.
		do
			safe_process_and_print (l_as.elseif_keyword (match_list), indent, "", True)
			safe_process_and_print (l_as.expr, " ", "", False)
			safe_process_and_print (l_as.then_keyword (match_list), " ", "", False)

			indent.append ("%T")
			safe_process (l_as.compound)
			indent.remove_tail (1)
		end

	process_inspect_as (l_as: INSPECT_AS)
			-- Process inspect instruction `l_as'.
		do
			safe_process_and_print (l_as.inspect_keyword (match_list), indent, "", True)
			safe_process_and_print (l_as.switch, " ", "", False)

			safe_process (l_as.case_list)

			safe_process_and_print (l_as.else_keyword (match_list), indent, "", True)

			indent.append ("%T")
			safe_process (l_as.else_part)
			indent.remove_tail (1)

			safe_process_and_print (l_as.end_keyword, indent, "", True)
		end

	process_case_as (l_as: CASE_AS)
			-- Process inspect case `l_as'
		do
			safe_process_and_print (l_as.when_keyword (match_list), indent, "", True)
			safe_process_and_print (l_as.interval, " ", "", False)
			safe_process_and_print (l_as.then_keyword (match_list), " ", "", False)

			indent.append ("%T")
			safe_process (l_as.compound)
			indent.remove_tail (1)
		end

	process_instr_call_as (l_as: INSTR_CALL_AS)
			-- Process instr call instruction `l_as'.
		do
			safe_process_and_print (l_as.call, indent, "", True)
		end

	process_loop_as (l_as: LOOP_AS)
			-- Process loop instruction `l_as'.
		local
			l_until: KEYWORD_AS
			l_variant_processing_after: BOOLEAN
		do
			is_expr_iteration := False
			safe_process_and_print (l_as.iteration, indent, "", True)

			safe_process_and_print (l_as.from_keyword (match_list), indent, "", True)
			indent.append ("%T")
			safe_process (l_as.from_part)
			indent.remove_tail (1)

			safe_process_and_print (l_as.invariant_keyword (match_list), indent, "", True)
			process_and_print_eiffel_list (l_as.full_invariant_list, "%T" + indent, "", False, True)

				-- Special code to handle the old or new ordering of the `variant'
				-- clause in a loop.
			l_until := l_as.until_keyword (match_list)
			if l_as.variant_part /= Void and l_until /= Void then
				if l_as.variant_part.start_position > l_until.start_position then
					l_variant_processing_after := True
				else
					safe_process_and_print (l_as.variant_part, indent, "", True)
				end
			else
				safe_process_and_print (l_as.variant_part, indent, "", True)
			end

			safe_process_and_print (l_until, indent, "", True)
			safe_process_and_print (l_as.stop, "%T" + indent, "", True)

			safe_process_and_print (l_as.loop_keyword (match_list), indent, "", True)

			indent.append ("%T")
			safe_process (l_as.compound)
			indent.remove_tail (1)

			if l_variant_processing_after then
				safe_process_and_print (l_as.variant_part, indent, "", True)
			end

			safe_process_and_print (l_as.end_keyword, indent, "", True)
		end

	process_iteration_as (l_as: ITERATION_AS)
		do
			safe_process (l_as.across_keyword (match_list))

				-- If used in a loop statement, we want the expression on a new line.
				-- If used in an expression, it should appear on the same line.
			if is_expr_iteration then
				safe_process_and_print (l_as.expression, " ", "", False)
			else
				safe_process_and_print (l_as.expression, "%T" + indent, "", True)
			end

			safe_process_and_print (l_as.as_keyword (match_list), " ", "", False)
			safe_process_and_print (l_as.identifier, " ", "", False)
		end

	process_variant_as (l_as: VARIANT_AS)
			-- Process variant `l_as'.
		do
			safe_process_and_print (l_as.variant_keyword (match_list), "", " ", False)
			if l_as.expr /= Void then
				safe_process_and_print (l_as.tag, "%T" + indent, "", True)
				safe_process_and_print (l_as.colon_symbol (match_list), "", " ", False)
				safe_process (l_as.expr)
			end
		end

	process_retry_as (l_as: RETRY_AS)
			-- Process retry instruction `l_as'.
		do
			process_keyword_as (l_as)
		end

feature {CLASS_AS} -- Expressions

	process_typed_char_as (l_as: TYPED_CHAR_AS)
			-- Process typed char expression `l_as'.
		do
			safe_process (l_as.type)
			process_char_as (l_as)
		end

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS)
			-- Process custom attribute expression `l_as'.
		do
			safe_process (l_as.creation_expr)
			safe_process_and_print (l_as.tuple, " ", "", False)
			safe_process_and_print (l_as.end_keyword (match_list), " ", "", False)
		end

	process_binary_as (l_as: BINARY_AS)
			-- Process binary expression `l_as'.
		do
			safe_process (l_as.left)
			safe_process_and_print (l_as.operator (match_list), " ", " ", False)
			safe_process (l_as.right)
		end

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS)
			-- Process 'and then' expression `l_as'.
		do
			safe_process (l_as.left)
			safe_process_and_print (l_as.and_keyword (match_list), " ", " ", False)
			safe_process_and_print (l_as.then_keyword (match_list), "", " ", False)
			safe_process (l_as.right)
		end

	process_bin_or_else_as (l_as: BIN_OR_ELSE_AS)
			-- Process 'or else' expression `l_as'.
		do
			safe_process (l_as.left)
			safe_process_and_print (l_as.or_keyword (match_list), " ", " ", False)
			safe_process_and_print (l_as.else_keyword (match_list), "", " ", False)
			safe_process (l_as.right)
		end

	process_bracket_as (l_as: BRACKET_AS)
			-- Process bracket expression `l_as'.
		do
			safe_process (l_as.target)
			safe_process_and_print (l_as.lbracket_symbol, " ", "", False)
			safe_process (l_as.operands)
			safe_process (l_as.rbracket_symbol)
		end

	process_agent_routine_creation_as (l_as: AGENT_ROUTINE_CREATION_AS)
			-- Process agent expression `l_as'.
		do
			safe_process_and_print (l_as.agent_keyword (match_list), "", " ", False)
			if l_as.target /= Void then
				safe_process (l_as.lparan_symbol (match_list))
				l_as.target.process (Current)
				safe_process (l_as.rparan_symbol (match_list))
				safe_process (l_as.dot_symbol (match_list))
			end
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_operands)
		end

	process_inline_agent_creation_as (l_as: INLINE_AGENT_CREATION_AS)
			-- Process inline agent expression `l_as'.
		do
			safe_process_and_print (l_as.agent_keyword (match_list), "", " ", False)
			indent.append ("%T")
			safe_process (l_as.body)
			indent.remove_tail (1)
			safe_process_and_print (l_as.internal_operands, " ", "", False)
		end

	process_delayed_actual_list_as (l_as: DELAYED_ACTUAL_LIST_AS)
			-- Process delayed parameter list `l_as'.
		do
			safe_process (l_as.lparan_symbol (match_list))
			process_and_print_eiffel_list (l_as.operands, "", " ", True, False)
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_tuple_as (l_as: TUPLE_AS)
			-- Process tuple expression `l_as'.
		do
			safe_process (l_as.lbracket_symbol (match_list))
			process_and_print_eiffel_list (l_as.expressions, "", " ", True, False)
			safe_process (l_as.rbracket_symbol (match_list))
		end

	process_unary_as (l_as: UNARY_AS)
			-- Process unary expression `l_as'.
		do
			safe_process_and_print (l_as.operator (match_list), "", " ", False)
			safe_process (l_as.expr)
		end

	process_un_free_as (l_as: UN_FREE_AS)
			-- Process free unary expression `l_as'.
		do
			safe_process_and_print (l_as.op_name, "", " ", False)
			safe_process (l_as.expr)
		end

	process_un_strip_as (l_as: UN_STRIP_AS)
			-- Process unary strip expression `l_as'.
		do
			safe_process_and_print (l_as.strip_keyword (match_list), "", " ", False)
			safe_process (l_as.lparan_symbol (match_list))
			process_and_print_identifier_list (l_as.id_list, "", " ", True, False)
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_loop_expr_as (l_as: LOOP_EXPR_AS)
			-- Process the loop expression `l_as'.
		do
			is_expr_iteration := True
			safe_process (l_as.iteration)
			safe_process_and_print (l_as.invariant_keyword (match_list), " ", "", False)
			safe_process_and_print (l_as.full_invariant_list, " ", "", False)
			safe_process_and_print (l_as.until_keyword (match_list), " ", "", False)
			safe_process_and_print (l_as.exit_condition, " ", "", False)
			safe_process_and_print (l_as.qualifier_keyword (match_list), " ", " ", False)
			safe_process (l_as.expression)
			safe_process_and_print (l_as.variant_part, " ", "", False)
			safe_process_and_print (l_as.end_keyword, " ", "", False)
		end

	process_object_test_as (l_as: OBJECT_TEST_AS)
			-- Process object test `l_as'.
		do
			if l_as.is_attached_keyword then
				safe_process (l_as.attached_keyword (match_list))
				safe_process_and_print (l_as.type, " ", "", False)
				safe_process_and_print (l_as.expression, " ", "", False)
				safe_process_and_print (l_as.as_keyword (match_list), " ", "", False)
				safe_process_and_print (l_as.name, " ", "", False)
			else
				safe_process (l_as.lcurly_symbol (match_list))
				safe_process (l_as.name)
				safe_process_and_print (l_as.type, " ", "", False)
				safe_process_and_print (l_as.expression, " ", "", False)
			end
		end

	process_array_as (l_as: ARRAY_AS)
			-- Process array expression `l_as'.
		do
			safe_process (l_as.larray_symbol (match_list))
			process_and_print_eiffel_list (l_as.expressions, "", " ", True, False)
			safe_process (l_as.rarray_symbol (match_list))
		end

feature {CLASS_AS} -- Calls

	process_access_feat_as (l_as: ACCESS_FEAT_AS)
			-- Process feature access `l_as'.
		do
			safe_process (l_as.feature_name)
			safe_process_and_print (l_as.internal_parameters, " ", "", False)
		end

	process_parameter_list_as (l_as: PARAMETER_LIST_AS)
			-- Process parameter list `l_as'.
		do
			safe_process (l_as.lparan_symbol (match_list))
			if l_as.parameters /= Void and then l_as.parameters.first_token (match_list) /= Void then
				last_index := l_as.parameters.first_token (match_list).index
			end
			process_and_print_eiffel_list (l_as.parameters, "", " ", True, False)
			last_index := l_as.rparan_symbol (match_list).index
			safe_process (l_as.rparan_symbol (match_list))
		end

	process_access_inv_as (l_as: ACCESS_INV_AS)
			-- Process feature access in an invariant `l_as'.
		do
			safe_process (l_as.dot_symbol (match_list))
			safe_process (l_as.feature_name)
			safe_process_and_print (l_as.internal_parameters, " ", "", False)
		end

	process_access_id_as (l_as: ACCESS_ID_AS)
			-- Process a (local, argument or feature) access `l_as'.
		do
			safe_process (l_as.feature_name)
			safe_process_and_print (l_as.internal_parameters, " ", "", False)
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS)
			-- Process a static precursor access `l_as'.
		do
			safe_process_and_print (l_as.feature_keyword (match_list), "", " ", False)
			safe_process (l_as.class_type)
			safe_process (l_as.dot_symbol (match_list))
			safe_process (l_as.feature_name)
			safe_process_and_print (l_as.internal_parameters, " ", "", False)
		end

	process_precursor_as (l_as: PRECURSOR_AS)
			-- Process precursor access `l_as'.
		do
			safe_process (l_as.precursor_keyword)
			safe_process_and_print (l_as.parent_base_class, " ", "", False)
			safe_process_and_print (l_as.internal_parameters, " ", "", False)
		end

	process_create_creation_expr_as (l_as: CREATE_CREATION_EXPR_AS)
			-- Process create creation expression `l_as'.
		do
			safe_process_and_print (l_as.create_keyword (match_list), "", " ", False)
			safe_process (l_as.type)
			safe_process (l_as.call)
		end

feature {CLASS_AS} -- Types

	process_bits_as (l_as: BITS_AS)
			-- Process BIT type `l_as'.
		do
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.bit_keyword (match_list))
			safe_process_and_print (l_as.bits_value, " ", "", False)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS)
			-- Process bit symbol `l_as'.
		do
			safe_process (l_as.lcurly_symbol (match_list))
			safe_process (l_as.bit_keyword (match_list))
			safe_process_and_print (l_as.bits_symbol, " ", "", False)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_class_type_as (l_as: CLASS_TYPE_AS)
			-- Process class type `l_as'.
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_type_marks (l_as)
			safe_process_and_print (l_as.expanded_keyword (match_list), "", " ", False)
			safe_process (l_as.class_name)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS)
			-- Process generic class type `l_as'.
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_type_marks (l_as)
			safe_process_and_print (l_as.expanded_keyword (match_list), "", " ", False)
			safe_process (l_as.class_name)
			safe_process_and_print (l_as.internal_generics, " ", "", False)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_formal_as (l_as: FORMAL_AS)
			-- Process formal type `l_as'.
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_type_marks (l_as)
			safe_process_and_print (l_as.reference_or_expanded_keyword (match_list), "", " ", False)
			safe_process (l_as.name)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_like_cur_as (l_as: LIKE_CUR_AS)
			-- Process 'like Current' type `l_as'.
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_type_marks (l_as)
			safe_process (l_as.like_keyword (match_list))
			safe_process_and_print (l_as.current_keyword, " ", "", False)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_like_id_as (l_as: LIKE_ID_AS)
			-- Process 'like id' type `l_as'.
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_type_marks (l_as)
			safe_process (l_as.like_keyword (match_list))
			safe_process_and_print (l_as.anchor, " ", "", False)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS)
			-- Process named tuple type `l_as'.
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_type_marks (l_as)
			safe_process (l_as.class_name)
			safe_process_and_print (l_as.parameters, " ", "", False)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_qualified_anchored_type_as (l_as: QUALIFIED_ANCHORED_TYPE_AS)
			-- Process qualified anchored type `l_as'.
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_type_marks (l_as)
			safe_process_and_print (l_as.like_keyword (match_list), "", " ", False)
			safe_process (l_as.qualifier)
			safe_process (l_as.chain)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_constraining_type_as (l_as: CONSTRAINING_TYPE_AS)
			-- Process constraining type `l_as'.
		do
			l_as.type.process (Current)
			safe_process_and_print (l_as.renaming, "", " ", False)
			safe_process (l_as.end_keyword (match_list))
		end

	process_type_list_as (l_as: TYPE_LIST_AS)
			-- Process type list `l_as'.
		do
			safe_process (l_as.opening_bracket_as (match_list))
			process_and_print_eiffel_list (l_as, "", " ", True, False)
			safe_process (l_as.closing_bracket_as (match_list))
		end

feature {NONE} -- Visitor: type

	process_type_marks (a: TYPE_AS)
			-- Process types attachment and separateness marks (if any) associated with type `a'.
		do
			safe_process_and_print (a.attachment_mark (match_list), "", " ", False)
			safe_process_and_print (a.separate_keyword (match_list), "", " ", False)
		end

invariant
	out_stream_attached: out_stream /= Void

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
