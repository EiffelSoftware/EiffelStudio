indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.BooleanSwitch"

external class
	SYSTEM_DIAGNOSTICS_BOOLEANSWITCH

inherit
	SYSTEM_DIAGNOSTICS_SWITCH

create
	make_booleanswitch

feature {NONE} -- Initialization

	frozen make_booleanswitch (display_name: STRING; description: STRING) is
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

end -- class SYSTEM_DIAGNOSTICS_BOOLEANSWITCH
