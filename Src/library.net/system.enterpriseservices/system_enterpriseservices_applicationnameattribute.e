indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ApplicationNameAttribute"

frozen external class
	SYSTEM_ENTERPRISESERVICES_APPLICATIONNAMEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_applicationnameattribute

feature {NONE} -- Initialization

	frozen make_applicationnameattribute (name: STRING) is
		external
			"IL creator signature (System.String) use System.EnterpriseServices.ApplicationNameAttribute"
		end

feature -- Access

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.ApplicationNameAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_ENTERPRISESERVICES_APPLICATIONNAMEATTRIBUTE
