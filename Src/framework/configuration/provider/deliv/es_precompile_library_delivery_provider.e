note
	description: "Summary description for {ES_LIBRARY_DELIVERY_PROVIDER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_PRECOMPILE_LIBRARY_DELIVERY_PROVIDER

inherit
	ES_LIBRARY_DELIVERY_PROVIDER
		redefine
			lookup_directories,
			library_locations,
			cache_name
		end

feature -- Access

	cache_name (a_target: CONF_TARGET): STRING
		do
			if is_dotnet (a_target) then
				Result := "configuration_precomp_libraries_dotnet.cache"
			else
				Result := "configuration_precomp_libraries.cache"
			end
		end

feature {NONE} -- Access

	library_locations (a_target: CONF_TARGET): SEARCH_TABLE [STRING_32]
		do
			Result := Precursor (a_target)
			if Result.is_empty then
					-- Extend the default library path
				scan_library_location_to (a_target, eiffel_layout.precompilation_path (is_dotnet (a_target)).name, 4, Result)
			end
		end

	lookup_directories: ARRAYED_LIST [TUPLE [path: STRING_32; depth: INTEGER]]
			-- A list of lookup directories
		local
			l_filename: detachable PATH
			l_file: RAW_FILE
		do
			create Result.make (10)

			l_filename := eiffel_layout.precompiles_config_name
			create l_file.make_with_path (l_filename)
			if l_file.exists then
				add_lookup_directories (l_filename.name, Result)
			end
			if eiffel_layout.is_user_files_supported then
				l_filename := eiffel_layout.user_priority_file_name (l_filename, True)
				if l_filename /= Void then
					l_file.reset_path (l_filename)
					if l_file.exists then
						add_lookup_directories (l_filename.name, Result)
					end
				end
			end
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
