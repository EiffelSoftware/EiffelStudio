indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ArgParser"

deferred external class
	ARG_PARSER

inherit
	GLOBALS

feature {NONE} -- Implementation

	on_switch (switch_symbol: SYSTEM_STRING; switch_value: SYSTEM_STRING): ARG_PARSER+_SWITCH_STATUSSWITCH_STATUS_IN_ARG_PARSER is
		external
			"IL signature (System.String, System.String): ArgParser+SwitchStatus use ArgParser"
		alias
			"OnSwitch"
		end

	on_done_parse: ARG_PARSER+_SWITCH_STATUSSWITCH_STATUS_IN_ARG_PARSER is
		external
			"IL signature (): ArgParser+SwitchStatus use ArgParser"
		alias
			"OnDoneParse"
		end

	on_non_switch (value: SYSTEM_STRING): ARG_PARSER+_SWITCH_STATUSSWITCH_STATUS_IN_ARG_PARSER is
		external
			"IL signature (System.String): ArgParser+SwitchStatus use ArgParser"
		alias
			"OnNonSwitch"
		end

end -- class ARG_PARSER
