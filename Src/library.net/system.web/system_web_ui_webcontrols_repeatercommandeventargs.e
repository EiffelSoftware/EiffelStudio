indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.RepeaterCommandEventArgs"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_REPEATERCOMMANDEVENTARGS

inherit
	SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTARGS

create
	make_repeatercommandeventargs

feature {NONE} -- Initialization

	frozen make_repeatercommandeventargs (item: SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEM; command_source: ANY; original_args: SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTARGS) is
		external
			"IL creator signature (System.Web.UI.WebControls.RepeaterItem, System.Object, System.Web.UI.WebControls.CommandEventArgs) use System.Web.UI.WebControls.RepeaterCommandEventArgs"
		end

feature -- Access

	frozen get_command_source: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.RepeaterCommandEventArgs"
		alias
			"get_CommandSource"
		end

	frozen get_item: SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEM is
		external
			"IL signature (): System.Web.UI.WebControls.RepeaterItem use System.Web.UI.WebControls.RepeaterCommandEventArgs"
		alias
			"get_Item"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_REPEATERCOMMANDEVENTARGS
