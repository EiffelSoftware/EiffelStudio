indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlSelect"

external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLSELECT

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
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IPOSTBACKDATAHANDLER
		rename
			raise_post_data_changed_event as system_web_ui_ipost_back_data_handler_raise_post_data_changed_event,
			load_post_data as system_web_ui_ipost_back_data_handler_load_post_data
		end
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLCONTAINERCONTROL
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object_object
		redefine
			set_inner_text,
			get_inner_text,
			set_inner_html,
			get_inner_html,
			render_attributes,
			track_view_state,
			create_control_collection,
			render_children,
			save_view_state,
			on_pre_render,
			load_view_state,
			system_web_ui_iparser_accessor_add_parsed_sub_object_object,
			on_data_binding
		select
			system_web_ui_iparser_accessor_add_parsed_sub_object_object
		end

create
	make_htmlselect

feature {NONE} -- Initialization

	frozen make_htmlselect is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlSelect"
		end

feature -- Access

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_Size"
		end

	get_data_member: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_DataMember"
		end

	get_data_value_field: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_DataValueField"
		end

	get_inner_html: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_InnerHtml"
		end

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_Value"
		end

	get_data_source: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_DataSource"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_Name"
		end

	frozen get_items: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMCOLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.ListItemCollection use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_Items"
		end

	frozen get_multiple: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_Multiple"
		end

	get_data_text_field: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_DataTextField"
		end

	get_selected_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_SelectedIndex"
		end

	get_inner_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_InnerText"
		end

feature -- Element Change

	frozen set_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_Size"
		end

	frozen set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_Value"
		end

	set_inner_html (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_InnerHtml"
		end

	frozen remove_server_change (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"remove_ServerChange"
		end

	set_data_value_field (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_DataValueField"
		end

	frozen add_server_change (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"add_ServerChange"
		end

	set_selected_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_SelectedIndex"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_Name"
		end

	set_data_text_field (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_DataTextField"
		end

	frozen set_multiple (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_Multiple"
		end

	set_data_source (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_DataSource"
		end

	set_inner_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_InnerText"
		end

	set_data_member (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"set_DataMember"
		end

feature {NONE} -- Implementation

	on_server_change (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"OnServerChange"
		end

	render_children (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"RenderChildren"
		end

	frozen system_web_ui_ipost_back_data_handler_load_post_data (post_data_key: STRING; post_collection: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): BOOLEAN is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"System.Web.UI.IPostBackDataHandler.LoadPostData"
		end

	render_attributes (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"RenderAttributes"
		end

	get_selected_indices: ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"get_SelectedIndices"
		end

	save_view_state: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"SaveViewState"
		end

	on_pre_render (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"OnPreRender"
		end

	Select_ (selected_indices: ARRAY [INTEGER]) is
		external
			"IL signature (System.Int32[]): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"Select"
		end

	frozen system_web_ui_ipost_back_data_handler_raise_post_data_changed_event is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent"
		end

	on_data_binding (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"OnDataBinding"
		end

	create_control_collection: SYSTEM_WEB_UI_CONTROLCOLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"CreateControlCollection"
		end

	clear_selection is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"ClearSelection"
		end

	system_web_ui_iparser_accessor_add_parsed_sub_object_object (obj: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"AddParsedSubObject"
		end

	load_view_state (saved_state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"LoadViewState"
		end

	track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlSelect"
		alias
			"TrackViewState"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLSELECT
