indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.SendKeys"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_SEND_KEYS

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen send_wait (keys: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Windows.Forms.SendKeys"
		alias
			"SendWait"
		end

	frozen send (keys: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Windows.Forms.SendKeys"
		alias
			"Send"
		end

	frozen flush is
		external
			"IL static signature (): System.Void use System.Windows.Forms.SendKeys"
		alias
			"Flush"
		end

end -- class WINFORMS_SEND_KEYS
