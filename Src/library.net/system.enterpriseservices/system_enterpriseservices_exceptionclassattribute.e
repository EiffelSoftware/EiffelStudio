indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ExceptionClassAttribute"

frozen external class
	SYSTEM_ENTERPRISESERVICES_EXCEPTIONCLASSATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_exceptionclassattribute

feature {NONE} -- Initialization

	frozen make_exceptionclassattribute (name: STRING) is
		external
			"IL creator signature (System.String) use System.EnterpriseServices.ExceptionClassAttribute"
		end

feature -- Access

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.ExceptionClassAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_ENTERPRISESERVICES_EXCEPTIONCLASSATTRIBUTE
