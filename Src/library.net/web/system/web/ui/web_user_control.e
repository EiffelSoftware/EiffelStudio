indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.UserControl"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_USER_CONTROL

inherit
	WEB_TEMPLATE_CONTROL
		redefine
			save_view_state,
			load_view_state,
			on_init
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
	WEB_IATTRIBUTE_ACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	WEB_IUSER_CONTROL_DESIGNER_ACCESSOR
		rename
			set_inner_text as system_web_ui_iuser_control_designer_accessor_set_inner_text,
			get_inner_text as system_web_ui_iuser_control_designer_accessor_get_inner_text,
			set_tag_name as system_web_ui_iuser_control_designer_accessor_set_tag_name,
			get_tag_name as system_web_ui_iuser_control_designer_accessor_get_tag_name
		end

create
	make_web_user_control

feature {NONE} -- Initialization

	frozen make_web_user_control is
		external
			"IL creator use System.Web.UI.UserControl"
		end

feature -- Access

	frozen get_is_post_back: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.UserControl"
		alias
			"get_IsPostBack"
		end

	frozen get_server: WEB_HTTP_SERVER_UTILITY is
		external
			"IL signature (): System.Web.HttpServerUtility use System.Web.UI.UserControl"
		alias
			"get_Server"
		end

	frozen get_response: WEB_HTTP_RESPONSE is
		external
			"IL signature (): System.Web.HttpResponse use System.Web.UI.UserControl"
		alias
			"get_Response"
		end

	frozen get_cache: WEB_CACHE is
		external
			"IL signature (): System.Web.Caching.Cache use System.Web.UI.UserControl"
		alias
			"get_Cache"
		end

	frozen get_application: WEB_HTTP_APPLICATION_STATE is
		external
			"IL signature (): System.Web.HttpApplicationState use System.Web.UI.UserControl"
		alias
			"get_Application"
		end

	frozen get_trace: WEB_TRACE_CONTEXT is
		external
			"IL signature (): System.Web.TraceContext use System.Web.UI.UserControl"
		alias
			"get_Trace"
		end

	frozen get_session: WEB_HTTP_SESSION_STATE is
		external
			"IL signature (): System.Web.SessionState.HttpSessionState use System.Web.UI.UserControl"
		alias
			"get_Session"
		end

	frozen get_attributes: WEB_ATTRIBUTE_COLLECTION is
		external
			"IL signature (): System.Web.UI.AttributeCollection use System.Web.UI.UserControl"
		alias
			"get_Attributes"
		end

	frozen get_request: WEB_HTTP_REQUEST is
		external
			"IL signature (): System.Web.HttpRequest use System.Web.UI.UserControl"
		alias
			"get_Request"
		end

feature -- Basic Operations

	frozen initialize_as_user_control (page: WEB_PAGE) is
		external
			"IL signature (System.Web.UI.Page): System.Void use System.Web.UI.UserControl"
		alias
			"InitializeAsUserControl"
		end

	frozen designer_initialize is
		external
			"IL signature (): System.Void use System.Web.UI.UserControl"
		alias
			"DesignerInitialize"
		end

	frozen map_path (virtual_path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.UserControl"
		alias
			"MapPath"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_iattribute_accessor_get_attribute (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.UserControl"
		alias
			"System.Web.UI.IAttributeAccessor.GetAttribute"
		end

	load_view_state (saved_state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.UserControl"
		alias
			"LoadViewState"
		end

	frozen system_web_ui_iattribute_accessor_set_attribute (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.UserControl"
		alias
			"System.Web.UI.IAttributeAccessor.SetAttribute"
		end

	frozen system_web_ui_iuser_control_designer_accessor_get_tag_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.UserControl"
		alias
			"System.Web.UI.IUserControlDesignerAccessor.get_TagName"
		end

	save_view_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.UserControl"
		alias
			"SaveViewState"
		end

	frozen system_web_ui_iuser_control_designer_accessor_set_tag_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.UserControl"
		alias
			"System.Web.UI.IUserControlDesignerAccessor.set_TagName"
		end

	frozen system_web_ui_iuser_control_designer_accessor_set_inner_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.UserControl"
		alias
			"System.Web.UI.IUserControlDesignerAccessor.set_InnerText"
		end

	frozen system_web_ui_iuser_control_designer_accessor_get_inner_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.UserControl"
		alias
			"System.Web.UI.IUserControlDesignerAccessor.get_InnerText"
		end

	on_init (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.UserControl"
		alias
			"OnInit"
		end

end -- class WEB_USER_CONTROL
