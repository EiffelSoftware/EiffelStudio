indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ApplicationIDAttribute"

frozen external class
	SYSTEM_ENTERPRISESERVICES_APPLICATIONIDATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_applicationidattribute

feature {NONE} -- Initialization

	frozen make_applicationidattribute (guid: STRING) is
		external
			"IL creator signature (System.String) use System.EnterpriseServices.ApplicationIDAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.EnterpriseServices.ApplicationIDAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_ENTERPRISESERVICES_APPLICATIONIDATTRIBUTE
