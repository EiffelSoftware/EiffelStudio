indexing
	Generator: "Eiffel Emitter 2.6b2"
	external_name: "ArgParser"
deferred external class
	ARGPARSER

inherit
	GLOBALS

feature {NONE} -- Implementation

	on_switch (switch_symbol: STRING; switch_value: STRING): SWITCHSTATUS_IN_ARGPARSER is
		external
			"IL signature (System.String, System.String): ArgParser+SwitchStatus use ArgParser"
		alias
			"OnSwitch"
		end

	on_done_parse: SWITCHSTATUS_IN_ARGPARSER is
		external
			"IL signature (): ArgParser+SwitchStatus use ArgParser"
		alias
			"OnDoneParse"
		end

	on_non_switch (value: STRING): SWITCHSTATUS_IN_ARGPARSER is
		external
			"IL signature (System.String): ArgParser+SwitchStatus use ArgParser"
		alias
			"OnNonSwitch"
		end

end -- class ARGPARSER
