indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.IsolatedStorageFilePermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEFILEPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEPERMISSIONATTRIBUTE

create
	make_isolatedstoragefilepermissionattribute

feature {NONE} -- Initialization

	frozen make_isolatedstoragefilepermissionattribute (action: INTEGER) is
			-- Valid values for `action' are:
			-- Demand = 2
			-- Assert = 3
			-- Deny = 4
			-- PermitOnly = 5
			-- LinkDemand = 6
			-- InheritanceDemand = 7
			-- RequestMinimum = 8
			-- RequestOptional = 9
			-- RequestRefuse = 10
		require
			valid_security_action: action = 2 or action = 3 or action = 4 or action = 5 or action = 6 or action = 7 or action = 8 or action = 9 or action = 10
		external
			"IL creator signature (enum System.Security.Permissions.SecurityAction) use System.Security.Permissions.IsolatedStorageFilePermissionAttribute"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.IsolatedStorageFilePermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_ISOLATEDSTORAGEFILEPERMISSIONATTRIBUTE
