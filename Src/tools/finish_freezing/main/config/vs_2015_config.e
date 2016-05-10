note
	description: "Specialize configuration for VS 2015"
	date: "$Date$"
	revision: "$Revision$"

class
	VS_2015_CONFIG

inherit
	VS_NEW_CONFIG
		redefine
			batch_file_arguments
		end

create
	make

feature {NONE} -- Access

	batch_file_arguments: STRING_32
			-- <Precursor>
		do
			if use_32bit then
				if is_vs_installed ({STRING_32} "x86") then
					Result := {STRING_32} "x86"
				else
						-- Even if not installed we will default to the cross compiler.
					Result := {STRING_32} "amd64_x86"
				end
			else
				if is_vs_installed ({STRING_32} "amd64") then
					Result := {STRING_32} "amd64"
				else
						-- Even if not installed we will default to the cross compiler.					
					Result := {STRING_32} "x86_amd64"
				end
			end
		end

	is_vs_installed (arch: STRING_32): BOOLEAN
			-- Is the C compiler available for architecture `arch'?
		local
			l_path: PATH
			u: FILE_UTILITIES
		do
			l_path := install_path.extended ("bin").extended (arch)
				-- Check that the basic tools are installed.
			Result := u.file_path_exists (l_path.extended ("cl.exe")) and then
				u.file_path_exists (l_path.extended ("lib.exe")) and then
				u.file_path_exists (l_path.extended ("link.exe"))
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
