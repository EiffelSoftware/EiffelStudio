indexing
	description: "Access to Win32 externals"
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNALS

feature -- Externals		

	get_drive_type (root_dir: POINTER): INTEGER is
			-- Determines type of disk drive on 'root_dir'.
		external
			"C (LPCTSTR): UINT | %"windows.h%""
		alias
			"GetDriveType"
		end

end -- class EXTERNALS
