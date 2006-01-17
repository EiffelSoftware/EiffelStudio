indexing
	description: "Objects that is an UML view for an eiffel cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	UML_CLUSTER_FIGURE

inherit
	EIFFEL_CLUSTER_FIGURE
		redefine
			default_create,
			update,
			recursive_transform,
			set_name_label_text,
			minimum_size,
			set_is_selected,
			xml_node_name,
			xml_element,
			set_with_xml_element,
			recycle
		end

	UML_CONSTANTS
		undefine
			default_create
		end

	OBSERVER
		rename
			update as retrieve_preferences
		undefine
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create
		end

create
	make_with_model

create {UML_CLUSTER_FIGURE}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create a UML_CLUSTER_FIGURE.
		do
			Precursor {EIFFEL_CLUSTER_FIGURE}

			-- create the cluster rectangle
			create rectangle
			set_pointer_style (default_pixmaps.sizeall_cursor)
			extend (rectangle)
			send_to_back (rectangle)

			-- create the label rectangle
			create label_rectangle
			label_rectangle.pointer_double_press_actions.extend (agent on_label_double_press)
			extend (label_rectangle)
			bring_to_front (name_label)
			name_label.pointer_double_press_actions.extend (agent on_label_double_press)

			real_rectangle_border := 5.0
			real_label_rectangle_border := 5.0

			preferences.diagram_tool_data.add_observer (Current)
			retrieve_preferences
			is_shown := True
		end

	make_with_model (a_model: like model) is
			-- Create a UML_CLUSTER_FIGURE with `a_model'.
		require
			a_model_not_void: a_model /= Void
		do
			default_create
			model := a_model
			initialize

			disable_rotating
			disable_scaling

			request_update
		end

feature -- Access

	left: INTEGER is
			-- Left most position.
		do
			Result := rectangle.point_a_x
		end

	top: INTEGER is
			-- Top most position
		do
			Result := rectangle.point_a_y
		end

	right: INTEGER is
			-- Right most position.
		do
			Result := rectangle.point_b_x
		end

	bottom: INTEGER is
			-- Bottom most position.
		do
			Result := rectangle.point_b_y
		end

	port_x: INTEGER is
			-- x position where links are starting.
		do
			Result := rectangle.x
		end

	port_y: INTEGER is
			-- y position where links are starting.
		do
			Result := rectangle.y
		end

	size: EV_RECTANGLE is
			-- Size of `Current'.
		do
			create Result.make (rectangle.point_a_x, rectangle.point_a_y, rectangle.width, rectangle.height)
		end

	height: INTEGER is
			-- Height in pixels.
		do
			Result := rectangle.height
		end

	width: INTEGER is
			-- Width in pixels.
		do
			Result := rectangle.width
		end

	minimum_size: EV_RECTANGLE is
			-- `Current' has to be of `Result' size
			-- to include all visible elements starting from `number_of_figures' + 1.
		local
			l_area: like area
			i, nb: INTEGER
			l_bbox: like bounding_box
			l_item: EG_FIGURE
			l_border: INTEGER
		do
			if count <= number_of_figures then
				l_border := (real_rectangle_border * 5).truncated_to_integer
				create Result.make (port_x - 2 * l_border, port_y - l_border, 4 * l_border, 2 * l_border)
			else
				from
					l_area := area
					i := number_of_figures
					nb := count - 1
					l_item ?= l_area.item (i)
				until
					i > nb or else l_area.item (i).is_show_requested
				loop
					i := i + 1
					if i <= nb then
						l_item ?= l_area.item (i)
					end
				end
				if i <= nb then
					Result := l_area.item (i).bounding_box
					from
						i := i + 1
					until
						i > nb
					loop
						l_item ?= l_area.item (i)
						if l_area.item (i).is_show_requested then
							l_bbox := l_area.item (i).bounding_box
							if l_bbox.height > 0 or else l_bbox.width > 0 then
								Result.merge (l_bbox)
							end
						end
						i := i + 1
					end
				else
					l_border := (real_rectangle_border * 5).truncated_to_integer
					create Result.make (port_x - 2 * l_border, port_y - l_border, 4 * l_border, 2 * l_border)
				end
			end
		end

	xml_node_name: STRING is
			-- Name of the xml node returned by `xml_element'.
		do
			Result := "UML_CLUSTER_FIGURE"
		end

	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml element representing `Current's state.
		do
			Result := Precursor {EIFFEL_CLUSTER_FIGURE} (node)
			Result.put_last (Xml_routines.xml_node (Result, "IS_ICONIFIED", is_iconified.out))
			Result.put_last (Xml_routines.xml_node (Result, "IS_NEEDED_ON_DIAGRAM", model.is_needed_on_diagram.out))
		end

	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		do
			Precursor {EIFFEL_CLUSTER_FIGURE} (node)
			if xml_routines.xml_boolean (node, "IS_ICONIFIED") then
				if not is_iconified then
					collapse
					is_iconified := True
				end
			else
				if is_iconified then
					expand
					is_iconified := False
				end
			end
			if xml_routines.xml_boolean (node, "IS_NEEDED_ON_DIAGRAM") then
				model.enable_needed_on_diagram
			else
				model.disable_needed_on_diagram
			end
		end

feature -- Element change

	recycle is
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_CLUSTER_FIGURE}
			label_rectangle.pointer_double_press_actions.prune_all (agent on_label_double_press)
			name_label.pointer_double_press_actions.prune_all (agent on_label_double_press)
		end

	update_edge_point (p: EV_COORDINATE; an_angle: DOUBLE) is
			-- Set `p' position such that it is on a point on the edge of `Current'.
		local
			m: DOUBLE
			new_x, new_y: DOUBLE
			w2: DOUBLE
			mod_angle: DOUBLE
			l_pi, l_pi2: DOUBLE
		do
			l_pi := pi
			l_pi2 := l_pi / 2
			mod_angle := modulo (an_angle, 2 * l_pi)
			if mod_angle = 0 then
				new_x := right
				new_y := port_y
			elseif mod_angle = l_pi2 then
				new_x := port_x
				new_y := bottom
			elseif mod_angle = l_pi then
				new_x := left
				new_y := port_y
			elseif mod_angle = 3 * l_pi2 then
				new_x := port_x
				new_y := top
			else
				m := tangent (mod_angle)
				check
					m_never_zero: m /= 0.0
				end
				new_x := (bottom + m * port_x - port_y) / m
				w2 := (right - left) / 2
				if new_x > left and new_x < right then
					if mod_angle > 0 and mod_angle < l_pi then
						-- intersect with bottom line
						new_y := bottom
					else
						-- intersect with top line
						new_y := top
						new_x := 2 * port_x - new_x
					end
				else
					new_y := m * right - m * port_x + port_y
					if mod_angle > l_pi2 and mod_angle < 3 * l_pi2 then
						-- intersect with left line
						new_x := left
						new_y := 2 * port_y - new_y
					else
						-- intersect with right line
						new_x := right
					end
				end
			end
			p.set_precise (new_x, new_y)
		end

feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update is
			-- Some properties of current may have changed.
		local
			l_min_size: like minimum_size
			w, h, rb, lrb, l_left, l_top, l_right, l_bottom: INTEGER
			px, py, pax, pay: INTEGER
		do

			if is_shown then
				if is_iconified then
					rb := rectangle_border
					w := name_label.width
					h := name_label.height
					px := port_x
					py := port_y
					l_left := px - as_integer (w / 2)
					l_top := py - as_integer (h / 2)

					pax := l_left - rb
					pay := l_top - rb

					rectangle.set_point_a_position (pax, pay)
					rectangle.set_point_b_position (l_left + w + rb, l_top + h + rb)

					name_label.set_x_y (px, py)

					lrb := label_rectangle_border * 2
					label_rectangle.set_point_a_position (pax, pay - lrb)
					label_rectangle.set_point_b_position (pax + 2 * lrb, pay)

				else
					l_min_size := minimum_size
					rb := rectangle_border
					if user_size /= Void then
						l_left := (l_min_size.left - rb).min (user_size.left)
						l_top := (l_min_size.top - rb).min (user_size.top)
						l_right := (l_min_size.right + rb).max (user_size.right)
						l_bottom := (l_min_size.bottom + rb).max (user_size.bottom)
					else
						l_left := l_min_size.left - rb
						l_top := l_min_size.top - rb
						l_right := l_min_size.right + rb
						l_bottom := l_min_size.bottom + rb
					end
					rectangle.set_point_a_position (l_left, l_top)
					rectangle.set_point_b_position (l_right, l_bottom)

					lrb := label_rectangle_border
					label_rectangle.set_point_a_position (l_left, l_top - 2 * lrb - name_label.height)
					label_rectangle.set_point_b_position (l_left + name_label.width + 2 * lrb, l_top)

					name_label.set_point_position (l_left + lrb, label_rectangle.point_a_y + lrb)
				end
				Precursor {EIFFEL_CLUSTER_FIGURE}
			end
			is_update_required := False
		end

