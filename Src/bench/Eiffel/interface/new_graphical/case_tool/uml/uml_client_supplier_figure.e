indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UML_CLIENT_SUPPLIER_FIGURE
	
inherit
	EIFFEL_CLIENT_SUPPLIER_FIGURE
		redefine
			update,
--			remove_i_th_point,
--			add_point_between,
			default_create,
			set_foreground_color,
			recursive_transform,
			set_line_width,
--			retrieve_edges,
			show_label,
			hide_label,
--			set_name_label_text,
			is_label_shown,
			xml_element,
			xml_node_name,
			set_with_xml_element
--			reset
		end
	
--	EG_POLYLINE_LABEL
--		rename
--			update as update_label_position,
--			default_create as default_create_label,
--			xml_element as polyline_label_xml_element,
--			set_with_xml_element as polyline_label_set_with_xml_element
--		redefine
--			set_label_position_on_line
--		end
--		
--	BON_FIGURE
--		undefine
--			default_create
--		end

	UML_CONSTANTS
		undefine
			default_create
		end
		
create
	make_with_model,
	default_create
	
feature {NONE} -- Initialization

	default_create is
			-- Create a UML_CLIENT_SUPPLIER_FIGURE.
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE}

			label_font := uml_client_label_font
			label_color := uml_client_label_color
			
			create aggregate_figure
			aggregate_figure.set_point_count (4)
			aggregate_figure.set_background_color (default_colors.white)
			aggregate_figure.set_i_th_point_position (1, 0, 0)
			aggregate_figure.set_i_th_point_position (2, -10, 10)
			aggregate_figure.set_i_th_point_position (3, 0, 20)
			aggregate_figure.set_i_th_point_position (4, 10, 10)
			aggregate_figure.set_line_width (uml_client_line_width)
			aggregate_figure.set_foreground_color (foreground_color)
			create aggregate_group
			aggregate_group.extend (aggregate_figure)
			extend (aggregate_group)
			
			name_label.set_font (label_font)
			name_label.set_foreground_color (label_color)

			set_foreground_color (uml_client_color)
			set_line_width (uml_client_line_width)
			
--			create multiplicity
--			multiplicity.set_font (label_font)
--			multiplicity.set_foreground_color (label_color)
--			extend (multiplicity)
			
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
--			name_label.pointer_double_press_actions.extend (agent on_name_label_double_clicked)
			
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
			
--	is_label_expanded: BOOLEAN
--			-- Is name label expanded?

feature -- Access

	label_color: EV_COLOR
			-- Feature name color.

	label_font: EV_FONT
			-- Font used for the feature name.
			
	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml node representing `Current's state.
		do
			Result := Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (node)
			Result.add_attribute ("SOURCE_CLUSTER", xml_namespace, model.client.class_i.cluster.cluster_name)
			Result.add_attribute ("TARGET_CLUSTER", xml_namespace, model.supplier.class_i.cluster.cluster_name)
			Result.remove_attribute_by_name ("NAME")
--			Result.put_last (Xml_routines.xml_node (Result, "IS_LABEL_EXPANDED", is_label_expanded.out))
			Result.put_last (Xml_routines.xml_node (Result, "IS_NEEDED_ON_DIAGRAM", model.is_needed_on_diagram.out))
			Result.put_last (xml_routines.xml_node (Result, "REAL_LINE_WIDTH", (real_line_width * 100).rounded.out))
		end
		
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		do
			node.forth
			node.forth
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (node)
--			if xml_routines.xml_boolean (node, "IS_LABEL_EXPANDED") then
--				is_label_expanded := True
--				on_name_change
--			else
--				is_label_expanded := False
--				on_name_change
--			end
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
			real_line_width := a_line_width
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Set `foreground_color' to `a_color'.
		do
			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (a_color)
			aggregate_figure.set_foreground_color (a_color)
		end

	set_label_color (a_label_color: like label_color) is
			-- Set `label_color' to `a_label_color'.
		require
			a_label_color_not_void: a_label_color /= Void
		do
			label_color := a_label_color
			name_label.set_foreground_color (label_color)
		ensure
			label_color_assigned: label_color = a_label_color
		end

	set_label_font (a_label_font: like label_font) is
			-- Set `label_font' to `a_label_font'.
		require
			a_label_font_not_void: a_label_font /= Void
		do
			label_font := a_label_font
			name_label.set_font (label_font)
			request_update
		ensure
			label_font_assigned: label_font = a_label_font
		end
		
--	add_point_between (i, j: INTEGER) is
--			-- Add a point between `i'-th and `j'-th point.
--		do
--			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (i, j)
--			set_label_line_start_and_end
--		end
--		
--	remove_i_th_point (i: INTEGER) is
--			-- Remove `i'-th point.
--		do
--			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (i)
--			set_label_line_start_and_end
--			request_update
--		end
--		
--	retrieve_edges (retrieved_edges: LIST [EG_EDGE]) is
--			-- Add lines corresponding to the points in `retrieved_edges'.
--		do
--			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE} (retrieved_edges)
--			set_label_line_start_and_end
--			request_update
--		end
--		
--	reset is
--			-- 
--		do
--			Precursor {EIFFEL_CLIENT_SUPPLIER_FIGURE}
--			set_label_line_start_and_end
--		end
--		
		
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
--			p1 := line.i_th_point (line.point_count -1)
--			p2 := line.i_th_point (line.point_count)
			px := p2.x
			py := p2.y
			
			name_group.set_point_position (px, py)
--			set_label_group_position_on_line (px, py, p2, p1)
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
		end
	
feature {NONE} -- Implementation

	real_line_width: REAL
			-- Real line width.
	
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
--			s: INTEGER
--			cos, sin, dcos, dsin, hssin, hscos: DOUBLE
			a_point, b_point: EV_COORDINATE
--			px, py: INTEGER
		do
			a_point := line.point_array.item (1)
			b_point := line.point_array.item (0)
			an_angle := line_angle (a_point.x_precise, a_point.y_precise, b_point.x_precise, b_point.y_precise) + pi / 2
			
			
			
			aggregate_group.rotate_around (an_angle - old_angle, aggregate_group.point_x, aggregate_group.point_y)
			aggregate_group.set_point_position (b_point.x, b_point.y)
			
			old_angle := an_angle
--			
--			s := aggregate_figure_length + line_width
--			
--			cos := cosine (an_angle)
--			sin := sine (an_angle)
--			dcos := a_distance * cos
--			dsin := a_distance * sin
--			hssin := -s / 2 * sin
--			hscos := -s / 2 * cos
--			
--			px := a_point.x
--			py := a_point.y
--			
--			aggregate_figure.set_point_a_position (px + (dcos - hssin).truncated_to_integer, py + (dsin + hscos).truncated_to_integer)
--			aggregate_figure.set_point_b_position (px + (dcos + hssin).truncated_to_integer, py + (dsin - hscos).truncated_to_integer)	
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
		
--	set_label_position_on_line (nearest_start, nearest_end: EV_COORDINATE) is
--			-- Set the `label_move_handle' position such that its point is
--			-- on the segment from `nearest_start' to `nearest_end'.
--		local
--			l_point_array: like point_array
--			other_bbox, label_bbox: EV_RECTANGLE
--		do
--			Precursor {EG_POLYLINE_LABEL} (nearest_start, nearest_end)
--			
--			if source /= Void and then target /= Void then
--				-- do not intersect with start or target figure
--				l_point_array := point_array
--				other_bbox := source.bounding_box
--				label_bbox := label_group.bounding_box
--				if other_bbox.intersects (label_bbox) then
--					set_label_move_handle_position_out_of_intersection (label_bbox, other_bbox, nearest_start, nearest_end)
--				end
--				other_bbox := target.bounding_box
--				label_bbox := label_group.bounding_box
--				if other_bbox.intersects (label_bbox) then
--					set_label_move_handle_position_out_of_intersection (label_bbox, other_bbox, nearest_end, nearest_start)
--				end
--			end
--		end
--		

