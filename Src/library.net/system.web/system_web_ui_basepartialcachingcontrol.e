indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.BasePartialCachingControl"

deferred external class
	SYSTEM_WEB_UI_BASEPARTIALCACHINGCONTROL

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_CONTROL
		redefine
			render,
			on_init
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

feature -- Access

	frozen get_dependency: SYSTEM_WEB_CACHING_CACHEDEPENDENCY is
		external
			"IL signature (): System.Web.Caching.CacheDependency use System.Web.UI.BasePartialCachingControl"
		alias
			"get_Dependency"
		end

feature -- Element Change

	frozen set_dependency (value: SYSTEM_WEB_CACHING_CACHEDEPENDENCY) is
		external
			"IL signature (System.Web.Caching.CacheDependency): System.Void use System.Web.UI.BasePartialCachingControl"
		alias
			"set_Dependency"
		end

feature {NONE} -- Implementation

	on_init (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.BasePartialCachingControl"
		alias
			"OnInit"
		end

	render (output: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.BasePartialCachingControl"
		alias
			"Render"
		end

end -- class SYSTEM_WEB_UI_BASEPARTIALCACHINGCONTROL
