indexing

	description:
		"Window where output is generated."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

deferred class OUTPUT_WINDOW

inherit
	TEXT_FORMATTER
		redefine
			process_string_text, process_difference_text_item,
			process_feature_error
		end

feature -- Text processing

	process_basic_text (text: STRING) is
		do
			put_string (text)
		end

	process_string_text (text, link: STRING) is
		do
			put_string (text)
		end

	process_comment_text (text: STRING; url: STRING) is
			-- Process comment text.
		do
			put_comment (text)
		end

	process_quoted_text (text: STRING) is
			-- Process the quoted `text' within a comment.
		do
			put_quoted_comment (text)
		end

	process_cluster_name_text (text: STRING; a_cluster: CONF_GROUP; a_quote: BOOLEAN) is
			-- Process class name text `t'.
		do
			if a_quote then
				put_cluster (a_cluster, text_quoted (text))
			else
				put_cluster (a_cluster, text)
			end
		end

	process_class_name_text (text: STRING; a_class: CLASS_I; a_quote: BOOLEAN) is
			-- Process class name text `t'.
		local
			e_class: CLASS_C
			class_i: CLASS_I
			l_text : STRING
		do
			if a_quote then
				l_text := text_quoted (text)
			else
				l_text := text
			end
			class_i := a_class
			e_class := class_i.compiled_class
			if e_class /= Void then
				put_class (e_class, l_text)
			else
				put_classi (class_i, l_text)
			end
		end

	process_feature_name_text (text: STRING; a_class: CLASS_C) is
			-- Process feature name text `t'.
		do
			put_feature_name (text, a_class)
		end

	process_feature_text (text: STRING; a_feature: E_FEATURE; a_quote: BOOLEAN) is
			-- Process feature text `text'.
		do
			if a_quote then
				put_feature (a_feature, text_quoted (text))
			else
				put_feature (a_feature, text)
			end
		end

	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER) is
			-- Process breakpoint.
		do
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN) is
			-- Process breakpoint.
		do
		end

	process_padded is
			-- Process padded item at start of non breakpoint line.
		do
		end

	process_new_line is
			-- Process new line text `t'.
		do
			put_new_line
		end

	process_indentation (a_indent_depth: INTEGER) is
			-- Process indentation `t'.
		do
			put_string (indentation (a_indent_depth))
		end

	process_after_class (a_class: CLASS_C) is
			-- Process after class text `t'.
		do
			put_after_class (a_class, a_class.name_in_upper)
		end

	process_before_class (a_class: CLASS_C) is
			-- Process before class `t'.
		do
			put_before_class (a_class)
		end

	process_filter_item (text: STRING; is_before: BOOLEAN) is
			-- Process filter text `t'.
		do
			put_filter_item (text, is_before)
		end

	process_symbol_text (text: STRING) is
			-- Process symbol text.
		do
			put_symbol (text)
		end

	process_keyword_text (text: STRING; a_feature: E_FEATURE) is
			-- Process keyword text.
		do
			put_keyword (text)
		end

	process_operator_text (text: STRING; a_feature: E_FEATURE) is
			-- Process operator text.
		do
			put_operator (text, a_feature, is_keyword (text))
		end

	process_address_text (a_address, a_name: STRING; a_class: CLASS_C) is
			-- Process address text.
		do
			put_address (a_address, a_name, a_class)
		end

	process_error_text (text: STRING; a_error: ERROR) is
			-- Process error text.
		do
			put_error (a_error, text)
		end

	process_cl_syntax (text: STRING; a_syntax_message: SYNTAX_MESSAGE; a_class: CLASS_C) is
			-- Process class syntax text.
		do
			put_class_syntax (a_syntax_message, a_class, text)
		end

	process_ace_syntax (text: STRING; a_error: SYNTAX_ERROR) is
			-- Process Ace syntax text.
		do
			put_ace_syntax (a_error, text)
		end

	process_difference_text_item (text: STRING) is
			-- Process difference text.
		do
			put_string (text)
		end

	process_feature_error (text: STRING; a_feature: E_FEATURE; a_line: INTEGER) is
			-- Process error feature text.
		do
			put_feature_error (a_feature, text, a_line)
		end

feature -- Output

	display is
			-- Display the contents of window.
		do
		end

	clear_window is
			-- Clear the contents of window.
		do
		end

	put_new_line is
			-- Put a new line at current position.
		deferred
		end

	put_string (s: STRING) is
			-- Put string `s' at current position.
		require
			valid_s: s /= Void
		deferred
		end

	put_one_indent is
			-- Put one indent to Current.
		do
			put_indent (1)
		end

	put_indent (nbr_of_tabs: INTEGER) is
			-- Put indent of `nbr_of_tabs'.
		require
			valid_tabs: nbr_of_tabs > 0
		local
			str: STRING
		do
			str := "%T"
			if nbr_of_tabs > 1 then
				str.multiply (nbr_of_tabs)
			end
			put_string (str)
		end

	put_cluster (e_cluster: CONF_GROUP; str: STRING) is
			-- Put `e_cluster' with string representation
			-- `str' at current position.
		require
			valid_str: str /= Void
		do
			put_string (str)
		end

	put_class (e_class: CLASS_C; str: STRING) is
			-- Put `e_class' with string representation
			-- `str' at current position.
		require
			valid_str: str /= Void
		do
			put_string (str)
		end

	put_classi (class_i: CLASS_I; str: STRING) is
			-- Put `class_i' with string representation
			-- `str' at current position.
		require
			valid_str: str /= Void
		do
			put_string (str)
		end

	put_error (error: ERROR; str: STRING) is
			-- Put `error' with string representation
			-- `str' at current position.
		require
			valid_error: error /= Void
			valid_str: str /= Void
		do
			put_string (str)
		end

	put_feature (feat: E_FEATURE; str: STRING) is
			-- Put feature `feat' with string
			-- representation `str' at current position.
		require
			valid_str: str /= Void
		do
			put_string (str)
		end

	put_feature_name (f_name: STRING; e_class: CLASS_C) is
			-- Put feature name `f_name' defined in `e_class'.
		require
			valid_f_name: f_name /= Void
		do
			put_string (f_name)
		end

	put_exported_feature_name (f_name: STRING; class_c: CLASS_C; alias_name: STRING) is
		require
			valid_f_name: f_name /= Void
		do
			put_string (f_name)
		end

	put_feature_error (feat: E_FEATURE; str: STRING; pos: INTEGER) is
			-- Put feature `feat' with error at charcter
			-- position `pos'
		require
			valid_str: str /= Void
			positive_pos: pos > 0
		do
			put_feature (feat, str)
		end

	put_address (address: STRING; a_name: STRING; e_class: CLASS_C) is
			-- Put `address' with `a_name' for `e_class'.
		require
			valid_address: address /= Void
			valid_name: a_name /= Void
		do
			put_string (address)
		end

	put_class_syntax (syn: SYNTAX_MESSAGE; eclass: CLASS_C; str: STRING) is
			-- Put `syn' for `e_class' with `str' as representation.
		require
			valid_syn: syn /= Void
			valid_str: str /= Void
		do
			put_string (str)
		end

	put_ace_syntax (syn: SYNTAX_ERROR; str: STRING) is
			-- Put `syn' with `str' as representation.
		require
			valid_syn: syn /= Void
			valid_str: str /= Void
		do
			put_string (str)
		end

	put_comment (str: STRING) is
			-- Put `str' as representation of a comment.
		require
			valid_str: str /= Void
		do
			put_string (str)
		end

	put_quoted_comment (str: STRING) is
			-- Put `str' as representation of quoted text.
		require
			valid_str: str /= Void
		do
			put_string (text_quoted (str))
		end;

	put_after_class (e_class: CLASS_C; str: STRING) is
			-- Put `str' as representation of quoted text.
		require
			valid_str: str /= Void
		do
			put_string (str)
		end

	put_before_class (e_class: CLASS_C) is
			-- Put `str' as representation of quoted text.
		require
			valid_e_class: e_class /= Void
		do
		end

	put_filter_item (construct: STRING; is_before: BOOLEAN) is
			-- Put `str' as representation of quoted text.
		require
			valid_construct: construct /= Void
		do
		end

	put_symbol (str: STRING) is
			-- Put `str' as representation of quoted text.
		require
			valid_str: str /= Void
		do
			put_string (str)
		end

	put_keyword (str: STRING) is
			-- Put `str' as representation of quoted text.
		require
			valid_str: str /= Void
		do
			put_string (str)
		end

	put_operator (str: STRING; e_feature: E_FEATURE; a_is_keyword: BOOLEAN) is
			-- Put `str' as representation of quoted text.
		require
			valid_str: str /= Void
			valid_e_feature: e_feature /= Void
		do
			put_string (str)
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

end -- class OUTPUT_WINDOW
