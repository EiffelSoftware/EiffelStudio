indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.Html32TextWriter"

external class
	SYSTEM_WEB_UI_HTML32TEXTWRITER

inherit
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end
	SYSTEM_WEB_UI_HTMLTEXTWRITER
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

create
	make_html32textwriter_1,
	make_html32textwriter

feature {NONE} -- Initialization

	frozen make_html32textwriter_1 (writer: SYSTEM_IO_TEXTWRITER; tab_string: STRING) is
		external
			"IL creator signature (System.IO.TextWriter, System.String) use System.Web.UI.Html32TextWriter"
		end

	frozen make_html32textwriter (writer: SYSTEM_IO_TEXTWRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.Web.UI.Html32TextWriter"
		end

feature -- Basic Operations

	render_end_tag is
		external
			"IL signature (): System.Void use System.Web.UI.Html32TextWriter"
		alias
			"RenderEndTag"
		end

	render_begin_tag_html_text_writer_tag (tag_key: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG) is
		external
			"IL signature (System.Web.UI.HtmlTextWriterTag): System.Void use System.Web.UI.Html32TextWriter"
		alias
			"RenderBeginTag"
		end

feature {NONE} -- Implementation

	get_tag_name_html_text_writer_tag (tag_key: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG): STRING is
		external
			"IL signature (System.Web.UI.HtmlTextWriterTag): System.String use System.Web.UI.Html32TextWriter"
		alias
			"GetTagName"
		end

	render_before_content: STRING is
		external
			"IL signature (): System.String use System.Web.UI.Html32TextWriter"
		alias
			"RenderBeforeContent"
		end

	on_style_attribute_render (name: STRING; value: STRING; key: SYSTEM_WEB_UI_HTMLTEXTWRITERSTYLE): BOOLEAN is
		external
			"IL signature (System.String, System.String, System.Web.UI.HtmlTextWriterStyle): System.Boolean use System.Web.UI.Html32TextWriter"
		alias
			"OnStyleAttributeRender"
		end

	frozen get_font_stack: SYSTEM_COLLECTIONS_STACK is
		external
			"IL signature (): System.Collections.Stack use System.Web.UI.Html32TextWriter"
		alias
			"get_FontStack"
		end

	render_before_tag: STRING is
		external
			"IL signature (): System.String use System.Web.UI.Html32TextWriter"
		alias
			"RenderBeforeTag"
		end

	on_tag_render (name: STRING; key: SYSTEM_WEB_UI_HTMLTEXTWRITERTAG): BOOLEAN is
		external
			"IL signature (System.String, System.Web.UI.HtmlTextWriterTag): System.Boolean use System.Web.UI.Html32TextWriter"
		alias
			"OnTagRender"
		end

	render_after_content: STRING is
		external
			"IL signature (): System.String use System.Web.UI.Html32TextWriter"
		alias
			"RenderAfterContent"
		end

	render_after_tag: STRING is
		external
			"IL signature (): System.String use System.Web.UI.Html32TextWriter"
		alias
			"RenderAfterTag"
		end

end -- class SYSTEM_WEB_UI_HTML32TEXTWRITER
