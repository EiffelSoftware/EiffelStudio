indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.PerformanceCounterPermissionAccess"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONACCESS

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

	frozen administer: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONACCESS is
		external
			"IL enum signature :System.Diagnostics.PerformanceCounterPermissionAccess use System.Diagnostics.PerformanceCounterPermissionAccess"
		alias
			"14"
		end

	frozen browse: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONACCESS is
		external
			"IL enum signature :System.Diagnostics.PerformanceCounterPermissionAccess use System.Diagnostics.PerformanceCounterPermissionAccess"
		alias
			"2"
		end

	frozen none: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONACCESS is
		external
			"IL enum signature :System.Diagnostics.PerformanceCounterPermissionAccess use System.Diagnostics.PerformanceCounterPermissionAccess"
		alias
			"0"
		end

	frozen instrument: SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONACCESS is
		external
			"IL enum signature :System.Diagnostics.PerformanceCounterPermissionAccess use System.Diagnostics.PerformanceCounterPermissionAccess"
		alias
			"6"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERPERMISSIONACCESS
