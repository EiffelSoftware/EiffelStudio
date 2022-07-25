note
	description: "Locale used by interface name translation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_LOCALE

inherit
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	LOCALIZED_PRINTER

	SYSTEM_ENCODINGS

feature -- Access

	locale: I18N_LOCALE
			-- Current locale
        do
			Result := locale_internal.item
		ensure
			class
			attached Result
		end

	locale_manager: I18N_LOCALE_MANAGER
			-- Locale manager
		once
			if is_eiffel_layout_defined and then eiffel_layout.is_valid_environment then
				create Result.make (eiffel_layout.language_path.name)
			else
				create Result.make (".")
			end
		ensure
			class
		end

feature -- Status change

	set_locale_with_id (a_id: STRING_32)
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
		ensure
			class
		end

	set_locale (a_locale: like locale)
			-- Set `locale' with `a_locale'.
		require
			a_locale_not_void: a_locale /= Void
		do
			locale_internal.put (a_locale)
		ensure
			class
		end

	set_system_locale
			-- Set `locale' `system_locale'
		do
			locale_internal.put (system_locale)
		ensure
			class
		end

	set_empty_locale
			-- Set locale to be an empty locale.
		do
			locale_internal.put (empty_locale)
		ensure
			class
		end

feature {NONE} -- Implementation

	locale_internal: CELL [I18N_LOCALE]
		once
			create Result.put (empty_locale)
		ensure
			class
			attached Result
		end

	system_locale: I18N_LOCALE
		once
			Result := locale_manager.system_locale
		ensure
			class
			attached Result
		end

	empty_locale: I18N_LOCALE
		once
			Result := locale_manager.locale (create {I18N_LOCALE_ID}.make_from_string (""))
		ensure
			class
			attached Result
		end

feature -- File saving

	save_string_in_file (a_file: FILE; a_str: READABLE_STRING_GENERAL)
			-- Save `a_str' in `a_file', according to current system locale.
			-- `a_str' is taken as UTF-32 string.
		require
			a_file_not_void: a_file /= Void
			a_file_open: a_file.is_open_write
			a_file_exist: a_file.exists
			a_str_not_void: a_str /= Void
		do
			a_file.put_string (utf32_to_console_encoding (system_encoding, a_str))
		end

	read_string_from_file (a_file: FILE): STRING_32
			-- Read Unicode from `a_file'. If no encoding is detected
			-- use encoding of current locale.
		require
			a_file_not_void: a_file /= Void
			a_file_open: a_file.is_open_read
			a_file_exist: a_file.exists
		local
			l_bom_encoding_detector: BOM_ENCODING_DETECTOR
			l_source_encoding: ENCODING
			l_string_read: STRING_8
		do
			a_file.read_stream (a_file.count)
			l_string_read := a_file.last_string

			create l_bom_encoding_detector
			l_bom_encoding_detector.detect (l_string_read)
			if attached l_bom_encoding_detector.detected_encoding as l_encoding then
				l_source_encoding := l_encoding
			else
				l_source_encoding := system_encoding
			end
			l_source_encoding.convert_to (utf32, l_string_read)
			if l_source_encoding.last_conversion_successful then
				Result := l_source_encoding.last_converted_string_32
			else
				Result := l_string_read.as_string_32
			end
		ensure
			Result_set: Result /= Void
		end

feature -- String

	as_string_general (s: READABLE_STRING_GENERAL): STRING_GENERAL
		do
			if attached {STRING_GENERAL} s as sg then
				Result := sg
			else
				if attached {READABLE_STRING_8} s as s8 then
					create {STRING_8} Result.make (s.count)
				else
					create {STRING_32} Result.make (s.count)
				end
				Result.append (s)
			end
		end

	as_string_general_twin (s: READABLE_STRING_GENERAL): STRING_GENERAL
		do
			if attached {STRING_GENERAL} s as sg then
				Result := sg.twin
			else
				if attached {READABLE_STRING_8} s as s8 then
					create {STRING_8} Result.make (s.count)
				else
					create {STRING_32} Result.make (s.count)
				end
				Result.append (s)
			end
		end

	first_character_as_upper (a_s: READABLE_STRING_GENERAL): STRING_32
			-- First character to upper case if possible.
			-- Be careful to apply this to a translated word.
			-- Since translation might result in more than one word from one in English.
		require
			a_s_not_void: a_s /= Void
		do
			Result := a_s.as_string_32
			if Result = a_s then
				Result := Result.twin
			end
			if not Result.is_empty then
				Result [1] := Result [1].as_upper
			end
		ensure
			Result_not_void: Result /= Void
			Identity: Result /= a_s
		end

	string_general_as_lower (a_s: READABLE_STRING_GENERAL): STRING_GENERAL
			-- Make all possible char in `a_str' to lower.
		obsolete "use {READABLE_STRING_GENERAL}.as_lower [2012-10-01]"
		require
			a_str_not_void: a_s /= Void
		do
			Result := as_string_general (a_s).as_lower
		ensure
			Result_not_void: Result /= Void
			Result_is_lower: is_string_general_lower (Result)
			Identity: Result /= a_s
		end

	string_general_as_upper (a_s: READABLE_STRING_GENERAL): STRING_GENERAL
			-- Make all possible char in `a_str' to upper.
		obsolete "use {READABLE_STRING_GENERAL}.as_upper [2012-10-01]"
		require
			a_str_not_void: a_s /= Void
		do
			Result := as_string_general (a_s).as_upper
		ensure
			Result_not_void: Result /= Void
			Result_is_upper: is_string_general_upper (Result)
			Identity: Result /= a_s
		end

	string_general_left_adjust (a_str: STRING_GENERAL)
			-- Make all possible char in `a_str' to upper.
		require
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER_32
		do
			if attached {STRING_8} a_str as l_str_8 then
				l_str_8.left_adjust
			else
				from
					i := 1
					nb := a_str.count
				until
					i > nb or else not a_str.item (i).is_space
				loop
					i := i + 1
				end
				if i > 1 then
					a_str.keep_tail (nb - i + 1)
				end
			end
		end

	string_general_right_adjust (a_str: STRING_GENERAL)
			-- Remove leading whitespace.
		require
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER_32
		do
			if attached {STRING_8} a_str as l_str_8 then
				l_str_8.right_adjust
			else
				from
					nb := a_str.count
					i := nb
				until
					i < 1 or else not a_str.item (i).is_space
				loop
					i := i - 1
				end
				if i < nb then
					a_str.keep_head (i)
				end
			end
		end

	is_string_general_lower (a_str: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_str' in lower case?
		require
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER_32
			c: CHARACTER_32
		do
			Result := True
			from
				i := 1
				nb := a_str.count
			until
				i > nb or not Result
			loop
				c := a_str.item (i)
				if c.as_lower /= c then
					Result := False
				end
				i := i + 1
			end
		end

	is_string_general_upper (a_str: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_str' in upper case?
		require
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER_32
			c: CHARACTER_32
		do
			Result := True
			from
				i := 1
				nb := a_str.count
			until
				i > nb or not Result
			loop
				c := a_str.item (i)
				if c.as_upper /= c then
					Result := False
				end
				i := i + 1
			end
		end

	string_general_is_caseless_equal (a_str: READABLE_STRING_GENERAL; a_str_other: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_str' case insensitive equal to `a_str_other'?
			--
			-- `a_str' and `a_str_other' must be UTF-32 compatible.
		obsolete "use {READABLE_STRING_GENERAL}.is_case_insensitive_equal (..) [2012-10-01]"
		require
			a_str_32_not_void: a_str /= Void
			a_str_other_not_void: a_str_other /= Void
		do
			Result := a_str.is_case_insensitive_equal (a_str_other)
		end

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
