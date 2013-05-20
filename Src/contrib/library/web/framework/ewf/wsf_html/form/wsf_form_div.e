note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	WSF_FORM_DIV

inherit
	WSF_FORM_ITEM

	WSF_FORM_COMPOSITE

	WSF_WITH_CSS_ID

create
	make,
	make_with_item,
	make_with_items,
	make_with_text,
	make_with_text_and_css_id,
	make_with_item_and_css_id

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			initialize_with_count (0)
		end

	make_with_text (s: READABLE_STRING_8)
		do
			make_with_item (create {WSF_FORM_RAW_TEXT}.make (s))
		end

	make_with_item (i: WSF_WIDGET)
		do
			initialize_with_count (1)
			extend (i)
		end

	make_with_items (it: ITERABLE [WSF_WIDGET])
		do
			initialize_with_count (2)
			across
				it as c
			loop
				extend (c.item)
			end
		end

	make_with_item_and_css_id (i: WSF_WIDGET; a_css_id: READABLE_STRING_8)
		do
			make_with_item (i)
			set_css_id (a_css_id)
		end

	make_with_text_and_css_id (s: READABLE_STRING_8; a_css_id: READABLE_STRING_8)
		do
			make_with_text (s)
			set_css_id (a_css_id)
		end

feature -- Conversion

	append_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		do
			a_html.append ("<div")
			append_css_class_to (a_html, Void)
			append_css_id_to (a_html)
			append_css_style_to (a_html)

			a_html.append (">%N")
			across
				items as c
			loop
				c.item.append_to_html (a_theme, a_html)
			end
			a_html.append ("%N</div>%N")
		end

end
