indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "NewEmitterMain"

external class
	NEWEMITTERMAIN

inherit
	NEWARGPARSER
		redefine
			OnDoneParse,
			OnNonSwitch,
			OnSwitch
		end

create
	make_newemittermain

feature {NONE} -- Initialization

	frozen make_newemittermain is
		external
			"IL creator use NewEmitterMain"
		end

feature -- Basic Operations

	frozen Main is
		external
			"IL static signature (): System.Void use NewEmitterMain"
		alias
			"Main"
		end

feature {NONE} -- Implementation

	OnNonSwitch (switchValue: STRING): INTEGER is
		external
			"IL signature (System.String): enum NewArgParser+SwitchStatus use NewEmitterMain"
		alias
			"OnNonSwitch"
		end

	OnSwitch (switchSymbol: STRING; switchValue: STRING): INTEGER is
		external
			"IL signature (System.String, System.String): enum NewArgParser+SwitchStatus use NewEmitterMain"
		alias
			"OnSwitch"
		end

	OnDoneParse: INTEGER is
		external
			"IL signature (): enum NewArgParser+SwitchStatus use NewEmitterMain"
		alias
			"OnDoneParse"
		end

end -- class NEWEMITTERMAIN
