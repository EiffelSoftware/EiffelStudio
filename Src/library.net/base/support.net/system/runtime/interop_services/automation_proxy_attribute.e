indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.AutomationProxyAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	AUTOMATION_PROXY_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_automation_proxy_attribute

feature {NONE} -- Initialization

	frozen make_automation_proxy_attribute (val: BOOLEAN) is
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

end -- class AUTOMATION_PROXY_ATTRIBUTE
