indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataGridCommandEventArgs"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTARGS

inherit
	SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTARGS

create
	make_datagridcommandeventargs

feature {NONE} -- Initialization

	frozen make_datagridcommandeventargs (item: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEM; command_source: ANY; original_args: SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTARGS) is
		external
			"IL creator signature (System.Web.UI.WebControls.DataGridItem, System.Object, System.Web.UI.WebControls.CommandEventArgs) use System.Web.UI.WebControls.DataGridCommandEventArgs"
		end

feature -- Access

	frozen get_command_source: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGridCommandEventArgs"
		alias
			"get_CommandSource"
		end

	frozen get_item: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEM is
		external
			"IL signature (): System.Web.UI.WebControls.DataGridItem use System.Web.UI.WebControls.DataGridCommandEventArgs"
		alias
			"get_Item"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOMMANDEVENTARGS
