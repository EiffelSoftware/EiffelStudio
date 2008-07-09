indexing
	description: "[
		The Unix implementation of a URI launcher.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	URI_LAUNCHER

inherit
	URI_LAUNCHER_I

feature -- Basic operations

	launch (a_uri: !STRING_GENERAL): BOOLEAN
			-- <Precursor>
		local
			l_exec: !EXECUTION_ENVIRONMENT
			l_cmd: !STRING
		do
			check is_unix: {PLATFORM}.is_unix end
			create l_exec
			create l_cmd.make (256)
			if not {PLATFORM}.is_mac then
					-- Unix systems other than mac should be using 'xdg-open', Mac's use 'open'
				l_cmd.append ("xdg-")
			end
			l_cmd.append ("open %"")
			l_cmd.append (a_uri.as_string_8)
			l_cmd.append_character ('%"')
			l_exec.launch (l_cmd)
			Result := True
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
