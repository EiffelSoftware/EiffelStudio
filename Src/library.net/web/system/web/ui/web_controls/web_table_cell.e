indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.TableCell"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_TABLE_CELL

inherit
	WEB_WEB_CONTROL
		redefine
			render_contents,
			create_control_style,
			add_attributes_to_render,
			add_parsed_sub_object
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
	make_web_table_cell

feature {NONE} -- Initialization

	frozen make_web_table_cell is
		external
			"IL creator use System.Web.UI.WebControls.TableCell"
		end

feature -- Access

	get_horizontal_align: WEB_HORIZONTAL_ALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.HorizontalAlign use System.Web.UI.WebControls.TableCell"
		alias
			"get_HorizontalAlign"
		end

	get_row_span: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.TableCell"
		alias
			"get_RowSpan"
		end

	get_vertical_align: WEB_VERTICAL_ALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.VerticalAlign use System.Web.UI.WebControls.TableCell"
		alias
			"get_VerticalAlign"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.TableCell"
		alias
			"get_Text"
		end

	get_column_span: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.TableCell"
		alias
			"get_ColumnSpan"
		end

	get_wrap: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TableCell"
		alias
			"get_Wrap"
		end

feature -- Element Change

	set_wrap (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"set_Wrap"
		end

	set_column_span (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"set_ColumnSpan"
		end

	set_vertical_align (value: WEB_VERTICAL_ALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.VerticalAlign): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"set_VerticalAlign"
		end

	set_horizontal_align (value: WEB_HORIZONTAL_ALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.HorizontalAlign): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"set_HorizontalAlign"
		end

	set_row_span (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"set_RowSpan"
		end

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"set_Text"
		end

feature {NONE} -- Implementation

	create_control_style: WEB_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.TableCell"
		alias
			"CreateControlStyle"
		end

	render_contents (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"RenderContents"
		end

	add_parsed_sub_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"AddParsedSubObject"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"AddAttributesToRender"
		end

end -- class WEB_TABLE_CELL
