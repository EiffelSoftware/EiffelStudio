indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.SharedPropertyGroupManager"

frozen external class
	SYSTEM_ENTERPRISESERVICES_SHAREDPROPERTYGROUPMANAGER

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
			"IL creator use System.EnterpriseServices.SharedPropertyGroupManager"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.SharedPropertyGroupManager"
		alias
			"GetHashCode"
		end

	frozen group (name: STRING): SYSTEM_ENTERPRISESERVICES_SHAREDPROPERTYGROUP is
		external
			"IL signature (System.String): System.EnterpriseServices.SharedPropertyGroup use System.EnterpriseServices.SharedPropertyGroupManager"
		alias
			"Group"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.EnterpriseServices.SharedPropertyGroupManager"
		alias
			"GetEnumerator"
		end

	frozen create_property_group (name: STRING; dw_iso_mode: SYSTEM_ENTERPRISESERVICES_PROPERTYLOCKMODE; dw_rel_mode: SYSTEM_ENTERPRISESERVICES_PROPERTYRELEASEMODE; f_exist: BOOLEAN): SYSTEM_ENTERPRISESERVICES_SHAREDPROPERTYGROUP is
		external
			"IL signature (System.String, System.EnterpriseServices.PropertyLockMode&, System.EnterpriseServices.PropertyReleaseMode&, System.Boolean&): System.EnterpriseServices.SharedPropertyGroup use System.EnterpriseServices.SharedPropertyGroupManager"
		alias
			"CreatePropertyGroup"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.SharedPropertyGroupManager"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_ENTERPRISESERVICES_SHAREDPROPERTYGROUPMANAGER
