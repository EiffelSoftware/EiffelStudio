indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "EmitterMain"

external class
	EMITTER_MAIN

inherit
	ARG_PARSER
		redefine
			on_done_parse,
			on_non_switch,
			on_switch
		end

create
	make_emitter_main

feature {NONE} -- Initialization

	frozen make_emitter_main is
		external
			"IL creator use EmitterMain"
		end

feature -- Access

	frozen default_xml_switch: SYSTEM_STRING is
		external
			"IL field signature :System.String use EmitterMain"
		alias
			"DefaultXmlSwitch"
		end

	frozen default_formatting_switch: SYSTEM_STRING is
		external
			"IL field signature :System.String use EmitterMain"
		alias
			"DefaultFormattingSwitch"
		end

feature -- Basic Operations

	frozen main is
		external
			"IL static signature (): System.Void use EmitterMain"
		alias
			"Main"
		end

feature {NONE} -- Implementation

	on_switch (switch_symbol: SYSTEM_STRING; switch_value: SYSTEM_STRING): ARG_PARSER+_SWITCH_STATUSSWITCH_STATUS_IN_ARG_PARSER is
		external
			"IL signature (System.String, System.String): ArgParser+SwitchStatus use EmitterMain"
		alias
			"OnSwitch"
		end

	on_done_parse: ARG_PARSER+_SWITCH_STATUSSWITCH_STATUS_IN_ARG_PARSER is
		external
			"IL signature (): ArgParser+SwitchStatus use EmitterMain"
		alias
			"OnDoneParse"
		end

	on_non_switch (switch_value: SYSTEM_STRING): ARG_PARSER+_SWITCH_STATUSSWITCH_STATUS_IN_ARG_PARSER is
		external
			"IL signature (System.String): ArgParser+SwitchStatus use EmitterMain"
		alias
			"OnNonSwitch"
		end

end -- class EMITTER_MAIN
