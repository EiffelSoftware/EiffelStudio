indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlInputImage"

external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLINPUTIMAGE

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IPOSTBACKDATAHANDLER
		rename
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data
		end
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_WEB_UI_IPOSTBACKEVENTHANDLER
		rename
			raise_post_back_event as system_web_ui_ipost_back_event_handler_raise_post_back_event
		end
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLINPUTCONTROL
		redefine
			render_attributes,
			on_pre_render
		end

create
	make_htmlinputimage

feature {NONE} -- Initialization

	frozen make_htmlinputimage is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlInputImage"
		end

feature -- Access

	frozen get_border: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"get_Border"
		end

	frozen get_align: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"get_Align"
		end

	frozen get_causes_validation: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"get_CausesValidation"
		end

	frozen get_alt: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"get_Alt"
		end

	frozen get_src: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"get_Src"
		end

feature -- Element Change

	frozen set_align (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"set_Align"
		end

	frozen set_src (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"set_Src"
		end

	frozen set_causes_validation (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"set_CausesValidation"
		end

	frozen remove_server_click (value: SYSTEM_WEB_UI_IMAGECLICKEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.ImageClickEventHandler): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"remove_ServerClick"
		end

	frozen set_border (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"set_Border"
		end

	frozen set_alt (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"set_Alt"
		end

	frozen add_server_click (value: SYSTEM_WEB_UI_IMAGECLICKEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.ImageClickEventHandler): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"add_ServerClick"
		end

feature {NONE} -- Implementation

	render_attributes (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"RenderAttributes"
		end

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: STRING; post_collection: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	on_pre_render (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"OnPreRender"
		end

	frozen system_web_ui_ipost_back_event_handler_raise_post_back_event (event_argument: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"System.Web.UI.IPostBackEventHandler.RaisePostBackEvent"
		end

	on_server_click (e: SYSTEM_WEB_UI_IMAGECLICKEVENTARGS) is
		external
			"IL signature (System.Web.UI.ImageClickEventArgs): System.Void use System.Web.UI.HtmlControls.HtmlInputImage"
		alias
			"OnServerClick"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLINPUTIMAGE
