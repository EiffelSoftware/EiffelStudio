﻿note
	description: "Recent project preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RECENT_PROJECTS

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES)
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end

feature -- Value

	last_opened_projects: ARRAY [TUPLE [PATH, READABLE_STRING_32]]
			-- List of last opened projects
		local
			i: INTEGER
			p: TUPLE [PATH, READABLE_STRING_32]
			f8: STRING_8
			t8: STRING_8
			f: READABLE_STRING_32
			t: READABLE_STRING_32
			u: UTF_CONVERTER
			s: STRING
		do
			create Result.make_empty
			Result.compare_objects
			across
				last_opened_projects_preference.value as ic
			loop
				s := ic.item
				i := s.index_of_code (('>').code.as_natural_32, 1)
				if i > 1 then
					f8 := s.substring (1, i - 1)
					t8 := s.substring (i + 1, s.count)
				else
					f8 := s
					t8 := ""
				end
				f := u.utf_8_string_8_to_string_32 (f8)
				t := u.utf_8_string_8_to_string_32 (t8)
					-- Ensure the type of tuple by using locals.
				p := [create {PATH}.make_from_string (f), t]
				p.compare_objects
				Result.force (p, Result.upper + 1)
			end
		end

feature -- Modification

	set_last_opened_projects (a_list: ARRAY [TUPLE [file: PATH; target: READABLE_STRING_32]])
			-- Set list of last opened projects
		local
			a: ARRAY [STRING_8]
			u: UTF_CONVERTER
		do
			create a.make_empty
			a.compare_objects
			across
				a_list as ic
			loop
				if attached ic.item as t then
					if attached t.target as t_target and then not t_target.is_empty then
						a.force (u.string_32_to_utf_8_string_8 (t.file.name + ">" + t_target), a.upper + 1)
					else
						a.force (u.string_32_to_utf_8_string_8 (t.file.name), a.upper + 1)
					end
				end
			end

			last_opened_projects_preference.set_value (a)
		ensure
			last_opened_projects_set: last_opened_projects ~ a_list
		end

feature {EB_SHARED_PREFERENCES} -- Preference

	last_opened_projects_preference: ARRAY_PREFERENCE

feature {EB_RECENT_PROJECTS_MANAGER} -- Preference Strings

	last_opened_projects_string: STRING = "recent_projects.last_opened_projects"

feature {NONE} -- Implementation

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "recent_projects")
			last_opened_projects_preference := l_manager.new_array_preference_value (l_manager, last_opened_projects_string, <<>>)
		end

	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void

note
	ca_ignore:
		"CA093", "CA093: manifest array type mismatch"
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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

end -- class EB_RECENT_PROJECTS