--	set_label_group_position_on_line (new_x, new_y: DOUBLE; p, q: EV_COORDINATE) is
--			-- Set `label_group' position to left or right of line from `p' to `q' depending on `is_left'.
--			-- Afterwards a line perpendicular to the line `p' `q' through the `center' of `label_group'
--			-- will intersect with the line `p' `q' at position (`new_x', `new_y').
--		require
--			p_not_void: p /= Void
--			q_not_void: q /= Void
--		local
--			d_x, d_y: DOUBLE
--			m, m_inv: DOUBLE
--			w2, h2: DOUBLE
--			nx, ny: DOUBLE
--			bbox: EV_RECTANGLE
--			is_left: BOOLEAN
--		do
--			is_left := False
--			d_x := q.x_precise - p.x_precise
--			d_y := q.y_precise - p.y_precise
--			bbox := name_group.bounding_box
--			w2 := bbox.width / 2 + line_width - 1
--			h2 := bbox.height / 2 + line_width - 1
--			if d_x = 0 then
--				if d_y < 0 then
--					if is_left then
--						nx := new_x - w2
--						ny := new_y
--					else
--						nx := new_x + w2
--						ny := new_y
--					end
--				else
--					if is_left then
--						nx := new_x + w2
--						ny := new_y
--					else
--						nx := new_x - w2
--						ny := new_y
--					end
--				end
--			elseif d_y = 0 then
--				if d_x > 0 then
--					if is_left then
--						nx := new_x
--						ny := new_y - h2
--					else
--						nx := new_x
--						ny := new_y + h2
--					end
--				else
--					if is_left then
--						nx := new_x
--						ny := new_y + h2
--					else
--						nx := new_x
--						ny := new_y - h2
--					end
--				end
--			else
--				m := d_y / d_x
--				check 
--					m_not_zero: m /= 0
--				end
--				m_inv := -1 / m
--				if m > 0 then
--					if d_x > 0 then
--						if is_left then
--							-- -w
--							-- +h
--							nx := (-h2 - new_x * (1/m + m) + m * -w2) / (-1/m -m)
--							ny := m_inv * (nx - new_x) + new_y
--						else
--							-- +w
--							-- -h
--							nx := (h2 - new_x * (1/m + m) + m * w2) / (-1/m - m)
--							ny := m_inv * (nx - new_x) + new_y
--						end
--					else
--						if is_left then
--							-- +w
--							-- -h
--							nx := (h2 - new_x * (1/m + m) + m * w2) / (-1/m - m)
--							ny := m_inv * (nx - new_x) + new_y
--						else
--							-- -w
--							-- +h
--							nx := (-h2 - new_x * (1/m + m) + m * -w2) / (-1/m -m)
--							ny := m_inv * (nx - new_x) + new_y
--						end
--					end
--				else
--					if d_x > 0 then
--						if is_left then
--							-- +w
--							-- +h
--							nx := (-h2 - new_x * (1/m + m) + m * +w2) / (-1/m -m)
--							ny := m_inv * (nx - new_x) + new_y
--						else
--							-- -w
--							-- -h
--							nx := (h2 - new_x * (1/m + m) + m * -w2) / (-1/m - m)
--							ny := m_inv * (nx - new_x) + new_y
--						end
--					else
--						if is_left then
--							-- -w
--							-- -h
--							nx := (h2 - new_x * (1/m + m) + m * -w2) / (-1/m - m)
--							ny := m_inv * (nx - new_x) + new_y
--						else
--							-- +w
--							-- +h
--							nx := (-h2 - new_x * (1/m + m) + m * +w2) / (-1/m -m)
--							ny := m_inv * (nx - new_x) + new_y
--						end
--					end
--				end
--			end
--			name_group.set_x_y (nx.truncated_to_integer, ny.truncated_to_integer)
--		end
		
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
			name_group.set_point_position (nx.truncated_to_integer + 5, ny.truncated_to_integer)
		end
--		
--	on_name_label_double_clicked (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
--			-- User doubleclicked on `label_group'.
--		do
--			is_label_expanded := not is_label_expanded
--			on_name_change
--		end
--		
--	set_name_label_text (a_text: STRING) is
--			-- Set `name_label'.`text' to `a_text'.
--		local
--			txt: EV_MODEL_TEXT
--			l_features: LIST [E_FEATURE]
--			l_item: E_FEATURE
--			l_feature_names: EIFFEL_LIST [FEATURE_NAME]
--			str: STRING
--		do
--			if not is_label_expanded then
--				name_label.set_text (a_text)
--				name_label.show
--				name_label.enable_sensitive
--				
--				l_features := model.e_features
--				if l_features.is_empty then
--					name_label.remove_pebble
--				else
--					l_item := l_features.first
--					
--					if l_item.name.is_equal (model.features.first.feature_name) then
--						name_label.set_pebble (create {FEATURE_STONE}.make (l_item))
--					else
--						name_label.remove_pebble
--					end
--				end
--			else
--				name_label.hide
--				name_label.disable_sensitive
--				name_label.set_text (a_text)
--				l_features := model.e_features
--				from
--					l_features.start
--				until
--					l_features.after
--				loop
--					l_feature_names := l_features.item.ast.feature_names
--					if l_feature_names.count > 1 then
--						--skip synonyms
--						from
--							l_feature_names.start
--							l_feature_names.forth
--						until
--							l_feature_names.after
--						loop
--							l_feature_names.forth
--							l_features.forth
--						end
--					end
--					str := model.full_name (l_features.item.ast)
--					str.replace_substring_all (model.supplier.name, "...")
--					if str.substring (str.count - 4, str.count).is_equal (": ...") then
--						str.replace_substring_all (": ...", "")
--					end
--					create txt.make_with_text (str)
--					txt.set_font (label_font)
--					txt.set_foreground_color (label_color)
--					if world /= Void then
--						txt.scale (world.scale_factor)
--					end
--					txt.set_pebble (create {FEATURE_STONE}.make (l_features.item))
--					txt.set_accept_cursor (cursors.cur_feature)
--					txt.set_deny_cursor (cursors.cur_x_feature)
--					txt.set_point_position (label_group.point_x, label_group.bounding_box.bottom)
--					label_group.extend (txt)
--					l_features.forth
--				end
--			end
--		end

invariant
	label_font_not_void: label_font /= Void
	label_color_not_void: label_color /= Void
	foreground_color_not_void: foreground_color /= Void
	aggregate_figure_not_void: aggregate_figure /= Void

end -- class UML_CLIENT_SUPPLIER_FIGURE
