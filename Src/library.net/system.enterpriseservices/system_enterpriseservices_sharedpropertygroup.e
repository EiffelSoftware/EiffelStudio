indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.SharedPropertyGroup"

frozen external class
	SYSTEM_ENTERPRISESERVICES_SHAREDPROPERTYGROUP

create {NONE}

feature -- Basic Operations

	frozen property (name: STRING): SYSTEM_ENTERPRISESERVICES_SHAREDPROPERTY is
		external
			"IL signature (System.String): System.EnterpriseServices.SharedProperty use System.EnterpriseServices.SharedPropertyGroup"
		alias
			"Property"
		end

	frozen create_property (name: STRING; f_exists: BOOLEAN): SYSTEM_ENTERPRISESERVICES_SHAREDPROPERTY is
		external
			"IL signature (System.String, System.Boolean&): System.EnterpriseServices.SharedProperty use System.EnterpriseServices.SharedPropertyGroup"
		alias
			"CreateProperty"
		end

	frozen property_by_position (position: INTEGER): SYSTEM_ENTERPRISESERVICES_SHAREDPROPERTY is
		external
			"IL signature (System.Int32): System.EnterpriseServices.SharedProperty use System.EnterpriseServices.SharedPropertyGroup"
		alias
			"PropertyByPosition"
		end

	frozen create_property_by_position (position: INTEGER; f_exists: BOOLEAN): SYSTEM_ENTERPRISESERVICES_SHAREDPROPERTY is
		external
			"IL signature (System.Int32, System.Boolean&): System.EnterpriseServices.SharedProperty use System.EnterpriseServices.SharedPropertyGroup"
		alias
			"CreatePropertyByPosition"
		end

end -- class SYSTEM_ENTERPRISESERVICES_SHAREDPROPERTYGROUP
