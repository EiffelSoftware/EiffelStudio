indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.ListBox"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_LISTBOX

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPOSTBACKDATAHANDLER
		rename
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_WEBCONTROLS_LISTCONTROL
		redefine
			render_contents,
			add_attributes_to_render,
			set_tool_tip,
			get_tool_tip,
			set_border_style,
			get_border_style,
			set_border_width,
			get_border_width,
			set_border_color,
			get_border_color,
			on_pre_render
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_listbox

feature {NONE} -- Initialization

	frozen make_listbox is
		external
			"IL creator use System.Web.UI.WebControls.ListBox"
		end

feature -- Access

	get_tool_tip: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ListBox"
		alias
			"get_ToolTip"
		end

	get_selection_mode: SYSTEM_WEB_UI_WEBCONTROLS_LISTSELECTIONMODE is
		external
			"IL signature (): System.Web.UI.WebControls.ListSelectionMode use System.Web.UI.WebControls.ListBox"
		alias
			"get_SelectionMode"
		end

	get_rows: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.ListBox"
		alias
			"get_Rows"
		end

	get_border_width: SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.ListBox"
		alias
			"get_BorderWidth"
		end

	get_border_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.ListBox"
		alias
			"get_BorderColor"
		end

	get_border_style: SYSTEM_WEB_UI_WEBCONTROLS_BORDERSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.BorderStyle use System.Web.UI.WebControls.ListBox"
		alias
			"get_BorderStyle"
		end

feature -- Element Change

	set_selection_mode (value: SYSTEM_WEB_UI_WEBCONTROLS_LISTSELECTIONMODE) is
		external
			"IL signature (System.Web.UI.WebControls.ListSelectionMode): System.Void use System.Web.UI.WebControls.ListBox"
		alias
			"set_SelectionMode"
		end

	set_tool_tip (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ListBox"
		alias
			"set_ToolTip"
		end

	set_border_style (value: SYSTEM_WEB_UI_WEBCONTROLS_BORDERSTYLE) is
		external
			"IL signature (System.Web.UI.WebControls.BorderStyle): System.Void use System.Web.UI.WebControls.ListBox"
		alias
			"set_BorderStyle"
		end

	set_border_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.ListBox"
		alias
			"set_BorderColor"
		end

	set_rows (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.ListBox"
		alias
			"set_Rows"
		end

	set_border_width (value: SYSTEM_WEB_UI_WEBCONTROLS_UNIT) is
		external
			"IL signature (System.Web.UI.WebControls.Unit): System.Void use System.Web.UI.WebControls.ListBox"
		alias
			"set_BorderWidth"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: STRING; post_collection: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.WebControls.ListBox"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.ListBox"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	render_contents (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.ListBox"
		alias
			"RenderContents"
		end

	on_pre_render (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.ListBox"
		alias
			"OnPreRender"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.ListBox"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_LISTBOX
