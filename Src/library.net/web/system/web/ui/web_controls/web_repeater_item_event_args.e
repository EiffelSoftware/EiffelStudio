indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.RepeaterItemEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_REPEATER_ITEM_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_web_repeater_item_event_args

feature {NONE} -- Initialization

	frozen make_web_repeater_item_event_args (item: WEB_REPEATER_ITEM) is
		external
			"IL creator signature (System.Web.UI.WebControls.RepeaterItem) use System.Web.UI.WebControls.RepeaterItemEventArgs"
		end

feature -- Access

	frozen get_item: WEB_REPEATER_ITEM is
		external
			"IL signature (): System.Web.UI.WebControls.RepeaterItem use System.Web.UI.WebControls.RepeaterItemEventArgs"
		alias
			"get_Item"
		end

end -- class WEB_REPEATER_ITEM_EVENT_ARGS
