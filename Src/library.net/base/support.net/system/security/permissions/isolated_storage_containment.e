indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.IsolatedStorageContainment"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	ISOLATED_STORAGE_CONTAINMENT

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen domain_isolation_by_roaming_user: ISOLATED_STORAGE_CONTAINMENT is
		external
			"IL enum signature :System.Security.Permissions.IsolatedStorageContainment use System.Security.Permissions.IsolatedStorageContainment"
		alias
			"80"
		end

	frozen administer_isolated_storage_by_user: ISOLATED_STORAGE_CONTAINMENT is
		external
			"IL enum signature :System.Security.Permissions.IsolatedStorageContainment use System.Security.Permissions.IsolatedStorageContainment"
		alias
			"112"
		end

	frozen assembly_isolation_by_user: ISOLATED_STORAGE_CONTAINMENT is
		external
			"IL enum signature :System.Security.Permissions.IsolatedStorageContainment use System.Security.Permissions.IsolatedStorageContainment"
		alias
			"32"
		end

	frozen none: ISOLATED_STORAGE_CONTAINMENT is
		external
			"IL enum signature :System.Security.Permissions.IsolatedStorageContainment use System.Security.Permissions.IsolatedStorageContainment"
		alias
			"0"
		end

	frozen assembly_isolation_by_roaming_user: ISOLATED_STORAGE_CONTAINMENT is
		external
			"IL enum signature :System.Security.Permissions.IsolatedStorageContainment use System.Security.Permissions.IsolatedStorageContainment"
		alias
			"96"
		end

	frozen domain_isolation_by_user: ISOLATED_STORAGE_CONTAINMENT is
		external
			"IL enum signature :System.Security.Permissions.IsolatedStorageContainment use System.Security.Permissions.IsolatedStorageContainment"
		alias
			"16"
		end

	frozen unrestricted_isolated_storage: ISOLATED_STORAGE_CONTAINMENT is
		external
			"IL enum signature :System.Security.Permissions.IsolatedStorageContainment use System.Security.Permissions.IsolatedStorageContainment"
		alias
			"240"
		end

end -- class ISOLATED_STORAGE_CONTAINMENT
