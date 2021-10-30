note
	description: "Used to read assemblies and extract basic metadata information."
	date: "$Date$"
	revision: "$Revision$"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	ASSEMBLY_PROPERTIES_READER

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Initialize

	make (a_runtime_version: READABLE_STRING_32)
			-- Initialize Current. Initialize `exists' accordingly.
		require
			a_runtime_version_not_void: a_runtime_version /= Void
			not_a_runtime_version_is_empty: not a_runtime_version.is_empty
		local
			l_reg: WEL_REGISTRY
			l_p: POINTER
			l_dir: STRING_32
			l_dis: like dispenser
			l_cache: like assembly_cache
		do
			create l_reg
			l_p := l_reg.open_key ({WEL_REGISTRY}.hkey_local_machine, "SOFTWARE\Microsoft\.NETFramework", {WEL_REGISTRY_ACCESS_MODE}.key_read)
			if l_p /= default_pointer then
				if
					attached l_reg.key_value (l_p, "InstallRoot") as l_val and then
					l_val.type = {WEL_REGISTRY_KEY_VALUE}.reg_sz
				then
					l_dir := l_val.string_value
					l_dir.prune_all_trailing ('\')
					l_dir.prune_all_trailing ('/')
					if (create {DIRECTORY}.make (l_dir)).exists then
						l_dir.append ("\")
						l_dir.append (a_runtime_version)
						l_dir.append ("\")
						add_runtime_path (l_dir)
							-- Check DLL exists.
						strong_name_retriveable := (create {WEL_DLL}.make ("mscorsn.dll")).exists
					end
				end
				l_reg.close_key (l_p)
			end

			(create {CLI_COM}).initialize_com

			c_initialize_dispenser ($l_dis).do_nothing
			c_create_cache ($l_cache, 0).do_nothing
			dispenser := l_dis
			assembly_cache := l_cache
		end

feature -- Clean up

	dispose
			-- Cleans up any allocated resources
		local
			l_dis: like dispenser
			l_cache: like assembly_cache
		do
			if exists then
				l_dis := dispenser
				l_cache := assembly_cache
				c_uninitialize ($l_dis, $l_cache)
				dispenser := default_pointer
				assembly_cache := default_pointer
			end
		ensure then
			not_exists: not exists
		end

feature -- Basic operations

	retrieve_assembly_properties (a_file_name: READABLE_STRING_GENERAL): detachable ASSEMBLY_PROPERTIES
			-- Retrieves assembly properties for `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: (create {RAW_FILE}.make_with_name (a_file_name)).exists
			a_file_name_is_pe_file: (create {PE_FILE_INFO}).is_com2_pe_file (a_file_name)
			exists: exists
		local
			l_scope: POINTER
			l_cache: like assembly_cache
			l_amd: ASSEMBLY_METADATA
			l_fn: WEL_STRING
			l_hash: NATURAL_64
			l_name: WEL_STRING
			l_name_len: NATURAL_32
			l_flags: NATURAL_32
			l_key: ARRAY [NATURAL_8]
			l_bytes: MANAGED_POINTER
			l_p: POINTER
			l_bytes_len: NATURAL_64
			l_len: INTEGER
			l_res: INTEGER
			i: INTEGER
		do
			create l_fn.make (a_file_name)
			l_res := cpp_open_scope (dispenser, l_fn.item, 0, $l_scope)
			if l_res = 0 then
				l_bytes_len := 8
				l_name_len := 512

				create l_name.make_empty ((l_name_len + 2).to_integer_32)
				create l_amd.make

				l_res := cpp_assembly_props (l_scope, $l_hash, l_name.item, $l_name_len, $l_flags, l_amd)
				if l_res = 0 then
					if
						strong_name_retriveable and then
						strong_name_token_from_assembly (l_fn.item, $l_p, $l_bytes_len)
					then
						create l_bytes.make_from_pointer (l_p, l_bytes_len.to_integer_32)
						l_len := l_bytes_len.to_integer_32
						create l_key.make_filled (0, 1, l_len)
						from until i = l_len  loop
							l_key.put (l_bytes.read_natural_8 (i), i + 1)
							i := i + 1
						end
						strong_name_free_buffer (l_p)
					end

					l_name.set_count (l_name_len.to_integer_32)

					l_cache := assembly_cache
					create Result.make (a_file_name, l_name.string, l_hash, l_key, l_flags, l_amd)
					if l_cache /= default_pointer and Result.is_signed then

						create l_name.make (Result.full_name)
						if c_is_in_cache (l_cache, l_name.item) then
							Result.set_is_locatable_in_gac
						else
								-- Check 1.x
							create l_name.make (Result.full_name_v1x)
							if c_is_in_cache (l_cache, l_name.item) then
								Result.set_is_locatable_in_gac
							end
						end
					end

				end
				cpp_close_scope ($l_scope)
			end
		end

feature -- Status report

	exists: BOOLEAN
			-- Indicates if reader was successfully initialized and is read for use.
		do
			Result := dispenser /= default_pointer
		end

	fusion_exists: BOOLEAN
			-- Indicates if fusion was successfully initialized and is read for use.
		do
			Result := assembly_cache /= default_pointer
		end

feature {NONE} -- Caching

	add_runtime_path (a_path: STRING_32)
			-- Add's `a_path' to PATH environment variable, if it has not already been added
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		local
			l_access: EXECUTION_ENVIRONMENT
			l_name, l_path, l_new_path: STRING_32
			l_wname, l_wpath: WEL_STRING
		do
			if not added_paths.has (a_path) then
				create l_access
				l_name := "PATH"

					-- Get path environment variable
				l_path := l_access.item (l_name)

					-- Create new path variable
				create l_new_path.make (256)
				l_new_path.append (a_path)
				if l_path /= Void then
					l_new_path.append_character (';')
					l_new_path.append (l_path)
				end

					-- Set it with new value
				l_access.put (l_new_path, l_name)
					-- Really set the variable because on .NET ENVIRONMENT_ACCESS.put does not work.
				create l_wname.make (l_name)
				create l_wpath.make (l_new_path)
				c_set_environment_variable (l_wname.item, l_wpath.item).do_nothing

				added_paths.force (True, a_path)
			end
		ensure
			has_path: added_paths.has (a_path)
		end

	added_paths: STRING_TABLE [BOOLEAN]
			-- List of paths added to PATH environment variable
		once
			create Result.make (1)
			Result.compare_objects
		ensure
			result_attached: Result /= Void
			result_compares_objects: Result.object_comparison
		end

feature {NONE} -- Implementation

	strong_name_retriveable: BOOLEAN
			-- Inidicates if strong name can be retrieved

	dispenser: POINTER
			-- Pointer to a IMetadataDespenser interface, when /= default_pointer

	assembly_cache: POINTER
			-- Pointer to a IAssemblyCache interface, when /= default_pointer

