indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.TableRow"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_TABLEROW

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			create_control_style,
			create_control_collection
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_tablerow

feature {NONE} -- Initialization

	frozen make_tablerow is
		external
			"IL creator use System.Web.UI.WebControls.TableRow"
		end

feature -- Access

	get_vertical_align: SYSTEM_WEB_UI_WEBCONTROLS_VERTICALALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.VerticalAlign use System.Web.UI.WebControls.TableRow"
		alias
			"get_VerticalAlign"
		end

	get_horizontal_align: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.HorizontalAlign use System.Web.UI.WebControls.TableRow"
		alias
			"get_HorizontalAlign"
		end

	get_cells: SYSTEM_WEB_UI_WEBCONTROLS_TABLECELLCOLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.TableCellCollection use System.Web.UI.WebControls.TableRow"
		alias
			"get_Cells"
		end

feature -- Element Change

	set_vertical_align (value: SYSTEM_WEB_UI_WEBCONTROLS_VERTICALALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.VerticalAlign): System.Void use System.Web.UI.WebControls.TableRow"
		alias
			"set_VerticalAlign"
		end

	set_horizontal_align (value: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.HorizontalAlign): System.Void use System.Web.UI.WebControls.TableRow"
		alias
			"set_HorizontalAlign"
		end

feature {NONE} -- Implementation

	create_control_style: SYSTEM_WEB_UI_WEBCONTROLS_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.TableRow"
		alias
			"CreateControlStyle"
		end

	create_control_collection: SYSTEM_WEB_UI_CONTROLCOLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.WebControls.TableRow"
		alias
			"CreateControlCollection"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_TABLEROW
