indexing

	description: "Registry keys constants"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	WEL_HKEY

feature -- Access

	Hkey_classes_root: INTEGER is
		external
			"C [macro %"winreg.h%"]"
		alias
			"HKEY_CLASSES_ROOT"
		end

	Hkey_current_user: INTEGER is
		external
			"C [macro %"winreg.h%"]"
		alias
			"HKEY_CURRENT_USER"
		end

	Hkey_local_machine: INTEGER is
		external
			"C [macro %"winreg.h%"]"
		alias
			"HKEY_LOCAL_MACHINE"
		end

	Hkey_users: INTEGER is
		external
			"C [macro %"winreg.h%"]"
		alias
			"HKEY_USERS"
		end

	Hkey_performance_data: INTEGER is
		external
			"C [macro %"winreg.h%"]"
		alias
			"HKEY_PERFORMANCE_DATA"
		end

	Hkey_current_config: INTEGER is
		external
			"C [macro %"winreg.h%"]"
		alias
			"HKEY_CURRENT_CONFIG"
		end

	Hkey_dyn_data: INTEGER is
		external
			"C [macro %"winreg.h%"]"
		alias
			"HKEY_DYN_DATA"
		end

end -- class WEL_HKEY
	
--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

