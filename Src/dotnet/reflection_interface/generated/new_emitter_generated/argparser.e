indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ArgParser"
	assembly: "ISE.Reflection.Emitter", "1.0.0.62252", "neutral", "20ff36d6debc9ba6"

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
