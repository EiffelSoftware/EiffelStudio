indexing
	description: "Registry keys constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$";

class
	WEL_HKEY

feature -- Status

	basic_valid_value_for_hkey (value: POINTER): BOOLEAN is
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

	basic_valid_name_for_hkey (name: STRING_GENERAL): BOOLEAN is
			-- Return True if 'name' correspond to one of the
			-- value names below.
		require
			name_possible: name /= Void
			name_valid: name.is_valid_as_string_8
		local
			l_string: STRING
		do
			l_string := name.to_string_8
			if
				l_string.is_case_insensitive_equal ("hkey_classes_root") or else
				l_string.is_case_insensitive_equal ("hkey_dyn_data") or else
				l_string.is_case_insensitive_equal ("hkey_current_config") or else
				l_string.is_case_insensitive_equal ("hkey_performance_data") or else
				l_string.is_case_insensitive_equal ("hkey_users") or else
				l_string.is_case_insensitive_equal ("hkey_current_user") or else
				l_string.is_case_insensitive_equal ("hkey_local_machine")
			then
				Result := True
			end
		end

	index_value_for_root_keys (name: STRING_GENERAL): POINTER is
			-- Return the index corresponding to a root key.
		require
			name_not_void: name /= Void
			name_valid: name.is_valid_as_string_8
			valid_key: basic_valid_name_for_hkey (name)
		local
			l_string: STRING
		do
			l_string := name.to_string_8
			if l_string.is_case_insensitive_equal ("hkey_classes_root") then
					Result := Hkey_classes_root
			elseif l_string.is_case_insensitive_equal ("hkey_dyn_data") then
					Result := Hkey_dyn_data
			elseif l_string.is_case_insensitive_equal ("hkey_current_config") then
					Result := Hkey_current_config
			elseif l_string.is_case_insensitive_equal ("hkey_performance_data") then
					Result := Hkey_performance_data
			elseif l_string.is_case_insensitive_equal ("hkey_users") then
					Result := Hkey_users
			elseif l_string.is_case_insensitive_equal ("hkey_current_user") then
					Result := Hkey_current_user
			elseif l_string.is_case_insensitive_equal ("hkey_local_machine") then
					Result := Hkey_local_machine
			end
		end

feature -- Access

	frozen Hkey_classes_root: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_CLASSES_ROOT"
		end

	frozen Hkey_current_user: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_CURRENT_USER"
		end

	frozen Hkey_local_machine: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_LOCAL_MACHINE"
		end

	frozen Hkey_users: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_USERS"
		end

	frozen Hkey_performance_data: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_PERFORMANCE_DATA"
		end

	frozen Hkey_current_config: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_CURRENT_CONFIG"
		end

	frozen Hkey_dyn_data: POINTER is
		external
			"C [macro %"winreg.h%"] : EIF_POINTER"
		alias
			"HKEY_DYN_DATA"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_HKEY

