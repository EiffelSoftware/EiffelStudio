indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.Html32TextWriter"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML32_TEXT_WRITER

inherit
	WEB_HTML_TEXT_WRITER
		redefine
			render_after_tag,
			render_after_content,
			render_before_content,
			render_before_tag,
			render_end_tag,
			render_begin_tag_html_text_writer_tag,
			on_tag_render,
			on_style_attribute_render,
			get_tag_name_html_text_writer_tag
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_web_html32_text_writer,
	make_web_html32_text_writer_1

feature {NONE} -- Initialization

	frozen make_web_html32_text_writer (writer: TEXT_WRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.Web.UI.Html32TextWriter"
		end

	frozen make_web_html32_text_writer_1 (writer: TEXT_WRITER; tab_string: SYSTEM_STRING) is
		external
			"IL creator signature (System.IO.TextWriter, System.String) use System.Web.UI.Html32TextWriter"
		end

feature -- Basic Operations

	render_end_tag is
		external
			"IL signature (): System.Void use System.Web.UI.Html32TextWriter"
		alias
			"RenderEndTag"
		end

	render_begin_tag_html_text_writer_tag (tag_key: WEB_HTML_TEXT_WRITER_TAG) is
		external
			"IL signature (System.Web.UI.HtmlTextWriterTag): System.Void use System.Web.UI.Html32TextWriter"
		alias
			"RenderBeginTag"
		end

feature {NONE} -- Implementation

	get_tag_name_html_text_writer_tag (tag_key: WEB_HTML_TEXT_WRITER_TAG): SYSTEM_STRING is
		external
			"IL signature (System.Web.UI.HtmlTextWriterTag): System.String use System.Web.UI.Html32TextWriter"
		alias
			"GetTagName"
		end

	render_before_content: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.Html32TextWriter"
		alias
			"RenderBeforeContent"
		end

	on_style_attribute_render (name: SYSTEM_STRING; value: SYSTEM_STRING; key: WEB_HTML_TEXT_WRITER_STYLE): BOOLEAN is
		external
			"IL signature (System.String, System.String, System.Web.UI.HtmlTextWriterStyle): System.Boolean use System.Web.UI.Html32TextWriter"
		alias
			"OnStyleAttributeRender"
		end

	frozen get_font_stack: SYSTEM_STACK is
		external
			"IL signature (): System.Collections.Stack use System.Web.UI.Html32TextWriter"
		alias
			"get_FontStack"
		end

	render_before_tag: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.Html32TextWriter"
		alias
			"RenderBeforeTag"
		end

	on_tag_render (name: SYSTEM_STRING; key: WEB_HTML_TEXT_WRITER_TAG): BOOLEAN is
		external
			"IL signature (System.String, System.Web.UI.HtmlTextWriterTag): System.Boolean use System.Web.UI.Html32TextWriter"
		alias
			"OnTagRender"
		end

	render_after_content: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.Html32TextWriter"
		alias
			"RenderAfterContent"
		end

	render_after_tag: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.Html32TextWriter"
		alias
			"RenderAfterTag"
		end

end -- class WEB_HTML32_TEXT_WRITER
