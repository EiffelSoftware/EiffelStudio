indexing
	Generator: "Eiffel Emitter 2.6b2"
	external_name: "EmitterMain"
external class
	EMITTERMAIN

inherit
	ARGPARSER
		redefine
			on_done_parse,
			on_non_switch,
			on_switch
		end

create
	make_emittermain

feature {NONE} -- Initialization

	frozen make_emittermain is
		external
			"IL creator use EmitterMain"
		end

feature -- Access

	frozen eiffel_formatting_switch: STRING is
		external
			"IL field signature :System.String use EmitterMain"
		alias
			"EiffelFormattingSwitch"
		end

feature -- Basic Operations

	frozen main is
		external
			"IL static signature (): System.Void use EmitterMain"
		alias
			"Main"
		end

feature {NONE} -- Implementation

	on_switch (switch_symbol: STRING; switch_value: STRING): SWITCHSTATUS_IN_ARGPARSER is
		external
			"IL signature (System.String, System.String): ArgParser+SwitchStatus use EmitterMain"
		alias
			"OnSwitch"
		end

	on_done_parse: SWITCHSTATUS_IN_ARGPARSER is
		external
			"IL signature (): ArgParser+SwitchStatus use EmitterMain"
		alias
			"OnDoneParse"
		end

	on_non_switch (switch_value: STRING): SWITCHSTATUS_IN_ARGPARSER is
		external
			"IL signature (System.String): ArgParser+SwitchStatus use EmitterMain"
		alias
			"OnNonSwitch"
		end

end -- class EMITTERMAIN
