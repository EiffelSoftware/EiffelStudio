indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.Page"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_PAGE

inherit
	WEB_TEMPLATE_CONTROL
		redefine
			set_visible,
			get_visible,
			set_enable_view_state,
			get_enable_view_state,
			set_id,
			get_id,
			get_context
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
	WEB_INAMING_CONTAINER
	WEB_IHTTP_HANDLER

create
	make_web_page

feature {NONE} -- Initialization

	frozen make_web_page is
		external
			"IL creator use System.Web.UI.Page"
		end

feature -- Access

	frozen get_is_post_back: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Page"
		alias
			"get_IsPostBack"
		end

	frozen get_server: WEB_HTTP_SERVER_UTILITY is
		external
			"IL signature (): System.Web.HttpServerUtility use System.Web.UI.Page"
		alias
			"get_Server"
		end

	frozen get_trace: WEB_TRACE_CONTEXT is
		external
			"IL signature (): System.Web.TraceContext use System.Web.UI.Page"
		alias
			"get_Trace"
		end

	frozen get_error_page: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.Page"
		alias
			"get_ErrorPage"
		end

	get_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Page"
		alias
			"get_Visible"
		end

	frozen get_smart_navigation: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Page"
		alias
			"get_SmartNavigation"
		end

	frozen get_user: IPRINCIPAL is
		external
			"IL signature (): System.Security.Principal.IPrincipal use System.Web.UI.Page"
		alias
			"get_User"
		end

	get_session: WEB_HTTP_SESSION_STATE is
		external
			"IL signature (): System.Web.SessionState.HttpSessionState use System.Web.UI.Page"
		alias
			"get_Session"
		end

	get_enable_view_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Page"
		alias
			"get_EnableViewState"
		end

	get_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.Page"
		alias
			"get_ID"
		end

	frozen get_application: WEB_HTTP_APPLICATION_STATE is
		external
			"IL signature (): System.Web.HttpApplicationState use System.Web.UI.Page"
		alias
			"get_Application"
		end

	frozen get_request: WEB_HTTP_REQUEST is
		external
			"IL signature (): System.Web.HttpRequest use System.Web.UI.Page"
		alias
			"get_Request"
		end

	frozen get_is_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Page"
		alias
			"get_IsValid"
		end

	frozen get_response: WEB_HTTP_RESPONSE is
		external
			"IL signature (): System.Web.HttpResponse use System.Web.UI.Page"
		alias
			"get_Response"
		end

	frozen get_cache: WEB_CACHE is
		external
			"IL signature (): System.Web.Caching.Cache use System.Web.UI.Page"
		alias
			"get_Cache"
		end

	frozen get_is_reusable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Page"
		alias
			"get_IsReusable"
		end

	frozen get_validators: WEB_VALIDATOR_COLLECTION is
		external
			"IL signature (): System.Web.UI.ValidatorCollection use System.Web.UI.Page"
		alias
			"get_Validators"
		end

	frozen get_client_target: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.Page"
		alias
			"get_ClientTarget"
		end

