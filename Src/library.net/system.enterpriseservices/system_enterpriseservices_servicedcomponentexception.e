indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ServicedComponentException"

frozen external class
	SYSTEM_ENTERPRISESERVICES_SERVICEDCOMPONENTEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_servicedcomponentexception,
	make_servicedcomponentexception_1,
	make_servicedcomponentexception_2

feature {NONE} -- Initialization

	frozen make_servicedcomponentexception is
		external
			"IL creator use System.EnterpriseServices.ServicedComponentException"
		end

	frozen make_servicedcomponentexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.EnterpriseServices.ServicedComponentException"
		end

	frozen make_servicedcomponentexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.EnterpriseServices.ServicedComponentException"
		end

end -- class SYSTEM_ENTERPRISESERVICES_SERVICEDCOMPONENTEXCEPTION
