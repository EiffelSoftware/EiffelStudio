indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DropDownList"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_DROPDOWNLIST

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
			set_selected_index,
			get_selected_index,
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
			create_control_collection
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_dropdownlist

feature {NONE} -- Initialization

	frozen make_dropdownlist is
		external
			"IL creator use System.Web.UI.WebControls.DropDownList"
		end

feature -- Access

	get_selected_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DropDownList"
		alias
			"get_SelectedIndex"
		end

	get_tool_tip: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DropDownList"
		alias
			"get_ToolTip"
		end

	get_border_width: SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.DropDownList"
		alias
			"get_BorderWidth"
		end

	get_border_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Web.UI.WebControls.DropDownList"
		alias
			"get_BorderColor"
		end

	get_border_style: SYSTEM_WEB_UI_WEBCONTROLS_BORDERSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.BorderStyle use System.Web.UI.WebControls.DropDownList"
		alias
			"get_BorderStyle"
		end

feature -- Element Change

	set_tool_tip (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.DropDownList"
		alias
			"set_ToolTip"
		end

	set_border_style (value: SYSTEM_WEB_UI_WEBCONTROLS_BORDERSTYLE) is
		external
			"IL signature (System.Web.UI.WebControls.BorderStyle): System.Void use System.Web.UI.WebControls.DropDownList"
		alias
			"set_BorderStyle"
		end

	set_border_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Web.UI.WebControls.DropDownList"
		alias
			"set_BorderColor"
		end

	set_selected_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.DropDownList"
		alias
			"set_SelectedIndex"
		end

	set_border_width (value: SYSTEM_WEB_UI_WEBCONTROLS_UNIT) is
		external
			"IL signature (System.Web.UI.WebControls.Unit): System.Void use System.Web.UI.WebControls.DropDownList"
		alias
			"set_BorderWidth"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: STRING; post_collection: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.WebControls.DropDownList"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DropDownList"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	render_contents (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.DropDownList"
		alias
			"RenderContents"
		end

	create_control_collection: SYSTEM_WEB_UI_CONTROLCOLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.WebControls.DropDownList"
		alias
			"CreateControlCollection"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.DropDownList"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DROPDOWNLIST
