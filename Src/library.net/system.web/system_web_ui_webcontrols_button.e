indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.Button"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_BUTTON

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			render_contents,
			add_attributes_to_render
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IPOSTBACKEVENTHANDLER
		rename
			raise_post_back_event as system_web_ui_ipost_back_event_handler_raise_post_back_event
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_button

feature {NONE} -- Initialization

	frozen make_button is
		external
			"IL creator use System.Web.UI.WebControls.Button"
		end

feature -- Access

	frozen get_command_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Button"
		alias
			"get_CommandName"
		end

	frozen get_command_argument: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Button"
		alias
			"get_CommandArgument"
		end

	frozen get_causes_validation: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.Button"
		alias
			"get_CausesValidation"
		end

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Button"
		alias
			"get_Text"
		end

feature -- Element Change

	frozen set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Button"
		alias
			"set_Text"
		end

	frozen add_command (value: SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.CommandEventHandler): System.Void use System.Web.UI.WebControls.Button"
		alias
			"add_Command"
		end

	frozen set_command_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Button"
		alias
			"set_CommandName"
		end

	frozen set_command_argument (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Button"
		alias
			"set_CommandArgument"
		end

	frozen remove_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.Button"
		alias
			"remove_Click"
		end

	frozen add_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.Button"
		alias
			"add_Click"
		end

	frozen set_causes_validation (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.Button"
		alias
			"set_CausesValidation"
		end

	frozen remove_command (value: SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.CommandEventHandler): System.Void use System.Web.UI.WebControls.Button"
		alias
			"remove_Command"
		end

feature {NONE} -- Implementation

	on_click (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.Button"
		alias
			"OnClick"
		end

	render_contents (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Button"
		alias
			"RenderContents"
		end

	on_command (e: SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.CommandEventArgs): System.Void use System.Web.UI.WebControls.Button"
		alias
			"OnCommand"
		end

	frozen system_web_ui_ipost_back_event_handler_raise_post_back_event (event_argument: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Button"
		alias
			"System.Web.UI.IPostBackEventHandler.RaisePostBackEvent"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Button"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_BUTTON
