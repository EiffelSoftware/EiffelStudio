indexing
	description	: "Objects that allow the user to know about Windows versions"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_WINDOWS_VERSION

create
	default_create

feature -- Windows Versions

	is_windows95: BOOLEAN is
		once
			--| FIXME ARNAUD: To be implemented
			check
				not_implemented: False
			end
		end

	is_windows98: BOOLEAN is
		once
			--| FIXME ARNAUD: To be implemented
			check
				not_implemented: False
			end
		end

	is_windowsNT4: BOOLEAN is
		once
			--| FIXME ARNAUD: To be implemented
			check
				not_implemented: False
			end
		end

	is_windows2000: BOOLEAN is
		once
			--| FIXME ARNAUD: To be implemented
			check
				not_implemented: False
			end
		end

	is_windowsNT351: BOOLEAN is
		once
			--| FIXME ARNAUD: To be implemented
			check
				not_implemented: False
			end
		end

feature -- "Shell and Common controls" Versions

--|--------------------------------------------------------------------------|
--| Version |     DLL      |        Distribution Platform                    |
--|---------|--------------|-------------------------------------------------|
--| 4.00    | All          | Microsoft® Windows® 95/Windows NT® 4.0          |
--| 4.70    | All          | Microsoft® Internet Explorer 3.x                |
--| 4.71    | All          | Microsoft® Internet Explorer 4.0                |
--| 4.72    | All          | Microsoft® Internet Explorer 4.01 & Windows® 98 |
--| 5.00    | Shlwapi.dll  | Microsoft® Internet Explorer 5                  |
--| 5.00    | Shell32.dll  | Microsoft® Windows® 2000                        |
--| 5.80    | Comctl32.dll | Microsoft® Internet Explorer 5                  |
--| 5.81    | Comctl32.dll | Microsoft® Windows 2000                         |
--|--------------------------------------------------------------------------|

	comctl32_version: INTEGER is
			-- Version of Comctl32.dll
		once
			Result := cwin_get_comctl32dll_version
		end

	shell32_version: INTEGER is
			-- Version of Shell32.dll
		once
			Result := cwin_get_shell32dll_version
		end

	shlwapi_version: INTEGER is
			-- Version of Shlwapi.dll
		once
			Result := cwin_get_shlwapidll_version
		end
	
feature -- Version Constants

	version_400: INTEGER is
			-- version_400 <=> Microsoft® Windows® 95/Windows NT® 4.0
		once
			Result := pack_version(4,00)
		end

	version_470: INTEGER is
			-- version_470 <=> Microsoft® Internet Explorer 3.x
		once
			Result := pack_version(4,70)
		end

	version_471: INTEGER is
			-- version_471 <=> Microsoft® Internet Explorer 4.0
		once
			Result := pack_version(4,71)
		end

	version_472: INTEGER is
			-- version_472 <=> Microsoft® Internet Explorer 4.01 & Windows® 98 
		once
			Result := pack_version(4,72)
		end

	version_500: INTEGER is
			-- version_500 (Shlwapi.dll) <=> Microsoft® Internet Explorer 5
			-- version_500 (Shell32.dll) <=> Microsoft® Windows® 2000
		once
			Result := pack_version(5,00)
		end

	version_580: INTEGER is
			-- version_580 (Comctl32.dll) <=> Microsoft® Internet Explorer 5
		once
			Result := pack_version(5,80)
		end

	version_581: INTEGER is
			-- version_581 (Comctl32.dll)<=> Microsoft® Windows 2000
		once
			Result := pack_version(5,81)
		end

feature {NONE} -- External

	cwin_get_dll_version (dll_name: POINTER): INTEGER is
			-- Return the version number of the specified DLL.
			-- The version number is packed.
		external
			"C (char *): DWORD | %"wel_dynload.h%""
		end

	cwin_get_shell32dll_version: INTEGER is
			-- Return the version number of the "shell32.dll" DLL. 
			-- The version number is packed.
		external
			"C (): DWORD | %"wel_dynload.h%""
		end

	cwin_get_comctl32dll_version: INTEGER is
			-- Return the version number of the "Comctl32.dll" DLL. 
			-- The version number is packed.
		external
			"C (): DWORD | %"wel_dynload.h%""
		end

	cwin_get_shlwapidll_version: INTEGER is
			-- Return the version number of the "Shlwapi.dll" DLL. 
			-- The version number is packed.
		external
			"C (): DWORD | %"wel_dynload.h%""
		end

	pack_version(major: INTEGER; minor: INTEGER): INTEGER is
		external
			"C [ macro %"wel_dynload.h%"] "
		alias
			"PACKVERSION"
		end

end -- class WEL_WINDOWS_VERSION


