indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.CommandEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_COMMAND_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_web_command_event_args,
	make_web_command_event_args_1

feature {NONE} -- Initialization

	frozen make_web_command_event_args (e: WEB_COMMAND_EVENT_ARGS) is
		external
			"IL creator signature (System.Web.UI.WebControls.CommandEventArgs) use System.Web.UI.WebControls.CommandEventArgs"
		end

	frozen make_web_command_event_args_1 (command_name: SYSTEM_STRING; argument: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.String, System.Object) use System.Web.UI.WebControls.CommandEventArgs"
		end

feature -- Access

	frozen get_command_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.CommandEventArgs"
		alias
			"get_CommandName"
		end

	frozen get_command_argument: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.CommandEventArgs"
		alias
			"get_CommandArgument"
		end

end -- class WEB_COMMAND_EVENT_ARGS
