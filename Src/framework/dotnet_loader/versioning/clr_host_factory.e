note
	description: "Manage unique instance of COR_RUNTIME_HOST."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLR_HOST_FACTORY

inherit
	CLR_HOST_STARTUP_FLAGS

feature -- Access

	runtime_host (version: READABLE_STRING_GENERAL): detachable CLR_HOST
			-- CLR runtime version currently loaded in process.
			-- Check documentation available at:
			-- http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpgenref/html/grfuncorbindtoruntimeex.asp
		require
			has_version: version /= Void implies (create {IL_ENVIRONMENT}).is_version_installed (version)
		local
			l_version: UNI_STRING
			l_host: POINTER
		once
			if version = Void then
					-- Default version.
				create l_version.make ((create {IL_ENVIRONMENT}).default_version)
			else
				create l_version.make (version)
			end
			l_host := new_cor_runtime_host (l_version.item, 0)
			if l_host /= default_pointer then
				create Result.make_by_pointer (l_host)
			end
		end

feature {NONE} -- Implementation

	new_cor_runtime_host (version: POINTER; flags: INTEGER): POINTER
			-- Create a new instance of ICorRuntimeHost. Used to fix version of the CLR
			-- being used by compiler to generate IL code.
		external
			"C inline use <mscoree.h>"
		alias
			"[
				HRESULT hr;
				HMODULE mscoree = NULL;
				FARPROC cor_bind_to_runtime_ex = NULL;
				ICorRuntimeHost *pHost = NULL;

				mscoree = LoadLibrary (L"mscoree.dll");
				if (mscoree != NULL) {
					cor_bind_to_runtime_ex = GetProcAddress (mscoree, "CorBindToRuntimeEx");
					if (cor_bind_to_runtime_ex != NULL) {
						hr = (FUNCTION_CAST_TYPE(HRESULT, STDAPICALLTYPE, (LPWSTR, LPWSTR, DWORD, REFCLSID, REFIID, LPVOID *)) cor_bind_to_runtime_ex)
							($version, NULL, $flags, &CLSID_CorRuntimeHost, &IID_ICorRuntimeHost, (LPVOID*)&pHost);
					}
				}

				return pHost;
			]"
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class CLR_HOST_FACTORY
