indexing
	description	: "Objects that allow the user to know about Windows versions"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_WINDOWS_VERSION

feature -- Exact Windows Versions

	is_windows_95: BOOLEAN is
			-- Is the current program running under Windows 95
			-- (OSR1, OSR2 or OSR2.5)?
		do
			Result := is_windows_9x and (major_version = 4) and (minor_version < 10)
		ensure
			windows95_is_9x: Result implies is_windows_9x
		end

	is_windows_98: BOOLEAN is
			-- Is the current program running under Windows 98
			-- (1st or 2nd edition)?
		do
			Result := is_windows_9x and (major_version = 4) and (minor_version >= 10 and minor_version < 90)
		ensure
			windows98_is_9x: Result implies is_windows_9x
		end

	is_windows_me: BOOLEAN is
			-- Is the current program running under Windows Millenium Edition?
		do
			Result := is_windows_9x and (major_version = 4) and (minor_version >= 90)
		ensure
			windows_me_is_9x: Result implies is_windows_9x
		end

	is_windows_nt4: BOOLEAN is
			-- Is the current program running under Windows NT4?
		do
			Result := is_windows_nt and major_version = 4
		ensure
			windows_nt4_is_nt: Result implies is_windows_nt
		end

	is_windows_2000: BOOLEAN is
			-- Is the current program running under Windows 2000?
		do
			Result := is_windows_nt and major_version = 5 and minor_version = 0
		ensure
			windows2000_is_nt: Result implies is_windows_nt
		end
		
	is_windows_xp: BOOLEAN is
			-- Is the current program running under Windows XP (Home or Professional)?
		do
			Result := is_windows_NT and major_version = 5 and minor_version = 1
		ensure
			windows_xp_is_nt: Result implies is_windows_nt
		end
		
feature -- Compatible Windows Versions

	is_windows_9x: BOOLEAN is
			-- Is the current program running under Windows 9x
			-- (Windows 95, Windows 98, Windows Me, ...)?
		do
			Result := (internal_version & 0x80000000) /= 0
		end

	is_windows_nt: BOOLEAN is
			-- Is the current program running under a version of
			-- windows belonging to the NT family?
			-- (Windows NT 3.51, Windows NT4, Windows 2000, 
			-- Windows XP Home/Professional)
		do
			Result := (internal_version & 0x80000000) = 0
		end

	is_windows_nt4_compatible: BOOLEAN is
			-- Is the current program running under Windows NT4 or above?
		do
			Result := is_windows_nt and major_version >= 4
		end

	is_windows_98_compatible: BOOLEAN is
			-- Is the current program running under Windows 98 or above?
		do
			Result := (is_windows_98 or is_windows_me) or else is_windows_2000_compatible
		end

	is_windows_me_compatible: BOOLEAN is
			-- Is the current program running under Windows Me or above?
		do
			Result := is_windows_me or else is_windows_xp_compatible
		end

	is_windows_2000_compatible: BOOLEAN is
			-- Is the current program running under Windows 2000 or above?
		do
			Result := is_windows_NT and major_version >= 5
		end
		
	is_windows_xp_compatible: BOOLEAN is
			-- Is the current program running under Windows XP or above?
		do
			Result := is_windows_nt and 
				(major_version = 5 and minor_version >= 1) or (major_version > 5)
		end
		
feature -- Current Windows Version

	major_version: INTEGER is
			-- Major version of current operating system
		do
			Result := (internal_version & 0x000000FF)
		end

	minor_version: INTEGER is
			-- Minor version of current operating system
		do
			Result := (internal_version & 0x0000FF00) |>> 8
		end

	build_number: INTEGER is
			-- Build number of current operating system
		require
			windows_nt_family: is_windows_nt
		do
			Result := (internal_version & 0x7FFF0000) |>> 16
		end

feature -- Windows Versions (output)

	version_number_string: STRING is
			-- String representing the version number using the following format
			--   <major_version>.<minor_version>.<build_number> for Windows NT, 2000, XP
			--   <major_version>.<minor_version> for Windows 95, 98, Me
		do
			create Result.make (8)
			Result.append_integer (major_version)
			Result.append_character ('.')
			Result.append_integer (minor_version)
			if is_windows_nt then
				Result.append_character ('.')
				Result.append_integer (build_number)
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

	version_400: INTEGER is 0x00040000
			-- version_400 <=> Microsoft® Windows® 95/Windows NT® 4.0

	version_470: INTEGER is 0x00040046
			-- version_470 <=> Microsoft® Internet Explorer 3.x

	version_471: INTEGER is 0x00040047
			-- version_471 <=> Microsoft® Internet Explorer 4.0

	version_472: INTEGER is 0x00040048
			-- version_472 <=> Microsoft® Internet Explorer 4.01 & Windows® 98 

	version_500: INTEGER is 0x00050000
			-- version_500 (Shlwapi.dll) <=> Microsoft® Internet Explorer 5
			-- version_500 (Shell32.dll) <=> Microsoft® Windows® 2000

	version_580: INTEGER is 0x00050050
			-- version_580 (Comctl32.dll) <=> Microsoft® Internet Explorer 5

	version_581: INTEGER is 0x00050051
			-- version_581 (Comctl32.dll)<=> Microsoft® Windows 2000

feature {NONE} -- Implementation

	internal_version: INTEGER is
			-- Internal version as returned by Windows.
		once
			Result := cwin_get_version
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

