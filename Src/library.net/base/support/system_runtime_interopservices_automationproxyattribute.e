indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.AutomationProxyAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_AUTOMATIONPROXYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_automationproxyattribute

feature {NONE} -- Initialization

	frozen make_automationproxyattribute (val: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Runtime.InteropServices.AutomationProxyAttribute"
		end

feature -- Access

	frozen get_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.InteropServices.AutomationProxyAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_AUTOMATIONPROXYATTRIBUTE
