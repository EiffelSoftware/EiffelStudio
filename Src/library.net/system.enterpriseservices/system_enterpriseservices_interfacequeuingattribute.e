indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.InterfaceQueuingAttribute"

frozen external class
	SYSTEM_ENTERPRISESERVICES_INTERFACEQUEUINGATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_interfacequeuingattribute_1,
	make_interfacequeuingattribute

feature {NONE} -- Initialization

	frozen make_interfacequeuingattribute_1 (enabled: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.EnterpriseServices.InterfaceQueuingAttribute"
		end

	frozen make_interfacequeuingattribute is
		external
			"IL creator use System.EnterpriseServices.InterfaceQueuingAttribute"
		end

feature -- Access

	frozen get_interface: STRING is
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

	frozen set_interface (value: STRING) is
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

end -- class SYSTEM_ENTERPRISESERVICES_INTERFACEQUEUINGATTRIBUTE
