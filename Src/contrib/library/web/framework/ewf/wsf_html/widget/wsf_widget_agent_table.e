note
	description: "Summary description for {WSF_WIDGET_TABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_WIDGET_AGENT_TABLE [G -> detachable ANY]

inherit
	WSF_WIDGET

	WSF_WITH_CSS_ID

	WSF_WITH_CSS_CLASS

	WSF_WITH_CSS_STYLE

create
	make

convert
	to_computed_table: {WSF_WIDGET_TABLE}

feature {NONE} -- Initialization

	make
		do
			create columns.make_empty
		end

feature -- Access

	column_count: INTEGER
		do
			Result := columns.count
		end

	columns: ARRAY [WSF_WIDGET_TABLE_COLUMN]

	column (c: INTEGER): WSF_WIDGET_TABLE_COLUMN
		do
			if c > column_count then
				set_column_count (c)
			end
			Result := columns[c]
		end

	has_title: BOOLEAN
		do
			Result := across columns as c some c.item.title /= Void end
		end

	head_data: detachable ITERABLE [G]
			-- thead

	foot_data: detachable ITERABLE [G]
			-- tfoot

	data: detachable ITERABLE [G]
			-- tbody

	compute_item_function: detachable FUNCTION [G, WSF_WIDGET_TABLE_ROW]

feature -- Change

	set_head_data (d: like head_data)
		do
			head_data := d
		end

	set_foot_data (d: like foot_data)
		do
			foot_data := d
		end

	set_data (d: like data)
		do
			data := d
		end

	set_compute_item_function (fct: like compute_item_function)
		do
			compute_item_function := fct
		end

	set_column_count (nb: INTEGER)
		do
			if nb > columns.count then
--				columns.conservative_resize_with_default (create {WSF_WIDGET_TABLE_COLUMN}, 1, nb)
				from
				until
					columns.count = nb
				loop
					columns.force (create {WSF_WIDGET_TABLE_COLUMN}.make (columns.upper + 1), columns.upper + 1)
				end
			else
				columns.remove_tail (columns.count - nb)
			end
		end

	set_column_title (c: INTEGER; t: READABLE_STRING_32)
		do
			if c > column_count then
				set_column_count (c)
			end
			if attached column (c) as col then
				col.set_title (t)
			end
		end

feature -- Conversion

	to_computed_table: WSF_WIDGET_TABLE
		local
			col: WSF_WIDGET_TABLE_COLUMN
		do
			create Result.make
			Result.set_column_count (column_count)
				-- css classes
			Result.add_css_classes (css_classes)
				-- css id
			Result.set_css_id (css_id)
				-- css style
			Result.add_css_style (css_style)

				-- columns
			across
				columns as c
			loop
				col := Result.column (c.item.index)
				col.set_title (c.item.title)
				col.add_css_style (c.item.css_style)
				col.add_css_classes (c.item.css_classes)
			end

				-- rows
			if attached compute_item_function as fct then
				if attached head_data as lst then
					across lst as d loop
						Result.add_head_row (fct.item ([d.item]))
					end
				end
				if attached data as lst then
					across lst as d loop
						Result.add_row (fct.item ([d.item]))
					end
				end
				if attached foot_data as lst then
					across lst as d loop
						Result.add_foot_row (fct.item ([d.item]))
					end
				end
			end
		end

feature -- Conversion: HTML

	append_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		local
			l_use_tbody: BOOLEAN
		do
			a_html.append ("<table")
			append_css_id_to (a_html)
			append_css_class_to (a_html, Void)
			append_css_style_to (a_html)
			a_html.append (">")

			if has_title then
				a_html.append ("<tr>")
				across
					columns as c
				loop
					c.item.append_table_header_to_html (a_theme, a_html)
				end
				a_html.append ("</tr>")
			end
			if attached head_data as l_head_data then
				l_use_tbody := True
				a_html.append ("<thead>")
				append_data_to_html (l_head_data, a_theme, a_html)
				a_html.append ("</thead>")
			end
			if attached foot_data as l_foot_data then
				l_use_tbody := True
				a_html.append ("<tfoot>")
				append_data_to_html (l_foot_data, a_theme, a_html)
				a_html.append ("</tfoot>")
			end

			if attached data as l_data then
				if l_use_tbody then
					a_html.append ("<tbody>")
				end
				append_data_to_html (l_data, a_theme, a_html)
				if l_use_tbody then
					a_html.append ("</tbody>")
				end
			end
			a_html.append ("</table>")
		end

	append_data_to_html (lst: ITERABLE [G]; a_theme: WSF_THEME; a_html: STRING_8)
		local
			fct: like compute_item_function
		do
			fct := compute_item_function
			across
				lst as d
			loop
				if fct /= Void and then attached fct.item ([d.item]) as r then
					r.append_to_html (a_theme, a_html)
				else
					a_html.append ("<tr>")
					a_html.append ("<td>")
					if attached d.item as g then
						a_html.append (g.out)
					end
					a_html.append ("</td>")
					a_html.append ("</tr>")
				end
			end
		end

end
