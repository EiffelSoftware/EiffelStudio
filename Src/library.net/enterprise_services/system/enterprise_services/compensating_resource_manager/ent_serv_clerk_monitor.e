indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_CLERK_MONITOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		end

feature -- Access

	frozen get_item (index: SYSTEM_STRING): ENT_SERV_CLERK_INFO is
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

	frozen get_item_int32 (index: INTEGER): ENT_SERV_CLERK_INFO is
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

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.CompensatingResourceManager.ClerkMonitor"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

end -- class ENT_SERV_CLERK_MONITOR
