indexing
	description: "Interface preserved from structured text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_OPERATOR

inherit
	SHARED_FILTER

	SHARED_TEXT_ITEMS

feature -- Operation

	add (s: STRING_GENERAL) is
			-- Add `s'.
		require
			s_not_void: s /= Void
		do
			add_string (s)
		end

	add_new_line is
			-- Put a new line aat current position.
		deferred
		end

	add_space is
			-- Put a space at current position.
		do
			add (ti_Space)
		end

	add_string (s: STRING_GENERAL) is
			-- Put default string `s' at current position.
			-- Default string is used for formats.
		require
			s_not_void: s /= Void
		deferred
		end

	add_manifest_string (s: STRING_GENERAL) is
			-- Put `s' at current position as a manifest string.
			-- Break `s' up in multiple tokens, if a link is
			-- present.
		require
			s_not_void: s /= Void
			s_not_has_eol: not has_new_line (s)
		do
			add_string (s)
		end

	add_multiline_string (a_s: STRING_GENERAL; indent: INTEGER) is
			-- Put string `s' at current position.
			-- Break `s' up in multiple lines, if it has new line character(s).
			-- Indent each line `indent' times in the latter case.
			-- Example:
			--    add_multiline_string ("123", 3) with last string "ABC":
			--       ABC123
			--    add_multiline_string ("1%N2%N3", 1) with last string "ABC":
			--       ABC
			--        1
			--        2
			--        3
		require
			a_s_not_void: a_s /= Void
			non_negative_indent: indent >= 0
		local
			l_pos, l_previous: INTEGER
			s: STRING_32
		do
			s := a_s.as_string_32
			l_pos := s.index_of ('%N', 1)
			if l_pos > 0 then
				from
					l_previous := 1
				until
					l_pos = 0
				loop
					add_indents (indent)
					add_string (s.substring (l_previous, l_pos -1))
					add_new_line
					l_previous := l_pos + 1
					l_pos := s.index_of ('%N', l_previous)
				end
				if l_previous < s.count then
					add_indents (indent)
					add_string (s.substring (l_previous, s.count))
				end
			else
				add_string (s)
			end
		end

	add_indexing_string (s: STRING_GENERAL) is
			-- Put string `s' at current position.
			-- Break `s' up in multiple processings, see `separate_string'.
		require
			-- Universe exists
			s_not_void: s /= Void
		do
			if not s.is_empty then
				separate_string (s, False)
			else
				add_string (s)
			end
		end

	add_char (c: CHARACTER_32) is
			-- Put `c' at current position.
		deferred
		end

	add_int (i: INTEGER) is
			-- Put `i' at current position.
		deferred
		end

	add_local (s: STRING_GENERAL) is
			-- Put `s' at current position as local symbol.
		require
			s_not_void: s /= Void
		deferred
		end

	add_group (e_cluster: CONF_GROUP; str: STRING_GENERAL) is
			-- Put `e_cluster' with strring representation
			-- `str' at current position.
		require
			str_not_void: str /= Void
		deferred
		end

	add_before_class (e_class: CLASS_C) is
			-- Put `e_class' at current position.
		require
			valid_e_class: e_class /= Void
		deferred
		end

	add_end_class (e_class: CLASS_C) is
			-- Put `e_class' at current position.
		require
			valid_e_class: e_class /= Void
		deferred
		end

	add_classi (class_i: CLASS_I; str: STRING_GENERAL) is
			-- Put `class_i' with string representation
			-- `str' at current position.
		require
			valid_str: str /= Void
		deferred
		end

	add_class (class_i: CLASS_I) is
			-- Append class item.
		require
			class_i_not_void: class_i /= Void
		deferred
		end

	add_error (error: ERROR; str: STRING_GENERAL) is
			-- Put `error' with string representation
			-- `str' at current position.
		require
			valid_error: error /= Void
			valid_str: str /= Void
		deferred
		end

	add_feature (feat: E_FEATURE; str: STRING_GENERAL) is
			-- Put feature `feat' with string
			-- representation `str' at current position.
		require
			valid_feat: feat /= Void
			valid_str: str /= Void
		deferred
		end

	add_breakpoint_index (feat: E_FEATURE; indx: INTEGER; has_cond: BOOLEAN) is
			-- Put `index'-th breakpoint of feature `feat' with integer
			-- representation `index' at current position.
		deferred
		end

	add_feature_name (f_name: STRING_GENERAL; e_class: CLASS_C) is
			-- Put feature name `f_name' defined in `e_class'.
		require
			f_name_not_void: f_name /= Void
			e_class_not_void: e_class /= Void
		deferred
		end

	add_sectioned_feature_name (e_feature: E_FEATURE) is
			-- Put feature name of `e_feature', taking reserved words into consideration.
		require
			e_feature_attached: e_feature /= Void
		deferred
		end

	add_quoted_text (s: STRING_GENERAL) is
			-- Put `s' at current position.
		require
			s_not_void: s /= Void
		deferred
		end

	add_comment (s: STRING_GENERAL) is
			-- Add simple comment `s'.
		require
			s_not_void: s /= Void
		deferred
		end

	add_comment_text (s: STRING_GENERAL) is
			-- Put `s' at current position.
			-- Break `s' up in multiple processings, if a link is
			-- present.
		require
			-- Universe exists
			s_not_void: s /= Void
		do
			separate_string (s, True)
		end

	add_address (address: STRING_GENERAL; a_name: STRING_GENERAL; e_class: CLASS_C) is
			-- Put `address' for `e_class'.
		require
			valid_address: address /= Void
		deferred
		end

	add_indent is
			-- Add an indentation.
		deferred
		end

	add_indents (nr: INTEGER) is
			-- Add `nr' indentations.
		deferred
		end

	add_class_syntax (syn: ERROR; e_class: CLASS_C; str: STRING_GENERAL) is
			-- Put `syn' for `e_class'.
		require
			valid_syn: syn /= Void
			valid_str: str /= Void
		deferred
		end

	add_column_number (column_num: INTEGER) is
			-- Add column number `i' to structure text.
		require
			positive_ints: column_num > 0
		deferred
		end

	add_feature_error (feat: E_FEATURE; str: STRING_GENERAL; a_line: INTEGER) is
			-- Put `address' for `e_class'.
		require
			valid_str: str /= Void
			positive_line: a_line > 0
		deferred
		end

feature -- Status report

	has_new_line (a_s: STRING_GENERAL): BOOLEAN is
		do
			Result := a_s.as_string_32.has ('%N')
		end

feature {NONE} -- Implementation

	separate_string (s: STRING_GENERAL; for_comment: BOOLEAN) is
			-- Separate `s' into parts and add them to `Current'.
		deferred
		end

	process_character_text (text: STRING_GENERAL) is
			-- Add a char.
		require
			text_not_void: text /= Void
		deferred
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
end -- class TEXT_OPERATOR
