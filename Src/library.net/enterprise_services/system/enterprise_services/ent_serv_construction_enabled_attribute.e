indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ConstructionEnabledAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_CONSTRUCTION_ENABLED_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_construction_enabled_attribute,
	make_ent_serv_construction_enabled_attribute_1

feature {NONE} -- Initialization

	frozen make_ent_serv_construction_enabled_attribute is
		external
			"IL creator use System.EnterpriseServices.ConstructionEnabledAttribute"
		end

	frozen make_ent_serv_construction_enabled_attribute_1 (val: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.EnterpriseServices.ConstructionEnabledAttribute"
		end

feature -- Access

	frozen get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.ConstructionEnabledAttribute"
		alias
			"get_Enabled"
		end

	frozen get_default: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.ConstructionEnabledAttribute"
		alias
			"get_Default"
		end

feature -- Element Change

	frozen set_default (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.ConstructionEnabledAttribute"
		alias
			"set_Default"
		end

	frozen set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.EnterpriseServices.ConstructionEnabledAttribute"
		alias
			"set_Enabled"
		end

end -- class ENT_SERV_CONSTRUCTION_ENABLED_ATTRIBUTE
