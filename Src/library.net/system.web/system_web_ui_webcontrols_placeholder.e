indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.PlaceHolder"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_PLACEHOLDER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_CONTROL
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_placeholder

feature {NONE} -- Initialization

	frozen make_placeholder is
		external
			"IL creator use System.Web.UI.WebControls.PlaceHolder"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_PLACEHOLDER
