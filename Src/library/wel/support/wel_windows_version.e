indexing
	description	: "Objects that allow the user to know about Windows versions"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_WINDOWS_VERSION

create
	default_create

feature -- Windows Versions


	is_windows_9x: BOOLEAN is
			-- Is the current program running under Windows 9x
			-- (Windows 95, Windows 98, Windows Me, ...)?
		local
			version: INTEGER
		once
			Result := (version >= 0x80000000)
		end

	is_windows_NT: BOOLEAN is
			-- Is the current program running under Windows NT
			-- (Windows NT 3.51, Windows NT4, Windows 2000, ...)?
		local
			version: INTEGER
		once
			Result := (version < 0x80000000)
		end

	is_windows_95: BOOLEAN is
			-- Is the current program running under Windows 95
			-- (OSR1, OSR2 or OSR2.5)?
		local
			version: INTEGER
		once
			version := cwin_get_version
			Result := (version >= 0x80000000) and then (version < 0xc0000a00)
		ensure
			windows95_is_9x: Result implies is_windows_9x
		end

	is_windows_98: BOOLEAN is
			-- Is the current program running under Windows 98
			-- (1st or 2nd edition)?
		local
			version: INTEGER
		once
			version := cwin_get_version
			Result := (version >= 0xc0000a00)
		ensure
			windows98_is_9x: Result implies is_windows_9x
		end

	is_windows_me: BOOLEAN is
			-- Is the current program running under Windows Millenium Edition?
		once
			--| FIXME ARNAUD: To be implemented
			check
				not_implemented: False
			end
		ensure
			windows_me_is_9x: Result implies is_windows_9x
		end

	is_windows_nt4: BOOLEAN is
		local
			version: INTEGER
		once
			Result := (version < 0x07ef0000)
		ensure
			windows_nt4_is_nt: Result implies is_windows_nt
		end

	is_windows_2000: BOOLEAN is
		local
			version: INTEGER
		once
			version := cwin_get_version
			Result := (version < 0x80000000) and then (version >= 0x07ef0000)
		ensure
			windows2000_is_nt: Result implies is_windows_nt
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
 --| 5.81    | Comctl32.dll | Microsoft® Windows 2000, Millenium Edition      |
 --| 5.81    | Comctl32.dll | Microsoft® Internet Explorer 5.5                |
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

	cwin_get_version: INTEGER is
			-- Return the version number of the current OS.
			-- The version number is packed.
		external
			"C (): DWORD | %"windows.h%""
		alias
			"GetVersion"
		end

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

feature -- Obsolete

	is_windows95: BOOLEAN is
		obsolete "use `is_windows_95' instead"
		do
			Result := is_windows_95
		end

	is_windows98: BOOLEAN is
		obsolete "use `is_windows_98' instead"
		do
			Result := is_windows_98
		end

	is_windows2000: BOOLEAN is
		obsolete "use `is_windows_2000' instead"
		do
			Result := is_windows_2000
		end

end -- class WEL_WINDOWS_VERSION

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