feature {EV_MODEL_GROUP} -- Transformation

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		local
			p0, p1: EV_COORDINATE
		do
			Precursor {EIFFEL_CLUSTER_FIGURE} (a_transformation)
			real_rectangle_border := real_rectangle_border * a_transformation.item (1, 1)
			real_label_rectangle_border := real_label_rectangle_border * a_transformation.item (1, 1)
			if user_size /= Void then
				create p0.make (user_size.left, user_size.top)
				create p1.make (user_size.right, user_size.bottom)
				a_transformation.project (p0)
				a_transformation.project (p1)
				create user_size.make (p0.x, p0.y, p1.x - p0.x, p1.y - p0.y)
			end
			request_update
		end

feature {EG_LAYOUT} -- Layouting

	set_to_minimum_size is
			-- Set `rectangle' to `minimum_size'.
		local
			l_min_size: like minimum_size
		do
			update_links
			l_min_size := minimum_size
			rectangle.set_point_a_position (l_min_size.left - rectangle_border, l_min_size.top - rectangle_border)
			rectangle.set_point_b_position (l_min_size.right + rectangle_border, l_min_size.bottom + rectangle_border)
			request_update
		end

feature {EIFFEL_WORLD} -- Show/Hide

	disable_shown is
			-- Hide `Current'.
		do
			rectangle.hide
			rectangle.disable_sensitive
			label_rectangle.hide
			label_rectangle.disable_sensitive
			name_label.hide
			resizer_bottom_left.disable_sensitive
			resizer_bottom_right.disable_sensitive
			resizer_top_left.disable_sensitive
			resizer_top_right.disable_sensitive
			request_update
			is_shown := False
		end

	enable_shown is
			-- Show `Current'.
		do
			rectangle.show
			rectangle.enable_sensitive
			label_rectangle.show
			label_rectangle.enable_sensitive
			name_label.show
			resizer_bottom_left.enable_sensitive
			resizer_bottom_right.enable_sensitive
			resizer_top_left.enable_sensitive
			resizer_top_right.enable_sensitive
			request_update
			is_shown := True
		end

