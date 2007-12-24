indexing
	description: "Text formatter for all text output formatting."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_FORMATTER

inherit
	TEXT_OPERATOR

	EIFFEL_PROJECT_FACILITIES

	REFACTORING_HELPER
		export
			{NONE} all
		end

feature -- Access

	context_group: CONF_GROUP is
			-- Context group, i.e. can be used to retrive renamed name.
		do
			Result := internal_context_group
		end

feature -- Element change

	set_context_group (a_group: like context_group) is
			-- Set `context_group' with `a_group'.
		do
			internal_context_group := a_group
		ensure
			context_group_set: internal_context_group = a_group
		end

feature -- Operation

	start_processing (append: BOOLEAN) is
			-- Start processing.
		do
		end

	end_processing is
			-- End processing.
		do
		end

feature -- Process

	process_basic_text (text: STRING_GENERAL) is
			-- Process default basic text `t'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_character_text (text: STRING_GENERAL) is
			-- Process string text `t'.
		do
			process_basic_text (text)
		end

	process_generic_text (text: STRING_GENERAL) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_indexing_tag_text (text: STRING_GENERAL) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_local_text (text: STRING_GENERAL) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_number_text (text: STRING_GENERAL) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_quoted_text (text: STRING_GENERAL) is
			-- Process the quoted `text' within a comment.
		require
			text_not_void: text /= Void
		deferred
		end

	process_assertion_tag_text (text: STRING_GENERAL) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_string_text (text: STRING_GENERAL; link: STRING_GENERAL) is
			-- Process string text `text'.
			-- possible `link', can be void.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_reserved_word_text (text: STRING_GENERAL) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_comment_text (text: STRING_GENERAL; url: STRING_GENERAL) is
			-- Process comment text.
			-- `url' is possible url, which can be void if none.
		require
			text_not_void: text /= Void
		deferred
		end

	process_difference_text_item (text: STRING_GENERAL) is
			-- Process difference text text.
		require
			text_not_void: text /= Void
		do
		end

	process_class_name_text (text: STRING_GENERAL; a_class: CLASS_I; a_quote: BOOLEAN) is
			-- Process class name of `a_class'.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

	process_cluster_name_text (text: STRING_GENERAL; a_cluster: CONF_GROUP; a_quote: BOOLEAN) is
			-- Process cluster name of `a_cluster'.
		require
			text_not_void: text /= Void
			a_cluster_not_void: a_cluster /= Void
		deferred
		end

	process_target_name_text (text: STRING_GENERAL; a_target: CONF_TARGET) is
			-- Process target name text `text'.
		require
			text_not_void: text /= Void
			a_target_not_void: a_target /= Void
		deferred
		end

	process_feature_name_text (text: STRING_GENERAL; a_class: CLASS_C) is
			-- Process feature name text `text'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_feature_error (text: STRING_GENERAL; a_feature: E_FEATURE; a_line: INTEGER) is
			-- Process error feature text.
		require
			text_not_void: text /= Void
			a_feature_not_void: a_feature /= Void
		do
			process_feature_text (text, a_feature, false)
		end

	process_feature_text (text: STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN) is
			-- Process feature text `text'.
		require
			text_not_void: text /= Void
			a_feature_not_void: a_feature /= Void
		deferred
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN) is
			-- Process breakpoint index `a_index'.
		require
			a_feature_not_void: a_feature /= Void
		deferred
		end

	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER) is
			-- Process breakpoint.
		require
			a_feature_not_void: a_feature /= Void
		deferred
		end

	process_padded is
			-- Process padded item at start of non breakpoint line.
		deferred
		end

	process_new_line is
			-- Process new line.
		deferred
		end

	process_indentation (a_indent_depth: INTEGER) is
			-- Process indentation `t'.
		deferred
		end

	process_after_class (a_class: CLASS_C) is
			-- Process after class `a_class'.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

	process_before_class (a_class: CLASS_C) is
			-- Process before class `a_class'.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

	process_filter_item (text: STRING_GENERAL; is_before: BOOLEAN) is
			-- Process filter text `text'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_tooltip_item (a_tooltip: STRING_GENERAL; is_before: BOOLEAN) is
			-- Process tooltip text `a_tooltip'.
		require
			a_tooltip_not_void: a_tooltip /= Void
		do
			process_filter_item (a_tooltip, is_before)
		end

	process_feature_dec_item (a_feature_name: STRING_GENERAL; is_before: BOOLEAN) is
			-- Process feature dec.
		require
			a_feature_name_not_void: a_feature_name /= Void
		do
			process_filter_item (a_feature_name, is_before)
		end

	process_symbol_text (text: STRING_GENERAL) is
			-- Process symbol text.
		require
			text_not_void: text /= Void
		deferred
		end

	process_keyword_text (text: STRING_GENERAL; a_feature: E_FEATURE) is
			-- Process keyword text.
			-- `a_feature' is possible feature.
		require
			text_not_void: text /= Void
		deferred
		end

	process_operator_text (text: STRING_GENERAL; a_feature: E_FEATURE) is
			-- Process operator text.
			-- `a_feature' can be void.
		require
			text_not_void: text /= Void
		deferred
		end

	process_address_text (a_address, a_name: STRING_GENERAL; a_class: CLASS_C) is
			-- Process address text.
		deferred
		end

	process_error_text (text: STRING_GENERAL; a_error: ERROR) is
			-- Process error text.
		require
			text_not_void: text /= Void
			a_error_not_void: a_error /= Void
		deferred
		end

	process_cl_syntax (text: STRING_GENERAL; a_syntax_message: ERROR; a_class: CLASS_C) is
			-- Process class syntax text.
		require
			text_not_void: text /= Void
			a_syntax_message_not_void: a_syntax_message /= Void
			a_class_not_void: a_class /= Void
		deferred
		end

	process_column_text (a_column_number: INTEGER) is
			-- Process `a_column_number'.
		do
		end

	process_call_stack_item (level_number: INTEGER; display: BOOLEAN) is
			-- Process the current callstack text.
		do
		end

	process_menu_text (text, link: STRING_GENERAL) is
			-- Process menu item. This is only useful for generation to
			-- formats that support hyperlinking.
		do
		end

	process_class_menu_text (text, link: STRING_GENERAL) is
			-- Process class menu item. This is only useful for generation to
			-- formats that support hyperlinking.
		do
			process_menu_text (text, link)
		end

feature {NONE} -- Implementation

	indentation (a_indent_depth: INTEGER): STRING is
			-- Indentation of `a_indent_depth'
		local
			i: INTEGER
		do
			create Result.make (a_indent_depth);
			from
				i := 1
			until
				i > a_indent_depth
			loop
				Result.append ("%T");
				i := i + 1
			end
		end

	text_quoted (text: STRING_GENERAL): STRING_GENERAL is
			-- Quote `text'.
		require
			text_not_void: text /= Void
		do
			Result := ("`").as_string_32 + text + "%'"
		ensure
			text_quoted_not_void: Result /= Void
		end

	is_keyword (text: STRING_GENERAL): BOOLEAN is
			-- Is `text' a keyword?
		require
			valid_text: text /= Void and then not text.is_empty
		do
			if text.is_valid_as_string_8 then
				Result := (text.as_string_8 @ 1).is_alpha
			end

		end

	is_symbol (text: STRING_GENERAL): BOOLEAN is
			-- Is `text' a symbol?
		require
			valid_text: text /= Void and then not text.is_empty
		do
			Result := not is_keyword (text)
		ensure
			not_keyword: Result = not is_keyword (text)
		end

feature -- Text operator

	add_char (c: CHARACTER_32) is
			-- Add `c'.
		local
			l_s: STRING_32
		do
			create l_s.make_filled (c, 1)
			process_character_text (l_s)
		end

	add_new_line is
			-- Add new line.
		do
			process_new_line
		end

	add_string (s: STRING_GENERAL) is
			-- Add `s'.
		do
			process_basic_text (s)
		end

	add_local (s: STRING_GENERAL) is
			-- Add `s' as a local.
		do
			process_local_text (s)
		end

	add_int (i: INTEGER) is
			-- Put `i' at current position.
		do
			process_number_text (i.out)
		end

	add_group (e_cluster: CONF_GROUP; str: STRING_GENERAL) is
			-- Put `e_cluster' with string representation
			-- `str' at current position.
		do
			process_cluster_name_text (str, e_cluster, false)
		end

	add_before_class (e_class: CLASS_C) is
			-- Put `e_class' at current position.
		do
			process_before_class (e_class)
		end

	add_end_class (e_class: CLASS_C) is
			-- Put `e_class' at current position.
		do
			process_after_class (e_class)
		end

	add_classi (class_i: CLASS_I; str: STRING_GENERAL) is
			-- Put `class_i' with string representation
			-- `str' at current position.
		do
			process_class_name_text (str, class_i, false)
		end

	add_class (class_i: CLASS_I) is
			-- Append class item.
		local
			l_name: STRING
			l_list: LINKED_LIST [STRING]
		do
			if context_group /= Void and then class_i.is_valid then
				l_list := context_group.name_by_class (class_i.config_class, True)
				if not l_list.is_empty then
					l_name := l_list.first
				end
			end
			if l_name = Void then
				l_name := class_i.name
			end
			process_class_name_text (l_name, class_i, false)
		end

	add_error (error: ERROR; str: STRING_GENERAL) is
			-- Put `error' with string representation
			-- `str' at current position.
		do
			process_error_text (str, error)
		end

	add_feature (feat: E_FEATURE; str: STRING_GENERAL) is
			-- Put feature `feat' with string
			-- representation `str' at current position.
		do
			process_feature_text (str, feat, false)
		end

	add_breakpoint_index (feat: E_FEATURE; indx: INTEGER; has_cond: BOOLEAN) is
			-- Put `index'-th breakpoint of feature `feat' with integer
			-- representation `index' at current position.
		do
			process_breakpoint_index (feat, indx, has_cond)
		end

	add_feature_name (f_name: STRING_GENERAL; e_class: CLASS_C) is
			-- Put feature name `f_name' defined in `e_class'.
		do
			process_feature_name_text (f_name, e_class)
		end

	add_sectioned_feature_name (e_feature: E_FEATURE) is
			-- Put feature name of `e_feature', taking reserved words into consideration.
		local
			l_is_prefix_infix: BOOLEAN
			l_keyword: STRING
			l_prefix_infix: STRING
		do
				-- Prepare prefix/infix text.
			if e_feature.is_prefix then
				l_keyword := ti_prefix_keyword
				l_prefix_infix := e_feature.extract_symbol_from_prefix (e_feature.name)
				l_is_prefix_infix := True
			elseif e_feature.is_infix then
				l_keyword := ti_infix_keyword
				l_prefix_infix := e_feature.extract_symbol_from_infix (e_feature.name)
				l_is_prefix_infix := True
			end

			if l_is_prefix_infix then
				process_keyword_text (ti_prefix_keyword, Void)
				add_space
				l_prefix_infix.prepend (ti_quote)
				l_prefix_infix.append (ti_quote)
				process_operator_text (l_prefix_infix, e_feature)
			else
				add_feature_name (e_feature.name, e_feature.written_class)
			end
		end

	add_quoted_text (s: STRING_GENERAL) is
			-- Put `s' at current position.
		do
			process_quoted_text (s)
		end

	add_comment (s: STRING_GENERAL) is
			-- Add simple comment `s'.
		do
			process_comment_text (s, Void)
		end

	add_address (address: STRING_GENERAL; a_name: STRING_GENERAL; e_class: CLASS_C) is
			-- Put `address' for `e_class'.
		do
			process_address_text (address, a_name, e_class)
		end

	add_indent is
			-- Add an indentation.
		do
			process_indentation (1)
		end

	add_indents (nr: INTEGER) is
			-- Add `nr' indentations.
		do
			process_indentation (nr)
		end

	add_class_syntax (syn: ERROR; e_class: CLASS_C; str: STRING_GENERAL) is
			-- Put `syn' for `e_class'.
		do
			process_cl_syntax (str, syn, e_class)
		end

	add_column_number (column_num: INTEGER) is
			-- Add column number `column_num' to current.
		do
			process_column_text (column_num)
		end

	add_feature_error (feat: E_FEATURE; str: STRING_GENERAL; a_line: INTEGER) is
			-- Put `address' for `e_class'.
		do
			process_feature_error (str, feat, a_line)
		end

feature {NONE} -- Implementation

	separate_string (s: STRING_GENERAL; for_comment: BOOLEAN) is
			-- Separate `s' into parts and add them to `Current'.
			-- Mostly for manifest strings and comments.
		do
				--| FIXME: s.as_string_8 may cause information lose.
			comment_scanner.set_input_buffer (create {YY_BUFFER}.make (s.as_string_8))
			comment_scanner.set_text_formatter (Current)
			comment_scanner.set_for_comment (for_comment)
			comment_scanner.set_seperate (seperate_comment)
			comment_scanner.set_current_class (comment_context_class)
			comment_scanner.scan
		end

	comment_scanner: COMMENT_SCANNER is
			-- Scanner for comment and manifest string
		once
			create Result.make_with_text_formatter (Current, seperate_comment)
		end

	seperate_comment: BOOLEAN
			-- Seperate comment into words?

	reset_phrase (p: STRING_GENERAL; for_comment: BOOLEAN) is
			-- Add comment `p' and wipe out `p'.
		require
			p_not_void: p /= Void
		local
			l_s: STRING
			l_s32: STRING_32
		do
			if for_comment then
				process_comment_text (p.twin, Void)
			else
				process_string_text (p.twin, Void)
			end
			l_s ?= p
			if l_s /= Void then
				l_s.wipe_out
			else
				l_s32 ?= p
				if l_s32 /= Void then
					l_s32.wipe_out
				else
					check
						error: False
					end
				end
			end
		end

	process_quoted_item (text: STRING_GENERAL; quote: BOOLEAN) is
			-- Process quoted `s' according to its type.
		local
			l_feature: E_FEATURE
			l_class_i: CLASS_I
			l_cluster_i: CLUSTER_I
			l_text: STRING
		do
			if text.is_string_8 then
				l_text := text.as_string_8
				l_feature := feature_by_name (l_text)
				if l_feature = Void then
					if (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (l_text) and l_text.as_upper.is_equal (l_text) then
						l_class_i := class_by_name (l_text)
					end
					if l_class_i = Void then
						l_cluster_i := cluster_by_name (l_text)
					end
				end
				if l_feature /= Void then
					process_feature_text (l_text, l_feature, quote)
				elseif l_class_i /= Void then
					process_class_name_text (l_text, l_class_i, quote)
				elseif l_cluster_i /= Void then
					process_cluster_name_text (l_text, l_cluster_i, quote)
				else
					process_quoted_text (l_text)
				end
			else
				process_quoted_text (text)
			end
		end

	comment_context_class : CLASS_C is
			-- Current class for comment context.
		do
			Result := eiffel_system.system.current_class
		end

	internal_context_group: like context_group;
			-- Internal context group

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class TEXT_FORMATTER
