indexing
	description: "Graphical representations of client/supplier links in BON notation."
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLIENT_SUPPLIER_FIGURE

inherit
	CLIENT_SUPPLIER_FIGURE
		redefine
			create_line,
			name_figure
		end

create
	make_with_classes

feature -- Access

	start_point: EV_RELATIVE_POINT is
			-- Origin of `client'.
		do
			Result := client.point
		end

	end_point: EV_RELATIVE_POINT is
			-- Origin of `supplier'.
		do
			Result := supplier.point
		end

feature -- Memory management

	recycle is
			-- Frees `Current's memory, and leave `Current' in an unstable state
			-- so that we know whether we're still referenced or not.
		do
			enclosing_figure := Void
			name_figure_mover := Void
		end

feature -- Figures

	name_figure: BON_LABEL
			-- Graphical representation of `label'.
			
	name_figure_moving_area: EV_FIGURE_RECTANGLE
			-- Invisible rectangle where mouse cursor changes.
	
feature -- Status setting

	set_active (b: BOOLEAN) is
			-- Highlight `Current' if `b' `True'.
		do
		end

	update is
			-- `client' or `supplier' has been moved/resized. Need to update.
		local
			p1, p2: EV_RELATIVE_POINT
			x1, y1, x2, y2, o_x, o_y, x_label, y_label, dif_y, dif_x: INTEGER
			s_x, s_y: DOUBLE
			angle: REAL
			se_nw_label, strong_slope: BOOLEAN
		do
			p1 := vertices.i_th (vertices.count - 1)
			p2 := end_point
			angle := line_angle (p2.x_abs, p2.y_abs, p1.x_abs, p1.y_abs)
			supplier.update_edge_point (lines.last.point_b, angle)

			p1 := vertices.i_th (2)
			p2 := start_point
			angle := line_angle (p2.x_abs, p2.y_abs, p1.x_abs, p1.y_abs)
			client.update_edge_point (lines.first.point_a, angle)

			if not is_reflexive then
				if lines.count < line_labelled then
						-- Labelled line has been removed, reset name placement.
					line_labelled := 1
					label_position := 0.5
				end
				p1 := vertices.i_th (line_labelled)
				p2 := vertices.i_th (line_labelled + 1)
				o_x := enclosing_figure.point.x_abs
				o_y := enclosing_figure.point.y_abs
				s_x := client.world.scale_x
				s_y := client.world.scale_y
				x1 := ((p1.x_abs - o_x) / s_x).rounded
				y1 := ((p1.y_abs - o_y) / s_y).rounded
				x2 := ((p2.x_abs - o_x) / s_x).rounded
				y2 := ((p2.y_abs - o_y) / s_y).rounded
				x_label := x1 + (label_position * (x2 - x1)).rounded
				y_label := y1 + (label_position * (y2 - y1)).rounded
				dif_y := (y2 - y1).abs
				dif_x := (x2 - x1).abs
				if dif_x = 0 then
					strong_slope := True
				elseif dif_y = 0 then
					strong_slope := False
				elseif dif_x / dif_y <= 1 then
					strong_slope := True
				else
					strong_slope := False
				end
				if (x2 > x1 and y2 > y1) or (x2 < x1 and y2 < y1) then
					se_nw_label := True
				else
					se_nw_label := False
				end
				if name_shifted then
					if strong_slope then
						name_figure.point.set_position (x_label - name_figure.width, y_label)
						name_figure_mover.point.set_position (x_label - name_figure.width, y_label)
					else
						if dif_y = 0 then
							name_figure.point.set_position (x_label, y_label - name_figure.height)
							name_figure_mover.point.set_position (x_label, y_label - name_figure.height)
						elseif se_nw_label then
							name_figure.point.set_position (x_label, y_label + name_figure.height)
							name_figure_mover.point.set_position (x_label, y_label + name_figure.height)
						else
							name_figure.point.set_position (x_label, y_label - 2 * name_figure.height)
							name_figure_mover.point.set_position (x_label, y_label - 2 * name_figure.height)
						end
					end
				else
					if strong_slope then
						name_figure.point.set_position (x_label, y_label)
						name_figure_mover.point.set_position (x_label, y_label)
					elseif se_nw_label then
						name_figure.point.set_position (x_label, y_label - name_figure.height)
						name_figure_mover.point.set_position (x_label, y_label - name_figure.height)
					else
						name_figure.point.set_position (x_label, y_label)
						name_figure_mover.point.set_position (x_label, y_label)
					end
				end
			else
				name_figure.point.set_origin (client.point)
				name_figure.point.set_position (- client.width // 2, client.height // 2)
			end
		end

	hide_label is
			-- Hide `name_figure'.
		do
			name_figure.hide
		end

	show_label is
			-- Show `name_figure'.
		do
			name_figure.show
		end

feature {CONTEXT_DIAGRAM} -- XML

	xml_element (a_parent: XML_ELEMENT): XML_ELEMENT is
			-- XML representation.
		local		
			vertice_xml_element, label_xml_element: XML_ELEMENT
		do
			create Result.make (a_parent, "CLIENT_SUPPLIER_FIGURE")
			Result.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("SRC", client.name))
			Result.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("TRG", supplier.name))
			create label_xml_element.make (Result, "LABEL")
			label_xml_element.put_last (
				xml_node (
					label_xml_element,
					"POSITION",
					 (label_position.out)))
			label_xml_element.put_last (
				xml_node (
					label_xml_element,
					"LINE",
					 (line_labelled.out)))
			label_xml_element.put_last (
				xml_node (
					label_xml_element,
					"SHIFTED",
					 (name_shifted.out)))
			Result.put_last (label_xml_element)
			if vertices.count > 2 and not is_reflexive then
				from
					vertices.go_i_th (2)
				until	
					vertices.islast
				loop
					create vertice_xml_element.make (Result, "MIDPOINT")
					vertice_xml_element.put_last (
						xml_node (
							vertice_xml_element,
							"X_POS",
							 ((vertices.item.x_abs - client.world.point.x_abs) / client.world.scale_x).rounded.out))
					vertice_xml_element.put_last (
						xml_node (
							vertice_xml_element,
							"Y_POS",
							 ((vertices.item.y_abs - client.world.point.y_abs) / client.world.scale_y).rounded.out))
					Result.put_last (vertice_xml_element)
					vertices.forth
				end
			end
		end

	set_with_xml_element (an_element: XML_ELEMENT) is
			-- Set attributes from XML element.
		require else
			an_element_is_client_supplier_figure: an_element.name.is_equal ("CLIENT_SUPPLIER_FIGURE")
		local
			x_pos, y_pos: INTEGER
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			node: XML_ELEMENT
			new_midpoint: EV_RELATIVE_POINT
			retrieved_midpoints: LINKED_LIST [EV_RELATIVE_POINT]
		do
			reset
			create retrieved_midpoints.make
			a_cursor := an_element.new_cursor
			from
				a_cursor.start
			until
				a_cursor.after
			loop
				node ?= a_cursor.item
				if node /= Void then
					if node.name.is_equal ("MIDPOINT") then
						x_pos := xml_integer (node, "X_POS")
						y_pos := xml_integer (node, "Y_POS")
						create new_midpoint.make_with_position (x_pos, y_pos)
						retrieved_midpoints.put_front (new_midpoint)
					elseif node.name.is_equal ("LABEL") then
						label_position := xml_double (node, "POSITION")
						line_labelled := xml_integer (node, "LINE")
						name_shifted := xml_boolean (node, "SHIFTED")
					else
						create error_window
						error_window.set_text ("Tag: " + node.name + " not known")
						error_window.show
					end
				else
					create error_window
					error_window.set_text ("XML element missing")
					error_window.show
				end
				a_cursor.forth
			end
			retrieve_lines (retrieved_midpoints)
			update
			update_origin
		end

