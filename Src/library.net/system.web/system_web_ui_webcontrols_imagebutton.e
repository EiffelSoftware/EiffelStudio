indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.ImageButton"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_IMAGEBUTTON

inherit
	SYSTEM_WEB_UI_IPOSTBACKDATAHANDLER
		rename
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_WEB_UI_WEBCONTROLS_IMAGE
		redefine
			add_attributes_to_render,
			get_tag_key,
			on_pre_render
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_WEB_UI_IPOSTBACKEVENTHANDLER
		rename
			raise_post_back_event as system_web_ui_ipost_back_event_handler_raise_post_back_event
		end

create
	make_imagebutton

feature {NONE} -- Initialization

	frozen make_imagebutton is
		external
			"IL creator use System.Web.UI.WebControls.ImageButton"
		end

feature -- Access

	frozen get_command_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ImageButton"
		alias
			"get_CommandName"
		end

	frozen get_command_argument: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ImageButton"
		alias
			"get_CommandArgument"
		end

	frozen get_causes_validation: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ImageButton"
		alias
			"get_CausesValidation"
		end

feature -- Element Change

	frozen remove_click (value: SYSTEM_WEB_UI_IMAGECLICKEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.ImageClickEventHandler): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"remove_Click"
		end

	frozen add_click (value: SYSTEM_WEB_UI_IMAGECLICKEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.ImageClickEventHandler): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"add_Click"
		end

	frozen set_causes_validation (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"set_CausesValidation"
		end

	frozen set_command_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"set_CommandName"
		end

	frozen add_command (value: SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.CommandEventHandler): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"add_Command"
		end

	frozen remove_command (value: SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.CommandEventHandler): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"remove_Command"
		end

	frozen set_command_argument (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"set_CommandArgument"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_ipost_back_event_handler_raise_post_back_event (event_argument: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"System.Web.UI.IPostBackEventHandler.RaisePostBackEvent"
		end

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: STRING; post_collection: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.WebControls.ImageButton"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	on_click (e: SYSTEM_WEB_UI_IMAGECLICKEVENTARGS) is
		external
			"IL signature (System.Web.UI.ImageClickEventArgs): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"OnClick"
		end

	on_pre_render (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"OnPreRender"
		end

	on_command (e: SYSTEM_WEB_UI_WEBCONTROLS_COMMANDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.CommandEventArgs): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"OnCommand"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.ImageButton"
		alias
			"AddAttributesToRender"
		end

	get_tag_key: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG is
		external
			"IL signature (): System.Web.UI.HtmlTextWriterTag use System.Web.UI.WebControls.ImageButton"
		alias
			"get_TagKey"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_IMAGEBUTTON
