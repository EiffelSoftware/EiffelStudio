indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.BasePartialCachingControl"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_BASE_PARTIAL_CACHING_CONTROL

inherit
	WEB_CONTROL
		redefine
			dispose,
			render,
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

feature -- Access

	frozen get_dependency: WEB_CACHE_DEPENDENCY is
		external
			"IL signature (): System.Web.Caching.CacheDependency use System.Web.UI.BasePartialCachingControl"
		alias
			"get_Dependency"
		end

feature -- Element Change

	frozen set_dependency (value: WEB_CACHE_DEPENDENCY) is
		external
			"IL signature (System.Web.Caching.CacheDependency): System.Void use System.Web.UI.BasePartialCachingControl"
		alias
			"set_Dependency"
		end

feature -- Basic Operations

	dispose is
		external
			"IL signature (): System.Void use System.Web.UI.BasePartialCachingControl"
		alias
			"Dispose"
		end

feature {NONE} -- Implementation

	on_init (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.BasePartialCachingControl"
		alias
			"OnInit"
		end

	render (output: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.BasePartialCachingControl"
		alias
			"Render"
		end

end -- class WEB_BASE_PARTIAL_CACHING_CONTROL
