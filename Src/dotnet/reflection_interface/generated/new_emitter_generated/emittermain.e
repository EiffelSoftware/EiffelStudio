indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "EmitterMain"

external class
	EMITTERMAIN

inherit
	ARGPARSER
		redefine
			OnDoneParse,
			OnNonSwitch,
			OnSwitch
		end

create
	make_emittermain

feature {NONE} -- Initialization

	frozen make_emittermain is
		external
			"IL creator use EmitterMain"
		end

feature -- Basic Operations

	frozen Main is
		external
			"IL static signature (): System.Void use EmitterMain"
		alias
			"Main"
		end

feature {NONE} -- Implementation

	OnNonSwitch (switchValue: STRING): INTEGER is
		external
			"IL signature (System.String): enum ArgParser+SwitchStatus use EmitterMain"
		alias
			"OnNonSwitch"
		end

	OnSwitch (switchSymbol: STRING; switchValue: STRING): INTEGER is
		external
			"IL signature (System.String, System.String): enum ArgParser+SwitchStatus use EmitterMain"
		alias
			"OnSwitch"
		end

	OnDoneParse: INTEGER is
		external
			"IL signature (): enum ArgParser+SwitchStatus use EmitterMain"
		alias
			"OnDoneParse"
		end

end -- class EMITTERMAIN
