indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EventLogPermissionEntry"

external class
	SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY

create
	make

feature {NONE} -- Initialization

	frozen make (permission_access: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONACCESS; machine_name: STRING) is
		external
			"IL creator signature (System.Diagnostics.EventLogPermissionAccess, System.String) use System.Diagnostics.EventLogPermissionEntry"
		end

feature -- Access

	frozen get_machine_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogPermissionEntry"
		alias
			"get_MachineName"
		end

	frozen get_permission_access: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONACCESS is
		external
			"IL signature (): System.Diagnostics.EventLogPermissionAccess use System.Diagnostics.EventLogPermissionEntry"
		alias
			"get_PermissionAccess"
		end

end -- class SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY
