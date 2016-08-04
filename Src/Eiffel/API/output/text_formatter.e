note
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

	SHARED_ENCODING_CONVERTER

feature -- Access

	context_group: CONF_GROUP
			-- Context group, i.e. can be used to retrive renamed name.
		do
			Result := internal_context_group
		end

	meta_data: detachable ANY
			-- Meta data

feature -- Element change

	set_context_group (a_group: like context_group)
			-- Set `context_group' with `a_group'.
		do
			internal_context_group := a_group
		ensure
			context_group_set: internal_context_group = a_group
		end

	set_meta_data (a_data: detachable ANY)
			-- Set `meta_data' with `a_data'.
		do
			meta_data := a_data
		ensure
			meta_data_set: meta_data = a_data
		end

feature -- Operation

	start_processing (append: BOOLEAN)
			-- Start processing.
		do
		end

	end_processing
			-- End processing.
		do
		end

	search_eis_entry_in_note_clause (a_index: detachable INDEX_AS; a_class: detachable CLASS_I; a_feat: detachable FEATURE_I)
			-- Search EIS entry in the context.
		do
		end

feature -- Process

	process_basic_text (text: READABLE_STRING_GENERAL)
			-- Process default basic text `t'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_character_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		do
			process_basic_text (text)
		end

	process_generic_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_indexing_tag_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_local_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_number_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_quoted_text (text: READABLE_STRING_GENERAL)
			-- Process the quoted `text' within a comment.
		require
			text_not_void: text /= Void
		deferred
		end

	process_assertion_tag_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_string_text (text: READABLE_STRING_GENERAL; link: READABLE_STRING_GENERAL)
			-- Process string text `text'.
			-- possible `link', can be void.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_string_text_with_pebble (text: READABLE_STRING_GENERAL; a_pebble: detachable ANY)
			-- Process string text `text'.
			-- possible `link', can be void.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_reserved_word_text (text: READABLE_STRING_GENERAL)
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_comment_text (text: READABLE_STRING_GENERAL; url: READABLE_STRING_GENERAL)
			-- Process comment text.
			-- `url' is possible url, which can be void if none.
		require
			text_not_void: text /= Void
		deferred
		end

	process_difference_text_item (text: READABLE_STRING_GENERAL)
			-- Process difference text text.
		require
			text_not_void: text /= Void
		do
		end

	process_class_name_text (text: READABLE_STRING_GENERAL; a_class: CLASS_I; a_quote: BOOLEAN)
			-- Process class name of `a_class'.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

	process_cluster_name_text (text: READABLE_STRING_GENERAL; a_cluster: CONF_GROUP; a_quote: BOOLEAN)
			-- Process cluster name of `a_cluster'.
		require
			text_not_void: text /= Void
			a_cluster_not_void: a_cluster /= Void
		deferred
		end

	process_target_name_text (text: READABLE_STRING_GENERAL; a_target: CONF_TARGET)
			-- Process target name text `text'.
		require
			text_not_void: text /= Void
			a_target_not_void: a_target /= Void
		deferred
		end

	process_feature_name_text (text: READABLE_STRING_GENERAL; a_class: CLASS_C)
			-- Process feature name text `text'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_feature_error (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE; a_line: INTEGER)
			-- Process error feature text.
		require
			text_not_void: text /= Void
			a_feature_not_void: a_feature /= Void
		do
			process_feature_text (text, a_feature, false)
		end

	process_feature_text (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN)
			-- Process feature text `text'.
		require
			text_not_void: text /= Void
			a_feature_not_void: a_feature /= Void
		deferred
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN)
			-- Process breakpoint index `a_index'.
		require
			a_feature_not_void: a_feature /= Void
		deferred
		end

	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER)
			-- Process breakpoint.
		require
			a_feature_not_void: a_feature /= Void
		deferred
		end

	process_padded
			-- Process padded item at start of non breakpoint line.
		deferred
		end

	process_new_line
			-- Process new line.
		deferred
		end

	process_indentation (a_indent_depth: INTEGER)
			-- Process indentation `t'.
		deferred
		end

	process_after_class (a_class: CLASS_C)
			-- Process after class `a_class'.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

	process_before_class (a_class: CLASS_C)
			-- Process before class `a_class'.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

	process_filter_item (text: READABLE_STRING_GENERAL; is_before: BOOLEAN)
			-- Process filter text `text'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_tooltip_item (a_tooltip: READABLE_STRING_GENERAL; is_before: BOOLEAN)
			-- Process tooltip text `a_tooltip'.
		require
			a_tooltip_not_void: a_tooltip /= Void
		do
			process_filter_item (a_tooltip, is_before)
		end

	process_feature_dec_item (a_feature_name: READABLE_STRING_GENERAL; is_before: BOOLEAN)
			-- Process feature dec.
		require
			a_feature_name_not_void: a_feature_name /= Void
		do
			process_filter_item (a_feature_name, is_before)
		end

	process_symbol_text (text: READABLE_STRING_GENERAL)
			-- Process symbol text.
		require
			text_not_void: text /= Void
		deferred
		end

	process_keyword_text (text: READABLE_STRING_GENERAL; a_feature: detachable E_FEATURE)
			-- Process keyword text.
			-- `a_feature' is possible feature.
		require
			text_not_void: text /= Void
		deferred
		end

	process_operator_text (text: READABLE_STRING_GENERAL; a_feature: detachable E_FEATURE)
			-- Process operator text.
			-- `a_feature' can be void.
		require
			text_not_void: text /= Void
		deferred
		end

	process_address_text (a_address, a_name: READABLE_STRING_GENERAL; a_class: CLASS_C)
			-- Process address text.
		require
			a_address_attached: a_address /= Void
		deferred
		end

	process_error_text (text: READABLE_STRING_GENERAL; a_error: ERROR)
			-- Process error text.
		require
			text_not_void: text /= Void
			a_error_not_void: a_error /= Void
		deferred
		end

	process_cl_syntax (text: READABLE_STRING_GENERAL; a_syntax_message: ERROR; a_class: CLASS_C)
			-- Process class syntax text.
		require
			text_not_void: text /= Void
			a_syntax_message_not_void: a_syntax_message /= Void
			a_class_not_void: a_class /= Void
		deferred
		end

	process_column_text (a_column_number: INTEGER)
			-- Process `a_column_number'.
		do
		end

	process_call_stack_item (level_number: INTEGER; display: BOOLEAN)
			-- Process the current callstack text.
		do
		end

	process_menu_text (text, link: READABLE_STRING_GENERAL)
			-- Process menu item. This is only useful for generation to
			-- formats that support hyperlinking.
		do
		end

	process_class_menu_text (text, link: READABLE_STRING_GENERAL)
			-- Process class menu item. This is only useful for generation to
			-- formats that support hyperlinking.
		do
			process_menu_text (text, link)
		end

feature {NONE} -- Implementation

	indentation (a_indent_depth: INTEGER): STRING
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

	text_quoted (text: READABLE_STRING_GENERAL): STRING_32
			-- Quote `text'.
		require
			text_not_void: text /= Void
		do
			create Result.make (text.count + 2)
			Result.append_character ('`')
			Result.append_string_general (text)
			Result.append_character ('%'')
		ensure
			text_quoted_not_void: Result /= Void
		end

	is_keyword (text: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `text' a keyword?
		require
			valid_text: text /= Void and then not text.is_empty
		local
			c: CHARACTER_32
		do
				-- FIXME: Use `Result := text.item (1).is_alpha' when optimized on CHARACTER_32.
			c := text.item (1)
			Result := c.is_character_8 and then c.to_character_8.is_alpha and then text.is_valid_as_string_8
		end

	is_symbol (text: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `text' a symbol?
		require
			valid_text: text /= Void and then not text.is_empty
		do
			Result := not is_keyword (text)
		ensure
			not_keyword: Result = not is_keyword (text)
		end

feature -- Text operator

	add_char (c: CHARACTER_32)
			-- Add `c'.
		local
			l_s: STRING_32
		do
			create l_s.make_filled (c, 1)
			process_character_text (l_s)
		end

	add_new_line
			-- Add new line.
		do
			process_new_line
		end

	add_string (s: READABLE_STRING_GENERAL)
			-- Add `s'.
		do
			process_basic_text (s)
		end

	add_local (s: READABLE_STRING_GENERAL)
			-- Add `s' as a local.
		do
			process_local_text (s)
		end

	add_natural_32 (i: NATURAL_32)
			-- Put `i' at current position.
		do
			process_number_text (i.out)
		end

	add_int (i: INTEGER)
			-- Put `i' at current position.
		do
			process_number_text (i.out)
		end

	add_group (e_cluster: CONF_GROUP; str: READABLE_STRING_GENERAL)
			-- Put `e_cluster' with string representation
			-- `str' at current position.
		do
			process_cluster_name_text (str, e_cluster, false)
		end

	add_before_class (e_class: CLASS_C)
			-- Put `e_class' at current position.
		do
			process_before_class (e_class)
		end

	add_end_class (e_class: CLASS_C)
			-- Put `e_class' at current position.
		do
			process_after_class (e_class)
		end

	add_classi (class_i: CLASS_I; str: READABLE_STRING_GENERAL)
			-- Put `class_i' with string representation
			-- `str' at current position.
		do
			process_class_name_text (str, class_i, false)
		end

	add_class (class_i: CLASS_I)
			-- Append class item.
		local
			l_name: READABLE_STRING_GENERAL
		do
			if context_group /= Void and then class_i.is_valid then
				if attached context_group.name_by_class (class_i.config_class, True) as l_list and then not l_list.is_empty then
					l_name := l_list.first
				end
			end
			if l_name = Void then
				l_name := class_i.name
			end
			process_class_name_text (l_name, class_i, false)
		end

	add_error (error: ERROR; str: READABLE_STRING_GENERAL)
			-- Put `error' with string representation
			-- `str' at current position.
		do
			process_error_text (str, error)
		end

	add_feature (feat: E_FEATURE; str: READABLE_STRING_GENERAL)
			-- Put feature `feat' with string
			-- representation `str' at current position.
		do
			process_feature_text (str, feat, false)
		end

	add_breakpoint_index (feat: E_FEATURE; indx: INTEGER; has_cond: BOOLEAN)
			-- Put `index'-th breakpoint of feature `feat' with integer
			-- representation `index' at current position.
		do
			process_breakpoint_index (feat, indx, has_cond)
		end

	add_feature_name (f_name: READABLE_STRING_GENERAL; e_class: CLASS_C)
			-- Put feature name `f_name' defined in `e_class'.
		do
			process_feature_name_text (f_name, e_class)
		end

	add_sectioned_feature_name (e_feature: E_FEATURE)
			-- Put feature name of `e_feature', taking reserved words into consideration.
		local
			l_is_prefix_infix: BOOLEAN
			l_keyword: STRING
			l_prefix_infix: STRING_32
		do
				-- Prepare prefix/infix text.
			if e_feature.is_prefix then
				l_keyword := ti_prefix_keyword
				l_prefix_infix := e_feature.prefix_symbol_32
				l_is_prefix_infix := True
			elseif e_feature.is_infix then
				l_keyword := ti_infix_keyword
				l_prefix_infix := e_feature.infix_symbol_32
				l_is_prefix_infix := True
			end

			if l_is_prefix_infix then
				process_keyword_text (ti_prefix_keyword, Void)
				add_space
				l_prefix_infix.prepend_string_general (ti_quote)
				l_prefix_infix.append_string_general (ti_quote)
				process_operator_text (l_prefix_infix, e_feature)
			else
				add_feature_name (e_feature.name_32, e_feature.written_class)
			end
		end

	add_quoted_text (s: READABLE_STRING_GENERAL)
			-- Put `s' at current position.
		do
			process_quoted_text (s)
		end

	add_comment (s: READABLE_STRING_GENERAL)
			-- Add simple comment `s'.
		do
			process_comment_text (s, Void)
		end

	add_address (address: READABLE_STRING_GENERAL; a_name: READABLE_STRING_GENERAL; e_class: CLASS_C)
			-- Put `address' for `e_class'.
		do
			process_address_text (address, a_name, e_class)
		end

	add_indent
			-- Add an indentation.
		do
			process_indentation (1)
		end

	add_indents (nr: INTEGER)
			-- Add `nr' indentations.
		do
			process_indentation (nr)
		end

	add_class_syntax (syn: ERROR; e_class: CLASS_C; str: READABLE_STRING_GENERAL)
			-- Put `syn' for `e_class'.
		do
			process_cl_syntax (str, syn, e_class)
		end

	add_column_number (column_num: INTEGER)
			-- Add column number `column_num' to current.
		do
			process_column_text (column_num)
		end

	add_feature_error (feat: E_FEATURE; str: READABLE_STRING_GENERAL; a_line: INTEGER)
			-- Put error of feature `feat', named `str' and located at `a_line'.
		do
			process_feature_error (str, feat, a_line)
		end

	add_eis_source (s: READABLE_STRING_GENERAL)
			-- Add EIS source
		do
		end

feature -- Query

	format_eis_entry (a_as: AST_EIFFEL): BOOLEAN
			-- Should eis entry be formatted?
		do
		end

feature {NONE} -- Implementation

	separate_string (s: READABLE_STRING_GENERAL; for_comment: BOOLEAN)
			-- Separate `s' into parts and add them to `Current'.
			-- Mostly for manifest strings and comments.
		local
			l_scanner: like comment_scanner
		do
			l_scanner := comment_scanner
			l_scanner.set_input_buffer (create {YY_BUFFER}.make (encoding_converter.utf32_to_utf8 (s.to_string_32)))
			l_scanner.set_text_formatter (Current)
			l_scanner.set_for_comment (for_comment)
			l_scanner.set_separate (separate_comment)
			l_scanner.set_current_class (comment_context_class)
			l_scanner.scan
		end

	comment_scanner: COMMENT_SCANNER
			-- Scanner for comment and manifest string
		once
			create Result.make_with_text_formatter (Current, separate_comment)
		end

	separate_comment: BOOLEAN
			-- Separate comment into words?

	reset_phrase (p: READABLE_STRING_GENERAL; for_comment: BOOLEAN)
			-- Add comment `p' and wipe out `p'.
		require
			p_not_void: p /= Void
		do
			if for_comment then
				process_comment_text (p.twin, Void)
			else
				process_string_text (p.twin, Void)
			end
			if attached {STRING} p as l_s then
				l_s.wipe_out
			elseif attached {STRING_32} p as l_s32 then
				l_s32.wipe_out
			else
				check
					error: False
				end
			end
		end

	comment_context_class : CLASS_C
			-- Current class for comment context.
		do
			Result := eiffel_system.system.current_class
		end

	internal_context_group: like context_group;
			-- Internal context group

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