feature {NONE} -- Implementation

	label_position: DOUBLE
			-- Parameter defining position of `name_figure' on `line_labelled'-th line of `Current'.

	line_labelled: INTEGER
			-- Index of line where `name_figure' is.

	name_shifted: BOOLEAN
			-- Does `name_figure' need to be shifted to the left of `Current'?

	build_figure is
			-- Build graphical representation from recently updated structure.
		do
			if parent_link = Void then
				if not is_reflexive then
					from lines.start until lines.after loop
						extend (lines.item)
						lines.forth
					end
				end
				create name_figure_mover
				create name_figure
				name_figure.set_text (label)
				name_figure.set_font (bon_client_label_font)
				if is_reflexive then
					name_figure.point.set_origin (client.point)
				else
					name_figure.point.set_origin (enclosing_figure.point)
				end
				name_figure.disable_sensitive
				label_position := 0.5
				line_labelled := 1
				create name_figure_moving_area
				name_figure_moving_area.point_a.set_origin (name_figure.point)
				name_figure_moving_area.point_b.set_origin (name_figure_moving_area.point_a)
				name_figure_moving_area.point_b.set_position (name_figure.width, name_figure.height)
				name_figure_mover.hide
				name_figure_mover.disable_snapping
				name_figure_mover.point.set_origin (enclosing_figure.point)
				name_figure_mover.extend (name_figure_moving_area)
				name_figure_mover.start_actions.extend (
					name_figure_moving_area~set_pointer_style (Default_pixmaps.Sizeall_cursor))
				name_figure_mover.end_actions.extend (
					name_figure_moving_area~set_pointer_style (Default_pixmaps.Standard_cursor))
				name_figure_mover.end_actions.extend (~update_scrollable_area_size)
				name_figure_mover.end_actions.extend (~update)
				name_figure_mover.set_real_position_agent (~adjust_mover_coordinates)
				name_figure_mover.start_actions.extend (agent start_capture)
				name_figure_mover.end_actions.extend (agent stop_capture)
				extend (name_figure)
			end
		end

	create_line: BON_LINE is
			-- Create new line segment with default values.
		do
			Result := Precursor
			Result.set_pointer_style (Cursors.cur_Client_link)
			Result.set_foreground_color (Default_colors.Blue)
			Result.set_line_width (4)
		end

	update_name_figure is
			-- `label' has changed, `name_figure' should follow.
		do
			name_figure.set_text (label)
			name_figure_moving_area.point_b.set_position (name_figure.width, name_figure.height)
		end

	adjust_mover_coordinates (x, y: INTEGER): TUPLE [INTEGER,INTEGER] is
			-- Restore the right coordinates of `name_figure'.
		local
			p1, p2: EV_RELATIVE_POINT
			x1, y1, x2, y2, xp, yp, xproj, yproj: INTEGER
			x1_ok, y1_ok, x2_ok, y2_ok, min_dist: INTEGER
			dif_x, dif_y, o_x, o_y: INTEGER
			t, alpha, s_x, s_y: DOUBLE
			strong_slope, se_nw_label: BOOLEAN
		do
			min_dist := 10000
			from
				lines.start
			until
				lines.after
			loop
				p1 := vertices.i_th (lines.index)
				p2 := vertices.i_th (lines.index + 1)
				if is_reflexive then
					x1 := p1.x
					y1 := p1.y
					x2 := p2.x
					y2 := p2.y
				else
					o_x := enclosing_figure.point.x_abs
					o_y := enclosing_figure.point.y_abs
					s_x := client.world.scale_x
					s_y := client.world.scale_y
					x1 := ((p1.x_abs - o_x) / s_x).rounded
					y1 := ((p1.y_abs - o_y) / s_y).rounded
					x2 := ((p2.x_abs - o_x) / s_x).rounded
					y2 := ((p2.y_abs - o_y) / s_y).rounded
				end
				if has_projection (x, y, x1 ,y1, x2, y2) then
					dif_x := x2 - x1
					dif_y := y2 - y1
					if dif_x.abs /= dif_y.abs then
						t := 
							(dif_x * (x - x1) - dif_y * (y - y1)) /
								(dif_x ^ 2 - dif_y ^ 2)
						xproj := (x1 + t * dif_x).rounded
						yproj := (y1 + t * dif_y).rounded
					else
						if x2 >= x1 and y2 >= y1 and x /= x1 then
							alpha := arc_tangent ((y - y1) / (x - x1))
							xproj := (x1 + (cosine (Pi / 4 - alpha) * distance (x1, y1, x, y)) / sqrt (2)).rounded
							yproj := -x1 + y1 + xproj
						elseif x2 >= x1 and y2 <= y1 then
							alpha := arc_tangent ((y - y1) / (x - x1))
							xproj := (x1 + (cosine (7 * Pi / 4 - alpha) * distance (x1, y1, x, y)) / sqrt (2)).rounded
							yproj := -xproj + x1 + y1
						elseif x2 <= x1 and y2 >= y1 then
							alpha := arc_tangent ((y - y1) / (x - x1))
							xproj := (x1 + (cosine (3 * Pi / 4 - alpha) * distance (x1, y1, x, y)) / sqrt (2)).rounded
							yproj := -xproj + x1 + y1
						elseif x2 <= x1 and y2 <= y1 then
							alpha := arc_tangent ((y - y1) / (x - x1))
							xproj := (x1 + (cosine (5 * Pi / 4 - alpha) * distance (x1, y1, x, y)) / sqrt (2)).rounded
							yproj := -x1 + y1 + xproj
						end
						if x2 /= x1 then
							t := (xproj - x1) / dif_x
						end
					end
					if distance (x, y, xproj, yproj) < min_dist then
						label_position := t
						line_labelled := lines.index
						x1_ok := x1
						y1_ok := y1
						x2_ok := x2
						y2_ok := y2
						xp := xproj
						yp := yproj
						min_dist := distance (x, y, xproj, yproj)
					end
				else
					if distance (x, y, x1, y1) < min_dist then
						xp := x1
						yp := y1
						min_dist := distance (x, y, x1, y1)
						label_position := 0
						line_labelled := lines.index
					elseif distance (x, y, x2, y2) < min_dist then
						xp := x2
						yp := y2
						min_dist := distance (x, y, x2, y2)
						label_position := 1
						line_labelled := lines.index
					end
				end
				lines.forth
			end

			dif_x := (x2_ok - x1_ok).abs
			dif_y := (y2_ok - y1_ok).abs
			if dif_x = 0 then
				strong_slope := True
			elseif dif_y = 0 then
				strong_slope := False
			elseif dif_x / dif_y <= 1 then
				strong_slope := True
			else
				strong_slope := False
			end
			if (x2_ok > x1_ok and y2_ok > y1_ok) or (x2_ok < x1_ok and y2_ok < y1_ok) then
				se_nw_label := True
			else
				se_nw_label := False
			end

			name_shifted := name_shift_needed (x, y, x1_ok, y1_ok, x2_ok, y2_ok)

			if name_shifted then
				if strong_slope then
					name_figure.point.set_position (xp - name_figure.width, yp)
				else
					if dif_y = 0 then
						name_figure.point.set_position (xp, yp - name_figure.height)
					elseif se_nw_label then
						name_figure.point.set_position (xp, yp + name_figure.height)
					else
						name_figure.point.set_position (xp, yp - 2 * name_figure.height)
					end
				end
			else
				if strong_slope then
					name_figure.point.set_position (xp, yp)
				elseif se_nw_label then
					name_figure.point.set_position (xp, yp - name_figure.height)
				else
					name_figure.point.set_position (xp, yp)
				end
			end
			Result := [xp, yp]
		end
	
	has_projection (x, y, x1, y1, x2, y2: INTEGER): BOOLEAN is
			-- Does (`x', `y') have a projection on segment [(`x1', `y1'),(`x2', `y2')]?
		local
			r, dif_x, dif_y:  INTEGER
		do
			dif_x := x2 - x1
			dif_y := y2 - y1
			if dif_x.abs /= dif_y.abs then
				r := (dif_x ^ 2 - dif_y ^ 2).sign
				Result := 
					((x - x1) * dif_x - (y - y1) * dif_y).sign = r and
					((x - x2) * dif_x - (y - y2) * dif_y).sign = -r
			else
				if x2 >= x1 and y2 >= y1 then
					r := (x2 + y2 - x1 - y1).sign
					Result :=
						(x + y - x1 - y1).sign = r and
						(x + y - x2 - y2).sign = -r
				elseif x2 >= x1 and y2 <= y1 then
					r := (x2 - y2 - x1 + y1).sign
					Result :=
						(x - y - x1 + y1).sign = r and
						(x - y - x2 + y2).sign = -r
				elseif x2 <= x1 and y2 >= y1 then
					r := (x2 - y2 - x1 + y1).sign
					Result :=
						(x - y - x1 + y1).sign = r and
						(x - y - x2 + y2).sign = -r
				elseif x2 <= x1 and y2 <= y1 then
					r := (x2 + y2 - x1 - y1).sign
					Result :=
						(x + y - x1 - y1).sign = r and
						(x + y - x2 - y2).sign = -r
				end
			end
		end

	name_shift_needed (x, y, x1, y1, x2, y2: INTEGER): BOOLEAN is
			-- Is (`x', `y') on the left side of segment [(`x1', `y1'), (`x2', `y2')]?
		local
			eq: DOUBLE
		do
			if x2 /= x1 and y2 /= y1 then
				eq := y1 + (x - x1) * (y2 - y1) / (x2 - x1)
				if x1 < x2 and y1 > y2 then
					Result := y <= eq
				elseif x1 < x2 and y1 < y2 then
					Result := y >= eq
				elseif x1 > x2 and y1 < y2 then
					Result := y <= eq
				else
					Result := y >= eq
				end
			elseif x1 = x2 then
				Result := x <= x1
			else
				Result := y <= y1
			end
		end

feature {BON_DIAGRAM_FACTORY} -- Drawing

	draw is
			-- Do a quick draw on `drawable'.
		local
			pa, t1, t2, t3: ARRAY [EV_COORDINATE]
			p: EV_RELATIVE_POINT
			l: BON_LINE
			label_font: EV_FONT
			d: like drawable
		do
			d := drawable
			create pa.make (1, vertices.count)
			from
				vertices.start
			until
				vertices.after
			loop
				pa.put (vertices.item.absolute_coordinates, vertices.index)
				vertices.forth
			end

			l := lines.last
			if l.is_end_arrow then
				l.end_arrow.i_th_point (2).set_angle (l.end_angle)
				t1 := l.end_arrow.point_array
				p := l.end_draw_point
			else
				p := l.point_b
			end
			pa.put (create {EV_COORDINATE}.set (p.x_abs, p.y_abs), pa.upper)
			if l.is_cut_figure then
				l.cut_figure_point.set_angle (l.end_angle)
				t3 := l.cut_figure.point_array
				p := l.point_b
			else
				p := l.point_b
			end
			l := lines.first
			if l.is_start_arrow then
				l.start_arrow.i_th_point (2).set_angle (l.start_angle)
				t2 := l.start_arrow.point_array
				p := l.start_draw_point
			else
				p := l.point_a
			end
			pa.put (create {EV_COORDINATE}.set (p.x_abs, p.y_abs), pa.lower)

			d.set_foreground_color (Default_colors.Blue)
			d.set_line_width (4)
			d.draw_polyline (pa, False)
			d.set_foreground_color (Default_colors.White)
			d.set_line_width (2)
			d.draw_polyline (pa, False)
			d.set_foreground_color (Default_colors.Blue)
			d.set_line_width (0)
			if t1 /= Void then
				d.fill_polygon (t1)
			end
			if t2 /= Void then
				d.fill_polygon (t2)
			end
			d.set_line_width (2)
			if t3 /= Void then
				d.draw_polyline (t3, False)
			end
			d.set_foreground_color (name_figure.foreground_color)
			create label_font.make_with_values (
				bon_client_label_font.family,
				bon_client_label_font.weight,
				bon_client_label_font.shape,
				bon_client_label_font.height)
			label_font.set_height ((label_font.height * client.world.point.scale_y).rounded)	
			d.set_font (label_font)
			if name_figure.is_show_requested then
				d.draw_text_top_left (name_figure.point.x_abs, name_figure.point.y_abs, name_figure.text)
			end
		end

feature {EB_DIAGRAM_TO_PS_COMMAND} -- Postscript

	draw_ps (ps_proj: EV_POSTSCRIPT_PROJECTOR) is
			-- Postscript drawing routine for `Current' used by `ps_proj'.
		local
			pa, t1, t2, t3: ARRAY [EV_COORDINATE]
			p: EV_RELATIVE_POINT
			pl: EV_FIGURE_POLYLINE
			pol: EV_FIGURE_POLYGON
			l: BON_LINE
		do
			create pa.make (1, vertices.count)
			from
				vertices.start
			until
				vertices.after
			loop
				pa.put (vertices.item.absolute_coordinates, vertices.index)
				vertices.forth
			end

			l := lines.last
			if l.is_end_arrow then
				l.end_arrow.i_th_point (2).set_angle (l.end_angle)
				t1 := l.end_arrow.point_array
				p := l.end_draw_point
			else
				p := l.point_b
			end
			pa.put (create {EV_COORDINATE}.set (p.x_abs, p.y_abs), pa.upper)
			if l.is_cut_figure then
				l.cut_figure_point.set_angle (l.end_angle)
				t3 := l.cut_figure.point_array
				p := l.point_b
			else
				p := l.point_b
			end
			l := lines.first
			if l.is_start_arrow then
				l.start_arrow.i_th_point (2).set_angle (l.start_angle)
				t2 := l.start_arrow.point_array
				p := l.start_draw_point
			else
				p := l.point_a
			end
			pa.put (create {EV_COORDINATE}.set (p.x_abs, p.y_abs), pa.lower)

			create pl.make_with_coordinates (pa)
			pl.set_foreground_color (Default_colors.Blue)
			pl.set_line_width (4)
			ps_proj.draw_figure_polyline (pl)
			pl.set_foreground_color (Default_colors.White)
			pl.set_line_width (2)
			ps_proj.draw_figure_polyline (pl)
			if t1 /= Void then
				create pol.make_with_coordinates (t1)
				pol.set_foreground_color (Default_colors.Blue)
				pol.set_background_color (Default_colors.Blue)
				pol.set_line_width (2)
				ps_proj.draw_figure_polygon (pol)
			end
			if t2 /= Void then
				create pol.make_with_coordinates (t2)
				pol.set_foreground_color (Default_colors.Blue)
				pol.set_background_color (Default_colors.White)
				pol.set_line_width (2)
				ps_proj.draw_figure_polygon (pol)
			end
			if t3 /= Void then
				create pl.make_with_coordinates (t3)
				pl.set_foreground_color (Default_colors.Blue)
				pl.set_line_width (2)
				ps_proj.draw_figure_polyline (pl)
			end
			if name_figure.is_show_requested then				
				ps_proj.draw_figure_text (name_figure)
			end
		end

end -- class BON_CLIENT_SUPPLIER_FIGURE
