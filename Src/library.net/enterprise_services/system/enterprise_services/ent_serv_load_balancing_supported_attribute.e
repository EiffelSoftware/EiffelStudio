indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.LoadBalancingSupportedAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_LOAD_BALANCING_SUPPORTED_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_load_balancing_supported_attribute,
	make_ent_serv_load_balancing_supported_attribute_1

feature {NONE} -- Initialization

	frozen make_ent_serv_load_balancing_supported_attribute is
		external
			"IL creator use System.EnterpriseServices.LoadBalancingSupportedAttribute"
		end

	frozen make_ent_serv_load_balancing_supported_attribute_1 (val: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.EnterpriseServices.LoadBalancingSupportedAttribute"
		end

feature -- Access

	frozen get_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.LoadBalancingSupportedAttribute"
		alias
			"get_Value"
		end

end -- class ENT_SERV_LOAD_BALANCING_SUPPORTED_ATTRIBUTE
