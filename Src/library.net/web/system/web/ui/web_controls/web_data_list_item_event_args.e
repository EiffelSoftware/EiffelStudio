indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.DataListItemEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DATA_LIST_ITEM_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_web_data_list_item_event_args

feature {NONE} -- Initialization

	frozen make_web_data_list_item_event_args (item: WEB_DATA_LIST_ITEM) is
		external
			"IL creator signature (System.Web.UI.WebControls.DataListItem) use System.Web.UI.WebControls.DataListItemEventArgs"
		end

feature -- Access

	frozen get_item: WEB_DATA_LIST_ITEM is
		external
			"IL signature (): System.Web.UI.WebControls.DataListItem use System.Web.UI.WebControls.DataListItemEventArgs"
		alias
			"get_Item"
		end

end -- class WEB_DATA_LIST_ITEM_EVENT_ARGS
