indexing
	description: "Information about current .NET environment"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ENVIRONMENT
	
feature -- Access

	is_dotnet_installed: BOOLEAN is
			-- Is dotnet installed?
		local
			retried: BOOLEAN
			n: INTEGER
			p: POINTER
		once
			if not retried then
				n := 1024
					-- We allocate 2 * n bytes, as `p' will hold a unicode string.
				p := p.memory_alloc (2 * n)
				n := get_core_system_directory (p, n ,n)
				p.memory_free
				Result := True
			else
				if p /= default_pointer then
					p.memory_free
				end
			end
		rescue
				-- Looks like we could not load `mscoree.dll', most likely
				-- .NET is not installed.
			retried := True
			retry
		end

	dotnet_framework_path: STRING is
			-- Path to .NET Framework.
		require
			is_dotnet_installed: is_dotnet_installed
		local
			p: POINTER
			path: WEL_STRING
			n, len: INTEGER
		once
			n := 1024
				-- We allocate 2 * n bytes, as `p' will hold a unicode string.
			p := p.memory_alloc (2 * n)
			if get_core_system_directory (p, n, len) = 0 then
				create path.make_empty (len + 1)
				n := wcstombs (path.item, p, len)
				Result := path.string
			end
			p.memory_free
		end
		
	dotnet_framework_sdk_path: STRING is
			-- Path to .NET Framework SDK directory.
		local
			reg: WEL_REGISTRY
			p: POINTER
			key: WEL_REGISTRY_KEY_VALUE
		once
			create reg
			p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\.NETFramework",
				feature {WEL_REGISTRY_ACCESS_MODE}.key_all_access)
			if p /= default_pointer then
				key := reg.key_value (p, "sdkInstallRoot")
				reg.close_key (p)		
				Result := key.string_value
			end
		end
		
	Dotnet_framework_sdk_bin_path: STRING is
			-- Path to bin directory of .NET Framework SDK.
		local
			l_path: STRING
		once
			l_path := Dotnet_framework_sdk_path
			if l_path /= Void then
				Result := Dotnet_framework_sdk_path + "bin\"
			end
		end

feature -- Query
	
	use_cordbg (a_string: STRING): BOOLEAN is
			-- Should Current use cordbg.exe?
		do
			Result := a_string.is_equal ("cordbg")
		end
		
	use_dbgclr (a_string: STRING): BOOLEAN is
			-- Should Current use DbgCLR.exe?
		do
			Result := a_string.is_equal ("DbgCLR")
		end
	
	Dotnet_debugger_path (a_debug: STRING): STRING is
			-- The path to the .NET debugger associated with 'a_debug'.
		local
			l_path: STRING
		do
			l_path := Dotnet_framework_sdk_bin_path
			if l_path /= Void then
				if use_cordbg (a_debug) then
					Result := Dotnet_framework_sdk_bin_path + a_debug + ".exe"
				elseif use_dbgclr (a_debug) then
					Result := Dotnet_framework_sdk_path + "GuiDebug\" + a_debug + ".exe"
				end
			end	
		end
	
feature {NONE} -- Implementation

	get_core_system_directory (path: POINTER; buf_size: INTEGER; filled_length: INTEGER): INTEGER is
			-- Initializes a wide character `path' of size `buf_size' characters
			-- with path to .NET Framework SDK location. Number of characters set in `path'
			-- is given by `filled_length'.
		local
			n: INTEGER
		do
			n := filled_length
			Result := internal_get_core_system_directory (path, buf_size, $n);
		end

	internal_get_core_system_directory (path: POINTER; buf_size: INTEGER; filled_length: POINTER): INTEGER is
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
		
end -- class IL_ENVIRONMENT
