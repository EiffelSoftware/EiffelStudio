note
	description: "Specialize configuration for VS 2010 and beyond"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VS_NEW_CONFIG

inherit
	VS_CONFIG
		redefine
			batch_file_name, batch_file_arguments
		end

create
	make

feature {NONE} -- Access

	batch_file_name: STRING
			-- <Precursor>
		do
			create Result.make (256)
			Result.append (install_path)
			Result.append ("vcvarsall.bat")
		end

	batch_file_arguments: detachable STRING
			-- <Precursor>
		do
			create Result.make (5)
			if use_32bit then
				Result.append ("x86")
			else
				Result.append ("x64")
			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
