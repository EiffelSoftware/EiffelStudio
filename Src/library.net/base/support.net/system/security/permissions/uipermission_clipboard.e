indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.UIPermissionClipboard"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	UIPERMISSION_CLIPBOARD

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen all_clipboard: UIPERMISSION_CLIPBOARD is
		external
			"IL enum signature :System.Security.Permissions.UIPermissionClipboard use System.Security.Permissions.UIPermissionClipboard"
		alias
			"2"
		end

	frozen own_clipboard: UIPERMISSION_CLIPBOARD is
		external
			"IL enum signature :System.Security.Permissions.UIPermissionClipboard use System.Security.Permissions.UIPermissionClipboard"
		alias
			"1"
		end

	frozen no_clipboard: UIPERMISSION_CLIPBOARD is
		external
			"IL enum signature :System.Security.Permissions.UIPermissionClipboard use System.Security.Permissions.UIPermissionClipboard"
		alias
			"0"
		end

end -- class UIPERMISSION_CLIPBOARD