feature {NONE} -- Externals

	c_initialize_dispenser (a_dispenser: TYPED_POINTER [POINTER]): INTEGER
			-- Initializes metadata dispenser
		external
			"C++ inline use <cor.h>"
		alias
			"[
				IMetaDataDispenser* pDispenser = NULL;
				HRESULT hr = S_OK;
				
				hr = CoCreateInstance (CLSID_CorMetaDataDispenserRuntime, NULL, CLSCTX_INPROC_SERVER, IID_IMetaDataDispenser, (LPVOID*)&pDispenser);
				if (SUCCEEDED (hr) && (pDispenser != NULL))
				{
					pDispenser->AddRef();
					*$a_dispenser = (EIF_POINTER)pDispenser;				
				}
				return hr;
			]"
		ensure
			succeeded: Result = 0
		end

	c_uninitialize (a_dispenser: TYPED_POINTER [POINTER]; a_cache: TYPED_POINTER [POINTER])
			-- Uninitializes unmanaged COM resources
		external
			"C++ inline use <windows.h>"
		alias
			"[
				if (NULL != *$a_dispenser)
				{
					((IUnknown*)*$a_dispenser)->Release();
					*$a_dispenser = (EIF_POINTER)NULL;
				}
				if (NULL != $a_cache)
				{
					((IUnknown*)*$a_cache)->Release();
					*$a_cache = (EIF_POINTER)NULL;
				}
				// We cannot CoUninitialize here as we have to take into consideration that
				// another library is still using COM.
			]"
		end

	cpp_open_scope (a_dispenser: POINTER; a_fn: POINTER; a_flags: NATURAL; a_scope: TYPED_POINTER [POINTER]): INTEGER
			-- Opens an assembly scope
		require
			not_a_dispenser_is_null: a_dispenser /= default_pointer
			not_a_fn_is_null: a_fn /= default_pointer
		external
			"C++ inline use <cor.h>"
		alias
			"[
				IUnknown* pUnk = (IUnknown*)$a_dispenser;
				IMetaDataDispenser* pMDD = NULL;
				HRESULT hr = S_OK;
				
				hr = pUnk->QueryInterface (IID_IMetaDataDispenser, (LPVOID*)&pMDD);
				if (SUCCEEDED (hr))
				{
					IMetaDataAssemblyImport* pMDI = NULL;
					hr = pMDD->OpenScope ((LPCWSTR)$a_fn, (DWORD)$a_flags, IID_IMetaDataAssemblyImport, (IUnknown**)&pMDI);
					if (SUCCEEDED (hr))
					{
						*$a_scope = (EIF_POINTER)pMDI;
					}
					pMDD->Release();
				}
				else
				{
					hr = E_NOINTERFACE;
				}
				return hr;
			]"
		end

	cpp_close_scope (a_scope: TYPED_POINTER [POINTER])
			-- Closes an opened scope.
		require
			not_a_scope_is_null: a_scope /= default_pointer
		external
			"C++ inline use <windows.h>"
		alias
			"[
				if (NULL != *$a_scope) {
					IUnknown* pUnk = (IUnknown*)*$a_scope;	
					pUnk->Release();			
					*$a_scope = NULL;
				}
			]"
		end

	cpp_assembly_props (a_scope: POINTER; a_hash: TYPED_POINTER [NATURAL_64]; a_name: POINTER; a_name_len: TYPED_POINTER [NATURAL_32]; a_flags: TYPED_POINTER [NATURAL_32]; a_md: POINTER): INTEGER
			-- Retrieves a number of assembly properties
		require
			not_a_scope_is_null: a_scope /= default_pointer
		external
			"C++ inline use <cor.h>"
		alias
			"[
				IMetaDataAssemblyImport* pMDA = (IMetaDataAssemblyImport*)$a_scope;
				
				mdAssembly tScope;
				HRESULT hr = S_OK;
				
				hr = pMDA->GetAssemblyFromScope (&tScope);
				if (SUCCEEDED(hr))
				{
					BYTE* pKey = NULL;
					ULONG cbKey = 0;				
					hr = pMDA->GetAssemblyProps (tScope, (const void **)&pKey, (ULONG*)&cbKey, (ULONG*)$a_hash, (LPWSTR)$a_name, (ULONG)*$a_name_len, (ULONG*)$a_name_len, (ASSEMBLYMETADATA*)$a_md, (DWORD*)$a_flags);
				}
				return hr;
			]"
		end

	strong_name_token_from_assembly (a_container_name: POINTER; a_key_blob: TYPED_POINTER [POINTER];
			a_key_blob_size: TYPED_POINTER [NATURAL_64]): BOOLEAN
			-- Retrieve the public portion of a key pair.
		require
			strong_name_retriveable: -- strong_name_retriveable
		external
			"dllwin mscorsn.dll signature (LPCWSTR, BYTE**, ULONG*): EIF_BOOLEAN use <windows.h>"
		alias
			"StrongNameTokenFromAssembly"
		end

	strong_name_free_buffer (a_key_blob: POINTER)
			-- Retrieve the public portion of a key pair.
		require
			strong_name_retriveable: -- strong_name_retriveable
		external
			"dllwin mscorsn.dll signature (BYTE*) use <windows.h>"
		alias
			"StrongNameFreeBuffer"
		end

	c_set_environment_variable (a_name, a_value: POINTER): BOOLEAN
			-- The SetEnvironmentVariable function sets the contents of the specified environment variable for the current process.
		external
			"C (LPCTSTR, LPCTSTR): BOOL | <windows.h>"
		alias
			"SetEnvironmentVariable"
		end

	c_create_cache (a_cache: TYPED_POINTER [POINTER]; a_reserved: INTEGER): INTEGER
			-- Retrieve the public portion of a key pair.
		external
			"dllwin fusion.dll signature (IAssemblyCache**, DWORD): HRESULT use <fusion.h>"
		alias
			"CreateAssemblyCache"
		end

	c_is_in_cache (a_cache: POINTER; a_name: POINTER): BOOLEAN
			-- Determines if assembly is in the instatiate cache
		require
			not_a_cache_is_null: a_cache /= default_pointer
			not_a_name_is_null: a_name /= default_pointer
		external
			"C++ inline use <fusion.h>"
		alias
			"[
				IAssemblyCache* pCache = (IAssemblyCache*)$a_cache;
				ASSEMBLY_INFO asmInfo;
				WCHAR   path[MAX_PATH];
				HRESULT hr = S_OK;
				
				ZeroMemory ((LPVOID)&asmInfo, sizeof (ASSEMBLY_INFO));
				asmInfo.cbAssemblyInfo = sizeof (ASSEMBLY_INFO);
				asmInfo.pszCurrentAssemblyPathBuf = path;
				asmInfo.cchBuf = MAX_PATH;
				
				hr = pCache->QueryAssemblyInfo (0, (LPCWSTR)$a_name, &asmInfo);
				if (SUCCEEDED(hr))
				{
					return (EIF_BOOLEAN) (ASSEMBLYINFO_FLAG_INSTALLED == asmInfo.dwAssemblyFlags);
				}
				return (EIF_BOOLEAN)FALSE;
			]"
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end
