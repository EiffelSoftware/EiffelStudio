note
	description: "Versioning information about Windows"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_OS_VERSION_INFO

inherit
	WEL_STRUCTURE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			Precursor
			if exists then
					-- Properly initialize the structure size.
				c_set_struct_size (item, structure_size)
			end
		end

feature -- Status report

	major_version: INTEGER
			-- Major version number of the operating system.
		require
			exists: exists
		do
			Result := c_major_version (item)
		end

	minor_version: INTEGER
			-- Minor version number of the operating system.
		require
			exists: exists
		do
			Result := c_minor_version (item)
		end

	build_number: INTEGER
			-- Build number of the operating system.
			-- On Windows Me/98/95:
			--  # The low-order word contains the build number of the operating system.
			--  # The high-order word contains the major and minor version numbers.
		require
			exists: exists
		do
			Result := c_build_number (item)
		end

	platform_id: INTEGER
			-- Operating system platform.
		require
			exists: exists
		do
			Result := c_platform_id (item)
		ensure
			Result_valid: Result = win32_nt_platform or Result = win32_windows_platform or Result = win32_platform
		end

feature -- Constants

	major_pre_win2k: INTEGER = 4
			-- Windows NT 4.0, Windows Me, Windows 98, or Windows 95.

	major_post_win2k: INTEGER = 5
			-- Windows Server 2003, Windows XP, or Windows 2000.

	major_post_vista: INTEGER = 6
			-- Windows Vista, Windows Server 2008, Windows 7

	win32_nt_platform: INTEGER = 2
			-- Windows Server 2003, Windows XP, Windows 2000, or Windows NT

	win32_windows_platform: INTEGER = 1
			-- Windows Me, Windows 98, or Windows 95.

	win32_platform: INTEGER = 0
			-- Win32 API on Windows 3.1

feature -- Measurement

	structure_size: INTEGER
			-- <Precursor>
		do
			Result := c_structure_size
		end

feature {NONE} -- Implementation

	c_structure_size: INTEGER
			-- Implementation of `c_structure_size`.
		external
			"C inline use <windows.h>"
		alias
			"return sizeof(OSVERSIONINFO);"
		end

	c_set_struct_size (a_ptr: POINTER; a_size: INTEGER)
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_size_non_negative: a_size > 0
		external
			"C inline use <windows.h>"
		alias
			"((OSVERSIONINFO *) $a_ptr)->dwOSVersionInfoSize = (DWORD) $a_size;"
		end

	c_major_version (a_ptr: POINTER): INTEGER
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <windows.h>"
		alias
			"return ((OSVERSIONINFO *) $a_ptr)->dwMajorVersion;"
		end

	c_minor_version (a_ptr: POINTER): INTEGER
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <windows.h>"
		alias
			"return ((OSVERSIONINFO *) $a_ptr)->dwMinorVersion;"
		end

	c_build_number (a_ptr: POINTER): INTEGER
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <windows.h>"
		alias
			"return ((OSVERSIONINFO *) $a_ptr)->dwBuildNumber"
		end

	c_platform_id (a_ptr: POINTER): INTEGER
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <windows.h>"
		alias
			"return ((OSVERSIONINFO *) $a_ptr)->dwPlatformId"
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
