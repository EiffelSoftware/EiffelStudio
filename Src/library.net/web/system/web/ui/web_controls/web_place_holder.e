indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.PlaceHolder"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_PLACE_HOLDER

inherit
	WEB_CONTROL
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
	make_web_place_holder

feature {NONE} -- Initialization

	frozen make_web_place_holder is
		external
			"IL creator use System.Web.UI.WebControls.PlaceHolder"
		end

end -- class WEB_PLACE_HOLDER
