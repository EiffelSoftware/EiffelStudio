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

	EDITOR_SCANNER
		redefine
			make,
			reset,
			execute
		end

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton,
			reset as reset_compressed_scanner_skeleton
		export
			{NONE} all
			{ANY} valid_start_condition
		end

	KL_IMPORTED_INTEGER_ROUTINES
	KL_IMPORTED_STRING_ROUTINES
	KL_SHARED_PLATFORM
	KL_SHARED_EXCEPTIONS
	KL_SHARED_ARGUMENTS

feature {NONE} -- Init

	make
		do
			make_with_buffer (Empty_buffer)
			Precursor
		end

feature -- Access

	current_class : CONF_CLASS
			-- Current class

	current_group : CONF_GROUP
			-- Current group
		do
			if attached current_class then
				Result := current_class.group
			end
		end

feature -- Element change

	set_current_class (a_class : CONF_CLASS)
			-- Set `current_class' with `a_class'
		do
			current_class := a_class
		end

	reset
			-- Reset
		do
			reset_compressed_scanner_skeleton
			Precursor
		end

feature -- Action

	execute (a_string: STRING)
		do
			set_input_buffer (create {YY_UNICODE_BUFFER}.make_from_utf8_string (a_string))
			Precursor (a_string)
		end

feature {NONE} -- Status

	syntax_version: NATURAL_8
			-- Version of syntax used, one of the `ecma_syntax', `obsolete_syntax',
			-- `transitional_syntax', `provisional_syntax' in {EIFFEL_SCANNER}.
		do
			if attached {EIFFEL_CLASS_I} current_class as l_class then
				inspect l_class.options.syntax.index
				when {CONF_OPTION}.syntax_index_obsolete then
					Result := {EIFFEL_SCANNER}.obsolete_syntax
				when {CONF_OPTION}.syntax_index_transitional then
					Result := {EIFFEL_SCANNER}.transitional_syntax
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

	stone_of_class (a_class: CONF_CLASS): detachable CLASSI_STONE
			-- Stone of `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			if attached {CLASS_I} a_class as i then
				if attached i.compiled_class as c then
					create {CLASSC_STONE} Result.make (c)
				else
					create Result.make (i)
				end
			end
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

	new_eol (a_windows_style: BOOLEAN): EDITOR_TOKEN_EOL
		do
			create Result.make_with_style (a_windows_style)
		ensure
			result_not_void: Result /= Void
		end

	new_comment: EDITOR_TOKEN_COMMENT
			-- A new comment token from the current `unicode_text`.
		do
			create Result.make (unicode_text)
		ensure
			result_not_void: Result /= Void
		end

	new_text_in_comment: EDITOR_TOKEN_QUOTED_FEATURE_IN_COMMENT
			-- A new text-inside-comment token from the current `unicode_text`.
		do
			create Result.make (unicode_text)
		ensure
			result_not_void: Result /= Void
		end

	new_text: EDITOR_TOKEN_TEXT
			-- A new text token from the current `unicode_text`.
		do
			create Result.make (unicode_text)
		ensure
			result_not_void: Result /= Void
		end

	new_operator: EDITOR_TOKEN_OPERATOR
			-- A new operator token from the current `unicode_text`.
		do
			create Result.make (unicode_text)
		ensure
			result_not_void: Result /= Void
		end

	new_keyword: EDITOR_TOKEN_KEYWORD
			-- A new keyword token from the current `unicode_text`.
		do
			create Result.make (unicode_text)
		ensure
			result_not_void: Result /= Void
		end

	new_class: EDITOR_TOKEN_CLASS
			-- A new class token from the current `unicode_text`.
		do
			create Result.make (unicode_text)
		ensure
			result_not_void: Result /= Void
		end

	new_character: EDITOR_TOKEN_CHARACTER
			-- A new character token from the current `unicode_text`.
		do
			create Result.make (unicode_text)
		ensure
			result_not_void: Result /= Void
		end

	new_string: EDITOR_TOKEN_STRING
			-- A new string token from the current `unicode_text`.
		do
			create Result.make (unicode_text)
		ensure
			result_not_void: Result /= Void
		end

	new_number: EDITOR_TOKEN_NUMBER
			-- A new number token from the current `unicode_text`.
		do
			create Result.make (unicode_text)
		ensure
			result_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
