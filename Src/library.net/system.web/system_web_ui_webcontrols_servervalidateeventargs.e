indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.ServerValidateEventArgs"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_SERVERVALIDATEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_servervalidateeventargs

feature {NONE} -- Initialization

	frozen make_servervalidateeventargs (value: STRING; is_valid: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.Web.UI.WebControls.ServerValidateEventArgs"
		end

feature -- Access

	frozen get_is_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ServerValidateEventArgs"
		alias
			"get_IsValid"
		end

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ServerValidateEventArgs"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_is_valid (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.ServerValidateEventArgs"
		alias
			"set_IsValid"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_SERVERVALIDATEEVENTARGS
