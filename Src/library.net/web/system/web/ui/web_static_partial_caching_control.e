indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.StaticPartialCachingControl"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_STATIC_PARTIAL_CACHING_CONTROL

inherit
	WEB_BASE_PARTIAL_CACHING_CONTROL
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
	make_web_static_partial_caching_control

feature {NONE} -- Initialization

	frozen make_web_static_partial_caching_control (ctrl_id: SYSTEM_STRING; guid: SYSTEM_STRING; duration: INTEGER; vary_by_params: SYSTEM_STRING; vary_by_controls: SYSTEM_STRING; vary_by_custom: SYSTEM_STRING; build_method: WEB_BUILD_METHOD) is
		external
			"IL creator signature (System.String, System.String, System.Int32, System.String, System.String, System.String, System.Web.UI.BuildMethod) use System.Web.UI.StaticPartialCachingControl"
		end

feature -- Basic Operations

	frozen build_cached_control (parent: WEB_CONTROL; ctrl_id: SYSTEM_STRING; guid: SYSTEM_STRING; duration: INTEGER; vary_by_params: SYSTEM_STRING; vary_by_controls: SYSTEM_STRING; vary_by_custom: SYSTEM_STRING; build_method: WEB_BUILD_METHOD) is
		external
			"IL static signature (System.Web.UI.Control, System.String, System.String, System.Int32, System.String, System.String, System.String, System.Web.UI.BuildMethod): System.Void use System.Web.UI.StaticPartialCachingControl"
		alias
			"BuildCachedControl"
		end

end -- class WEB_STATIC_PARTIAL_CACHING_CONTROL
