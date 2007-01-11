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

feature -- Access

	locale: I18N_LOCALE is
			-- Current locale
        do
			Result := locale_internal.item
			if Result = Void then
				Result := system_locale
				locale_internal.put (Result)
			end
		ensure
			locale_not_void: Result /= Void
		end

	locale_manager: I18N_LOCALE_MANAGER is
			-- Locale manager
		local
			l_layout: EC_EIFFEL_LAYOUT
		once
        	create l_layout
        	l_layout.check_environment_variable
			create Result.make (l_layout.language_path)
		end

feature -- Status change

	set_locale_with_id (a_id: STRING) is
			-- Set `locale' with `a_id'.
			-- `a_id' is a Locale Id.
		require
			a_id_not_void: a_id /= Void
		local
			l_id: I18N_LOCALE_ID
        do
			create l_id.make_from_string (a_id)
			if locale_manager.has_locale (l_id) then
				locale_internal.put (locale_manager.get_locale (l_id))
			else
				locale_internal.put (system_locale)
			end
		end

feature {NONE} -- Implementation

	locale_internal: CELL [I18N_LOCALE] is
		once
			create Result
		end

	system_locale: I18N_LOCALE
		once
			Result := locale_manager.get_system_locale
		end

feature -- String

	first_character_to_upper_case (a_s: STRING_GENERAL): STRING_GENERAL is
			-- First character to upper case if possible
		require
			a_s_not_void: a_s /= Void
		local
			c: NATURAL_32
		do
			Result := a_s
			if not Result.is_empty then
				c := Result.code (1)
				if c <= {CHARACTER_8}.max_value.to_natural_32 then
					Result.put_code (c.to_character_8.as_upper.natural_32_code, 1)
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	string_general_to_lower (a_s: STRING_GENERAL): STRING_GENERAL is
		require
			a_s_not_void: a_s /= Void
		local
			l_str: STRING
		do
			if a_s.is_valid_as_string_8 then
				l_str := a_s.as_string_8
				Result := l_str.as_lower
			else
				Result := a_s
			end
		ensure
			Result_not_void: Result /= Void
			Result_is_lower: is_string_general_lower (Result)
		end

	string_general_to_upper (a_s: STRING_GENERAL): STRING_GENERAL is
		require
			a_s_not_void: a_s /= Void
		local
			l_str: STRING
		do
			if a_s.is_valid_as_string_8 then
				l_str := a_s.as_string_8
				Result := l_str.as_upper
			else
				Result := a_s
			end
		ensure
			Result_not_void: Result /= Void
			Result_is_upper: is_string_general_upper (Result)
		end

	string_general_left_adjust (a_s: STRING_GENERAL): STRING_GENERAL is
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
				Result := a_s
			end
		ensure
			Result_not_void: Result /= Void
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

