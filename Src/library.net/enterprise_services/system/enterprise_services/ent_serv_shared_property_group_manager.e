indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.SharedPropertyGroupManager"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_SHARED_PROPERTY_GROUP_MANAGER

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
			"IL creator use System.EnterpriseServices.SharedPropertyGroupManager"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.SharedPropertyGroupManager"
		alias
			"GetHashCode"
		end

	frozen group (name: SYSTEM_STRING): ENT_SERV_SHARED_PROPERTY_GROUP is
		external
			"IL signature (System.String): System.EnterpriseServices.SharedPropertyGroup use System.EnterpriseServices.SharedPropertyGroupManager"
		alias
			"Group"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.EnterpriseServices.SharedPropertyGroupManager"
		alias
			"GetEnumerator"
		end

	frozen create_property_group (name: SYSTEM_STRING; dw_iso_mode: ENT_SERV_PROPERTY_LOCK_MODE; dw_rel_mode: ENT_SERV_PROPERTY_RELEASE_MODE; f_exist: BOOLEAN): ENT_SERV_SHARED_PROPERTY_GROUP is
		external
			"IL signature (System.String, System.EnterpriseServices.PropertyLockMode&, System.EnterpriseServices.PropertyReleaseMode&, System.Boolean&): System.EnterpriseServices.SharedPropertyGroup use System.EnterpriseServices.SharedPropertyGroupManager"
		alias
			"CreatePropertyGroup"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.SharedPropertyGroupManager"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.SharedPropertyGroupManager"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.SharedPropertyGroupManager"
		alias
			"Finalize"
		end

end -- class ENT_SERV_SHARED_PROPERTY_GROUP_MANAGER
