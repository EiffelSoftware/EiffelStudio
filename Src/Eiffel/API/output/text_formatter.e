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

	DOCUMENTATION_FACILITIES

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

	process_basic_text (text: STRING) is
			-- Process default basic text `t'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_character_text (text: STRING) is
			-- Process string text `t'.
		do
			process_basic_text (text)
		end

	process_generic_text (text: STRING) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_indexing_tag_text (text: STRING) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_local_text (text: STRING) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_number_text (text: STRING) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_quoted_text (text: STRING) is
			-- Process the quoted `text' within a comment.
		require
			text_not_void: text /= Void
		deferred
		end

	process_assertion_tag_text (text: STRING) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_string_text (text: STRING; link: STRING) is
			-- Process string text `text'.
			-- possible `link', can be void.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_reserved_word_text (text: STRING) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_comment_text (text: STRING; url: STRING) is
			-- Process comment text.
			-- `url' is possible url, which can be void if none.
		require
			text_not_void: text /= Void
		deferred
		end

	process_difference_text_item (text: STRING) is
			-- Process difference text text.
		require
			text_not_void: text /= Void
		do
		end

	process_class_name_text (text: STRING; a_class: CLASS_I; a_quote: BOOLEAN) is
			-- Process class name of `a_class'.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

	process_cluster_name_text (text: STRING; a_cluster: CONF_GROUP; a_quote: BOOLEAN) is
			-- Process cluster name of `a_cluster'.
		require
			text_not_void: text /= Void
			a_cluster_not_void: a_cluster /= Void
		deferred
		end

	process_feature_name_text (text: STRING; a_class: CLASS_C) is
			-- Process feature name text `text'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_feature_error (text: STRING; a_feature: E_FEATURE; a_line: INTEGER) is
			-- Process error feature text.
		require
			text_not_void: text /= Void
			a_feature_not_void: a_feature /= Void
		do
			process_feature_text (text, a_feature, false)
		end

	process_feature_text (text: STRING; a_feature: E_FEATURE; a_quote: BOOLEAN) is
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

	process_filter_item (text: STRING; is_before: BOOLEAN) is
			-- Process filter text `text'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_tooltip_item (a_tooltip: STRING; is_before: BOOLEAN) is
			-- Process tooltip text `a_tooltip'.
		require
			a_tooltip_not_void: a_tooltip /= Void
		do
			process_filter_item (a_tooltip, is_before)
		end

	process_feature_dec_item (a_feature_name: STRING; is_before: BOOLEAN) is
			-- Process feature dec.
		require
			a_feature_name_not_void: a_feature_name /= Void
		do
			process_filter_item (a_feature_name, is_before)
		end

	process_symbol_text (text: STRING) is
			-- Process symbol text.
		require
			text_not_void: text /= Void
		deferred
		end

	process_keyword_text (text: STRING; a_feature: E_FEATURE) is
			-- Process keyword text.
			-- `a_feature' is possible feature.
		require
			text_not_void: text /= Void
		deferred
		end

	process_operator_text (text: STRING; a_feature: E_FEATURE) is
			-- Process operator text.
			-- `a_feature' can be void.
		require
			text_not_void: text /= Void
		deferred
		end

	process_address_text (a_address, a_name: STRING; a_class: CLASS_C) is
			-- Process address text.
		deferred
		end

	process_error_text (text: STRING; a_error: ERROR) is
			-- Process error text.
		require
			text_not_void: text /= Void
			a_error_not_void: a_error /= Void
		deferred
		end

	process_cl_syntax (text: STRING; a_syntax_message: SYNTAX_MESSAGE; a_class: CLASS_C) is
			-- Process class syntax text.
		require
			text_not_void: text /= Void
			a_syntax_message_not_void: a_syntax_message /= Void
			a_class_not_void: a_class /= Void
		deferred
		end

	process_ace_syntax (text: STRING; a_error: ERROR) is
			-- Process Ace syntax text.
		require
			text_not_void: text /= Void
			a_error_not_void: a_error /= Void
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

	process_menu_text (text, link: STRING) is
			-- Process menu item. This is only useful for generation to
			-- formats that support hyperlinking.
		do
		end

	process_class_menu_text (text, link: STRING) is
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

	text_quoted (text: STRING): STRING is
			-- Quote `text'.
		require
			text_not_void: text /= Void
		do
			Result := "`" + text + "%'"
		ensure
			text_quoted_not_void: Result /= Void
		end

	is_keyword (text: STRING): BOOLEAN is
			-- Is `text' a keyword?
		require
			valid_text: text /= Void and then not text.is_empty
		do
			Result := (text @ 1).is_alpha
		end

	is_symbol (text: STRING): BOOLEAN is
			-- Is `text' a symbol?
		require
			valid_text: text /= Void and then not text.is_empty
		do
			Result := not is_keyword (text)
		ensure
			not_keyword: Result = not is_keyword (text)
		end

feature -- Text operator

	add_char (c: CHARACTER) is
			-- Add `c'.
		do
			process_character_text (c.out)
		end

	add_new_line is
			-- Add new line.
		do
			process_new_line
		end

	add_string (s: STRING) is
			-- Add `s'.
		do
			process_basic_text (s)
		end

	add_local (s: STRING) is
			-- Add `s' as a local.
		do
			process_local_text (s)
		end

	add_int (i: INTEGER) is
			-- Put `i' at current position.
		do
			process_number_text (i.out)
		end

	add_group (e_cluster: CONF_GROUP; str: STRING) is
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

	add_classi (class_i: CLASS_I; str: STRING) is
			-- Put `class_i' with string representation
			-- `str' at current position.
		do
			process_class_name_text (str, class_i, false)
		end

	add_class (class_i: CLASS_I) is
			-- Append class item.
		do
			process_class_name_text (class_i.name_in_upper, class_i, false)
		end

	add_error (error: ERROR; str: STRING) is
			-- Put `error' with string representation
			-- `str' at current position.
		do
			process_error_text (str, error)
		end

	add_feature (feat: E_FEATURE; str: STRING) is
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

	add_feature_name (f_name: STRING; e_class: CLASS_C) is
			-- Put feature name `f_name' defined in `e_class'.
		do
			process_feature_name_text (f_name, e_class)
		end

	add_quoted_text (s: STRING) is
			-- Put `s' at current position.
		do
			process_quoted_text (s)
		end

	add_comment (s: STRING) is
			-- Add simple comment `s'.
		do
			process_comment_text (s, Void)
		end

	add_address (address: STRING; a_name: STRING; e_class: CLASS_C) is
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

	add_class_syntax (syn: SYNTAX_MESSAGE; e_class: CLASS_C; str: STRING) is
			-- Put `syn' for `e_class'.
		do
			process_cl_syntax (str, syn, e_class)
		end

	add_ace_syntax (syn: SYNTAX_ERROR; str: STRING) is
			-- Put `syn' of `str'.
		do
			process_ace_syntax (str, syn)
		end

	add_column_number (column_num: INTEGER) is
			-- Add column number `column_num' to current.
		do
			process_column_text (column_num)
		end

	add_feature_error (feat: E_FEATURE; str: STRING; a_line: INTEGER) is
			-- Put `address' for `e_class'.
		do
			process_feature_error (str, feat, a_line)
		end

feature {NONE} -- Implementation

	separate_string (s:STRING; for_comment: BOOLEAN) is
			-- Separate `s' into parts and add them to `Current'.
			-- Mostly for manifest strings and comments.
		local
			l_string: STRING
		do
			create l_string.make_from_string (s)
			comment_scanner.set_input_buffer (create {YY_BUFFER}.make (l_string))
			comment_scanner.set_text_formatter (Current)
			comment_scanner.set_for_comment (for_comment)
			comment_scanner.set_current_class (comment_context_class)
			comment_scanner.scan
		end

	comment_scanner: COMMENT_SCANNER is
			-- Scanner for comment and manifest string
		once
			create Result.make_with_text_formatter (Current)
		end

	reset_phrase (p: STRING; for_comment: BOOLEAN) is
			-- Add comment `p' and wipe out `p'.
		require
			p_not_void: p /= Void
		do
			if for_comment then
				process_comment_text (p.twin, Void)
			else
				process_string_text (p.twin, Void)
			end
			p.wipe_out
		end

	process_quoted_item (text: STRING; quote: BOOLEAN) is
			-- Process quoted `s' according to its type.
		local
			l_feature: E_FEATURE
			l_class_i: CLASS_I
			l_cluster_i: CLUSTER_I
		do
			l_feature := feature_by_name (text)
			if l_feature = Void then
				if (create {IDENTIFIER_CHECKER}).is_valid_upper (text) then
					l_class_i := class_by_name (text)
				end
				if l_class_i = Void then
					l_cluster_i := cluster_by_name (text)
				end
			end
			if l_feature /= Void then
				process_feature_text (text, l_feature, quote)
			elseif l_class_i /= Void then
				process_class_name_text (text, l_class_i, quote)
			elseif l_cluster_i /= Void then
				process_cluster_name_text (text, l_cluster_i, quote)
			else
				process_quoted_text (text)
			end
		end

	comment_context_class : CLASS_C is
			-- Current class for comment context.
		do
			Result := eiffel_system.system.current_class
		end

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
