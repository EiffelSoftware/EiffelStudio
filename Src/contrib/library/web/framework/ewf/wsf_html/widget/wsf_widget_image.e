note
	description: "Summary description for {WSF_WIDGET_IMAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_WIDGET_IMAGE

inherit
	WSF_WIDGET

	WSF_WITH_CSS_ID

	WSF_WITH_CSS_CLASS

	WSF_WITH_CSS_STYLE

	WSF_WITH_HTML_ATTRIBUTE

create
	make

feature {NONE} -- Initialization

	make (a_src: READABLE_STRING_8)
		do
			src := a_src
		end

feature -- Access

	src: READABLE_STRING_8
			-- `src` html attribute.


	alt: detachable READABLE_STRING_8
			-- Alternate text for Current image.	

	width: detachable READABLE_STRING_8
			-- Optional width value.

	height: detachable READABLE_STRING_8
			-- Optional height value.

feature -- Change

	set_src (v: like src)
		do
			src := v
		end

	set_alt (v: like alt)
		do
			alt := v
		end

	set_width (v: like width)
		do
			width := v
		end

	set_height (v: like height)
		do
			height := v
		end

feature -- Conversion		

	append_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		do
			a_html.append ("<img src=%"")
			a_html.append (src)
			a_html.append ("%"")
			if attached alt as l_alt then
				a_html.append (" alt=%"")
				a_html.append (l_alt)
				a_html.append ("%"")
			end
			if attached width as w then
				a_html.append (" width=%"")
				a_html.append (w)
				a_html.append ("%"")
			end
			if attached height as h then
				a_html.append (" height=%"")
				a_html.append (h)
				a_html.append ("%"")
			end
			append_css_id_to (a_html)
			append_css_style_to (a_html)
			append_css_class_to (a_html, css_classes)
			append_html_attributes_to (a_html)
			a_html.append ("/>")
		end

end
