indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlAnchor"

external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLANCHOR

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
	make_htmlanchor

feature {NONE} -- Initialization

	frozen make_htmlanchor is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlAnchor"
		end

feature -- Access

	frozen get_href: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"get_HRef"
		end

	frozen get_target: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"get_Target"
		end

	frozen get_title: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"get_Title"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen add_server_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"add_ServerClick"
		end

	frozen set_href (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"set_HRef"
		end

	frozen remove_server_click (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"remove_ServerClick"
		end

	frozen set_title (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"set_Title"
		end

	frozen set_target (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"set_Target"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"set_Name"
		end

feature {NONE} -- Implementation

	render_attributes (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"RenderAttributes"
		end

	frozen system_web_ui_ipost_back_event_handler_raise_post_back_event (event_argument: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"System.Web.UI.IPostBackEventHandler.RaisePostBackEvent"
		end

	on_server_click (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlAnchor"
		alias
			"OnServerClick"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLANCHOR
