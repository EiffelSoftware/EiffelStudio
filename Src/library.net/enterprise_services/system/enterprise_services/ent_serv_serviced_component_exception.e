indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ServicedComponentException"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_SERVICED_COMPONENT_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_ent_serv_serviced_component_exception_1,
	make_ent_serv_serviced_component_exception_2,
	make_ent_serv_serviced_component_exception

feature {NONE} -- Initialization

	frozen make_ent_serv_serviced_component_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.EnterpriseServices.ServicedComponentException"
		end

	frozen make_ent_serv_serviced_component_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.EnterpriseServices.ServicedComponentException"
		end

	frozen make_ent_serv_serviced_component_exception is
		external
			"IL creator use System.EnterpriseServices.ServicedComponentException"
		end

end -- class ENT_SERV_SERVICED_COMPONENT_EXCEPTION
