indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.PartialCachingControl"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_PARTIAL_CACHING_CONTROL

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

create {NONE}

feature -- Access

	frozen get_cached_control: WEB_CONTROL is
		external
			"IL signature (): System.Web.UI.Control use System.Web.UI.PartialCachingControl"
		alias
			"get_CachedControl"
		end

end -- class WEB_PARTIAL_CACHING_CONTROL
