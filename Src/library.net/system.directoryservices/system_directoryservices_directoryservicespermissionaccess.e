indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.DirectoryServicesPermissionAccess"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONACCESS

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

	frozen browse: SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONACCESS is
		external
			"IL enum signature :System.DirectoryServices.DirectoryServicesPermissionAccess use System.DirectoryServices.DirectoryServicesPermissionAccess"
		alias
			"2"
		end

	frozen none: SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONACCESS is
		external
			"IL enum signature :System.DirectoryServices.DirectoryServicesPermissionAccess use System.DirectoryServices.DirectoryServicesPermissionAccess"
		alias
			"0"
		end

	frozen write: SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONACCESS is
		external
			"IL enum signature :System.DirectoryServices.DirectoryServicesPermissionAccess use System.DirectoryServices.DirectoryServicesPermissionAccess"
		alias
			"6"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONACCESS
