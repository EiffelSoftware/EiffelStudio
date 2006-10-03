indexing
	description: "[
		Used to read assemblies and extract basic metadata information.
	]"
	date:        "$Date$"
	revision:    "$Revision$"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	ASSEMBLY_PROPERTIES_READER

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make is
			-- Initializes reader
		local
			l_dis: like dispenser
		do
			c_initialize ($l_dis).do_nothing
			dispenser := l_dis
		end

feature -- Clean up

	dispose is
			-- Cleans up any allocated resources
		local
			l_dis: like dispenser
		do
			if exists then
				l_dis := dispenser
				c_uninitialize ($l_dis)
				dispenser := default_pointer
			end
		ensure then
			not_exists: not exists
		end

feature -- Basic operations

	retrieve_assembly_properties (a_file_name: STRING): ASSEMBLY_PROPERTIES is
			-- Retrieves assembly properties for `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: (create {RAW_FILE}.make (a_file_name)).exists
			a_file_name_is_pe_file: (create {PE_FILE_INFO}).is_com2_pe_file (a_file_name)
			exists: exists
		local
			l_scope: POINTER
			l_amd: ASSEMBLY_METADATA
			l_fn: WEL_STRING
			l_hash: NATURAL_64
			l_name: WEL_STRING
			l_name_len: NATURAL_64
			l_flags: NATURAL_64
			l_key: ARRAY [NATURAL_8]
			l_bytes: MANAGED_POINTER
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
				create l_bytes.make ((l_bytes_len).to_integer_32)
				create l_amd.make

				l_res := cpp_assembly_props (l_scope, $l_hash, l_name.item, $l_name_len, $l_flags, l_amd)
				if l_res = 0 then
					if cpp_token (l_fn.item, l_bytes.item, $l_bytes_len) then
						l_len := l_bytes_len.to_integer_32
						create l_key.make (1, l_len)
						from until i = l_len  loop
							l_key.put (l_bytes.read_natural_8 (i), i + 1)
							i := i + 1
						end
					end

					l_name.set_count (l_name_len.to_integer_32)
					create Result.make (a_file_name, l_name.string, l_hash, l_key, l_flags, l_amd)
				end
				cpp_close_scope ($l_scope)
			end
		end

feature -- Status report

	exists: BOOLEAN is
			-- Indicates if reader was successfully initialized and is read for use.
		do
			Result := dispenser /= default_pointer
		end

feature {NONE} -- Implementation

	dispenser: POINTER
			-- Pointer to a IMetadataDespenser interface, when /= default_pointer

feature {NONE} -- Externals

	c_initialize (a_dispenser: TYPED_POINTER [POINTER]): INTEGER is
			-- Initializes reader
		external
			"C++ inline use %"cor.h%""
		alias
			"[
				IMetaDataDispenser* pUnk = NULL;
				BOOL fWasInit = FALSE;
				HRESULT hr = S_OK;
				
				hr = CoInitializeEE (NULL);
				if (SUCCEEDED (hr))
				{
					fWasInit = (S_OK == hr); // COM was initialized here, make sure to uinit.
					hr = CoCreateInstance (CLSID_CorMetaDataDispenserRuntime, NULL, CLSCTX_INPROC_SERVER, IID_IMetaDataDispenser, (LPVOID*)&pUnk);
					if (SUCCEEDED (hr) & NULL != pUnk)
					{
						pUnk->AddRef();
						*$a_dispenser = (EIF_POINTER)pUnk;
					}
					else if (fWasInit)
					{
						// Clean up
						CoUninitializeEE(FALSE);
					}
				}
				return hr;
			]"
		ensure
			succeeded: Result = 0
		end

	c_uninitialize (a_dispenser: TYPED_POINTER [POINTER]) is
			-- Uninitializes reader
		external
			"C++ inline use %"cor.h%""
		alias
			"[
				if (NULL != *$a_dispenser)
				{
					((IUnknown*)*$a_dispenser)->Release();
					*$a_dispenser = (EIF_POINTER)NULL;
				}
				// We cannot CoUninitialize here as we have to take into consideration that
				// another library is still using COM.
			]"
		end

	cpp_open_scope (a_dispenser: POINTER; a_fn: POINTER; a_flags: NATURAL; a_scope: TYPED_POINTER [POINTER]): INTEGER is
			-- Opens an assembly scope
		external
			"C++ inline use %"cor.h%""
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

	cpp_close_scope (a_scope: TYPED_POINTER [POINTER]) is
			-- Closes an opened scope.
		external
			"C++ inline use %"cor.h%""
		alias
			"[
				if (NULL != *$a_scope) {
					IUnknown* pUnk = (IUnknown*)*$a_scope;	
					pUnk->Release();			
					*$a_scope = NULL;
				}
			]"
		end

	cpp_assembly_props (a_scope: POINTER; a_hash: TYPED_POINTER [NATURAL_64]; a_name: POINTER; a_name_len: TYPED_POINTER [NATURAL_64]; a_flags: TYPED_POINTER [NATURAL_64]; a_md: POINTER): INTEGER is
			-- Retrieves a number of assembly properties
		external
			"C++ inline use %"strongname.h%""
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

	cpp_token (a_fn: POINTER; a_bytes: POINTER; a_bytes_len: TYPED_POINTER [NATURAL_64]): BOOLEAN is
			-- Retrieves a strong name token from an assembly.
		external
			"C++ inline use %"strongname.h%""
		alias
			"[
				BYTE* pToken = NULL;
				ULONG cbToken = 0;
			
				if (StrongNameTokenFromAssembly ((LPWSTR)$a_fn, &pToken, &cbToken)) {
					*$a_bytes_len = (EIF_NATURAL) min ((ULONG)*$a_bytes_len, cbToken);
					memcpy ($a_bytes, pToken, (ULONG)*$a_bytes_len);
					return TRUE;
				} else {
					return FALSE;
				}
			]"
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

end -- class ASSEMBLY_PROPERTIES_READER
