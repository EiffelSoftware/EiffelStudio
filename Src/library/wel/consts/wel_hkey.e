indexing

	description: "Registry keys constants"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$";
	note: "Changed the type of Keys from INTEGER to POINTER"
	
class
	WEL_HKEY

feature -- Status

	basic_valid_value_for_HKEY(value: POINTER): BOOLEAN is
		-- Return True if 'value' is one of the basic following values.
		do
			if
				value = Hkey_classes_root or else
				value = Hkey_dyn_data or else
				value = Hkey_current_config or else
				value = Hkey_performance_data or else
				value = Hkey_users or else
				value = Hkey_current_user or else
				value = Hkey_local_machine
			then 
				Result := True
			end
		end

	basic_valid_name_for_HKEY(name: STRING): BOOLEAN is
			-- Return True if 'name' correspond to one of the
			-- value names below.
		require
				name_possible: name /= Void
		do
			name.to_lower
			if
				name.is_equal("hkey_classes_root") or else
				name.is_equal("hkey_dyn_data") or else
				name.is_equal("hkey_current_config") or else
				name.is_equal("hkey_performance_data") or else
				name.is_equal("hkey_users") or else
				name.is_equal("hkey_current_user") or else
				name.is_equal("hkey_local_machine")
			then 
				Result := True
			end
		end

	index_value_for_root_keys(name: STRING): POINTER is
			-- Return the index corresponding to a root key.
		require
				name_possible: name /= Void and then basic_valid_name_for_HKEY(name)
		do
			name.to_lower
			if name.is_equal("hkey_classes_root") then 
					Result := Hkey_classes_root
			elseif name.is_equal("hkey_dyn_data") then
					Result := Hkey_dyn_data
			elseif name.is_equal("hkey_current_config") then
					Result := Hkey_current_config
			elseif name.is_equal("hkey_performance_data") then
					Result := Hkey_performance_data
			elseif name.is_equal("hkey_users") then
					Result := Hkey_users
			elseif name.is_equal("hkey_current_user") then
					Result := Hkey_current_user
			elseif name.is_equal("hkey_local_machine") then 
					Result := Hkey_local_machine
			end
		end

feature -- Access

	Hkey_classes_root: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_CLASSES_ROOT"
		end

	Hkey_current_user: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_CURRENT_USER"
		end

	Hkey_local_machine: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_LOCAL_MACHINE"
		end

	Hkey_users: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_USERS"
		end

	Hkey_performance_data: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_PERFORMANCE_DATA"
		end

	Hkey_current_config: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_CURRENT_CONFIG"
		end

	Hkey_dyn_data: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_DYN_DATA"
		end

end -- class WEL_HKEY
	

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

