indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.UIPermissionWindow"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	UIPERMISSION_WINDOW

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen all_windows: UIPERMISSION_WINDOW is
		external
			"IL enum signature :System.Security.Permissions.UIPermissionWindow use System.Security.Permissions.UIPermissionWindow"
		alias
			"3"
		end

	frozen no_windows: UIPERMISSION_WINDOW is
		external
			"IL enum signature :System.Security.Permissions.UIPermissionWindow use System.Security.Permissions.UIPermissionWindow"
		alias
			"0"
		end

	frozen safe_top_level_windows: UIPERMISSION_WINDOW is
		external
			"IL enum signature :System.Security.Permissions.UIPermissionWindow use System.Security.Permissions.UIPermissionWindow"
		alias
			"2"
		end

	frozen safe_sub_windows: UIPERMISSION_WINDOW is
		external
			"IL enum signature :System.Security.Permissions.UIPermissionWindow use System.Security.Permissions.UIPermissionWindow"
		alias
			"1"
		end

end -- class UIPERMISSION_WINDOW
