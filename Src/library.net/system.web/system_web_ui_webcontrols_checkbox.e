indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.CheckBox"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_CHECKBOX

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			render,
			on_pre_render
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IPOSTBACKDATAHANDLER
		rename
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_checkbox

feature {NONE} -- Initialization

	frozen make_checkbox is
		external
			"IL creator use System.Web.UI.WebControls.CheckBox"
		end

feature -- Access

	get_auto_post_back: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CheckBox"
		alias
			"get_AutoPostBack"
		end

	get_text_align: SYSTEM_WEB_UI_WEBCONTROLS_TEXTALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.TextAlign use System.Web.UI.WebControls.CheckBox"
		alias
			"get_TextAlign"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.CheckBox"
		alias
			"get_Text"
		end

	get_checked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.CheckBox"
		alias
			"get_Checked"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"set_Text"
		end

	set_checked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"set_Checked"
		end

	frozen remove_checked_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"remove_CheckedChanged"
		end

	set_auto_post_back (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"set_AutoPostBack"
		end

	set_text_align (value: SYSTEM_WEB_UI_WEBCONTROLS_TEXTALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.TextAlign): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"set_TextAlign"
		end

	frozen add_checked_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"add_CheckedChanged"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: STRING; post_collection: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.WebControls.CheckBox"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	on_checked_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"OnCheckedChanged"
		end

	on_pre_render (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"OnPreRender"
		end

	render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.CheckBox"
		alias
			"Render"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_CHECKBOX
