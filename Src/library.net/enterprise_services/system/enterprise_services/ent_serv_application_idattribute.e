indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ApplicationIDAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_APPLICATION_IDATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_application_idattribute

feature {NONE} -- Initialization

	frozen make_ent_serv_application_idattribute (guid: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.EnterpriseServices.ApplicationIDAttribute"
		end

feature -- Access

	frozen get_value: GUID is
		external
			"IL signature (): System.Guid use System.EnterpriseServices.ApplicationIDAttribute"
		alias
			"get_Value"
		end

end -- class ENT_SERV_APPLICATION_IDATTRIBUTE
