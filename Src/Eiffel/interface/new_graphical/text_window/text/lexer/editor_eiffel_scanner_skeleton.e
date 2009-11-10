note
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

	current_group : CONF_GROUP
			-- Current group
		do
			if current_class /= Void then
				Result ?= current_class.group
			end
		end

feature -- Element change

	set_current_class (a_class : CONF_CLASS)
			-- Set `current_class' with `a_class'
		do
			current_class := a_class
		end

feature {NONE} -- Status

	syntax_version: NATURAL_8
			-- Version of syntax used, one of the `ecma_syntax', `obsolete_64_syntax',
			-- `transitional_64_syntax', `provisional_syntax' in {EIFFEL_SCANNER}.
		do
			if attached {EIFFEL_CLASS_I} current_class as l_class then
				inspect l_class.options.syntax.index
				when {CONF_OPTION}.syntax_index_obsolete then
					Result := {EIFFEL_SCANNER}.obsolete_64_syntax
				when {CONF_OPTION}.syntax_index_transitional then
					Result := {EIFFEL_SCANNER}.transitional_64_syntax
				when {CONF_OPTION}.syntax_index_provisional then
					Result := {EIFFEL_SCANNER}.provisional_syntax
				else
					Result := {EIFFEL_SCANNER}.ecma_syntax
				end
			else
				Result := {EIFFEL_SCANNER}.ecma_syntax
			end
		end

feature {NONE} -- Implementation

	tmp_classes : LINKED_SET [CONF_CLASS]

	is_current_group_valid: BOOLEAN
		do
			Result := current_class /= Void
			check
				Result implies current_group /= Void
			end
		end

	stone_of_class (a_class: CONF_CLASS): CLASSI_STONE
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

	new_space (a_count: INTEGER): EDITOR_TOKEN_SPACE
		require
			a_count_positive: a_count > 0
		do
			create Result.make (a_count)
		ensure
			result_not_void: Result /= Void
		end

	new_tabulation (a_count: INTEGER): EDITOR_TOKEN_TABULATION
		require
			a_count_positive: a_count > 0
		do
			create Result.make (a_count)
		ensure
			result_not_void: Result /= Void
		end

	new_eol: EDITOR_TOKEN_EOL
		do
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	new_comment (a_str: STRING): EDITOR_TOKEN_COMMENT
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_text (a_str: STRING): EDITOR_TOKEN_TEXT
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_operator (a_str: STRING): EDITOR_TOKEN_OPERATOR
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_keyword (a_str: STRING): EDITOR_TOKEN_KEYWORD
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_class (a_str: STRING): EDITOR_TOKEN_CLASS
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_character (a_str: STRING): EDITOR_TOKEN_CHARACTER
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_string (a_str: STRING): EDITOR_TOKEN_STRING
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

	new_number (a_str: STRING): EDITOR_TOKEN_NUMBER
		require
			a_str_not_void: a_str /= Void
		do
			create Result.make (utf8_to_utf32 (a_str))
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Encoding conversion

	utf8_to_utf32 (a_string: STRING_8): STRING_32
			-- UTF32 to UTF8 conversion, Eiffel implementation.
		require
			a_string_not_void: a_string /= Void
		do
			utf8.convert_to (utf32, a_string)
			if utf8.last_conversion_successful then
				Result := utf8.last_converted_string
			else
				Result := a_string
			end
		ensure
			Result_not_void: Result /= Void
		end

invariant
	invariant_clause: True -- Your invariant here

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
