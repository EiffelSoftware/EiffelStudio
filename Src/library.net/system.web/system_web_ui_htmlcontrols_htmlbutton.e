indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlButton"

external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLBUTTON

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
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
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLCONTAINERCONTROL
		redefine
			render_attributes
		end

create
	make_htmlbutton

feature {NONE} -- Initialization

	frozen make_htmlbutton is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlButton"
		end

feature -- Access

	frozen get_causes_validation: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlButton"
		alias
			"get_CausesValidation"
		end

feature -- Element Change

	frozen add_server_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlButton"
		alias
			"add_ServerClick"
		end

	frozen set_causes_validation (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.HtmlControls.HtmlButton"
		alias
			"set_CausesValidation"
		end

	frozen remove_server_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlButton"
		alias
			"remove_ServerClick"
		end

feature {NONE} -- Implementation

	render_attributes (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlButton"
		alias
			"RenderAttributes"
		end

	frozen system_web_ui_ipost_back_event_handler_raise_post_back_event (event_argument: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlButton"
		alias
			"System.Web.UI.IPostBackEventHandler.RaisePostBackEvent"
		end

	on_server_click (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlButton"
		alias
			"OnServerClick"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLBUTTON
