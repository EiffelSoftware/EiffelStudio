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
		local
			l_locale_manager: I18N_LOCALE_MANAGER
			l_id: I18N_LOCALE_ID
			l_layout: EC_EIFFEL_LAYOUT
        once
        	create l_layout
        	l_layout.check_environment_variable
			create l_locale_manager.make (l_layout.language_path)
				-- Only zh_CN is valid now, other languages are comming accompany with the interface.
			create l_id.make_from_string ("zh_CN")
			if l_locale_manager.has_locale (l_id) then
				Result := l_locale_manager.get_locale (l_id)
			else
				Result := l_locale_manager.get_system_locale
			end
		end

feature -- String

	first_character_to_upper_case (a_s: STRING_GENERAL): STRING_GENERAL is
			-- First character to upper case if possible
		require
			a_s_not_void: a_s /= Void
		local
			l_str: STRING
		do
			if not a_s.is_empty and then a_s.is_valid_as_string_8 then
				l_str := a_s.as_string_8
				l_str.left_adjust
					-- Set the first character to upper case.
				l_str.put (l_str.item (1).as_upper, 1)
				Result := l_str
			else
				Result := a_s
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

