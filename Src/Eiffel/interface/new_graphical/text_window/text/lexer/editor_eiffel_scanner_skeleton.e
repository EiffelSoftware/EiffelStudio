indexing
	description: "Skeleton for EDITOR_EIFFEL_SCANNER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDITOR_EIFFEL_SCANNER_SKELETON

inherit
	EC_ENCODINGS

feature -- Access

	current_class : CONF_CLASS
			-- Current class

	current_group : CONF_GROUP is
			-- Current group
		do
			if current_class /= Void then
				Result ?= current_class.group
			end
		end

feature -- Element change

	set_current_class (a_class : CONF_CLASS) is
			-- Set `current_class' with `a_class'
		do
			current_class := a_class
		end

feature {NONE} -- Implementation

	tmp_classes : LINKED_SET [CONF_CLASS]

	is_current_group_valid: BOOLEAN is
		do
			Result := current_class /= Void
			check
				Result implies current_group /= Void
			end
		end

	stone_of_class (a_class: CONF_CLASS): CLASSI_STONE is
			-- Stone of `a_class'
		require
			a_class_not_void: a_class /= Void
		local
			l_class: CLASS_I
		do
			l_class ?= a_class
			check
				l_class_not_void: l_class /= Void
			end
			if l_class.is_compiled then
				create {CLASSC_STONE}Result.make (l_class.compiled_class)
			else
				create Result.make (l_class)
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Token factory
		-- Arguments are assumed as UTF-8 encoding
		-- Since the scanner only accepts text of UTF-8

	new_space (a_count: INTEGER): EDITOR_TOKEN_SPACE is
		require
			a_count_positive: a_count > 0
		do
			create Result.make (a_count)
		ensure
			result_not_void: Result /= Void
		end

	new_tabulation (a_count: INTEGER): EDITOR_TOKEN_TABULATION is
		require
			a_count_positive: a_count > 0
		do
			create Result.make (a_count)
		ensure
			result_not_void: Result /= Void
		end

	new_eol: EDITOR_TOKEN_EOL is
		do
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	new_comment (a_str: STRING): EDITOR_TOKEN_COMMENT is
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_text (a_str: STRING): EDITOR_TOKEN_TEXT is
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_operator (a_str: STRING): EDITOR_TOKEN_OPERATOR is
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_keyword (a_str: STRING): EDITOR_TOKEN_KEYWORD is
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_class (a_str: STRING): EDITOR_TOKEN_CLASS is
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_character (a_str: STRING): EDITOR_TOKEN_CHARACTER is
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_string (a_str: STRING): EDITOR_TOKEN_STRING is
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_number (a_str: STRING): EDITOR_TOKEN_NUMBER is
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Encoding conversion

	utf8_to_utf32 (a_string: STRING_8): STRING_32 is
			-- UTF32 to UTF8 conversion, Eiffel implementation.
		require
			a_string_not_void: a_string /= Void
		local
			l_str: STRING_32
		do
			utf8.convert_to (utf32, a_string)
			l_str := utf8.last_converted_string
			if utf8.last_conversion_successful then
				Result := l_str
			else
				Result := a_string
			end
		ensure
			Result_not_void: Result /= Void
		end

invariant
	invariant_clause: True -- Your invariant here

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

end
