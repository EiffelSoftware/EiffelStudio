indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.Control"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_CONTROL

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WEB_IPARSER_ACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	WEB_IDATA_BINDINGS_ACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.Control"
		end

feature -- Access

	get_template_source_directory: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.Control"
		alias
			"get_TemplateSourceDirectory"
		end

	get_enable_view_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Control"
		alias
			"get_EnableViewState"
		end

	get_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Control"
		alias
			"get_Visible"
		end

	get_unique_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.Control"
		alias
			"get_UniqueID"
		end

	get_naming_container: WEB_CONTROL is
		external
			"IL signature (): System.Web.UI.Control use System.Web.UI.Control"
		alias
			"get_NamingContainer"
		end

	frozen get_binding_container: WEB_CONTROL is
		external
			"IL signature (): System.Web.UI.Control use System.Web.UI.Control"
		alias
			"get_BindingContainer"
		end

	get_parent: WEB_CONTROL is
		external
			"IL signature (): System.Web.UI.Control use System.Web.UI.Control"
		alias
			"get_Parent"
		end

	get_controls: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.Control"
		alias
			"get_Controls"
		end

	get_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.Control"
		alias
			"get_ID"
		end

	frozen get_site: SYSTEM_DLL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.Web.UI.Control"
		alias
			"get_Site"
		end

	get_page: WEB_PAGE is
		external
			"IL signature (): System.Web.UI.Page use System.Web.UI.Control"
		alias
			"get_Page"
		end

	get_client_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.Control"
		alias
			"get_ClientID"
		end

