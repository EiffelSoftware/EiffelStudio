indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.RepeaterCommandEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_REPEATER_COMMAND_EVENT_ARGS

inherit
	WEB_COMMAND_EVENT_ARGS

create
	make_web_repeater_command_event_args

feature {NONE} -- Initialization

	frozen make_web_repeater_command_event_args (item: WEB_REPEATER_ITEM; command_source: SYSTEM_OBJECT; original_args: WEB_COMMAND_EVENT_ARGS) is
		external
			"IL creator signature (System.Web.UI.WebControls.RepeaterItem, System.Object, System.Web.UI.WebControls.CommandEventArgs) use System.Web.UI.WebControls.RepeaterCommandEventArgs"
		end

feature -- Access

	frozen get_command_source: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.RepeaterCommandEventArgs"
		alias
			"get_CommandSource"
		end

	frozen get_item: WEB_REPEATER_ITEM is
		external
			"IL signature (): System.Web.UI.WebControls.RepeaterItem use System.Web.UI.WebControls.RepeaterCommandEventArgs"
		alias
			"get_Item"
		end

end -- class WEB_REPEATER_COMMAND_EVENT_ARGS
