indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.DataGridPageChangedEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DATA_GRID_PAGE_CHANGED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_web_data_grid_page_changed_event_args

feature {NONE} -- Initialization

	frozen make_web_data_grid_page_changed_event_args (command_source: SYSTEM_OBJECT; new_page_index: INTEGER) is
		external
			"IL creator signature (System.Object, System.Int32) use System.Web.UI.WebControls.DataGridPageChangedEventArgs"
		end

feature -- Access

	frozen get_command_source: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGridPageChangedEventArgs"
		alias
			"get_CommandSource"
		end

	frozen get_new_page_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGridPageChangedEventArgs"
		alias
			"get_NewPageIndex"
		end

end -- class WEB_DATA_GRID_PAGE_CHANGED_EVENT_ARGS
