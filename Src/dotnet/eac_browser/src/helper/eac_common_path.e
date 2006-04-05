indexing
	description: "Path used by eac browser."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EAC_COMMON_PATH

feature -- Access

	Eiffel_path: STRING is
			-- Path to Eiffel installation.
		local   
			retried: BOOLEAN
--			l_str: SYSTEM_STRING
--			l_registry_key: REGISTRY_KEY   
--			l_obj: SYSTEM_OBJECT
		once
			if not retried then   
				Result := (create {EXECUTION_ENVIRONMENT}).get (Ise_eiffel_key)
--				if Result = Void then   
--					l_registry_key := feature {REGISTRY}.local_machine   
--					l_registry_key := l_registry_key.open_sub_key (("SOFTWARE").to_cil)   
--					l_registry_key := l_registry_key.open_sub_key (("ISE").to_cil)   
--					l_registry_key := l_registry_key.open_sub_key (("Eiffel52").to_cil)   
--					l_registry_key := l_registry_key.open_sub_key (("emitter").to_cil)   
--					l_obj := l_registry_key.get_value (Ise_eiffel_key.to_cil)   
--					l_str ?= l_obj   
--
--					if l_str /= Void then   
--					 create Result.make_from_cil (l_str)   
--					end   
--				end 

				check
					Ise_eiffel_defined: Result /= Void
				end
				if Result.item (Result.count) /= (create {OPERATING_ENVIRONMENT}).Directory_separator then
					Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
				end
			else   
				-- FIXME: Manu 05/14/2002: we should raise an error here.   
				io.error.put_string ("ISE_EIFFEL environment variable is not defined!%N")   
			end 
		ensure
			exist: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator 
		rescue   
			retried := True   
			retry   
		end

	dotnet_framework_path: STRING is
		-- Path to .NET Framework.
		local
			p: POINTER
			path: WEL_STRING
			n, len: INTEGER
		once
			n := 1024
			-- We allocate 2 * n bytes, as `p' will hold a unicode string.
			p := p.memory_alloc (2 * n)
			if get_core_system_directory (p, n, $len) = 0 then
			create path.make_empty (len + 1)
			n := wcstombs (path.item, p, len)
			Result := path.string
		end
	end

	
feature {NONE} -- Implementation

	Info_path: STRING is "info.xml"
			-- Path to EAC info file relative to `Eac_path'.
		
	Ise_eiffel_key: STRING is "ISE_EIFFEL"
			-- Environment variable $ISE_EIFFEL.

	Eac_path: STRING is "dotnet\assemblies\"
			-- EAC path relative to $ISE_EIFFEL.

	Assembly_original_types_file_name: STRING is "original_types.xml"
			-- Original file of types which lists all types in assembly.
	
	
	
	get_core_system_directory (path: POINTER; buf_size: INTEGER; filled_length: POINTER): INTEGER is
			-- Initializes a wide character `path' of size `buf_size' characters
			-- with path to .NET Framework SDK location. Number of characters set in `path'
			-- is given by `filled_length'.
		external
			"C [dllwin32 %"mscoree.dll%"] (LPWSTR, DWORD, DWORD*): BOOL"
		alias
			"GetCORSystemDirectory"
		end
	
	wcstombs (dest, source: POINTER; count: INTEGER): INTEGER is
		-- Convert a sequence of `count' of wide characters `source' to a 
		-- corresponding sequence of multibyte characters `dest'.
		external
			"C macro signature (char*, wchar_t *,size_t): EIF_INTEGER use <stdlib.h>"
		alias
			"wcstombs"
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


end -- class EAC_COMMON_PATH
