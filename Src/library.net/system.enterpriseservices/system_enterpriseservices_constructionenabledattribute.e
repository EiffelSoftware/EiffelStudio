indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ConstructionEnabledAttribute"

frozen external class
	SYSTEM_ENTERPRISESERVICES_CONSTRUCTIONENABLEDATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_constructionenabledattribute_1,
	make_constructionenabledattribute

feature {NONE} -- Initialization

	frozen make_constructionenabledattribute_1 (val: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.EnterpriseServices.ConstructionEnabledAttribute"
		end

	frozen make_constructionenabledattribute is
		external
			"IL creator use System.EnterpriseServices.ConstructionEnabledAttribute"
		end

feature -- Access

	frozen get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.ConstructionEnabledAttribute"
		alias
			"get_Enabled"
		end

	frozen get_default: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.ConstructionEnabledAttribute"
		alias
			"get_Default"
		end

feature -- Element Change

	frozen set_default (value: STRING) is
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

end -- class SYSTEM_ENTERPRISESERVICES_CONSTRUCTIONENABLEDATTRIBUTE
