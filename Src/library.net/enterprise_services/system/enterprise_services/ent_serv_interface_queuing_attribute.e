indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.InterfaceQueuingAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_INTERFACE_QUEUING_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_interface_queuing_attribute_1,
	make_ent_serv_interface_queuing_attribute

feature {NONE} -- Initialization

	frozen make_ent_serv_interface_queuing_attribute_1 (enabled: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.EnterpriseServices.InterfaceQueuingAttribute"
		end

	frozen make_ent_serv_interface_queuing_attribute is
		external
			"IL creator use System.EnterpriseServices.InterfaceQueuingAttribute"
		end

feature -- Access

	frozen get_interface: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.InterfaceQueuingAttribute"
		alias
			"get_Interface"
		end

	frozen get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.InterfaceQueuingAttribute"
		alias
			"get_Enabled"
		end

feature -- Element Change

	frozen set_interface (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.InterfaceQueuingAttribute"
		alias
			"set_Interface"
		end

	frozen set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.EnterpriseServices.InterfaceQueuingAttribute"
		alias
			"set_Enabled"
		end

end -- class ENT_SERV_INTERFACE_QUEUING_ATTRIBUTE
