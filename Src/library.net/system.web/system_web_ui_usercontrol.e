indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.UserControl"

external class
	SYSTEM_WEB_UI_USERCONTROL

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_TEMPLATECONTROL
		redefine
			save_view_state,
			load_view_state,
			on_init
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	SYSTEM_WEB_UI_INAMINGCONTAINER
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_ITEMPLATE

create
	make_usercontrol

feature {NONE} -- Initialization

	frozen make_usercontrol is
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

	frozen get_server: SYSTEM_WEB_HTTPSERVERUTILITY is
		external
			"IL signature (): System.Web.HttpServerUtility use System.Web.UI.UserControl"
		alias
			"get_Server"
		end

	frozen get_response: SYSTEM_WEB_HTTPRESPONSE is
		external
			"IL signature (): System.Web.HttpResponse use System.Web.UI.UserControl"
		alias
			"get_Response"
		end

	frozen get_cache: SYSTEM_WEB_CACHING_CACHE is
		external
			"IL signature (): System.Web.Caching.Cache use System.Web.UI.UserControl"
		alias
			"get_Cache"
		end

	frozen get_application: SYSTEM_WEB_HTTPAPPLICATIONSTATE is
		external
			"IL signature (): System.Web.HttpApplicationState use System.Web.UI.UserControl"
		alias
			"get_Application"
		end

	frozen get_trace: SYSTEM_WEB_TRACECONTEXT is
		external
			"IL signature (): System.Web.TraceContext use System.Web.UI.UserControl"
		alias
			"get_Trace"
		end

	frozen get_session: SYSTEM_WEB_SESSIONSTATE_HTTPSESSIONSTATE is
		external
			"IL signature (): System.Web.SessionState.HttpSessionState use System.Web.UI.UserControl"
		alias
			"get_Session"
		end

	frozen get_attributes: SYSTEM_WEB_UI_ATTRIBUTECOLLECTION is
		external
			"IL signature (): System.Web.UI.AttributeCollection use System.Web.UI.UserControl"
		alias
			"get_Attributes"
		end

	frozen get_request: SYSTEM_WEB_HTTPREQUEST is
		external
			"IL signature (): System.Web.HttpRequest use System.Web.UI.UserControl"
		alias
			"get_Request"
		end

feature -- Basic Operations

	frozen initialize_as_user_control (page: SYSTEM_WEB_UI_PAGE) is
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

	frozen map_path (virtual_path: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.UserControl"
		alias
			"MapPath"
		end

feature {NONE} -- Implementation

	load_view_state (saved_state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.UserControl"
		alias
			"LoadViewState"
		end

	on_init (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.UserControl"
		alias
			"OnInit"
		end

	frozen system_web_ui_iattribute_accessor_set_attribute (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.UserControl"
		alias
			"System.Web.UI.IAttributeAccessor.SetAttribute"
		end

	frozen system_web_ui_iattribute_accessor_get_attribute (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.UserControl"
		alias
			"System.Web.UI.IAttributeAccessor.GetAttribute"
		end

	save_view_state: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.UserControl"
		alias
			"SaveViewState"
		end

end -- class SYSTEM_WEB_UI_USERCONTROL
