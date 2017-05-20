note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	WSF_FORM_FIELD_SET

inherit
	WSF_FORM_ITEM

	WSF_FORM_COMPOSITE

	WSF_WITH_CSS_ID

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			initialize_with_count (0)
		end

feature -- Access

	legend: detachable READABLE_STRING_8

	is_collapsible: BOOLEAN

feature -- Change

	set_legend (v: like legend)
		do
			legend := v
		end

	set_collapsible (b: BOOLEAN)
		do
			is_collapsible := b
			if b then
				add_css_class ("collapsible")
			else
				remove_css_class ("collapsible")
			end
		end

	set_collapsed (b: BOOLEAN)
		do
			if b then
				add_css_class ("collapsed")
			else
				remove_css_class ("collapsed")
			end
		end

feature -- Conversion

	append_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		do
			a_html.append ("<fieldset")
			append_css_class_to (a_html, Void)
			append_css_id_to (a_html)
			append_css_style_to (a_html)

			a_html.append (">%N")
			if attached legend as leg then
				a_html.append ("<legend>" + leg + "</legend>%N")
			end
			across
				items as c
			loop
				c.item.append_to_html (a_theme, a_html)
			end
			a_html.append ("%N</fieldset>%N")
		end

end
