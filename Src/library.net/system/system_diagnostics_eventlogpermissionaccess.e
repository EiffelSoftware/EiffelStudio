indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EventLogPermissionAccess"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONACCESS

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen browse: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONACCESS is
		external
			"IL enum signature :System.Diagnostics.EventLogPermissionAccess use System.Diagnostics.EventLogPermissionAccess"
		alias
			"2"
		end

	frozen none: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONACCESS is
		external
			"IL enum signature :System.Diagnostics.EventLogPermissionAccess use System.Diagnostics.EventLogPermissionAccess"
		alias
			"0"
		end

	frozen audit: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONACCESS is
		external
			"IL enum signature :System.Diagnostics.EventLogPermissionAccess use System.Diagnostics.EventLogPermissionAccess"
		alias
			"10"
		end

	frozen instrument: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONACCESS is
		external
			"IL enum signature :System.Diagnostics.EventLogPermissionAccess use System.Diagnostics.EventLogPermissionAccess"
		alias
			"6"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONACCESS
