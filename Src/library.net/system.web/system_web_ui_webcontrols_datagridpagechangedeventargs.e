indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataGridPageChangedEventArgs"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDPAGECHANGEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_datagridpagechangedeventargs

feature {NONE} -- Initialization

	frozen make_datagridpagechangedeventargs (command_source: ANY; new_page_index: INTEGER) is
		external
			"IL creator signature (System.Object, System.Int32) use System.Web.UI.WebControls.DataGridPageChangedEventArgs"
		end

feature -- Access

	frozen get_command_source: ANY is
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

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDPAGECHANGEDEVENTARGS
