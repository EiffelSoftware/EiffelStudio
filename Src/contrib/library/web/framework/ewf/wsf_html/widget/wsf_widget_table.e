note
	description: "Summary description for {WSF_WIDGET_FILLED_TABLE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_WIDGET_TABLE

inherit
	WSF_WIDGET

	WSF_WITH_CSS_ID

	WSF_WITH_CSS_CLASS

	WSF_WITH_CSS_STYLE

	ITERABLE [WSF_WIDGET_TABLE_ITEM]

create
	make

feature {NONE} -- Initialization

	make
		do
			create columns.make_empty
		end

	make_from_table (tb: WSF_WIDGET_AGENT_TABLE [detachable ANY])
		do
			make
			set_column_count (tb.column_count)
				-- css classes
			if attached tb.css_classes as lst then
				across lst as c loop
					add_css_class (c.item)
				end
			end
				-- css id
			set_css_id (tb.css_id)

				-- css style
			add_css_style (tb.css_style)

				-- columns
			across
				tb.columns as c
			loop
				columns [c.item.index] := c.item.twin
			end

				-- rows
			if attached tb.compute_item_function as fct then
				if attached tb.head_data as lst then
					across lst as d loop
						add_head_row (fct.item ([d.item]))
					end
				end
				if attached tb.data as lst then
					across lst as d loop
						add_row (fct.item ([d.item]))
					end
				end
				if attached tb.foot_data as lst then
					across lst as d loop
						add_foot_row (fct.item ([d.item]))
					end
				end
			end
		end

feature -- Access

	new_cursor: WSF_WIDGET_TABLE_ITERATION_CURSOR
			-- Fresh cursor associated with current structure
		do
			create Result.make (Current)
		end

	column_count: INTEGER
		do
			Result := columns.count
		end

	head_row_count: INTEGER
		do
			if attached head_rows as lst then
				Result := lst.count
			end
		end

	body_row_count: INTEGER
		do
			if attached rows as lst then
				Result := lst.count
			end
		end

	foot_row_count: INTEGER
		do
			if attached foot_rows as lst then
				Result := lst.count
			end
		end

	row_count: INTEGER
		do
			Result := head_row_count + body_row_count + foot_row_count
		end

	columns: ARRAY [WSF_WIDGET_TABLE_COLUMN]


	column (c: INTEGER): WSF_WIDGET_TABLE_COLUMN
		do
			if c > column_count then
				set_column_count (c)
			end
			Result := columns[c]
		end

	row (r: INTEGER): detachable WSF_WIDGET_TABLE_ROW
		do
			if r <= head_row_count then
				if attached head_rows as lst then
					Result := lst [r]
				end
			elseif r <= head_row_count + body_row_count then
				if attached rows as lst then
					Result := lst [r - head_row_count]
				end
			elseif r <= row_count then
				if attached foot_rows as lst then
					Result := lst [r - head_row_count - body_row_count]
				end
			end
		end

	has_title: BOOLEAN
		do
			Result := across columns as c some c.item.title /= Void end
		end

	head_rows: detachable ARRAYED_LIST [WSF_WIDGET_TABLE_ROW]
			-- thead

	foot_rows: detachable ARRAYED_LIST [WSF_WIDGET_TABLE_ROW]
			-- tfoot

	rows: detachable ARRAYED_LIST [WSF_WIDGET_TABLE_ROW]
			-- tbody

feature -- Change

	clear_rows
		do
			head_rows := Void
			foot_rows := Void
			rows := Void
		end

	add_head_row (r: WSF_WIDGET_TABLE_ROW)
		local
			lst: like head_rows
		do
			lst := head_rows
			if lst = Void then
				create {ARRAYED_LIST [WSF_WIDGET_TABLE_ROW]} lst.make (1)
				head_rows := lst
			end
			lst.force (r)
		end

	add_foot_row (r: WSF_WIDGET_TABLE_ROW)
		local
			lst: like foot_rows
		do
			lst := foot_rows
			if lst = Void then
				create {ARRAYED_LIST [WSF_WIDGET_TABLE_ROW]} lst.make (1)
				foot_rows := lst
			end
			lst.force (r)
		end

	add_row (r: WSF_WIDGET_TABLE_ROW)
		local
			lst: like rows
		do
			lst := rows
			if lst = Void then
				create {ARRAYED_LIST [WSF_WIDGET_TABLE_ROW]} lst.make (1)
				rows := lst
			end
			lst.force (r)
		end

	set_column_count (nb: INTEGER)
		do
			if nb > columns.count then
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
			if attached head_rows as l_head_rows then
				l_use_tbody := True
				a_html.append ("<thead>")
				append_rows_to_html (l_head_rows, a_theme, a_html)
				a_html.append ("</thead>")
			end
			if attached foot_rows as l_foot_rows then
				l_use_tbody := True
				a_html.append ("<tfoot>")
				append_rows_to_html (l_foot_rows, a_theme, a_html)
				a_html.append ("</tfoot>")
			end

			if attached rows as l_rows then
				if l_use_tbody then
					a_html.append ("<tbody>")
				end
				append_rows_to_html (l_rows, a_theme, a_html)
				if l_use_tbody then
					a_html.append ("</tbody>")
				end
			end
			a_html.append ("</table>")
		end

	append_rows_to_html (lst: ITERABLE [WSF_WIDGET_TABLE_ROW]; a_theme: WSF_THEME; a_html: STRING_8)
		do
			across
				lst as r
			loop
				r.item.append_to_html (a_theme, a_html)
			end
		end

end
