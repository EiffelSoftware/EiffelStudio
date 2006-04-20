indexing
	description: "Objects that projects an EIFFEL_WORLD."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_PROJECTOR

inherit
	EV_MODEL_BUFFER_PROJECTOR
		redefine
			on_paint,
			update_rectangle,
			update,
			project_rectangle,
			full_project,
			make_with_buffer,
			project,
			default_cursor,
			world
		end

	EB_CONSTANTS

create
	make_with_buffer

feature {NONE} -- Initialization

	make_with_buffer (a_world: like world; a_drawing_area: EV_DRAWING_AREA) is
			-- Create an EIFFEL_PROJECTOR projecting `a_world' to `a_drawing_area'.
		local
			l_figure: EG_FIGURE
		do
			Precursor {EV_MODEL_BUFFER_PROJECTOR} (a_world, a_drawing_area)

				-- Below, we need to create the corresponding figure instance and
				-- set it to the local variable `l_figure' so that we can call
				-- `recycle' on it when we are completely done with it.
			create {BON_CLIENT_SUPPLIER_FIGURE} l_figure
			register_figure (l_figure, agent draw_bon_client_supplier)
			l_figure.recycle

			create {BON_INHERITANCE_FIGURE} l_figure
			register_figure (l_figure, agent draw_bon_inheritance)
			l_figure.recycle

			create {BON_CLASS_FIGURE} l_figure
			register_figure (l_figure, agent draw_bon_class)
			l_figure.recycle

			create {UML_INHERITANCE_FIGURE} l_figure
			register_figure (l_figure, agent draw_uml_inheritance)
			l_figure.recycle
		end

feature -- Status report

	is_painting_disabled: BOOLEAN
			-- Is painting disabled?

feature -- Access

	world: EIFFEL_WORLD
			-- World `Current' is projecting.

feature -- Status settings

	enable_painting is
			-- Set `is_painting_disabled' to False.
		do
			is_painting_disabled := False
		ensure
			set: not is_painting_disabled
		end

	disable_painting is
			-- Set `is_painting_disabled' to True.
		do
			is_painting_disabled := True
		ensure
			set: is_painting_disabled
		end

feature -- Display updates

	full_project is
			-- Project entire area.
		local
			rectangle: EV_RECTANGLE
		do
			if not is_painting_disabled then
				world.update
				create rectangle.make (drawable_position.x, drawable_position.y, drawable.width, drawable.height)
				project_rectangle (rectangle)
			end
		end

	project is
			-- Make a standard projection of world on device.
		local
			e, u: EV_RECTANGLE
		do
			if not is_projecting and then not is_painting_disabled then
				is_projecting := True
				if world.is_redraw_needed then
					full_project
					world.full_redraw_performed
				else
					world.update
					e := world.invalid_rectangle
					if e /= Void then
						u := world.update_rectangle
						if u /= Void then
							e.merge (u)
						end
						project_rectangle (e)
					end
				end
			end
			is_projecting := False
		end

	project_rectangle (u: EV_RECTANGLE) is
			-- Project area under `u'
		do
			if not is_painting_disabled then
				Precursor {EV_MODEL_BUFFER_PROJECTOR} (u)
			end
		end

feature {NONE} -- Implementation

	on_paint (x, y, w, h: INTEGER) is
		do
			if not is_painting_disabled then
				update_rectangle (create {EV_RECTANGLE}.make (x, y, w, h), x, y)
			end
		end

	update_rectangle (u: EV_RECTANGLE; a_x, a_y: INTEGER) is
			-- Flush `u' on `area' at (`a_x', `a_y').
		do
			if not is_painting_disabled then
				Precursor {EV_MODEL_BUFFER_PROJECTOR} (u, a_x, a_y)
			end
		end

	update is
			-- Update display by drawing the right part of the buffer on `area'.
		do
			if not is_painting_disabled then
				Precursor {EV_MODEL_BUFFER_PROJECTOR}
			end
		end

	default_cursor: EV_CURSOR is
			-- Default cursor on eiffel world.
		do
			Result := cursors.open_hand_cursor
		end

	draw_bon_class (a_class: BON_CLASS_FIGURE) is
			-- Draw `a_class'
		local
			l_ellipse, r_ellipse: EV_MODEL_ELLIPSE
		do
			project_figure_group_full (a_class)
			if a_class.model.is_root_class then
				-- Draw second ellipse.
				l_ellipse := a_class.ellipse
				create r_ellipse.make_with_positions (l_ellipse.point_a_x + 3, l_ellipse.point_a_y + 3, l_ellipse.point_b_x - 3, l_ellipse.point_b_y - 3)
				draw_figure_ellipse (r_ellipse)
			end
		end


	draw_bon_client_supplier (group: BON_CLIENT_SUPPLIER_FIGURE) is
			-- Draw `group'.
		require -- from EV_MODEL_PROJECTION_ROUTINES
			group_not_void: group /= Void
			group_show_requested: group.is_show_requested
		local
			draw_item: EV_MODEL
			g: EV_MODEL_GROUP
			i, nb: INTEGER
			dr: PROCEDURE [ANY, TUPLE [EV_MODEL]]
			polyline: EV_MODEL_POLYLINE
		do
			from
				i := 1
				nb := group.count
			until
				i > nb
			loop
				draw_item := group.i_th (i)
				if draw_item.is_show_requested then
					polyline ?= draw_item
					if polyline /= Void then
						draw_figure_bonpolyline (polyline, True)
					else
						g ?= draw_item
						if draw_routines.valid_index (draw_item.draw_id) then
							dr := draw_routines.item (draw_item.draw_id)
						else
							dr := Void
						end
						if g /= Void and then dr = Void then
							project_figure_group_full (g)
						else
							project_figure_full (draw_item)
						end
					end
				end
				i := i + 1
			end
		end

	draw_bon_inheritance (group: BON_INHERITANCE_FIGURE) is
			-- Draw `group'.
		require
			group_not_void: group /= Void
			group_show_requested: group.is_show_requested
		local
			draw_item: EV_MODEL
			g: EV_MODEL_GROUP
			i, nb: INTEGER
			dr: PROCEDURE [ANY, TUPLE [EV_MODEL]]
			polyline: EV_MODEL_POLYLINE
		do
			from
				i := 1
				nb := group.count
			until
				i > nb
			loop
				draw_item := group.i_th (i)
				if draw_item.is_show_requested then
					polyline ?= draw_item
					if polyline /= Void then
						draw_figure_bonpolyline (polyline, False)
					else
						g ?= draw_item
						if draw_routines.valid_index (draw_item.draw_id) then
							dr := draw_routines.item (draw_item.draw_id)
						else
							dr := Void
						end
						if g /= Void and then dr = Void then
							project_figure_group_full (g)
						else
							project_figure_full (draw_item)
						end
					end
				end
				i := i + 1
			end
		end

	draw_uml_inheritance (group: UML_INHERITANCE_FIGURE) is
			-- Draw `group'.
		require
			group_not_void: group /= Void
			group_show_requested: group.is_show_requested
		local
			draw_item: EV_MODEL
			g: EV_MODEL_GROUP
			i, nb: INTEGER
			dr: PROCEDURE [ANY, TUPLE [EV_MODEL]]
			polyline: EV_MODEL_POLYLINE
		do
			from
				i := 1
				nb := group.count
			until
				i > nb
			loop
				draw_item := group.i_th (i)
				if draw_item.is_show_requested then
					polyline ?= draw_item
					if polyline /= Void then
						draw_figure_umlpolyline (polyline, False)
					else
						g ?= draw_item
						if draw_routines.valid_index (draw_item.draw_id) then
							dr := draw_routines.item (draw_item.draw_id)
						else
							dr := Void
						end
						if g /= Void and then dr = Void then
							project_figure_group_full (g)
						else
							project_figure_full (draw_item)
						end
					end
				end
				i := i + 1
			end
		end

	draw_figure_umlpolyline (line: EV_MODEL_POLYLINE; is_client_supplier: BOOLEAN) is
			-- Draw standard representation of `polyline' to canvas.
		local
			p: EV_MODEL_POLYGON
			d: like drawable
			point_array, poly: ARRAY [EV_COORDINATE]
			a1, a2, p0: EV_COORDINATE
			old_lex, old_ley: DOUBLE
			l_item: EV_COORDINATE
			x1, y1, x2, y2: INTEGER
			pa: SPECIAL [EV_COORDINATE]
		do
			d := drawable
			d.set_foreground_color (line.foreground_color)


			if line.point_count > 2 then
				point_array := create {EV_COORDINATE_ARRAY}.make_from_area (line.point_array)

				d.set_line_width (line.line_width)

				p := line.end_arrow
				poly := create {EV_COORDINATE_ARRAY}.make_from_area (p.point_array)
				if offset_x /= 0 or else offset_y /= 0 then
					offset_coordinates (poly)
					if not is_client_supplier then
						d.set_foreground_color (default_colors.white)
						d.fill_polygon (poly)
						d.set_foreground_color (line.foreground_color)
					end
					d.draw_polyline (poly, not is_client_supplier)
					deoffset_coordinates (poly)
				else
					if not is_client_supplier then
						d.set_foreground_color (default_colors.white)
						d.fill_polygon (poly)
						d.set_foreground_color (line.foreground_color)
					end
					d.draw_polyline (poly, not is_client_supplier)
				end
				a1 := p.point_array.item (1)
				a2 := p.point_array.item (2)
				l_item := point_array.item (point_array.count)
				old_lex := l_item.x_precise
				old_ley := l_item.y_precise

				p0 := point_array.item (point_array.count - 1)
				x1 := p0.x
				y1 := p0.y
				if (old_lex - x1).abs <= 1 then
					l_item.set_precise (old_lex, (a1.y_precise + a2.y_precise) / 2)
				elseif (old_ley - y1).abs <= 1 then
					l_item.set_precise ((a1.x_precise + a2.x_precise) / 2, old_ley)
				else
					l_item.set_precise ((a1.x_precise + a2.x_precise) / 2, (a1.y_precise + a2.y_precise) / 2)
				end

				if offset_x /= 0 or else offset_y /= 0 then
					offset_coordinates (point_array)
					d.draw_polyline (point_array, line.is_closed)
					deoffset_coordinates (point_array)
				else
					d.draw_polyline (point_array, line.is_closed)
				end

				point_array.item (point_array.count).set_precise (old_lex, old_ley)
			else
				pa := line.point_array

				d.set_line_width (line.line_width)

				p := line.end_arrow
				poly := create {EV_COORDINATE_ARRAY}.make_from_area (p.point_array)
				if offset_x /= 0 or else offset_y /= 0 then
					offset_coordinates (poly)
					if not is_client_supplier then
						d.set_foreground_color (default_colors.white)
						d.fill_polygon (poly)
						d.set_foreground_color (line.foreground_color)
					end
					d.draw_polyline (poly, not is_client_supplier)

					deoffset_coordinates (poly)
				else
					if not is_client_supplier then
						d.set_foreground_color (default_colors.white)
						d.fill_polygon (poly)
						d.set_foreground_color (line.foreground_color)
					end
					d.draw_polyline (poly, not is_client_supplier)
				end
				a1 := p.point_array.item (1)
				a2 := p.point_array.item (2)

				p0 := pa.item (0)
				x1 := p0.x + offset_x
				y1 := p0.y + offset_y

				x2 := as_integer ((a1.x_precise + a2.x_precise) / 2) + offset_x
				y2 := as_integer ((a1.y_precise + a2.y_precise) / 2) + offset_y

				if (x1 - x2).abs = 1 then
					x1 := x2
				end
				if (y1 - y2).abs = 1 then
					y1 := y2
				end

				d.draw_segment (x1, y1, x2, y2)
			end
		end

	draw_figure_bonpolyline (line: EV_MODEL_POLYLINE; is_client_supplier: BOOLEAN) is
			-- Draw standard representation of `polyline' to canvas.
		local
			p: EV_MODEL_POLYGON
			d: like drawable
			point_array, poly: ARRAY [EV_COORDINATE]
			a1, a2, p0: EV_COORDINATE
			old_lex, old_ley: DOUBLE
			l_item: EV_COORDINATE
			x1, y1, x2, y2: INTEGER
			pa: SPECIAL [EV_COORDINATE]
		do
			d := drawable
			d.set_foreground_color (line.foreground_color)

			if line.point_count > 2 then
				point_array := create {EV_COORDINATE_ARRAY}.make_from_area (line.point_array)

				d.set_line_width (line.line_width)

				p := line.end_arrow
				poly := create {EV_COORDINATE_ARRAY}.make_from_area (p.point_array)
				if offset_x /= 0 or else offset_y /= 0 then
					offset_coordinates (poly)
					d.fill_polygon (poly)
					deoffset_coordinates (poly)
				else
					d.fill_polygon (poly)
				end
				a1 := p.point_array.item (1)
				a2 := p.point_array.item (2)
				l_item := point_array.item (point_array.count)
				old_lex := l_item.x_precise
				old_ley := l_item.y_precise

				p0 := point_array.item (point_array.count - 1)
				x1 := p0.x
				y1 := p0.y
				if (old_lex - x1).abs <= 1 then
					l_item.set_precise (old_lex, (a1.y_precise + a2.y_precise) / 2)
				elseif (old_ley - y1).abs <= 1 then
					l_item.set_precise ((a1.x_precise + a2.x_precise) / 2, old_ley)
				else
					l_item.set_precise ((a1.x_precise + a2.x_precise) / 2, (a1.y_precise + a2.y_precise) / 2)
				end

				if offset_x /= 0 or else offset_y /= 0 then
					offset_coordinates (point_array)
					d.draw_polyline (point_array, line.is_closed)
					if is_client_supplier and then line.line_width > 4 then
						d.set_line_width (line.line_width - 4)
						d.set_foreground_color (default_colors.white)
						d.draw_polyline (point_array, line.is_closed)
					end
					deoffset_coordinates (point_array)
				else
					d.draw_polyline (point_array, line.is_closed)
					if is_client_supplier and then line.line_width > 4 then
						d.set_line_width (line.line_width - 4)
						d.set_foreground_color (default_colors.white)
						d.draw_polyline (point_array, line.is_closed)
					end
				end

				point_array.item (point_array.count).set_precise (old_lex, old_ley)
			else
				pa := line.point_array

				d.set_line_width (line.line_width)

				p := line.end_arrow
				poly := create {EV_COORDINATE_ARRAY}.make_from_area (p.point_array)
				if offset_x /= 0 or else offset_y /= 0 then
					offset_coordinates (poly)
					d.fill_polygon (poly)
					deoffset_coordinates (poly)
				else
					d.fill_polygon (poly)
				end
				a1 := p.point_array.item (1)
				a2 := p.point_array.item (2)

				p0 := pa.item (0)
				x1 := p0.x + offset_x
				y1 := p0.y + offset_y

				x2 := as_integer ((a1.x_precise + a2.x_precise) / 2) + offset_x
				y2 := as_integer ((a1.y_precise + a2.y_precise) / 2) + offset_y
				if (x1 - x2).abs = 1 then
					x1 := x2
				end
				if (y1 - y2).abs = 1 then
					y1 := y2
				end
				d.draw_segment (x1, y1, x2, y2)
				if is_client_supplier and then line.line_width > 4 then
					d.set_line_width (line.line_width - 4)
					d.set_foreground_color (default_colors.white)
					d.draw_segment (x1, y1, x2, y2)
				end
			end

		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_PROJECTOR
