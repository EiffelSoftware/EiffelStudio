indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.JustInTimeActivationAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_JUST_IN_TIME_ACTIVATION_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_just_in_time_activation_attribute_1,
	make_ent_serv_just_in_time_activation_attribute

feature {NONE} -- Initialization

	frozen make_ent_serv_just_in_time_activation_attribute_1 (val: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.EnterpriseServices.JustInTimeActivationAttribute"
		end

	frozen make_ent_serv_just_in_time_activation_attribute is
		external
			"IL creator use System.EnterpriseServices.JustInTimeActivationAttribute"
		end

feature -- Access

	frozen get_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.JustInTimeActivationAttribute"
		alias
			"get_Value"
		end

end -- class ENT_SERV_JUST_IN_TIME_ACTIVATION_ATTRIBUTE
