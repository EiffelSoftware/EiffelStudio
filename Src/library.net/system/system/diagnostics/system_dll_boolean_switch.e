indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.BooleanSwitch"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_BOOLEAN_SWITCH

inherit
	SYSTEM_DLL_SWITCH

create
	make_system_dll_boolean_switch

feature {NONE} -- Initialization

	frozen make_system_dll_boolean_switch (display_name: SYSTEM_STRING; description: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Diagnostics.BooleanSwitch"
		end

feature -- Access

	frozen get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.BooleanSwitch"
		alias
			"get_Enabled"
		end

feature -- Element Change

	frozen set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.BooleanSwitch"
		alias
			"set_Enabled"
		end

end -- class SYSTEM_DLL_BOOLEAN_SWITCH
