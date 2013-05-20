note
	description: "Summary description for {WSF_WIDGET_TABLE_ROW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_WIDGET_TABLE_ROW

inherit
	WSF_WITH_CSS_CLASS

	WSF_WITH_CSS_STYLE

	ITERABLE [WSF_WIDGET_TABLE_ITEM]

create
	make,
	make_with_items

feature {NONE} -- Initialization

	make (n: INTEGER)
		do
			create items.make (n)
		end

	make_with_items (lst: ITERABLE [WSF_WIDGET_TABLE_ITEM])
		local
			n: INTEGER
		do
			across lst as c loop
				n := n + 1
			end
			make (n)
			across
				lst as c
			loop
				add_item (c.item)
			end
		end

	items: ARRAYED_LIST [WSF_WIDGET_TABLE_ITEM]

feature -- Access

	new_cursor: ITERATION_CURSOR [WSF_WIDGET_TABLE_ITEM]
		do
			Result := items.new_cursor
		end

	count: INTEGER
		do
			Result := items.count
		end

	item (c: INTEGER): WSF_WIDGET_TABLE_ITEM
		do
			Result := items [c]
		end

feature -- Change

	set_item (w: WSF_WIDGET_TABLE_ITEM; col: INTEGER)
		do
			if col > items.count then
				items.grow (col)
				from
				until
					items.count >= col - 1
				loop
					items.force (create {WSF_WIDGET_TABLE_ITEM}.make_with_text (""))
				end
				items.force (w)
			else
				items.put_i_th (w, col)
			end
		end

	add_widget (w: WSF_WIDGET)
		do
			add_item (create {WSF_WIDGET_TABLE_ITEM}.make_with_content (w))
		end

	force, add_item (w: WSF_WIDGET_TABLE_ITEM)
		do
			items.force (w)
		end

feature -- Conversion

	append_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		do
			a_html.append ("<tr")
			append_css_class_to (a_html, Void)
			append_css_style_to (a_html)
			a_html.append_character ('>')
			across
				items as c
			loop
				c.item.append_to_html (a_theme, a_html)
			end
			a_html.append ("</tr>")
		end

end
