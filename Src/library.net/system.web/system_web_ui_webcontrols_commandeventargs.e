indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.CommandEventArgs"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_commandeventargs,
	make_commandeventargs_1

feature {NONE} -- Initialization

	frozen make_commandeventargs (e: SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTARGS) is
		external
			"IL creator signature (System.Web.UI.WebControls.CommandEventArgs) use System.Web.UI.WebControls.CommandEventArgs"
		end

	frozen make_commandeventargs_1 (command_name: STRING; argument: ANY) is
		external
			"IL creator signature (System.String, System.Object) use System.Web.UI.WebControls.CommandEventArgs"
		end

feature -- Access

	frozen get_command_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.CommandEventArgs"
		alias
			"get_CommandName"
		end

	frozen get_command_argument: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.CommandEventArgs"
		alias
			"get_CommandArgument"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTARGS
