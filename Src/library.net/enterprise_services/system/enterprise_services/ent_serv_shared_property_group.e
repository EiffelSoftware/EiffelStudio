indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.SharedPropertyGroup"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_SHARED_PROPERTY_GROUP

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen property (name: SYSTEM_STRING): ENT_SERV_SHARED_PROPERTY is
		external
			"IL signature (System.String): System.EnterpriseServices.SharedProperty use System.EnterpriseServices.SharedPropertyGroup"
		alias
			"Property"
		end

	frozen create_property (name: SYSTEM_STRING; f_exists: BOOLEAN): ENT_SERV_SHARED_PROPERTY is
		external
			"IL signature (System.String, System.Boolean&): System.EnterpriseServices.SharedProperty use System.EnterpriseServices.SharedPropertyGroup"
		alias
			"CreateProperty"
		end

	frozen property_by_position (position: INTEGER): ENT_SERV_SHARED_PROPERTY is
		external
			"IL signature (System.Int32): System.EnterpriseServices.SharedProperty use System.EnterpriseServices.SharedPropertyGroup"
		alias
			"PropertyByPosition"
		end

	frozen create_property_by_position (position: INTEGER; f_exists: BOOLEAN): ENT_SERV_SHARED_PROPERTY is
		external
			"IL signature (System.Int32, System.Boolean&): System.EnterpriseServices.SharedProperty use System.EnterpriseServices.SharedPropertyGroup"
		alias
			"CreatePropertyByPosition"
		end

end -- class ENT_SERV_SHARED_PROPERTY_GROUP
