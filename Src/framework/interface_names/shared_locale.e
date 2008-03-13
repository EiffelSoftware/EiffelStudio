indexing
	description:
		"Locale used by interface name translation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_LOCALE

inherit --{NONE}
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature -- Access

	locale: I18N_LOCALE is
			-- Current locale
        do
			Result := locale_internal.item
			if Result = Void then
				Result := empty_locale
				locale_internal.put (Result)
			end
		ensure
			locale_not_void: Result /= Void
		end

	locale_manager: I18N_LOCALE_MANAGER is
			-- Locale manager
		once
			check
				is_eiffel_layout_defined: is_eiffel_layout_defined
				is_valid_environment: eiffel_layout.is_valid_environment
			end
			create Result.make (eiffel_layout.language_path)
		end

feature -- Status change

	set_locale_with_id (a_id: STRING) is
			-- Set `locale' with `a_id'.
			-- `a_id' is a Locale Id.
			-- If locale of `a_id' not found, an empty locale is set.
		require
			a_id_not_void: a_id /= Void
		local
			l_id: I18N_LOCALE_ID
        do
			create l_id.make_from_string (a_id)
			if locale_manager.has_locale (l_id) then
				locale_internal.put (locale_manager.locale (l_id))
			else
				locale_internal.put (empty_locale)
			end
		end

	set_locale (a_locale: like locale) is
			-- Set `locale' with `a_locale'.
		require
			a_locale_not_void: a_locale /= Void
		do
			locale_internal.put (a_locale)
		end

	set_system_locale is
			-- Set `locale' `system_locale'
		do
			locale_internal.put (system_locale)
		end

	set_empty_locale is
			-- Set locale to be an empty locale.
		do
			locale_internal.put (empty_locale)
		end

feature -- Output

	localized_print (a_str: STRING_GENERAL) is
			-- Print `a_str' as localized encoding.
			-- `a_str' is taken as a UTF-16 string.
		local
			l_string: STRING_GENERAL
		do
			if a_str /= Void then
				l_string := utf16_to_console_encoding (console_encoding, a_str)
				if l_string /= Void then
					check
						l_string_is_valid_as_string_8: l_string.is_valid_as_string_8
					end
					io.put_string (l_string.as_string_8)
				else
					io.put_string (a_str.as_string_8)
				end
			end
		end

	localized_print_error (a_str: STRING_GENERAL) is
			-- Print an error, `a_str', as localized encoding.
			-- `a_str' is taken as a UTF-16 string.
		local
			l_string: STRING_GENERAL
		do
			l_string := utf16_to_console_encoding (console_encoding, a_str)
			if l_string /= Void then
				check
					l_string_is_valid_as_string_8: l_string.is_valid_as_string_8
				end
				io.error.put_string (l_string.as_string_8)
			else
				io.error.put_string (a_str.as_string_8)
			end
		end

feature -- Conversion

	utf16_to_console_encoding (a_console_encoding: ENCODING; a_str: STRING_GENERAL): STRING_GENERAL is
			-- Convert `a_str' to console encoding if possible.
			-- `a_str' is taken as a UTF-16 string.
		require
			a_console_encoding_not_void: a_console_encoding /= Void
			a_str_not_void: a_str /= Void
		do
			Result := encoding_utf16.convert_to (a_console_encoding, a_str)
				-- This is a hack, since some OSes don't support convertion from/to UTF-16 to `a_console_encoding'.
				-- We convert UTF-16 to UTF-8 first, then convert UTF-8 to `a_console_encoding'.
			if not encoding_utf16.last_conversion_successful and not encoding_utf8.is_equal (a_console_encoding) then
				Result := encoding_utf16.convert_to (encoding_utf8, a_str)
				if encoding_utf16.last_conversion_successful then
					Result := encoding_utf8.convert_to (a_console_encoding, Result)
				end
			end
		end

	console_encoding_to_utf16 (a_console_encoding: ENCODING; a_str: STRING_GENERAL): STRING_GENERAL is
			-- Convert `a_str' to console encoding if possible.
			-- `a_str' is taken as a UTF-16 string.
		require
			a_console_encoding_not_void: a_console_encoding /= Void
			a_str_not_void: a_str /= Void
		do
			Result := a_console_encoding.convert_to (encoding_utf16, a_str)
				-- This is a hack, since some OSes don't support convertion from/to UTF-16 to `a_console_encoding'.
				-- We convert `a_console_encoding' to UTF-8 first, then convert UTF-8 to UTF-16.
			if not a_console_encoding.last_conversion_successful and not encoding_utf8.is_equal (a_console_encoding) then
				Result := a_console_encoding.convert_to (encoding_utf8, a_str)
				if a_console_encoding.last_conversion_successful then
					Result := encoding_utf8.convert_to (encoding_utf16, Result)
				end
			end
		end

feature {NONE} -- Implementation

	locale_internal: CELL [I18N_LOCALE] is
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	system_locale: I18N_LOCALE
		once
			Result := locale_manager.system_locale
		ensure
			result_not_void: Result /= Void
		end

	empty_locale: I18N_LOCALE
		once
			Result := locale_manager.locale (create {I18N_LOCALE_ID}.make_from_string (""))
		ensure
			result_not_void: Result /= Void
		end

	system_encoding: ENCODING is
			-- System encoding which is from system locale.
		once
			create Result.make (system_locale.info.code_page)
		ensure
			result_not_void: Result /= Void
		end

	console_encoding: ENCODING is
			-- Encoding of console output
		local
			l_cp_i: CONSOLE_CODE_PAGE_I
		once
			create {CONSOLE_CODE_PAGE_IMP}l_cp_i
			create Result.make (l_cp_i.console_code_page)
		ensure
			result_not_void: Result /= Void
		end

	encoding_utf16: ENCODING is
			-- UTF-16 encoding.
		once
			create Result.make ((create {CODE_PAGE_CONSTANTS}).utf16)
		ensure
			result_not_void: Result /= Void
		end

	encoding_utf8: ENCODING is
			-- UTF-8 encoding.
		once
			create Result.make ((create {CODE_PAGE_CONSTANTS}).utf8)
		ensure
			result_not_void: Result /= Void
		end

feature -- File saving

	save_string_32_in_file (a_file: FILE; a_str: STRING_32) is
			-- Save `a_str' in `a_file', according to current locale.
			-- `a_str' should be UTF-16 string.
		require
			a_file_open: a_file.is_open_write
			a_file_exist: a_file.exists
			a_str_not_void: a_str /= Void
		local
			l_string: STRING_GENERAL
		do
			l_string := encoding_utf16.convert_to (system_encoding, a_str)
			if l_string /= Void then
				check
					l_string_is_valid_as_string_8: l_string.is_valid_as_string_8
				end
				a_file.put_string (l_string.as_string_8)
			else
				a_file.put_string (a_str.as_string_8)
			end
		end

feature -- String

	first_character_as_upper (a_s: STRING_GENERAL): STRING_GENERAL is
			-- First character to upper case if possible.
			-- Be careful to apply this to a translated word.
			-- Since translation might result in more than one word from one in English.
		require
			a_s_not_void: a_s /= Void
		local
			c: NATURAL_32
		do
			Result := a_s.twin
			if not Result.is_empty then
				c := Result.code (1)
				if c <= {CHARACTER_8}.max_value.to_natural_32 then
					Result.put_code (c.to_character_8.as_upper.natural_32_code, 1)
				end
			end
		ensure
			Result_not_void: Result /= Void
			Identity: Result /= a_s
		end

	string_general_as_lower (a_s: STRING_GENERAL): STRING_GENERAL is
		require
			a_s_not_void: a_s /= Void
		local
			l_str: STRING
		do
			if a_s.is_valid_as_string_8 then
				l_str := a_s.as_string_8
				Result := l_str.as_lower
			else
				Result := a_s.twin
			end
		ensure
			Result_not_void: Result /= Void
			Result_is_lower: is_string_general_lower (Result)
			Identity: Result /= a_s
		end

	string_general_as_upper (a_s: STRING_GENERAL): STRING_GENERAL is
		require
			a_s_not_void: a_s /= Void
		local
			l_str: STRING
		do
			if a_s.is_valid_as_string_8 then
				l_str := a_s.as_string_8
				Result := l_str.as_upper
			else
				Result := a_s.twin
			end
		ensure
			Result_not_void: Result /= Void
			Result_is_upper: is_string_general_upper (Result)
			Identity: Result /= a_s
		end

	string_general_as_left_adjusted (a_s: STRING_GENERAL): STRING_GENERAL is
		require
			a_s_not_void: a_s /= Void
		local
			l_str: STRING
		do
			if a_s.is_valid_as_string_8 then
				l_str := a_s.as_string_8
				l_str.left_adjust
				Result := l_str
			else
				Result := a_s.twin
			end
		ensure
			Result_not_void: Result /= Void
			Identity: Result /= a_s
		end

	is_string_general_lower (a_str: STRING_GENERAL): BOOLEAN is
			-- Is `a_str' in lower case?
		local
			l_str: STRING
		do
			if a_str.is_valid_as_string_8 then
				l_str := a_str.as_string_8
				Result := l_str.as_lower.is_equal (l_str)
			else
				Result := True
			end
		end

	is_string_general_upper (a_str: STRING_GENERAL): BOOLEAN is
			-- Is `a_str' in upper case?
		local
			l_str: STRING
		do
			if a_str.is_valid_as_string_8 then
				l_str := a_str.as_string_8
				Result := l_str.as_upper.is_equal (l_str)
			else
				Result := True
			end
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

end



