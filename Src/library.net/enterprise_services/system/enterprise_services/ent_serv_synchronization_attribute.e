indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.SynchronizationAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_SYNCHRONIZATION_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_synchronization_attribute_1,
	make_ent_serv_synchronization_attribute

feature {NONE} -- Initialization

	frozen make_ent_serv_synchronization_attribute_1 (val: ENT_SERV_SYNCHRONIZATION_OPTION) is
		external
			"IL creator signature (System.EnterpriseServices.SynchronizationOption) use System.EnterpriseServices.SynchronizationAttribute"
		end

	frozen make_ent_serv_synchronization_attribute is
		external
			"IL creator use System.EnterpriseServices.SynchronizationAttribute"
		end

feature -- Access

	frozen get_value: ENT_SERV_SYNCHRONIZATION_OPTION is
		external
			"IL signature (): System.EnterpriseServices.SynchronizationOption use System.EnterpriseServices.SynchronizationAttribute"
		alias
			"get_Value"
		end

end -- class ENT_SERV_SYNCHRONIZATION_ATTRIBUTE
