indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.TextBox"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_TEXTBOX

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			add_attributes_to_render,
			get_tag_key,
			render,
			on_pre_render,
			add_parsed_sub_object
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
	make_textbox

feature {NONE} -- Initialization

	frozen make_textbox is
		external
			"IL creator use System.Web.UI.WebControls.TextBox"
		end

feature -- Access

	get_rows: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.TextBox"
		alias
			"get_Rows"
		end

	get_max_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.TextBox"
		alias
			"get_MaxLength"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.TextBox"
		alias
			"get_Text"
		end

	get_columns: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.TextBox"
		alias
			"get_Columns"
		end

	get_auto_post_back: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TextBox"
		alias
			"get_AutoPostBack"
		end

	get_wrap: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TextBox"
		alias
			"get_Wrap"
		end

	get_text_mode: SYSTEM_WEB_UI_WEBCONTROLS_TEXTBOXMODE is
		external
			"IL signature (): System.Web.UI.WebControls.TextBoxMode use System.Web.UI.WebControls.TextBox"
		alias
			"get_TextMode"
		end

	get_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TextBox"
		alias
			"get_ReadOnly"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_Text"
		end

	frozen remove_text_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"remove_TextChanged"
		end

	set_max_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_MaxLength"
		end

	set_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_ReadOnly"
		end

	set_columns (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_Columns"
		end

	set_text_mode (value: SYSTEM_WEB_UI_WEBCONTROLS_TEXTBOXMODE) is
		external
			"IL signature (System.Web.UI.WebControls.TextBoxMode): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_TextMode"
		end

	set_wrap (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_Wrap"
		end

	frozen add_text_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"add_TextChanged"
		end

	set_rows (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_Rows"
		end

	set_auto_post_back (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"set_AutoPostBack"
		end

feature {NONE} -- Implementation

	add_parsed_sub_object (obj: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"AddParsedSubObject"
		end

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: STRING; post_collection: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.WebControls.TextBox"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	on_pre_render (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"OnPreRender"
		end

	render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"Render"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"AddAttributesToRender"
		end

	on_text_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.TextBox"
		alias
			"OnTextChanged"
		end

	get_tag_key: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG is
		external
			"IL signature (): System.Web.UI.HtmlTextWriterTag use System.Web.UI.WebControls.TextBox"
		alias
			"get_TagKey"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_TEXTBOX
