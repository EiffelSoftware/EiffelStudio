indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.ServerValidateEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_SERVER_VALIDATE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_web_server_validate_event_args

feature {NONE} -- Initialization

	frozen make_web_server_validate_event_args (value: SYSTEM_STRING; is_valid: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.Web.UI.WebControls.ServerValidateEventArgs"
		end

feature -- Access

	frozen get_is_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ServerValidateEventArgs"
		alias
			"get_IsValid"
		end

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ServerValidateEventArgs"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_is_valid (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.ServerValidateEventArgs"
		alias
			"set_IsValid"
		end

end -- class WEB_SERVER_VALIDATE_EVENT_ARGS
