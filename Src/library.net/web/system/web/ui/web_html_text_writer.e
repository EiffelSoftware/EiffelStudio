indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlTextWriter"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML_TEXT_WRITER

inherit
	TEXT_WRITER
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
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_web_html_text_writer,
	make_web_html_text_writer_1

feature {NONE} -- Initialization

	frozen make_web_html_text_writer (writer: TEXT_WRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.Web.UI.HtmlTextWriter"
		end

	frozen make_web_html_text_writer_1 (writer: TEXT_WRITER; tab_string: SYSTEM_STRING) is
		external
			"IL creator signature (System.IO.TextWriter, System.String) use System.Web.UI.HtmlTextWriter"
		end

feature -- Access

--	frozen default_tab_string: SYSTEM_STRING is "	"

	get_new_line: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"get_NewLine"
		end

	frozen tag_right_char: CHARACTER is '>'

	frozen equals_char: CHARACTER is '='

	frozen semicolon_char: CHARACTER is ';'

--	frozen self_closing_tag_end: SYSTEM_STRING is " />"

	frozen get_indent: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlTextWriter"
		alias
			"get_Indent"
		end

	frozen tag_left_char: CHARACTER is '<'

--	frozen self_closing_chars: SYSTEM_STRING is " /"

--	frozen equals_double_quote_string: SYSTEM_STRING is "=""

--	frozen end_tag_left_chars: SYSTEM_STRING is "</"

	frozen double_quote_char: CHARACTER is '"'

	frozen slash_char: CHARACTER is '/'

	frozen style_equals_char: CHARACTER is ':'

	get_encoding: ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Web.UI.HtmlTextWriter"
		alias
			"get_Encoding"
		end

	frozen single_quote_char: CHARACTER is '''

	frozen get_inner_writer: TEXT_WRITER is
		external
			"IL signature (): System.IO.TextWriter use System.Web.UI.HtmlTextWriter"
		alias
			"get_InnerWriter"
		end

	frozen space_char: CHARACTER is ' '

feature -- Element Change

	set_new_line (value: SYSTEM_STRING) is
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

	frozen set_inner_writer (value: TEXT_WRITER) is
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

	write_full_begin_tag (tag_name: SYSTEM_STRING) is
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

	render_begin_tag (tag_name: SYSTEM_STRING) is
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

	write_attribute_string_string_boolean (name: SYSTEM_STRING; value: SYSTEM_STRING; f_encode: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Boolean): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteAttribute"
		end

	write_line_string_array_object (format: SYSTEM_STRING; arg: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	write_string_array_object (format: SYSTEM_STRING; arg: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	write_line_string_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT) is
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

	write_string (s: SYSTEM_STRING) is
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

	add_style_attribute (name: SYSTEM_STRING; value: SYSTEM_STRING) is
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

	write_line_string (s: SYSTEM_STRING) is
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

	add_attribute (key: WEB_HTML_TEXT_WRITER_ATTRIBUTE; value: SYSTEM_STRING) is
		external
			"IL signature (System.Web.UI.HtmlTextWriterAttribute, System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"AddAttribute"
		end

	add_attribute_html_text_writer_attribute_string_boolean (key: WEB_HTML_TEXT_WRITER_ATTRIBUTE; value: SYSTEM_STRING; f_encode: BOOLEAN) is
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

	write_string_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT) is
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

	write_end_tag (tag_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteEndTag"
		end

	write_line_string_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	add_style_attribute_html_text_writer_style (key: WEB_HTML_TEXT_WRITER_STYLE; value: SYSTEM_STRING) is
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

	write_begin_tag (tag_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteBeginTag"
		end

	write_array_char_int32 (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	write_object (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	write_line_array_char (buffer: NATIVE_ARRAY [CHARACTER]) is
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

	add_attribute_string_string (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"AddAttribute"
		end

	write_line_array_char_int32 (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLine"
		end

	add_attribute_string_string_boolean (name: SYSTEM_STRING; value: SYSTEM_STRING; f_endode: BOOLEAN) is
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

	write_array_char (buffer: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"Write"
		end

	render_begin_tag_html_text_writer_tag (tag_key: WEB_HTML_TEXT_WRITER_TAG) is
		external
			"IL signature (System.Web.UI.HtmlTextWriterTag): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"RenderBeginTag"
		end

	write_style_attribute_string_string_boolean (name: SYSTEM_STRING; value: SYSTEM_STRING; f_encode: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Boolean): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteStyleAttribute"
		end

	write_string_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT) is
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

	frozen write_line_no_tabs (s: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteLineNoTabs"
		end

	write_style_attribute (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteStyleAttribute"
		end

	write_line_object (value: SYSTEM_OBJECT) is
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

	write_attribute (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"WriteAttribute"
		end

feature {NONE} -- Implementation

	frozen encode_url (url: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"EncodeUrl"
		end

	get_tag_key_string (tag_name: SYSTEM_STRING): WEB_HTML_TEXT_WRITER_TAG is
		external
			"IL signature (System.String): System.Web.UI.HtmlTextWriterTag use System.Web.UI.HtmlTextWriter"
		alias
			"GetTagKey"
		end

	frozen get_style_key (style_name: SYSTEM_STRING): WEB_HTML_TEXT_WRITER_STYLE is
		external
			"IL signature (System.String): System.Web.UI.HtmlTextWriterStyle use System.Web.UI.HtmlTextWriter"
		alias
			"GetStyleKey"
		end

	frozen get_attribute_name (attr_key: WEB_HTML_TEXT_WRITER_ATTRIBUTE): SYSTEM_STRING is
		external
			"IL signature (System.Web.UI.HtmlTextWriterAttribute): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"GetAttributeName"
		end

	add_attribute_string_string_html_text_writer_attribute (name: SYSTEM_STRING; value: SYSTEM_STRING; key: WEB_HTML_TEXT_WRITER_ATTRIBUTE) is
		external
			"IL signature (System.String, System.String, System.Web.UI.HtmlTextWriterAttribute): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"AddAttribute"
		end

	frozen push_end_tag (end_tag: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"PushEndTag"
		end

	frozen register_style (name: SYSTEM_STRING; key: WEB_HTML_TEXT_WRITER_STYLE) is
		external
			"IL static signature (System.String, System.Web.UI.HtmlTextWriterStyle): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"RegisterStyle"
		end

	render_before_content: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"RenderBeforeContent"
		end

	on_tag_render (name: SYSTEM_STRING; key: WEB_HTML_TEXT_WRITER_TAG): BOOLEAN is
		external
			"IL signature (System.String, System.Web.UI.HtmlTextWriterTag): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"OnTagRender"
		end

	frozen set_tag_key (value: WEB_HTML_TEXT_WRITER_TAG) is
		external
			"IL signature (System.Web.UI.HtmlTextWriterTag): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"set_TagKey"
		end

	frozen get_tag_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"get_TagName"
		end

	frozen register_tag (name: SYSTEM_STRING; key: WEB_HTML_TEXT_WRITER_TAG) is
		external
			"IL static signature (System.String, System.Web.UI.HtmlTextWriterTag): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"RegisterTag"
		end

	encode_attribute_value_html_text_writer_attribute (attr_key: WEB_HTML_TEXT_WRITER_ATTRIBUTE; value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.Web.UI.HtmlTextWriterAttribute, System.String): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"EncodeAttributeValue"
		end

	add_style_attribute_string_string_html_text_writer_style (name: SYSTEM_STRING; value: SYSTEM_STRING; key: WEB_HTML_TEXT_WRITER_STYLE) is
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

	frozen is_style_attribute_defined_html_text_writer_style_string (key: WEB_HTML_TEXT_WRITER_STYLE; value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.Web.UI.HtmlTextWriterStyle, System.String&): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"IsStyleAttributeDefined"
		end

	frozen is_style_attribute_defined (key: WEB_HTML_TEXT_WRITER_STYLE): BOOLEAN is
		external
			"IL signature (System.Web.UI.HtmlTextWriterStyle): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"IsStyleAttributeDefined"
		end

	frozen get_tag_key: WEB_HTML_TEXT_WRITER_TAG is
		external
			"IL signature (): System.Web.UI.HtmlTextWriterTag use System.Web.UI.HtmlTextWriter"
		alias
			"get_TagKey"
		end

	frozen is_attribute_defined_html_text_writer_attribute_string (key: WEB_HTML_TEXT_WRITER_ATTRIBUTE; value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.Web.UI.HtmlTextWriterAttribute, System.String&): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"IsAttributeDefined"
		end

	frozen is_attribute_defined (key: WEB_HTML_TEXT_WRITER_ATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.Web.UI.HtmlTextWriterAttribute): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"IsAttributeDefined"
		end

	render_before_tag: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"RenderBeforeTag"
		end

	frozen pop_end_tag: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"PopEndTag"
		end

	frozen get_style_name (style_key: WEB_HTML_TEXT_WRITER_STYLE): SYSTEM_STRING is
		external
			"IL signature (System.Web.UI.HtmlTextWriterStyle): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"GetStyleName"
		end

	frozen get_attribute_key (attr_name: SYSTEM_STRING): WEB_HTML_TEXT_WRITER_ATTRIBUTE is
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

	render_after_content: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"RenderAfterContent"
		end

	frozen set_tag_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"set_TagName"
		end

	frozen encode_attribute_value (value: SYSTEM_STRING; f_encode: BOOLEAN): SYSTEM_STRING is
		external
			"IL signature (System.String, System.Boolean): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"EncodeAttributeValue"
		end

	get_tag_name_html_text_writer_tag (tag_key: WEB_HTML_TEXT_WRITER_TAG): SYSTEM_STRING is
		external
			"IL signature (System.Web.UI.HtmlTextWriterTag): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"GetTagName"
		end

	render_after_tag: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlTextWriter"
		alias
			"RenderAfterTag"
		end

	on_attribute_render (name: SYSTEM_STRING; value: SYSTEM_STRING; key: WEB_HTML_TEXT_WRITER_ATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.String, System.String, System.Web.UI.HtmlTextWriterAttribute): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"OnAttributeRender"
		end

	frozen register_attribute (name: SYSTEM_STRING; key: WEB_HTML_TEXT_WRITER_ATTRIBUTE) is
		external
			"IL static signature (System.String, System.Web.UI.HtmlTextWriterAttribute): System.Void use System.Web.UI.HtmlTextWriter"
		alias
			"RegisterAttribute"
		end

	on_style_attribute_render (name: SYSTEM_STRING; value: SYSTEM_STRING; key: WEB_HTML_TEXT_WRITER_STYLE): BOOLEAN is
		external
			"IL signature (System.String, System.String, System.Web.UI.HtmlTextWriterStyle): System.Boolean use System.Web.UI.HtmlTextWriter"
		alias
			"OnStyleAttributeRender"
		end

end -- class WEB_HTML_TEXT_WRITER
