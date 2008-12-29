note
	description: "[
						Dynamic load a external API which exists in a dll or so.
						Benefit is we can still use our executables even without the dll/so files.
																									]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	API_LOADER

feature -- Query

	safe_load_api (a_module_name: STRING; a_api_name: STRING): POINTER
			-- Safe loading `a_api_name' in `a_module_name' if possible.
			-- `a_module_name' is case sensitive.
		require
			not_void: a_module_name /= Void and then not a_module_name.is_empty
			not_void: a_api_name /= Void and then not a_api_name.is_empty
		local
			l_module: POINTER
		do
			l_module := module_pointer (a_module_name)
			if l_module /= default_pointer then
				Result := api_pointer (l_module, a_api_name)
			end
		end

	module_pointer (a_name: STRING): POINTER
			-- Find module hanle with `a_name'
			-- Result is void if not exists
		require
			not_void: a_name /= Void
		do
			if loaded_modules.has_key (a_name) then
				Result := loaded_modules.item (a_name)
			else
				Result := implementation.load_module (a_name)
				if Result /= default_pointer then
					loaded_modules.extend (Result, a_name)
				end
			end
		end

	api_pointer (a_module: POINTER; a_name: STRING): POINTER
			-- Find API pointer which name is `a_name' in `a_module'
			-- Result is void if not exists.
		require
			exists: a_module /= default_pointer
			not_void: a_name /= Void
		do
			if loaded_apis.has (a_name) then
				Result := loaded_apis.item (a_name)
			else
				Result := implementation.loal_api (a_module, a_name)
				if Result /= default_pointer then
					loaded_apis.extend (Result, a_name)
				end
			end
		end

feature {NONE} -- Implementation

	loaded_modules: HASH_TABLE [POINTER, STRING]
			-- Loaded modules
		once
			create Result.make (1)
		end

	loaded_apis: HASH_TABLE [POINTER, STRING]
			-- Loaded apis.
		once
			create Result.make (10)
		end

	implementation: API_LOADER_IMP
			-- Native loader
		once
			create Result
		end
note
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
