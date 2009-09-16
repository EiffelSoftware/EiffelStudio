note
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

	last_opened_projects: ARRAY [TUPLE [READABLE_STRING_32, READABLE_STRING_32]]
			-- List of last opened projects
		do
			create Result.make (1, 0)
			Result.compare_objects
			last_opened_projects_preference.value.do_all (
				agent (s: STRING; r: ARRAY [TUPLE [READABLE_STRING_32, READABLE_STRING_32]])
					local
						i: INTEGER
						p: TUPLE [READABLE_STRING_32, READABLE_STRING_32]
						f: READABLE_STRING_32
						t: READABLE_STRING_32
					do
						i := s.index_of_code (('>').code.as_natural_32, 1)
						if i > 1 then
							f := s.substring (1, i - 1)
							t := s.substring (i + 1, s.count)
						else
							f := s
							t := ""
						end
							-- Ensure the type of tuple by using locals.
						p := [f, t]
						p.compare_objects
						r.force (p, r.upper + 1)
					end
				(?, Result)
			)
		end

feature -- Modification

	set_last_opened_projects (l: ARRAY [TUPLE [READABLE_STRING_32, READABLE_STRING_32]])
			-- Set list of last opened projects
		local
			a: ARRAY [STRING]
		do
			create a.make (1, 0)
			a.compare_objects
			l.do_all (
				agent (t: TUPLE [file: READABLE_STRING_32; target: READABLE_STRING_32]; r: ARRAY [STRING])
					do
						if t.target = Void or else t.target.is_empty then
							r.force (t.file, r.upper + 1)
						else
							r.force (t.file + ">" + t.target, r.upper + 1)
						end
					end
				(?, a)
			)
			last_opened_projects_preference.set_value (a)
		ensure
			last_opened_projects_set: last_opened_projects ~ l
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

end -- class EB_RECENT_PROJECTS
