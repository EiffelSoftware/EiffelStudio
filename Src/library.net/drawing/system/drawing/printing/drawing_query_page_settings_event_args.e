indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.QueryPageSettingsEventArgs"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_QUERY_PAGE_SETTINGS_EVENT_ARGS

inherit
	DRAWING_PRINT_EVENT_ARGS

create
	make_drawing_query_page_settings_event_args

feature {NONE} -- Initialization

	frozen make_drawing_query_page_settings_event_args (page_settings: DRAWING_PAGE_SETTINGS) is
		external
			"IL creator signature (System.Drawing.Printing.PageSettings) use System.Drawing.Printing.QueryPageSettingsEventArgs"
		end

feature -- Access

	frozen get_page_settings: DRAWING_PAGE_SETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PageSettings use System.Drawing.Printing.QueryPageSettingsEventArgs"
		alias
			"get_PageSettings"
		end

feature -- Element Change

	frozen set_page_settings (value: DRAWING_PAGE_SETTINGS) is
		external
			"IL signature (System.Drawing.Printing.PageSettings): System.Void use System.Drawing.Printing.QueryPageSettingsEventArgs"
		alias
			"set_PageSettings"
		end

end -- class DRAWING_QUERY_PAGE_SETTINGS_EVENT_ARGS
