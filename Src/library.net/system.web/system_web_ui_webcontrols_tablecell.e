indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.TableCell"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_TABLECELL

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			render_contents,
			create_control_style,
			add_attributes_to_render,
			add_parsed_sub_object
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
	make_tablecell

feature {NONE} -- Initialization

	frozen make_tablecell is
		external
			"IL creator use System.Web.UI.WebControls.TableCell"
		end

feature -- Access

	get_horizontal_align: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN is
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

	get_vertical_align: SYSTEM_WEB_UI_WEBCONTROLS_VERTICALALIGN is
		external
			"IL signature (): System.Web.UI.WebControls.VerticalAlign use System.Web.UI.WebControls.TableCell"
		alias
			"get_VerticalAlign"
		end

	get_text: STRING is
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

	set_vertical_align (value: SYSTEM_WEB_UI_WEBCONTROLS_VERTICALALIGN) is
		external
			"IL signature (System.Web.UI.WebControls.VerticalAlign): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"set_VerticalAlign"
		end

	set_horizontal_align (value: SYSTEM_WEB_UI_WEBCONTROLS_HORIZONTALALIGN) is
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

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"set_Text"
		end

feature {NONE} -- Implementation

	create_control_style: SYSTEM_WEB_UI_WEBCONTROLS_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.Style use System.Web.UI.WebControls.TableCell"
		alias
			"CreateControlStyle"
		end

	render_contents (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"RenderContents"
		end

	add_parsed_sub_object (obj: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"AddParsedSubObject"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.TableCell"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_TABLECELL
