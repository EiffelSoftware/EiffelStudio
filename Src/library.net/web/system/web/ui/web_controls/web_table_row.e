indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.TableRow"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_TABLE_ROW

inherit
	WEB_WEB_CONTROL
		redefine
			create_control_style,
			create_control_collection
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
	WEB_IATTRIBUTE_ACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end

create
	make_web_table_row

feature {NONE} -- Initialization

	frozen make_web_table_row is
		external
			"IL creator use System.Web.UI.WebControls.TableRow"
		end

feature -- Access

	get_vertical_align: WEB_VERTICAL_ALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.VerticalAlign use System.Web.UI.WebControls.TableRow"
		alias
			"get_VerticalAlign"
		end

	get_horizontal_align: WEB_HORIZONTAL_ALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.HorizontalAlign use System.Web.UI.WebControls.TableRow"
		alias
			"get_HorizontalAlign"
		end

	get_cells: WEB_TABLE_CELL_COLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.TableCellCollection use System.Web.UI.WebControls.TableRow"
		alias
			"get_Cells"
		end

feature -- Element Change

	set_vertical_align (value: WEB_VERTICAL_ALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.VerticalAlign): System.Void use System.Web.UI.WebControls.TableRow"
		alias
			"set_VerticalAlign"
		end

	set_horizontal_align (value: WEB_HORIZONTAL_ALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.HorizontalAlign): System.Void use System.Web.UI.WebControls.TableRow"
		alias
			"set_HorizontalAlign"
		end

feature {NONE} -- Implementation

	create_control_style: WEB_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.TableRow"
		alias
			"CreateControlStyle"
		end

	create_control_collection: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.WebControls.TableRow"
		alias
			"CreateControlCollection"
		end

end -- class WEB_TABLE_ROW
