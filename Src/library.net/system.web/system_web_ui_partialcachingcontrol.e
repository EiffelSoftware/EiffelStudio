indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.PartialCachingControl"

external class
	SYSTEM_WEB_UI_PARTIALCACHINGCONTROL

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_WEB_UI_BASEPARTIALCACHINGCONTROL
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create {NONE}

feature -- Access

	frozen get_cached_control: SYSTEM_WEB_UI_CONTROL is
		external
			"IL signature (): System.Web.UI.Control use System.Web.UI.PartialCachingControl"
		alias
			"get_CachedControl"
		end

end -- class SYSTEM_WEB_UI_PARTIALCACHINGCONTROL
