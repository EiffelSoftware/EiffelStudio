indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.DataGridSortCommandEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DATA_GRID_SORT_COMMAND_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_web_data_grid_sort_command_event_args

feature {NONE} -- Initialization

	frozen make_web_data_grid_sort_command_event_args (command_source: SYSTEM_OBJECT; dce: WEB_DATA_GRID_COMMAND_EVENT_ARGS) is
		external
			"IL creator signature (System.Object, System.Web.UI.WebControls.DataGridCommandEventArgs) use System.Web.UI.WebControls.DataGridSortCommandEventArgs"
		end

feature -- Access

	frozen get_command_source: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGridSortCommandEventArgs"
		alias
			"get_CommandSource"
		end

	frozen get_sort_expression: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridSortCommandEventArgs"
		alias
			"get_SortExpression"
		end

end -- class WEB_DATA_GRID_SORT_COMMAND_EVENT_ARGS
