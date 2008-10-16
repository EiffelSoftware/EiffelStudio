indexing
	description: "[
		The Unix implementation of a URI launcher.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	URI_LAUNCHER_IMP

inherit
	URI_LAUNCHER_I
		redefine
			launch_with_app
		end

feature -- Basic operations

	launch (a_uri: !READABLE_STRING_GENERAL): BOOLEAN
			-- <Precursor>
		local
			l_app: !STRING
		do
			check is_unix: {PLATFORM}.is_unix end

			create l_app.make (256)
			if not {PLATFORM}.is_mac then
					-- Unix systems other than mac should be using 'xdg-open', Mac's use 'open'
				l_app.append ("xdg-")
			end
			l_app.append ("open")
			Result := launch_with_app (a_uri, l_app)
		end

feature {NONE} -- Basic operations

	launch_with_app (a_uri: !READABLE_STRING_GENERAL; a_app: !READABLE_STRING_GENERAL): BOOLEAN
			-- <Precursor>
		local
			l_cmd: STRING_32
		do
				-- Wrap the execution using sh because the calling app may be a shell script.
			create l_cmd.make (a_app.count + 13)
			l_cmd.append ("/bin/sh -c %'")
			l_cmd.append_string_general (a_app)
			l_cmd.append_character ('%'')
			Result := Precursor (a_uri, l_cmd)
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
