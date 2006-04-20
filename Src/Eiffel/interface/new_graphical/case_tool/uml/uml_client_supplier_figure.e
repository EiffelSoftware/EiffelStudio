indexing
	description: "Objects that is an UML view for a client supplier link."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	UML_CLIENT_SUPPLIER_FIGURE

inherit
	EIFFEL_CLIENT_SUPPLIER_FIGURE
		redefine
			update,
			default_create,
			set_foreground_color,
			recursive_transform,
			set_line_width,
			show_label,
			hide_label,
			is_label_shown,
			xml_element,
			xml_node_name,
			set_with_xml_element,
			set_name_label_text
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
	make_with_model,
	default_create

create {UML_CLIENT_SUPPLIER_FIGURE}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create a UML_CLIENT_SUPPLIER_FIGURE.
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE}

			real_reflexive_radius := reflexive_radius

			create aggregate_figure
			aggregate_figure.set_point_count (4)
			aggregate_figure.set_background_color (default_colors.white)
			aggregate_figure.set_i_th_point_position (1, 0, 0)
			aggregate_figure.set_i_th_point_position (2, -10, 10)
			aggregate_figure.set_i_th_point_position (3, 0, 20)
			aggregate_figure.set_i_th_point_position (4, 10, 10)
			create aggregate_group
			aggregate_group.extend (aggregate_figure)
			extend (aggregate_group)

			preferences.diagram_tool_data.add_observer (Current)
			retrieve_preferences

			create name_group
			name_group.extend (name_label)
			extend (name_group)

			is_label_shown := True
		end

	make_with_model (a_model: ES_CLIENT_SUPPLIER_LINK) is
			-- Create an UML_CLIENT_SUPPLIER_FIGURE with `a_model'.
		do
			default_create
			model := a_model
			initialize

			name_label.set_accept_cursor (cursors.cur_feature)
			name_label.set_deny_cursor (cursors.cur_x_feature)

			if not model.is_aggregated then
				aggregate_figure.hide
			end
			model.is_aggregated_changed.extend (agent on_is_aggregated_change)


			line.disable_end_arrow
			line.disable_start_arrow

			request_update
		end

feature -- Status report

	is_label_shown: BOOLEAN
			-- Is label shown?

feature -- Access

	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml node representing `Current's state.
		do
			Result := Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (node)
			conf_todo
--			Result.add_attribute ("SOURCE_CLUSTER", xml_namespace, model.client.class_i.cluster.cluster_name)
--			Result.add_attribute ("TARGET_CLUSTER", xml_namespace, model.supplier.class_i.cluster.cluster_name)
--			Result.remove_attribute_by_name ("NAME")
--			Result.put_last (Xml_routines.xml_node (Result, "IS_NEEDED_ON_DIAGRAM", model.is_needed_on_diagram.out))
--			Result.put_last (xml_routines.xml_node (Result, "REAL_LINE_WIDTH", (real_line_width * 100).rounded.out))
		end

	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		do
			node.forth
			node.forth
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (node)
			if xml_routines.xml_boolean (node, "IS_NEEDED_ON_DIAGRAM") then
				model.enable_needed_on_diagram
			else
				model.disable_needed_on_diagram
			end
			real_line_width := xml_routines.xml_integer (node, "REAL_LINE_WIDTH") / 100
			if real_line_width.rounded.max (1) /= line_width then
				line.set_line_width (real_line_width.rounded.max (1))
			end
		end

	xml_node_name: STRING is
			-- Name of the node returned by `xml_element'.
		do
			Result := "UML_CLIENT_SUPPLIER_FIGURE"
		end

feature -- Element change

	hide_label is
			-- Hide label.
		do
			name_label.hide
			is_label_shown := False
			request_update
		end

	show_label is
			-- Show label.
		do
			name_label.show
			is_label_shown := True
			request_update
		end

	set_line_width (a_line_width: like line_width) is
			-- Set `line_width' to `a_line_width'.
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (a_line_width)
			aggregate_figure.set_line_width (a_line_width)
			real_line_width := a_line_width
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Set `foreground_color' to `a_color'.
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (a_color)
			aggregate_figure.set_foreground_color (a_color)
		end

feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update is
			-- Some properties of `Current' may have changed.
		local
			p1, p2: EV_COORDINATE
			px, py, pc: INTEGER
			lbbox, obbox: EV_RECTANGLE
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE}

			pc := line.point_count
			create p1.make (line.i_th_point_x (pc -1), line.i_th_point_y (pc - 1))
			create p2.make (line.i_th_point_x (pc), line.i_th_point_y (pc))
			px := p2.x
			py := p2.y

			name_group.set_point_position (px, py)
			lbbox := name_label.bounding_box
			obbox := target.bounding_box

			if lbbox.intersects (obbox) then
				set_name_group_position_out_of_intersection (lbbox, obbox, p2, p1)
			end
			set_aggregate_figure_position
			is_update_required := False
		end

feature {EV_MODEL_GROUP} -- Transformation

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (a_transformation)
			real_line_width := real_line_width * a_transformation.item (1, 1)
			if real_line_width.rounded.max (1) /= line_width then
				line.set_line_width (real_line_width.rounded.max (1))
				request_update
			end
			real_reflexive_radius := real_reflexive_radius * a_transformation.item (1, 1)
			if real_reflexive_radius.truncated_to_integer /= reflexive_radius then
				reflexive_radius := real_reflexive_radius.truncated_to_integer
				request_update
			end
		end

feature {NONE} -- Implementation

	real_line_width: REAL
			-- Real line width.

	real_reflexive_radius: REAL
			-- Real radius of reflexive line.

	aggregate_figure: EV_MODEL_POLYGON
			-- Figure indicating that `Current' `is_aggregated'.

	aggregate_group: EV_MODEL_GROUP
			-- Group containing `aggregate_figure'.

	old_angle: DOUBLE

	multiplicity: EV_MODEL_TEXT

	name_group: EV_MODEL_GROUP

	set_aggregate_figure_position is
			-- Set `aggregate_figure' `a_distance' away from `end_point'.
		local
			an_angle: DOUBLE
			a_point, b_point: EV_COORDINATE
		do
			a_point := line.point_array.item (1)
			b_point := line.point_array.item (0)
			an_angle := line_angle (a_point.x_precise, a_point.y_precise, b_point.x_precise, b_point.y_precise) + pi / 2

			aggregate_group.rotate_around (an_angle - old_angle, aggregate_group.point_x, aggregate_group.point_y)
			aggregate_group.set_point_position (b_point.x, b_point.y)

			old_angle := an_angle
		end

	on_is_aggregated_change is
			-- `model'.`is_aggregated' was changed.
		do
			if model.is_aggregated then
				aggregate_figure.show
			else
				aggregate_figure.hide
			end
		end

	set_name_group_position_out_of_intersection (label_bbox, other_bbox: EV_RECTANGLE; p, q: EV_COORDINATE) is
			-- Set position of `name_label' such that `label_bbox' does not intersect with `other_bbox'
			-- and `point' position of `name_group' is on the line from `p' to `q'.
		require
			label_bbox_not_void: label_bbox /= Void
			other_bbox_not_void: other_bbox /= Void
			intersects: other_bbox.intersects (label_bbox)
			p_not_void: p /= Void
			q_not_void: q /= Void
		local
			d_x, d_y: DOUBLE
			m: DOUBLE
			nx, ny: DOUBLE
			lx, ly: DOUBLE
			eq: DOUBLE
			intersect_bottom, intersect_top, intersect_left, intersect_right: BOOLEAN
			through_x, through_y: DOUBLE
		do
			d_x := q.x_precise - p.x_precise
			d_y := q.y_precise - p.y_precise
			lx := name_group.point_x
			ly := name_group.point_y
			if d_x = 0 then
				if d_y < 0 then
					nx := p.x_precise
					ny := ly - (label_bbox.bottom - other_bbox.top) - 1
				else
					nx := p.x_precise
					ny := ly + (other_bbox.bottom - label_bbox.top) + 1
				end
			elseif d_y = 0 then
				if d_x < 0 then
					nx := lx - (label_bbox.right - other_bbox.left) - 1
					ny := p.y_precise
				else
					nx := lx + (other_bbox.right - label_bbox.left) + 1
					ny := p.y_precise
				end
			else
				m := d_y / d_x
				check
					m /= 0
				end
				if d_y > 0 then
					through_y := label_bbox.top
				else
					through_y := label_bbox.bottom
				end
				if d_x > 0 then
					through_x := label_bbox.left
				else
					through_x := label_bbox.right
				end
				eq := (other_bbox.bottom + m * through_x - through_y) / m
				if d_y > 0 and then d_x > 0 then
					if eq < other_bbox.right then
						intersect_bottom := True
					else
						intersect_right := True
					end
				elseif d_y > 0 and then d_x < 0 then
					if eq > other_bbox.left then
						intersect_bottom := True
					else
						intersect_left := True
					end
				else
					eq := (other_bbox.top + m * through_x - through_y) / m
					if d_x > 0 then
						if eq < other_bbox.right then
							intersect_top := True
						else
							intersect_right := True
						end
					else
						if eq > other_bbox.left then
							intersect_top := True
						else
							intersect_left := True
						end
					end
				end
				check
					one_intersection: intersect_bottom xor intersect_top xor intersect_right xor intersect_left
				end

				if intersect_bottom then
					ny := ly + (other_bbox.bottom - label_bbox.top) + 2
					nx := (ny + m*lx - ly) / m
				elseif intersect_top then
					ny := ly - (label_bbox.bottom - other_bbox.top) - 2
					nx := (ny + m*lx - ly) / m
				elseif intersect_right then
					nx := lx + (other_bbox.right - label_bbox.left) + 2
					ny := m * (nx - lx) + ly
				elseif intersect_left then
					nx := lx - (label_bbox.right - other_bbox.left) - 2
					ny := m * (nx - lx) + ly
				end
			end
			name_group.set_point_position (as_integer (nx) + 5, as_integer (ny))
		end

	retrieve_preferences is
			-- Retrieve preferences when changed.
		do
			name_label.set_identified_font (uml_client_label_font)
			name_label.set_foreground_color (uml_client_label_color)
			set_foreground_color (uml_client_color)
			set_line_width (uml_client_line_width)
		end

	set_name_label_text (a_text: STRING) is
			-- Set `name_label'.`text' to `a_text'.
		local
			l_features: LIST [FEATURE_AS]
			l_item: FEATURE_AS
			e_feature: E_FEATURE
		do
			name_label.set_text (a_text)
			l_features := model.features
			if l_features.is_empty then
				name_label.remove_pebble
			else
				l_item := l_features.first

				e_feature := e_feature_from_abstract (l_item)

				if e_feature /= Void then
					name_label.set_pebble (create {FEATURE_STONE}.make (e_feature))
				else
					name_label.set_pebble (create {CLASSI_STONE}.make (model.client.class_i))
				end
			end
		end

invariant
	foreground_color_not_void: foreground_color /= Void
	aggregate_figure_not_void: aggregate_figure /= Void

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

end -- class UML_CLIENT_SUPPLIER_FIGURE
