indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.StaticPartialCachingControl"

external class
	SYSTEM_WEB_UI_STATICPARTIALCACHINGCONTROL

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

create
	make_staticpartialcachingcontrol

feature {NONE} -- Initialization

	frozen make_staticpartialcachingcontrol (ctrl_id: STRING; guid: STRING; duration: INTEGER; vary_by_params: STRING; vary_by_controls: STRING; vary_by_custom: STRING; build_method: SYSTEM_WEB_UI_BUILDMETHOD) is
		external
			"IL creator signature (System.String, System.String, System.Int32, System.String, System.String, System.String, System.Web.UI.BuildMethod) use System.Web.UI.StaticPartialCachingControl"
		end

feature -- Basic Operations

	frozen build_cached_control (parent: SYSTEM_WEB_UI_CONTROL; ctrl_id: STRING; guid: STRING; duration: INTEGER; vary_by_params: STRING; vary_by_controls: STRING; vary_by_custom: STRING; build_method: SYSTEM_WEB_UI_BUILDMETHOD) is
		external
			"IL static signature (System.Web.UI.Control, System.String, System.String, System.Int32, System.String, System.String, System.String, System.Web.UI.BuildMethod): System.Void use System.Web.UI.StaticPartialCachingControl"
		alias
			"BuildCachedControl"
		end

end -- class SYSTEM_WEB_UI_STATICPARTIALCACHINGCONTROL
