indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataListCommandEventArgs"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTARGS

inherit
	SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTARGS

create
	make_datalistcommandeventargs

feature {NONE} -- Initialization

	frozen make_datalistcommandeventargs (item: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEM; command_source: ANY; original_args: SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTARGS) is
		external
			"IL creator signature (System.Web.UI.WebControls.DataListItem, System.Object, System.Web.UI.WebControls.CommandEventArgs) use System.Web.UI.WebControls.DataListCommandEventArgs"
		end

feature -- Access

	frozen get_command_source: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataListCommandEventArgs"
		alias
			"get_CommandSource"
		end

	frozen get_item: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTITEM is
		external
			"IL signature (): System.Web.UI.WebControls.DataListItem use System.Web.UI.WebControls.DataListCommandEventArgs"
		alias
			"get_Item"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTARGS
