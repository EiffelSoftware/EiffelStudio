indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlTextWriter"

external class
	SYSTEM_WEB_UI_HTMLTEXTWRITER

inherit
	SYSTEM_IO_TEXTWRITER
		redefine
			write_line_string_array_object,
			write_line_string_object_object,
			write_line_string_object,
			write_line_object,
			write_line_string,
			write_line_double,
			write_line_single,
			write_line_int64,
			write_line_int32,
			write_line_boolean,
			write_line_array_char_int32,
			write_line_array_char,
			write_line_char,
			write_line,
			write_string_array_object,
			write_string_object_object,
			write_string_object,
			write_object,
			write_string,
			write_double,
			write_single,
			write,
			write_int32,
			write_boolean,
			write_array_char_int32,
			write_array_char,
			write_char,
			set_new_line,
			get_new_line,
			flush,
			close
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_htmltextwriter,
	make_htmltextwriter_1

feature {NONE} -- Initialization

	frozen make_htmltextwriter (writer: SYSTEM_IO_TEXTWRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.Web.UI.HtmlTextWriter"
		end

	frozen make_htmltextwriter_1 (writer: SYSTEM_IO_TEXTWRITER; tab_string: STRING) is
		external
			"IL creator signature (System.IO.TextWriter, System.String) use System.Web.UI.HtmlTextWriter"
		end

feature -- Access

	get_new_line: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"get_NewLine"
		end

	frozen tag_right_char: CHARACTER is '>'

	frozen equals_char: CHARACTER is '='

	frozen semicolon_char: CHARACTER is ';'

	frozen get_indent: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlTextWriter"
		alias
			"get_Indent"
		end

	frozen tag_left_char: CHARACTER is '<'

	frozen double_quote_char: CHARACTER is '"'

	frozen slash_char: CHARACTER is '/'

	frozen style_equals_char: CHARACTER is ':'

	get_encoding: SYSTEM_TEXT_ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Web.UI.HtmlTextWriter"
		alias
			"get_Encoding"
		end

	frozen single_quote_char: CHARACTER is '''

	frozen get_inner_writer: SYSTEM_IO_TEXTWRITER is
		external
			"IL signature (): System.IO.TextWriter use System.Web.UI.HtmlTextWriter"
		alias
			"get_InnerWriter"
		end

	frozen space_char: CHARACTER is ' '

feature -- Element Change

	set_new_line (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"set_NewLine"
		end

	frozen set_indent (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"set_Indent"
		end

	frozen set_inner_writer (value: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"set_InnerWriter"
		end

feature -- Basic Operations

	write_int32 (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	write_line_int64 (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	write_full_begin_tag (tag_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteFullBeginTag"
		end

	write_line is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	render_begin_tag (tag_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"RenderBeginTag"
		end

	write_line_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	write_attribute_string_string_boolean (name: STRING; value: STRING; f_encode: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Boolean): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteAttribute"
		end

	write_line_string_array_object (format: STRING; arg: ARRAY [ANY]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	write_string_array_object (format: STRING; arg: ARRAY [ANY]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	write_line_string_object_object (format: STRING; arg0: ANY; arg1: ANY) is
		external
			"IL signature (System.String, System.Object, System.Object): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	write_single (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	write_string (s: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	write_double (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	add_style_attribute (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"AddStyleAttribute"
		end

	write (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	write_line_string (s: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	write_line_single (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	write_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	add_attribute (key: SYSTEM_WEB_UI_HTMLTEXTWRITERATTRIBUTE; value: STRING) is
		external
			"IL signature (System.Web.UI.HtmlTextWriterAttribute, System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"AddAttribute"
		end

	add_attribute_html_text_writer_attribute_string_boolean (key: SYSTEM_WEB_UI_HTMLTEXTWRITERATTRIBUTE; value: STRING; f_encode: BOOLEAN) is
		external
			"IL signature (System.Web.UI.HtmlTextWriterAttribute, System.String, System.Boolean): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"AddAttribute"
		end

	render_end_tag is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"RenderEndTag"
		end

	write_string_object_object (format: STRING; arg0: ANY; arg1: ANY) is
		external
			"IL signature (System.String, System.Object, System.Object): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	close is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Close"
		end

	write_end_tag (tag_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteEndTag"
		end

	write_line_string_object (format: STRING; arg0: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	add_style_attribute_html_text_writer_style (key: SYSTEM_WEB_UI_HTMLTEXTWRITERSTYLE; value: STRING) is
		external
			"IL signature (System.Web.UI.HtmlTextWriterStyle, System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"AddStyleAttribute"
		end

	write_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	write_begin_tag (tag_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteBeginTag"
		end

	write_array_char_int32 (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	write_object (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	write_line_array_char (buffer: ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	write_line_int32 (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	add_attribute_string_string (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"AddAttribute"
		end

	write_line_array_char_int32 (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	add_attribute_string_string_boolean (name: STRING; value: STRING; f_endode: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Boolean): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"AddAttribute"
		end

	write_line_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	write_array_char (buffer: ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	render_begin_tag_html_text_writer_tag (tag_key: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG) is
		external
			"IL signature (System.Web.UI.HtmlTextWriterTag): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"RenderBeginTag"
		end

	write_style_attribute_string_string_boolean (name: STRING; value: STRING; f_encode: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Boolean): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteStyleAttribute"
		end

	write_string_object (format: STRING; arg0: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	write_line_double (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	frozen write_line_no_tabs (s: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLineNoTabs"
		end

	write_style_attribute (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteStyleAttribute"
		end

	write_line_object (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	flush is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Flush"
		end

	write_attribute (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteAttribute"
		end

feature {NONE} -- Implementation

	frozen encode_url (url: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"EncodeUrl"
		end

	get_tag_key_string (tag_name: STRING): SYSTEM_WEB_UI_HTMLTEXTWRITERTAG is
		external
			"IL signature (System.String): System.Web.UI.HtmlTextWriterTag use System.Web.UI.HtmlTextWriter"
		alias
			"GetTagKey"
		end

	frozen get_style_key (style_name: STRING): SYSTEM_WEB_UI_HTMLTEXTWRITERSTYLE is
		external
			"IL signature (System.String): System.Web.UI.HtmlTextWriterStyle use System.Web.UI.HtmlTextWriter"
		alias
			"GetStyleKey"
		end

	frozen get_attribute_name (attr_key: SYSTEM_WEB_UI_HTMLTEXTWRITERATTRIBUTE): STRING is
		external
			"IL signature (System.Web.UI.HtmlTextWriterAttribute): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"GetAttributeName"
		end

	add_attribute_string_string_html_text_writer_attribute (name: STRING; value: STRING; key: SYSTEM_WEB_UI_HTMLTEXTWRITERATTRIBUTE) is
		external
			"IL signature (System.String, System.String, System.Web.UI.HtmlTextWriterAttribute): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"AddAttribute"
		end

	frozen push_end_tag (end_tag: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"PushEndTag"
		end

	frozen register_style (name: STRING; key: SYSTEM_WEB_UI_HTMLTEXTWRITERSTYLE) is
		external
			"IL static signature (System.String, System.Web.UI.HtmlTextWriterStyle): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"RegisterStyle"
		end

	render_before_content: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"RenderBeforeContent"
		end

	on_tag_render (name: STRING; key: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG): BOOLEAN is
		external
			"IL signature (System.String, System.Web.UI.HtmlTextWriterTag): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"OnTagRender"
		end

	frozen set_tag_key (value: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG) is
		external
			"IL signature (System.Web.UI.HtmlTextWriterTag): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"set_TagKey"
		end

	frozen get_tag_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"get_TagName"
		end

	frozen register_tag (name: STRING; key: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG) is
		external
			"IL static signature (System.String, System.Web.UI.HtmlTextWriterTag): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"RegisterTag"
		end

	encode_attribute_value_html_text_writer_attribute (attr_key: SYSTEM_WEB_UI_HTMLTEXTWRITERATTRIBUTE; value: STRING): STRING is
		external
			"IL signature (System.Web.UI.HtmlTextWriterAttribute, System.String): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"EncodeAttributeValue"
		end

	add_style_attribute_string_string_html_text_writer_style (name: STRING; value: STRING; key: SYSTEM_WEB_UI_HTMLTEXTWRITERSTYLE) is
		external
			"IL signature (System.String, System.String, System.Web.UI.HtmlTextWriterStyle): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"AddStyleAttribute"
		end

	output_tabs is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"OutputTabs"
		end

	frozen is_style_attribute_defined_html_text_writer_style_string (key: SYSTEM_WEB_UI_HTMLTEXTWRITERSTYLE; value: STRING): BOOLEAN is
		external
			"IL signature (System.Web.UI.HtmlTextWriterStyle, System.String&): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"IsStyleAttributeDefined"
		end

	frozen is_style_attribute_defined (key: SYSTEM_WEB_UI_HTMLTEXTWRITERSTYLE): BOOLEAN is
		external
			"IL signature (System.Web.UI.HtmlTextWriterStyle): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"IsStyleAttributeDefined"
		end

	frozen get_tag_key: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG is
		external
			"IL signature (): System.Web.UI.HtmlTextWriterTag use System.Web.UI.HtmlTextWriter"
		alias
			"get_TagKey"
		end

	frozen is_attribute_defined_html_text_writer_attribute_string (key: SYSTEM_WEB_UI_HTMLTEXTWRITERATTRIBUTE; value: STRING): BOOLEAN is
		external
			"IL signature (System.Web.UI.HtmlTextWriterAttribute, System.String&): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"IsAttributeDefined"
		end

	frozen is_attribute_defined (key: SYSTEM_WEB_UI_HTMLTEXTWRITERATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.Web.UI.HtmlTextWriterAttribute): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"IsAttributeDefined"
		end

	render_before_tag: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"RenderBeforeTag"
		end

	frozen pop_end_tag: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"PopEndTag"
		end

	frozen get_style_name (style_key: SYSTEM_WEB_UI_HTMLTEXTWRITERSTYLE): STRING is
		external
			"IL signature (System.Web.UI.HtmlTextWriterStyle): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"GetStyleName"
		end

	frozen get_attribute_key (attr_name: STRING): SYSTEM_WEB_UI_HTMLTEXTWRITERATTRIBUTE is
		external
			"IL signature (System.String): System.Web.UI.HtmlTextWriterAttribute use System.Web.UI.HtmlTextWriter"
		alias
			"GetAttributeKey"
		end

	filter_attributes is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"FilterAttributes"
		end

	render_after_content: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"RenderAfterContent"
		end

	frozen set_tag_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"set_TagName"
		end

	frozen encode_attribute_value (value: STRING; f_encode: BOOLEAN): STRING is
		external
			"IL signature (System.String, System.Boolean): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"EncodeAttributeValue"
		end

	get_tag_name_html_text_writer_tag (tag_key: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG): STRING is
		external
			"IL signature (System.Web.UI.HtmlTextWriterTag): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"GetTagName"
		end

	render_after_tag: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"RenderAfterTag"
		end

	on_attribute_render (name: STRING; value: STRING; key: SYSTEM_WEB_UI_HTMLTEXTWRITERATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.String, System.String, System.Web.UI.HtmlTextWriterAttribute): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"OnAttributeRender"
		end

	frozen register_attribute (name: STRING; key: SYSTEM_WEB_UI_HTMLTEXTWRITERATTRIBUTE) is
		external
			"IL static signature (System.String, System.Web.UI.HtmlTextWriterAttribute): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"RegisterAttribute"
		end

	on_style_attribute_render (name: STRING; value: STRING; key: SYSTEM_WEB_UI_HTMLTEXTWRITERSTYLE): BOOLEAN is
		external
			"IL signature (System.String, System.String, System.Web.UI.HtmlTextWriterStyle): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"OnStyleAttributeRender"
		end

end -- class SYSTEM_WEB_UI_HTMLTEXTWRITER