feature -- Element Change

	set_id (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.Page"
		alias
			"set_ID"
		end

	frozen set_smart_navigation (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.Page"
		alias
			"set_SmartNavigation"
		end

	set_enable_view_state (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.Page"
		alias
			"set_EnableViewState"
		end

	set_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.Page"
		alias
			"set_Visible"
		end

	frozen set_client_target (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.Page"
		alias
			"set_ClientTarget"
		end

	frozen set_error_page (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.Page"
		alias
			"set_ErrorPage"
		end

feature -- Basic Operations

	frozen map_path (virtual_path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.Page"
		alias
			"MapPath"
		end

	frozen get_post_back_client_event (control: WEB_CONTROL; argument: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.Web.UI.Control, System.String): System.String use System.Web.UI.Page"
		alias
			"GetPostBackClientEvent"
		end

	frozen register_requires_post_back (control: WEB_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.Page"
		alias
			"RegisterRequiresPostBack"
		end

	frozen is_startup_script_registered (key: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Web.UI.Page"
		alias
			"IsStartupScriptRegistered"
		end

	get_type_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.Page"
		alias
			"GetTypeHashCode"
		end

	verify_rendering_in_server_form (control: WEB_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.Page"
		alias
			"VerifyRenderingInServerForm"
		end

	register_hidden_field (hidden_field_name: SYSTEM_STRING; hidden_field_initial_value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.Page"
		alias
			"RegisterHiddenField"
		end

	register_startup_script (key: SYSTEM_STRING; script: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.Page"
		alias
			"RegisterStartupScript"
		end

	frozen get_post_back_event_reference (control: WEB_CONTROL): SYSTEM_STRING is
		external
			"IL signature (System.Web.UI.Control): System.String use System.Web.UI.Page"
		alias
			"GetPostBackEventReference"
		end

	frozen is_client_script_block_registered (key: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Web.UI.Page"
		alias
			"IsClientScriptBlockRegistered"
		end

	frozen register_array_declaration (array_name: SYSTEM_STRING; array_value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.Page"
		alias
			"RegisterArrayDeclaration"
		end

	frozen get_post_back_client_hyperlink (control: WEB_CONTROL; argument: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.Web.UI.Control, System.String): System.String use System.Web.UI.Page"
		alias
			"GetPostBackClientHyperlink"
		end

	frozen register_view_state_handler is
		external
			"IL signature (): System.Void use System.Web.UI.Page"
		alias
			"RegisterViewStateHandler"
		end

	frozen get_post_back_event_reference_control_string (control: WEB_CONTROL; argument: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.Web.UI.Control, System.String): System.String use System.Web.UI.Page"
		alias
			"GetPostBackEventReference"
		end

	frozen designer_initialize is
		external
			"IL signature (): System.Void use System.Web.UI.Page"
		alias
			"DesignerInitialize"
		end

	register_client_script_block (key: SYSTEM_STRING; script: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.Page"
		alias
			"RegisterClientScriptBlock"
		end

	frozen process_request (context: WEB_HTTP_CONTEXT) is
		external
			"IL signature (System.Web.HttpContext): System.Void use System.Web.UI.Page"
		alias
			"ProcessRequest"
		end

	validate is
		external
			"IL signature (): System.Void use System.Web.UI.Page"
		alias
			"Validate"
		end

	frozen register_on_submit_statement (key: SYSTEM_STRING; script: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.Page"
		alias
			"RegisterOnSubmitStatement"
		end

	register_requires_raise_event (control: WEB_IPOST_BACK_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.IPostBackEventHandler): System.Void use System.Web.UI.Page"
		alias
			"RegisterRequiresRaiseEvent"
		end

feature {NONE} -- Implementation

	save_page_state_to_persistence_medium (view_state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.Page"
		alias
			"SavePageStateToPersistenceMedium"
		end

	frozen set_file_dependencies (value: ARRAY_LIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use System.Web.UI.Page"
		alias
			"set_FileDependencies"
		end

	frozen set_lcid (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.Page"
		alias
			"set_LCID"
		end

	frozen set_transaction_mode (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.Page"
		alias
			"set_TransactionMode"
		end

	frozen set_content_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.Page"
		alias
			"set_ContentType"
		end

	raise_post_back_event (source_control: WEB_IPOST_BACK_EVENT_HANDLER; event_argument: SYSTEM_STRING) is
		external
			"IL signature (System.Web.UI.IPostBackEventHandler, System.String): System.Void use System.Web.UI.Page"
		alias
			"RaisePostBackEvent"
		end

	frozen set_enable_view_state_mac (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.Page"
		alias
			"set_EnableViewStateMac"
		end

	determine_post_back_mode: SYSTEM_DLL_NAME_VALUE_COLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Web.UI.Page"
		alias
			"DeterminePostBackMode"
		end

	frozen set_buffer (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.Page"
		alias
			"set_Buffer"
		end

	create_html_text_writer (tw: TEXT_WRITER): WEB_HTML_TEXT_WRITER is
		external
			"IL signature (System.IO.TextWriter): System.Web.UI.HtmlTextWriter use System.Web.UI.Page"
		alias
			"CreateHtmlTextWriter"
		end

	frozen set_trace_mode_value (value: WEB_TRACE_MODE) is
		external
			"IL signature (System.Web.TraceMode): System.Void use System.Web.UI.Page"
		alias
			"set_TraceModeValue"
		end

	frozen get_enable_view_state_mac: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.Page"
		alias
			"get_EnableViewStateMac"
		end

	frozen set_trace_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.Page"
		alias
			"set_TraceEnabled"
		end

	frozen set_response_encoding (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.Page"
		alias
			"set_ResponseEncoding"
		end

	frozen set_uiculture (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.Page"
		alias
			"set_UICulture"
		end

	get_context: WEB_HTTP_CONTEXT is
		external
			"IL signature (): System.Web.HttpContext use System.Web.UI.Page"
		alias
			"get_Context"
		end

	frozen asp_compat_end_process_request (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.Page"
		alias
			"AspCompatEndProcessRequest"
		end

	load_page_state_from_persistence_medium: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.Page"
		alias
			"LoadPageStateFromPersistenceMedium"
		end

	init_output_cache (duration: INTEGER; vary_by_header: SYSTEM_STRING; vary_by_custom: SYSTEM_STRING; location: WEB_OUTPUT_CACHE_LOCATION; vary_by_param: SYSTEM_STRING) is
		external
			"IL signature (System.Int32, System.String, System.String, System.Web.UI.OutputCacheLocation, System.String): System.Void use System.Web.UI.Page"
		alias
			"InitOutputCache"
		end

	frozen set_culture (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.Page"
		alias
			"set_Culture"
		end

	frozen set_code_page (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.Page"
		alias
			"set_CodePage"
		end

	frozen asp_compat_begin_process_request (context: WEB_HTTP_CONTEXT; cb: ASYNC_CALLBACK; extra_data: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Web.HttpContext, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.Page"
		alias
			"AspCompatBeginProcessRequest"
		end

	frozen set_asp_compat_mode (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.Page"
		alias
			"set_AspCompatMode"
		end

end -- class WEB_PAGE
