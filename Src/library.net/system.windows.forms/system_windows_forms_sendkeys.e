indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.SendKeys"

external class
	SYSTEM_WINDOWS_FORMS_SENDKEYS

create {NONE}

feature -- Basic Operations

	frozen send_wait (keys: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Windows.Forms.SendKeys"
		alias
			"SendWait"
		end

	frozen send (keys: STRING) is
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

end -- class SYSTEM_WINDOWS_FORMS_SENDKEYS
