indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ExceptionClassAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_EXCEPTION_CLASS_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_exception_class_attribute

feature {NONE} -- Initialization

	frozen make_ent_serv_exception_class_attribute (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.EnterpriseServices.ExceptionClassAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.ExceptionClassAttribute"
		alias
			"get_Value"
		end

end -- class ENT_SERV_EXCEPTION_CLASS_ATTRIBUTE
