indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataGridSortCommandEventArgs"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDSORTCOMMANDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_datagridsortcommandeventargs

feature {NONE} -- Initialization

	frozen make_datagridsortcommandeventargs (command_source: ANY; dce: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTARGS) is
		external
			"IL creator signature (System.Object, System.Web.UI.WebControls.DataGridCommandEventArgs) use System.Web.UI.WebControls.DataGridSortCommandEventArgs"
		end

feature -- Access

	frozen get_command_source: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGridSortCommandEventArgs"
		alias
			"get_CommandSource"
		end

	frozen get_sort_expression: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridSortCommandEventArgs"
		alias
			"get_SortExpression"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDSORTCOMMANDEVENTARGS
