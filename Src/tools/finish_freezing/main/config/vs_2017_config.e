note
	description: "[
		Locator for C/C++ compiler for Visual Studio 2017.
		
		VS 2017 changed their install process and now we have to use a COM interface to locate VS 2017.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VS_2017_CONFIG

inherit
	MSCL_CONFIG

create
	make

feature -- Access

	install_path: PATH
			-- Precursor
		do
			if attached internal_install_path as l_path then
				Result := l_path
			else
				create Result.make_current
			end
		end

	exists: BOOLEAN
		do
			initialize
			Result := internal_install_path /= Void
		end

	batch_file_name: PATH
			-- Absolute path to an environment configuration batch script
		do
			if use_32bit then
				Result := install_path.extended ("VC\Auxiliary\Build\vcvars32.bat")
				-- Result := install_path.appended ("VC\Auxiliary\Build\vcvarsamd64_x86.bat"
			else
				Result := install_path.extended ("VC\Auxiliary\Build\vcvars64.bat")
				-- Result := install_path.appended ("VC\Auxiliary\Build\vcvarsx86_amd64.bat")
			end
		end

	vs_version: INTEGER
			-- Internal version of Visual Studio
		do
			Result := 15
		end

feature {NONE} -- Implementation

	on_initialize
		local
			l_str: WEL_STRING
			l_c_str: C_STRING
			l_file_name: like batch_file_name
			u: FILE_UTILITIES
			l_parser: ENV_PARSER
		do
			if attached c_vs_get_installation_path (vs_version) as l_str8 then
				create l_c_str.make (l_str8)
				create l_str.make_by_pointer_and_count (l_c_str.item, l_str8.count * 2)
				create internal_install_path.make_from_string (l_str.string)
				l_file_name := batch_file_name
				if u.file_path_exists (l_file_name) then
					create l_parser.make (l_file_name, batch_file_arguments, batch_file_options)
					extend_variable (path_var_name, l_parser.path)
					extend_variable (include_var_name, l_parser.include)
					extend_variable (lib_var_name, l_parser.lib)
				end

				if is_eiffel_layout_defined and then eiffel_layout.is_valid_environment then
						-- Added runtime include and lib paths
					extend_variable (include_var_name, eiffel_layout.runtime_include_path.name)
					extend_variable (lib_var_name, eiffel_layout.runtime_lib_path.name)
				end
			end
		end

	internal_install_path: detachable PATH
			-- Internal path for VS

	c_vs_get_installation_path (desired_version: INTEGER): detachable STRING_8
		external
			"C++ inline use %"eif_vs_setup.h%""
		alias
			"return c_vs_get_installation_path($desired_version);"
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