feature -- Element Change

	frozen add_unload (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.Control"
		alias
			"add_Unload"
		end

	frozen remove_init (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.Control"
		alias
			"remove_Init"
		end

	frozen remove_load (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.Control"
		alias
			"remove_Load"
		end

	frozen remove_disposed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.Control"
		alias
			"remove_Disposed"
		end

	frozen add_pre_render (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.Control"
		alias
			"add_PreRender"
		end

	set_enable_view_state (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.Control"
		alias
			"set_EnableViewState"
		end

	frozen add_disposed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.Control"
		alias
			"add_Disposed"
		end

	frozen add_data_binding (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.Control"
		alias
			"add_DataBinding"
		end

	frozen add_init (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.Control"
		alias
			"add_Init"
		end

	frozen remove_unload (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.Control"
		alias
			"remove_Unload"
		end

	set_id (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.Control"
		alias
			"set_ID"
		end

	frozen set_site (value: SYSTEM_DLL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Web.UI.Control"
		alias
			"set_Site"
		end

	frozen add_load (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.Control"
		alias
			"add_Load"
		end

	frozen remove_pre_render (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.Control"
		alias
			"remove_PreRender"
		end

	set_page (value: WEB_PAGE) is
		external
			"IL signature (System.Web.UI.Page): System.Void use System.Web.UI.Control"
		alias
			"set_Page"
		end

	frozen remove_data_binding (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.Control"
		alias
			"remove_DataBinding"
		end

	set_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.Control"
		alias
			"set_Visible"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.Control"
		alias
			"ToString"
		end

	frozen set_render_method_delegate (render_method: WEB_RENDER_METHOD) is
		external
			"IL signature (System.Web.UI.RenderMethod): System.Void use System.Web.UI.Control"
		alias
			"SetRenderMethodDelegate"
		end

	frozen resolve_url (relative_url: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.Control"
		alias
			"ResolveUrl"
		end

	dispose is
		external
			"IL signature (): System.Void use System.Web.UI.Control"
		alias
			"Dispose"
		end

	frozen render_control (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.Control"
		alias
			"RenderControl"
		end

	has_controls: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Control"
		alias
			"HasControls"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.Control"
		alias
			"Equals"
		end

	data_bind is
		external
			"IL signature (): System.Void use System.Web.UI.Control"
		alias
			"DataBind"
		end

	find_control (id: SYSTEM_STRING): WEB_CONTROL is
		external
			"IL signature (System.String): System.Web.UI.Control use System.Web.UI.Control"
		alias
			"FindControl"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.Control"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	find_control_string_int32 (id: SYSTEM_STRING; path_offset: INTEGER): WEB_CONTROL is
		external
			"IL signature (System.String, System.Int32): System.Web.UI.Control use System.Web.UI.Control"
		alias
			"FindControl"
		end

	create_control_collection: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.Control"
		alias
			"CreateControlCollection"
		end

	render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.Control"
		alias
			"Render"
		end

	frozen get_has_child_view_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Control"
		alias
			"get_HasChildViewState"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.Control"
		alias
			"Finalize"
		end

	frozen map_path_secure (virtual_path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.Control"
		alias
			"MapPathSecure"
		end

	frozen system_web_ui_idata_bindings_accessor_get_data_bindings: WEB_DATA_BINDING_COLLECTION is
		external
			"IL signature (): System.Web.UI.DataBindingCollection use System.Web.UI.Control"
		alias
			"System.Web.UI.IDataBindingsAccessor.get_DataBindings"
		end

	on_bubble_event (source: SYSTEM_OBJECT; args: EVENT_ARGS): BOOLEAN is
		external
			"IL signature (System.Object, System.EventArgs): System.Boolean use System.Web.UI.Control"
		alias
			"OnBubbleEvent"
		end

	frozen get_is_tracking_view_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Control"
		alias
			"get_IsTrackingViewState"
		end

	on_load (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.Control"
		alias
			"OnLoad"
		end

	on_data_binding (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.Control"
		alias
			"OnDataBinding"
		end

	added_control (control: WEB_CONTROL; index: INTEGER) is
		external
			"IL signature (System.Web.UI.Control, System.Int32): System.Void use System.Web.UI.Control"
		alias
			"AddedControl"
		end

	load_view_state (saved_state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.Control"
		alias
			"LoadViewState"
		end

	frozen get_child_controls_created: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Control"
		alias
			"get_ChildControlsCreated"
		end

	on_init (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.Control"
		alias
			"OnInit"
		end

	save_view_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.Control"
		alias
			"SaveViewState"
		end

	on_unload (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.Control"
		alias
			"OnUnload"
		end

	ensure_child_controls is
		external
			"IL signature (): System.Void use System.Web.UI.Control"
		alias
			"EnsureChildControls"
		end

	get_view_state_ignores_case: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Control"
		alias
			"get_ViewStateIgnoresCase"
		end

	frozen system_web_ui_iparser_accessor_add_parsed_sub_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.Control"
		alias
			"System.Web.UI.IParserAccessor.AddParsedSubObject"
		end

	track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.Control"
		alias
			"TrackViewState"
		end

	get_view_state: WEB_STATE_BAG is
		external
			"IL signature (): System.Web.UI.StateBag use System.Web.UI.Control"
		alias
			"get_ViewState"
		end

	removed_control (control: WEB_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.Control"
		alias
			"RemovedControl"
		end

	frozen get_events: SYSTEM_DLL_EVENT_HANDLER_LIST is
		external
			"IL signature (): System.ComponentModel.EventHandlerList use System.Web.UI.Control"
		alias
			"get_Events"
		end

	create_child_controls is
		external
			"IL signature (): System.Void use System.Web.UI.Control"
		alias
			"CreateChildControls"
		end

	render_children (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.Control"
		alias
			"RenderChildren"
		end

	add_parsed_sub_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.Control"
		alias
			"AddParsedSubObject"
		end

	frozen raise_bubble_event (source: SYSTEM_OBJECT; args: EVENT_ARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Web.UI.Control"
		alias
			"RaiseBubbleEvent"
		end

	frozen set_child_controls_created (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.Control"
		alias
			"set_ChildControlsCreated"
		end

	frozen system_web_ui_idata_bindings_accessor_get_has_data_bindings: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Control"
		alias
			"System.Web.UI.IDataBindingsAccessor.get_HasDataBindings"
		end

	frozen clear_child_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.Control"
		alias
			"ClearChildViewState"
		end

	get_context: WEB_HTTP_CONTEXT is
		external
			"IL signature (): System.Web.HttpContext use System.Web.UI.Control"
		alias
			"get_Context"
		end

	frozen build_profile_tree (parent_id: SYSTEM_STRING; calc_view_state: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.UI.Control"
		alias
			"BuildProfileTree"
		end

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.Control"
		alias
			"OnPreRender"
		end

	frozen is_literal_content: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Control"
		alias
			"IsLiteralContent"
		end

end -- class WEB_CONTROL
