indexing
	description: "Graphical representations of inheritance links in BON notation."
	date: "$Date$"
	revision: "$Revision$"

class
	BON_INHERITANCE_FIGURE

inherit
	INHERITANCE_FIGURE
		redefine
			remove_from_diagram,
			create_line
		end

create
	make_with_classes

feature -- Access

	start_point: EV_RELATIVE_POINT is
			-- Origin of `descendant'.
		do
			Result := descendant.point
		end

	end_point: EV_RELATIVE_POINT is
			-- Origin of `ancestor'.
		do
			Result := ancestor.point
		end

feature -- Status setting

	set_active (b: BOOLEAN) is
			-- Highlight `Current' if `b' `True'.
		do
		end

	update is
			-- `descendant' or `ancestor' has been moved/resized. Need to update.
		local
			p1, p2: EV_RELATIVE_POINT
			angle: REAL
		do
			p1 := vertices.i_th (vertices.count - 1)
			p2 := ancestor.point
			angle := line_angle (p2.x_abs, p2.y_abs, p1.x_abs, p1.y_abs)
			ancestor.update_edge_point (lines.last.point_b, angle)

			p1 := vertices.i_th (2)
			p2 := descendant.point
			angle := line_angle (p2.x_abs, p2.y_abs, p1.x_abs, p1.y_abs)
			descendant.update_edge_point (lines.first.point_a, angle)
		end

feature {CONTEXT_DIAGRAM} -- XML

	xml_element (a_parent: XML_ELEMENT): XML_ELEMENT is
			-- XML representation.
		local		
			vertice_xml_element: XML_ELEMENT
		do
			if vertices.count > 2 then
				create Result.make (a_parent, "INHERITANCE_FIGURE")
				Result.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("SRC", descendant.name))
				Result.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("TRG", ancestor.name))
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
							 ((vertices.item.x_abs - ancestor.world.point.x_abs) / ancestor.world.scale_x).rounded.out))
					vertice_xml_element.put_last (
						xml_node (
							vertice_xml_element,
							"Y_POS",
							 ((vertices.item.y_abs - ancestor.world.point.y_abs) / ancestor.world.scale_y).rounded.out))
					Result.put_last (vertice_xml_element)
					vertices.forth
				end
			end
		end

	set_with_xml_element (an_element: XML_ELEMENT) is
			-- Set attributes from XML element.
		require else
			an_element_is_inheritance_figure: an_element.name.is_equal ("INHERITANCE_FIGURE")
		local
			x_pos, y_pos: INTEGER
			a_cursor: DS_BILINKED_LIST_CURSOR[XML_NODE]
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
					else
						create error_window
						error_window.set_text ("tag: " + node.name + " not known")
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

feature {BON_DIAGRAM_FACTORY} -- Drawing

	draw is
			-- Do a quick draw on `drawable'.
		do
			from
				lines.start
			until	
				lines.after
			loop
				draw_figure_line (lines.item)
				lines.forth
			end
		end

	draw_figure_line (line: EV_FIGURE_LINE) is
			-- Draw standard representation of `line' to canvas.
		local
			s, t: EV_RELATIVE_POINT
			p: EV_FIGURE_POLYGON
			d: like drawable
		do
			d := drawable
			d.set_foreground_color (line.foreground_color)
			if line.is_start_arrow or else line.is_end_arrow then
				d.set_line_width (0)
				if line.is_start_arrow then
					p := line.start_arrow
					p.i_th_point (2).set_angle (line.start_angle)
					d.fill_polygon (offset_coordinates (p.point_array))
					s := line.start_draw_point
				else
					s := line.point_a
				end
				if line.is_end_arrow then
					p := line.end_arrow
					p.i_th_point (2).set_angle (line.end_angle)
					d.fill_polygon (offset_coordinates (p.point_array))
					t := line.end_draw_point
				else
					t := line.point_b
				end
			else
				s := line.point_a
				t := line.point_b
			end
			if line.dashed_line_style then
				d.enable_dashed_line_style
			end
			d.set_line_width (line.line_width)
			d.draw_segment (
				s.x_abs - drawable_position.x,
				s.y_abs - drawable_position.y,
				t.x_abs - drawable_position.x,
				t.y_abs - drawable_position.y)
			if line.dashed_line_style then
				d.disable_dashed_line_style
			end
		end

feature {EB_DIAGRAM_TO_PS_COMMAND} -- Postscript

	draw_ps (ps_proj: EV_POSTSCRIPT_PROJECTOR) is
			-- Postscript drawing routine for `Current' used by `ps_proj'.
		do
			from
				lines.start
			until	
				lines.after
			loop
				ps_proj.draw_figure_line (lines.item)
				lines.forth
			end
		end

feature {CONTEXT_DIAGRAM} -- Removal

	remove_from_diagram (d: CONTEXT_DIAGRAM) is
			-- Remove `Current' graphically.
		do
			remove_midpoints
			Precursor (d)
		end

feature {NONE} -- Implementation

	build_figure is
			-- Build graphical representation from recently updated structure.
		do
			from lines.start until lines.after loop
				extend (lines.item)
				lines.forth
			end
		end

	create_line: BON_LINE is
			-- Create new line segment with default values.
		do
			Result := Precursor
			Result.set_pointer_style (Cursors.cur_Inherit_link)
			Result.set_foreground_color (Default_colors.Red)
			Result.set_line_width (2)
		end

end -- class BON_INHERITANCE_FIGURE

