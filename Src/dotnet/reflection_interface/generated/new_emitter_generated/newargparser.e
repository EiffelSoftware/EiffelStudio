indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "NewArgParser"

deferred external class
	NEWARGPARSER

feature {NONE} -- Implementation

	OnNonSwitch (value: STRING): INTEGER is
		external
			"IL signature (System.String): enum NewArgParser+SwitchStatus use NewArgParser"
		alias
			"OnNonSwitch"
			--
		end

	OnSwitch (switchSymbol: STRING; switchValue: STRING): INTEGER is
		external
			"IL signature (System.String, System.String): enum NewArgParser+SwitchStatus use NewArgParser"
		alias
			"OnSwitch"
			--
		end

	OnDoneParse: INTEGER is
		external
			"IL signature (): enum NewArgParser+SwitchStatus use NewArgParser"
		alias
			"OnDoneParse"
			--
		end

end -- class NEWARGPARSER
