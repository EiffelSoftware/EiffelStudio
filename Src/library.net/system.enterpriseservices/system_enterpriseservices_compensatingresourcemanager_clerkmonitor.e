indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"

frozen external class
	SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_CLERKMONITOR

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		end

feature -- Access

	frozen get_item (index: STRING): SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_CLERKINFO is
		external
			"IL signature (System.String): System.EnterpriseServices.CompensatingResourceManager.ClerkInfo use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		alias
			"get_Count"
		end

	frozen get_item_int32 (index: INTEGER): SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_CLERKINFO is
		external
			"IL signature (System.Int32): System.EnterpriseServices.CompensatingResourceManager.ClerkInfo use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen populate is
		external
			"IL signature (): System.Void use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		alias
			"Populate"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		alias
			"Finalize"
		end

end -- class SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_CLERKMONITOR