feature {NONE} -- Implementation

	set_is_selected (an_is_selected: like is_selected) is
			-- Set `is_selected' to `an_is_selected'.
		do
			if is_selected /= an_is_selected then
				is_selected := an_is_selected
				if is_selected = True then
					rectangle.set_line_width (uml_cluster_line_width * 2)
					label_rectangle.set_line_width (uml_cluster_line_width * 2)
				else
					rectangle.set_line_width (uml_cluster_line_width)
					label_rectangle.set_line_width (uml_cluster_line_width)
				end
			end
		end

	label_rectangle_border: INTEGER is
			-- The border between the rectangle and the label.
		do
			Result := real_label_rectangle_border.truncated_to_integer
		end

	real_label_rectangle_border: REAL
			-- Real value for `label_rectangle_border'.

	rectangle_border: INTEGER is
			-- Minimum border between elements and `rectangle' border.
		do
			Result := real_rectangle_border.truncated_to_integer
		end

	real_rectangle_border: REAL
			-- Real value for `rectangle_border'.

	number_of_figures: INTEGER is 7
			-- Number of figures to visualize `Current'.
			-- high_quality: (`rectangle', `label_rectangle', `name_label', `resizer_top_left', `resizer_top_right', `resizer_bottom_right', `resizer_bottom_left').

	set_top_left_position (ax, ay: INTEGER) is
			-- Set position of top left corner to (`ax', `ay').
		do
			rectangle.set_point_a_position (ax, ay)
		end

	set_bottom_right_position (ax, ay: INTEGER) is
			-- Set position of bottom right corner to (`ax', `ay').
		do
			rectangle.set_point_b_position (ax, ay)
		end

	rectangle: EV_MODEL_RECTANGLE
			-- The rectangle.

	label_rectangle: EV_MODEL_RECTANGLE
			-- The rectangle for the label.

	set_name_label_text (a_text: STRING) is
			-- Set `name_label'.`text' to `a_text'.
		local
			s, rest: STRING
			i: INTEGER
		do
			if a_text.count > max_cluster_name_length then
				from
					s := ""
					rest := a_text
					i := a_text.last_index_of ('_', max_cluster_name_length)
					if i = 0 then
						i := max_cluster_name_length
					end
				until
					i = 0 or else rest.count <= max_cluster_name_length
				loop
					s := s + rest.substring (1, i) + "%N"
					rest := rest.substring (i + 1, rest.count)
					if rest.count > max_cluster_name_length then
						i := rest.last_index_of ('_', max_cluster_name_length)
						if i = 0 then
							i := max_cluster_name_length
						end
					end
				end
				s := s + rest
				name_label.set_text (s)
			else
				name_label.set_text (a_text)
			end
		end

	on_label_double_press (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Iconify or deiconify `Current'.
		local
			ew: EIFFEL_WORLD
		do
			ew ?= world
			if is_iconified then
				expand
				if ew /= Void then
					ew.context_editor.history.register_named_undoable (
						interface_names.t_diagram_cluster_expand (model.name),
						[<<agent expand, agent toggle_is_iconified, agent request_update>>],
						[<<agent collapse, agent toggle_is_iconified, agent request_update>>])
				end
			else
				collapse
				if ew /= Void then
					ew.context_editor.history.register_named_undoable (
						interface_names.t_diagram_cluster_collapse (model.name),
						[<<agent collapse, agent toggle_is_iconified, agent request_update>>],
						[<<agent expand, agent toggle_is_iconified, agent request_update>>])
				end
			end
			toggle_is_iconified
			request_update
		end

	toggle_is_iconified is
			-- Toggle value of `is_iconified'.
		do
			is_iconified := not is_iconified
			if is_iconified then
				if uml_cluster_iconified_fill_color /= Void then
					rectangle.set_background_color (uml_cluster_iconified_fill_color)
				else
					rectangle.remove_background_color
				end
			else
				if uml_cluster_fill_color /= Void then
					rectangle.set_background_color (uml_cluster_fill_color)
				else
					rectangle.remove_background_color
				end
			end
		end

	retrieve_preferences is
			-- Retrieve properties from preferences.
		do
			name_label.set_identified_font (uml_cluster_name_font)
			name_label.set_foreground_color (uml_cluster_name_color)

			rectangle.set_foreground_color (uml_cluster_line_color)
			if is_iconified then
				if uml_cluster_iconified_fill_color /= Void then
					rectangle.set_background_color (uml_cluster_iconified_fill_color)
				else
					rectangle.remove_background_color
				end
			else
				if uml_cluster_fill_color /= Void then
					rectangle.set_background_color (uml_cluster_fill_color)
				else
					rectangle.remove_background_color
				end
			end
			if is_selected then
				rectangle.set_line_width (uml_cluster_line_width * 2)
			else
				rectangle.set_line_width (uml_cluster_line_width)
			end

			label_rectangle.set_foreground_color (uml_cluster_line_color)
			if uml_cluster_name_area_color /= Void then
				label_rectangle.set_background_color (uml_cluster_name_area_color)
			end
			if is_selected then
				label_rectangle.set_line_width (uml_cluster_line_width * 2)
			else
				label_rectangle.set_line_width (uml_cluster_line_width)
			end
		end

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current is
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class UML_CLUSTER_FIGURE
