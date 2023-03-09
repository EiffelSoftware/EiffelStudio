note
	description: "Objects that is a BON view for an EIFFEL_CLIENT_SUPPLIER_LINK"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLIENT_SUPPLIER_FIGURE

inherit
	EIFFEL_CLIENT_SUPPLIER_FIGURE
		undefine
			is_storable
		redefine
			add_point_between,
			default_create,
			hide_label,
			is_label_shown,
			line,
			recursive_transform,
			recycle,
			reset,
			remove_i_th_point,
			retrieve_edges,
			set_foreground_color,
			set_line_width,
			set_name_label_text,
			set_with_xml_element,
			show_label,
			update,
			xml_element,
			xml_node_name
		select
			default_create,
			set_with_xml_element,
			xml_element
		end

	EG_POLYLINE_LABEL
		rename
			update as update_label_position,
			default_create as default_create_label,
			xml_element as polyline_label_xml_element,
			set_with_xml_element as polyline_label_set_with_xml_element,
			recycle as polyline_lable_recycle
		redefine
			set_label_position_on_line
		end

	BON_FIGURE
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

create {BON_CLIENT_SUPPLIER_FIGURE}
	make_filled

feature {NONE} -- Access

	line: ES_DOUBLE_POLYLINE
			-- A model for drawing the figure.

feature {NONE} -- Initialization

	default_create
			-- Create a BON_CLIENT_SUPPLIER_FIGURE.
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE}
			default_create_label
			is_high_quality := True

				-- Create `aggregate_figure' before doing any manipulation
				-- as otherwise we can be called back and we would violate our invariant.
			create aggregate_figure

			label_group.extend (name_label)
			extend (label_move_handle)

			extend (aggregate_figure)
			aggregate_figure.set_line_width (2)

			real_arrow_head_size := {REAL_32} 10.0
			real_reflexive_radius := reflexive_radius

			label_move_handle.set_pointer_style (default_pixmaps.sizeall_cursor)

			preferences.diagram_tool_data.add_observer (Current)
			retrieve_preferences

			is_label_shown := True
		end

	make_with_model (a_model: ES_CLIENT_SUPPLIER_LINK)
			-- Create an BON_CLIENT_SUPPLIER_FIGURE with `a_model'.
		do
			default_create
			model := a_model
			initialize

			name_label.set_accept_cursor (cursors.cur_feature)
			name_label.set_deny_cursor (cursors.cur_x_feature)
			label_group.pointer_double_press_actions.extend (agent on_label_group_double_clicked)

			if not model.is_aggregated then
				aggregate_figure.hide
			end
			model.is_aggregated_changed.extend (agent on_is_aggregated_change)

			position_on_line := 0.5
			request_update
		end

feature -- Status report

	is_label_shown: BOOLEAN
			-- Is label shown?

	is_label_expanded: BOOLEAN
			-- Is name label expanded?

feature -- Access

	xml_element (node: like xml_element): XML_ELEMENT
			-- Xml node representing `Current's state.
		local
			was_low: BOOLEAN
			l_xml_routines: like xml_routines
			l_model: like model
		do
			l_xml_routines := xml_routines
			l_model := model
			if not is_high_quality then
				enable_high_quality
				was_low := True
			end
			Result := Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (node)
			Result.remove_attribute_by_name (name_string)
			Result.put_last (l_xml_routines.xml_node (Result, once "IS_LABEL_EXPANDED", boolean_representation (is_label_expanded)))
			Result.put_last (l_xml_routines.xml_node (Result, is_needed_on_diagram_string, boolean_representation (l_model.is_needed_on_diagram)))
			Result.put_last (l_xml_routines.xml_node (Result, once "REAL_LINE_WIDTH", (real_line_width * 100).rounded.out))

			Result := polyline_label_xml_element (Result)
			if was_low then
				disable_high_quality
			end
		end

	set_with_xml_element (node: like xml_element)
			-- Retrive state from `node'.
		local
			was_low: BOOLEAN
			l_xml_routines: like xml_routines
		do
			l_xml_routines := xml_routines
			if not is_high_quality then
				enable_high_quality
				was_low := True
			end
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (node)
			if l_xml_routines.xml_boolean (node, once "IS_LABEL_EXPANDED") then
				is_label_expanded := True
				on_name_change
			else
				is_label_expanded := False
				on_name_change
			end
			if l_xml_routines.xml_boolean (node, once "IS_NEEDED_ON_DIAGRAM") then
				model.enable_needed_on_diagram
			else
				model.disable_needed_on_diagram
			end
			real_line_width := (l_xml_routines.xml_integer (node, once "REAL_LINE_WIDTH") / 100).truncated_to_real
			if real_line_width.rounded.max (1) /= line_width then
				set_line_width (real_line_width.rounded.max (1))
			end
			polyline_label_set_with_xml_element (node)
			if was_low then
				disable_high_quality
			end
		end

	xml_node_name: STRING
			-- Name of the node returned by `xml_element'.
		do
			Result := {BON_FACTORY}.xml_client_supplier_figure_node_name
		end

feature -- Element change

	recycle
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE}
			label_group.pointer_double_press_actions.prune_all (agent on_label_group_double_clicked)
			if model /= Void then
				model.is_aggregated_changed.prune_all (agent on_is_aggregated_change)
			end
			polyline_lable_recycle
			preferences.diagram_tool_data.remove_observer (Current)
		end

	hide_label
			-- Hide label.
		do
			if is_high_quality then
				label_group.hide
				label_group.disable_sensitive
			else
				name_label.hide
			end
			is_label_shown := False
			request_update
		end

	show_label
			-- Show label.
		do
			if is_high_quality then
				label_group.show
				label_group.enable_sensitive
				if not is_label_expanded then
					name_label.show
				else
					name_label.hide
				end
			else
				name_label.show
			end
			is_label_shown := True
			request_update
		end

	set_line_width (a_line_width: like line_width)
			-- Set `line_width' to `a_line_width'.
		local
			arrow_size: like line.arrow_size
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (a_line_width)
				-- Make arrow proportional to the line width.
			arrow_size := (a_line_width + (a_line_width * 0.8).max (4.0)).rounded
			line.set_arrow_size (arrow_size)
				-- Update aggregate figure.
			aggregate_figure.set_line_width ((a_line_width * 0.3).max (1.0).rounded)
			set_aggregate_figure_position (arrow_size * 2)
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Set `foreground_color' to `a_color'.
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (a_color)
			aggregate_figure.set_foreground_color (a_color)
		end

	add_point_between (i, j: INTEGER)
			-- Add a point between `i'-th and `j'-th point.
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (i, j)
			set_label_line_start_and_end
		end

	remove_i_th_point (i: INTEGER)
			-- Remove `i'-th point.
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (i)
			set_label_line_start_and_end
			request_update
		end

	retrieve_edges (retrieved_edges: LIST [EG_EDGE])
			-- Add lines corresponding to the points in `retrieved_edges'.
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (retrieved_edges)
			set_label_line_start_and_end
			request_update
		end

	reset
			--
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE}
			set_label_line_start_and_end
		end

feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update
			-- Some properties of `Current' may have changed.
		local
			an_angle: DOUBLE
			l_point_array: SPECIAL [EV_COORDINATE]
			p0, p1: EV_COORDINATE
		do
			if is_high_quality then
				Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE}
				if label_group.is_show_requested then
					update_label_position
				end
				set_aggregate_figure_position (line.arrow_size * 2)
			else
				if is_reflexive then
					low_quality_circle.set_x_y (source.port_x + as_integer (source.width / 2 + reflexive_radius / 2), source.port_y)
					name_label.set_point_position (source.port_x + as_integer (source.width / 2), low_quality_circle.y - as_integer (name_label.height / 2))
				else
					l_point_array := low_quality_line.point_array
					p0 := l_point_array.item (0)
					p1 := l_point_array.item (1)

					if source /= Void then
						p0.set_position (source.port_x, source.port_y)
					end
					if target /= Void then
						p1.set_position (target.port_x, target.port_y)
					end
					an_angle := line_angle (p0.x_precise, p0.y_precise, p1.x_precise, p1.y_precise)
					if source /= Void then
						source.update_edge_point (p0, an_angle)
					end
					if target /= Void then
						target.update_edge_point (p1, an_angle + pi)
					end
					low_quality_line.invalidate
					low_quality_line.center_invalidate
					name_label.set_x_y (low_quality_line.x, low_quality_line.y)
				end
			end
			is_update_required := False
		end

feature {EV_MODEL_GROUP} -- Transformation

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION)
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (a_transformation)
			real_line_width := real_line_width * a_transformation.item (1, 1).truncated_to_real
			real_arrow_head_size := real_arrow_head_size * a_transformation.item (1, 1).truncated_to_real
			if real_line_width.rounded.max (1) /= line_width then
				set_line_width (real_line_width.rounded.max (1))
			end
			if
				real_arrow_head_size.rounded.max (1) /= line.arrow_size and then
				not is_high_quality and then
				not is_reflexive
			then
				low_quality_line.set_arrow_size (real_arrow_head_size.rounded.max (1))
				request_update
			end
			real_reflexive_radius := real_reflexive_radius * a_transformation.item (1, 1).truncated_to_real
			if real_reflexive_radius.truncated_to_integer /= reflexive_radius then
				reflexive_radius := real_reflexive_radius.truncated_to_integer
				request_update
			end
		end

feature {NONE} -- Implementation

	real_reflexive_radius: REAL
			-- Real distance of the line from the linkable border if `is_reflexive'.

	real_line_width: REAL
			-- Real line width.

	real_arrow_head_size: REAL
			-- Real size of arrow head.

	polyline_points: SPECIAL [EV_COORDINATE]
			-- Points defining the line.
			-- | For EG_POLYLINE_LABEL.
		do
			Result := line.point_array
		end

	low_quality_line: EV_MODEL_LINE
			-- line used to visualize `Current' if `is_high_quality' is False.

	low_quality_circle: EV_MODEL_ELLIPSE
			-- Circle used to visualize `Current' if not `is_high_quality' and `is_reflexive'.

	aggregate_figure: EV_MODEL_LINE
			-- Figure indicating that `Current' `is_aggregated'.

	aggregate_figure_length: INTEGER
			-- Length of aggregate figure.
		do
			Result := line.arrow_size
		ensure
			Result_positive: Result >= 0
		end

	set_aggregate_figure_position (a_distance: INTEGER)
			-- Set `aggregate_figure' `a_distance' away from `end_point'.
		local
			an_angle: DOUBLE
			s: INTEGER
			cos, sin, dcos, dsin, hssin, hscos: DOUBLE
			a_point, b_point: EV_COORDINATE
			px, py: INTEGER
		do
			a_point := line.point_array.item (line.point_count - 1)
			b_point := line.point_array.item (line.point_count - 2)
			an_angle := line_angle (a_point.x_precise, a_point.y_precise, b_point.x_precise, b_point.y_precise)

			s := aggregate_figure_length + line_width

			cos := cosine (an_angle)
			sin := sine (an_angle)
			dcos := a_distance * cos
			dsin := a_distance * sin
			hssin := -s / 2 * sin
			hscos := -s / 2 * cos

			px := a_point.x
			py := a_point.y

			aggregate_figure.set_point_a_position (px + as_integer (dcos - hssin), py + as_integer (dsin + hscos))
			aggregate_figure.set_point_b_position (px + as_integer (dcos + hssin), py + as_integer (dsin - hscos))
		end

	on_is_aggregated_change
			-- `model'.`is_aggregated' was changed.
		do
			if model.is_aggregated then
				aggregate_figure.show
			else
				aggregate_figure.hide
			end
		end

	set_label_position_on_line (nearest_start, nearest_end: EV_COORDINATE)
			-- Set the `label_move_handle' position such that its point is
			-- on the segment from `nearest_start' to `nearest_end'.
		do
			Precursor {EG_POLYLINE_LABEL} (nearest_start, nearest_end)
			if source /= Void and then target /= Void then
					-- do not intersect with start or target figure
				source.update_rectangle_to_bounding_box (reusable_rectangle_1)
				label_group.update_rectangle_to_bounding_box (reusable_rectangle_2)
				if reusable_rectangle_1.intersects (reusable_rectangle_2) then
					set_label_move_handle_position_out_of_intersection (reusable_rectangle_2, reusable_rectangle_1, nearest_start, nearest_end)
					label_group.update_rectangle_to_bounding_box (reusable_rectangle_2)
				end
				target.update_rectangle_to_bounding_box (reusable_rectangle_1)
				if reusable_rectangle_1.intersects (reusable_rectangle_2) then
					set_label_move_handle_position_out_of_intersection (reusable_rectangle_2, reusable_rectangle_1, nearest_start, nearest_end)
				end
			end
		end

	set_label_move_handle_position_out_of_intersection (label_bbox, other_bbox: EV_RECTANGLE; p, q: EV_COORDINATE)
			-- Set position of `label_move_handle' such that `label_bbox' does not intersect with `other_bbox'
			-- and `point' position of `label_move_handle' is on the line from `p' to `q'.
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
			lx := label_move_handle.point_x
			ly := label_move_handle.point_y
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
			label_move_handle.set_point_position (as_integer (nx), as_integer (ny))
		end

	on_label_group_double_clicked (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- User doubleclicked on `label_group'.
		do
			is_label_expanded := not is_label_expanded
			on_name_change
		end

	set_name_label_text (a_text: READABLE_STRING_32)
			-- Set `name_label'.`text' to `a_text'.
		local
			txt: EV_MODEL_TEXT
			l_features: LIST [FEATURE_AS]
			l_feature_names: EIFFEL_LIST [FEATURE_NAME]
			str: STRING_32
			sorted_names: SORTED_TWO_WAY_LIST [EV_MODEL_TEXT]
			signature: STRING_32
			cur_y: INTEGER
		do
			if not is_label_expanded then
				label_group.wipe_out
				name_label.set_text (a_text)
				name_label.show
				name_label.enable_sensitive
				name_label.set_point_position (label_group.point_x + 5, label_group.point_y)
				label_group.extend (name_label)

				l_features := model.features
				if l_features.is_empty then
					name_label.remove_pebble
				else
					name_label.set_pebble
						(if attached e_feature_from_abstract (l_features.first) as e_feature then
							create {FEATURE_STONE}.make (e_feature)
						else
							create {CLASSI_STONE}.make (model.client.class_i)
						end)
				end
			else
				label_group.wipe_out
				name_label.hide
				name_label.disable_sensitive
				name_label.set_text (a_text)
				create sorted_names.make
				l_features := model.features
				from
					l_features.start
				until
					l_features.after
				loop
					signature := model.full_signature (l_features.item)
					signature.replace_substring_all (model.supplier.name_32, {STRING_32} "...")
					if signature.substring (signature.count - 4, signature.count).same_string ({STRING_32} ": ...") then
						signature.replace_substring_all ({STRING_32} ": ...", {STRING_32} "")
					end
					l_feature_names := l_features.item.feature_names
					from
						l_feature_names.start
					until
						l_feature_names.after
					loop
						create str.make_from_string (l_feature_names.item.visual_name_32)
						str.append (signature)
						create txt.make_with_text (str)
						txt.set_identified_font (bon_client_label_font)
						txt.set_foreground_color (bon_client_label_color)
						if world /= Void then
							txt.scale (world.scale_factor)
						end
						txt.set_pebble
							(if attached e_feature_from_abstract (l_features.item) as e_feature then
								create {FEATURE_STONE}.make (e_feature)
							else
								create {CLASSI_STONE}.make (model.client.class_i)
							end)
						txt.set_accept_cursor (cursors.cur_feature)
						txt.set_deny_cursor (cursors.cur_x_feature)
						sorted_names.extend (txt)

						l_feature_names.forth
						l_features.forth
					end
				end
				check
					is_sorted: sorted_names.sorted
				end
				across
					sorted_names as n
				from
					cur_y := label_group.point_y
				loop
					txt := n.item
					txt.set_point_position (label_group.point_x + 5, cur_y)
					label_group.extend (txt)
					cur_y := cur_y + ((txt.height * 12) // 10)
				end
			end
		end

	set_is_high_quality (an_is_high_quality: like is_high_quality)
			-- Set `is_high_quality' to `an_is_high_quality'.
		local
			l_mh: EV_MODEL_MOVE_HANDLE
		do
			if an_is_high_quality /= is_high_quality then
				is_high_quality := an_is_high_quality
				if is_high_quality then
					if is_reflexive then
						prune_all (low_quality_circle)
					else
						prune_all (low_quality_line)
					end
					prune_all (name_label)
					line.enable_sensitive
					extend (line)
					extend (aggregate_figure)
					name_label.set_point_position (label_group.point_x, label_group.point_y)
					label_group.extend (name_label)
					extend (label_move_handle)
					label_move_handle.enable_sensitive
					across
						edge_move_handlers as h
					loop
						l_mh := h.item
						extend (l_mh)
						l_mh.enable_sensitive
					end
					if not is_label_shown then
						label_group.hide
						label_group.disable_sensitive
					else
						label_group.show
						if not is_label_expanded then
							name_label.show
						else
							name_label.hide
						end
						label_group.enable_sensitive
					end
				else
					prune_all (label_move_handle)
					label_move_handle.disable_sensitive
					prune_all (line)
					line.disable_sensitive
					prune_all (aggregate_figure)
					across
						edge_move_handlers as h
					loop
						l_mh := h.item
						prune_all (l_mh)
						l_mh.disable_sensitive
					end

					if is_reflexive then
						create low_quality_circle.make_with_positions (0, 0, reflexive_radius, reflexive_radius)
						low_quality_circle.set_foreground_color (foreground_color)
						extend (low_quality_circle)
					else
						create low_quality_line
						low_quality_line.enable_end_arrow
						low_quality_line.set_foreground_color (foreground_color)
						low_quality_line.set_arrow_size (real_arrow_head_size.rounded.max (1))
						extend (low_quality_line)
					end
					extend (name_label)
					if not is_label_shown then
						name_label.hide
					else
						name_label.show
					end
				end
				request_update
			end
		end

	retrieve_preferences
			-- Retrieve preferences from shared resources.
		do
			across
				label_group as g
			loop
				if attached {EV_MODEL_TEXT} g.item as txt then
					txt.set_identified_font (bon_client_label_font)
					txt.set_foreground_color (bon_client_label_color)
				end
			end
			name_label.set_identified_font (bon_client_label_font)
			name_label.set_foreground_color (bon_client_label_color)
			set_foreground_color (bon_client_color)
			set_line_width (bon_client_line_width)
			real_line_width := line_width
		end

feature {NONE} -- Optimization

	reusable_rectangle_1: EV_RECTANGLE
			-- Temporary reusable rectangle used to prevent recreation of objects.
		once
			create Result
		end

	reusable_rectangle_2: EV_RECTANGLE
		-- Temporary reusable rectangle used to prevent recreation of objects.
		once
			create Result
		end

invariant
	aggregate_figure_not_void: aggregate_figure /= Void

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
