indexing
	description: "Objects that is a BON view for an EIFFEL_CLUSTER."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLUSTER_FIGURE

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
		select
			default_create,
			set_with_xml_element,
			xml_element
		end
		
	EG_POLYLINE_LABEL
		rename
			default_create as default_create_label,
			update as update_label,
			xml_element as polyline_label_xml_element,
			set_with_xml_element as polyline_label_set_with_xml_element,
			recycle as polyline_label_recycle
		redefine
			on_label_move,
			set_label_group_position_on_line
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
	make_with_model
		
feature {NONE} -- Initialization

	default_create is
			-- Create a BON_CLUSTER_FIGURE.
		do
			Precursor {EIFFEL_CLUSTER_FIGURE}
			
			-- create the cluster rectangle
			create rectangle
			real_rectangle_radius := 20.0
			rectangle.set_radius (rectangle_radius)
			rectangle.enable_dashed_line_style
			set_pointer_style (default_pixmaps.sizeall_cursor)
			extend (rectangle)
			send_to_back (rectangle)
			
			-- create the label rectangle
			create label_rectangle
			label_rectangle.enable_dashed_line_style
			label_rectangle.set_radius (3)
			
			-- create the label 
			default_create_label
			label_line_start_point := polyline_points.item (2)
			label_line_end_point := polyline_points.item (3)
			position_on_line := 0.5
			label_group.extend (label_rectangle)
			label_group.extend (name_label)
			label_move_handle.set_pointer_style (default_pixmaps.sizeall_cursor)
			label_move_handle.pointer_double_press_actions.extend (agent on_label_double_press)
			extend (label_move_handle)
			label_move_handle.disable_scaling
			label_move_handle.disable_rotating
			set_left (True)
			
			number_of_figures := 6
			is_high_quality := True
			real_rectangle_border := 5.0
			real_label_rectangle_border := 5.0
			
			preferences.diagram_tool_data.add_observer (Current)
			retrieve_preferences
			
			name_label.set_point_position (label_group.point_x + label_rectangle_border, label_group.point_y + label_rectangle_border)		
			
			is_shown := True
		end
		
	make_with_model (a_model: like model) is
			-- Create a BON_CLUSTER_FIGURE with `a_model'.
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
		local
			pax, pay: INTEGER
		do
			pax := rectangle.point_a_x
			pay := rectangle.point_a_y
			create Result.make (pax, pay, rectangle.point_b_x - pax, rectangle.point_b_y - pay)
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
			e_item: ES_ITEM
			l_item: EG_FIGURE
			l_border: INTEGER
		do
			if is_iconified then
				l_border := (real_rectangle_border * 2).truncated_to_integer
				create Result.make (port_x - 2 * l_border, port_y - l_border, 4 * l_border, 2 * l_border)
			else
				if count <= number_of_figures then
					l_border := (real_rectangle_border * 5).truncated_to_integer
					create Result.make (port_x - 2 * l_border, port_y - l_border, 4 * l_border, 2 * l_border)
				else
					from
						l_area := area
						i := number_of_figures
						nb := count - 1
						l_item ?= l_area.item (i)
						e_item ?= l_item.model
					until
						i > nb or else (e_item = Void or else e_item.is_needed_on_diagram)--l_area.item (i).is_show_requested
					loop
						i := i + 1
						if i <= nb then
							l_item ?= l_area.item (i)
							e_item ?= l_item.model
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
							e_item ?= l_item.model
							if e_item = Void or else e_item.is_needed_on_diagram then --l_area.item (i).is_show_requested then
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
		end
			
	xml_node_name: STRING is
			-- Name of the xml node returned by `xml_element'.
		do
			Result := "BON_CLUSTER_FIGURE"
		end
		
	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml element representing `Current's state.
		do
			Result := Precursor {EIFFEL_CLUSTER_FIGURE} (node)
			Result.put_last (Xml_routines.xml_node (Result, "IS_ICONIFIED", is_iconified.out))
			Result.put_last (Xml_routines.xml_node (Result, "IS_NEEDED_ON_DIAGRAM", model.is_needed_on_diagram.out))
			
			Result := polyline_label_xml_element (node)
		end
	
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		do
			Precursor {EIFFEL_CLUSTER_FIGURE} (node)
			if xml_routines.xml_boolean (node, "IS_ICONIFIED") then
				if not is_iconified then
					collapse
					if bon_cluster_iconified_fill_color /= Void then
						rectangle.set_background_color (bon_cluster_iconified_fill_color)
					else
						rectangle.remove_background_color
					end
					is_iconified := True
				end
			else
				if is_iconified then
					expand
					if bon_cluster_fill_color /= Void then
						rectangle.set_background_color (bon_cluster_fill_color)
					else
						rectangle.remove_background_color
					end
					is_iconified := False
				end
			end
			if xml_routines.xml_boolean (node, "IS_NEEDED_ON_DIAGRAM") then
				model.enable_needed_on_diagram
			else
				model.disable_needed_on_diagram
			end
			
			polyline_label_set_with_xml_element (node)
		end

feature -- Element change

	recycle is
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_CLUSTER_FIGURE}
			label_move_handle.pointer_double_press_actions.prune_all (agent on_label_double_press)
			polyline_label_recycle
			preferences.diagram_tool_data.remove_observer (Current)
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
		do
			
			if is_shown then
				l_min_size := minimum_size
				if user_size /= Void and then not is_iconified then
					rectangle.set_point_a_position ((l_min_size.left - rectangle_border).min (user_size.left), (l_min_size.top - rectangle_border).min (user_size.top))
					rectangle.set_point_b_position ((l_min_size.right + rectangle_border).max (user_size.right), (l_min_size.bottom + rectangle_border).max (user_size.bottom))		
				else
					rectangle.set_point_a_position ((l_min_size.left - rectangle_border), (l_min_size.top - rectangle_border))
					rectangle.set_point_b_position ((l_min_size.right + rectangle_border), (l_min_size.bottom + rectangle_border))		
				end
				
				if is_label_shown then
					label_rectangle.set_point_a_position (label_group.point_x, label_group.point_y)
					label_rectangle.set_point_b_position (label_group.point_x + name_label.width + 2*label_rectangle_border,
														  label_group.point_y + name_label.height + 2*label_rectangle_border)
														  
					if is_high_quality then
						update_label
					else
						name_label.set_point_position (rectangle.point_a_x, rectangle.point_a_y - name_label.height)
					end
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
			real_rectangle_radius := real_rectangle_radius * a_transformation.item (1, 1)
			if rectangle_radius.max (1) /= rectangle.radius then
				rectangle.set_radius (rectangle_radius)	
			end
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

	line_width: INTEGER is
			-- Cluster border line width.
		do
			Result := rectangle.line_width
		end

	set_is_selected (an_is_selected: like is_selected) is
			-- Set `is_selected' to `an_is_selected'.
		do
			if is_selected /= an_is_selected then
				is_selected := an_is_selected
				if is_selected = True then
					rectangle.set_line_width (line_width * 2)
					label_rectangle.set_line_width (line_width * 2)
				else
					rectangle.set_line_width (line_width)
					label_rectangle.set_line_width (line_width)
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
			
	rectangle_radius: INTEGER is
			-- Radius for `rectangle'
		do
			Result := real_rectangle_radius.truncated_to_integer
		end
		
	real_rectangle_radius: REAL
			-- Real value for `rectangle_radius'.

	number_of_figures: INTEGER
			-- Number of figures to visualize `Current'.
			-- high_quality: (`rectangle', `label_move_handle', `resizer_top_left', `resizer_top_right', `resizer_bottom_right', `resizer_bottom_left').
			-- low_quality: (`rectangle', `name_label')

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

	rectangle: BON_CLUSTER_RECTANGLE
			-- The rectangle.
			
	label_rectangle: EV_MODEL_ROUNDED_RECTANGLE
			-- The rectangle for the label.

	polyline_points: SPECIAL [EV_COORDINATE] is
			-- Points needed for EG_POLYLINE_LABEL.
		do
			Result := rectangle.polyline_points
		end
		
	on_label_move (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- `label_move_handler' was moved for `ax' `ay'.
			-- | Redefined because `is_left' must stay True.
		do
			set_label_line_start_and_end
			set_label_position_on_line (label_line_start_point, label_line_end_point)
			request_update
		end
		
	set_label_group_position_on_line (new_x, new_y: DOUBLE; p, q: EV_COORDINATE) is
			--
		local
			px, py, qx, qy: INTEGER
		do
			Precursor {EG_POLYLINE_LABEL} (new_x, new_y, p, q)
			px := p.x
			qx := q.x
			py := p.y
			qy := q.y
			if px = qx then
				if px <= polyline_points.item (2).x then
					-- Left line
					label_group.set_point_position (label_group.point_x + 3, label_group.point_y)
				end
			else
				if py <= polyline_points.item (2).y then
					-- top line
					label_group.set_point_position (label_group.point_x, label_group.point_y + 2)
				end
			end
		end
		
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
				if bon_cluster_iconified_fill_color /= Void then
					rectangle.set_background_color (bon_cluster_iconified_fill_color)
				else
					rectangle.remove_background_color
				end
			else
				if bon_cluster_fill_color /= Void then
					rectangle.set_background_color (bon_cluster_fill_color)
				else
					rectangle.remove_background_color
				end
			end
		end
		
	set_is_high_quality (an_is_high_quality: like is_high_quality) is
			-- Set `is_high_quality' to `an_is_high_quality'.
		do
			if an_is_high_quality /= is_high_quality then
				is_high_quality := an_is_high_quality
				if is_high_quality then
					prune_all (name_label)
					name_label.set_point_position (label_group.point_x + label_rectangle_border, label_group.point_y + label_rectangle_border)
					name_label.pointer_double_press_actions.prune_all (agent on_label_double_press)
					label_group.extend (name_label)
					put_front (label_move_handle)
					label_move_handle.enable_sensitive
					put_front (resizer_bottom_left)
					resizer_top_left.enable_sensitive
					put_front (resizer_bottom_right)
					resizer_bottom_right.enable_sensitive
					put_front (resizer_top_right)
					resizer_top_right.enable_sensitive
					put_front (resizer_top_left)
					resizer_top_left.enable_sensitive
					send_to_back (rectangle)
					rectangle.enable_dashed_line_style
					if not is_iconified then
						if bon_cluster_fill_color /= Void then
							rectangle.set_background_color (bon_cluster_fill_color)
						else
							rectangle.remove_background_color
						end
					else
						if bon_cluster_iconified_fill_color /= Void then
							rectangle.set_background_color (bon_cluster_iconified_fill_color)
						else
							rectangle.remove_background_color
						end
					end
					
					number_of_figures := 6
				else
					prune_all (resizer_top_left)
					resizer_top_left.disable_sensitive
					prune_all (resizer_top_right)
					resizer_top_right.disable_sensitive
					prune_all (resizer_bottom_right)
					resizer_bottom_right.disable_sensitive
					prune_all (resizer_bottom_left)
					resizer_top_left.disable_sensitive
					prune_all (label_move_handle)
					label_move_handle.disable_sensitive
					put_front (name_label)
					name_label.pointer_double_press_actions.extend (agent on_label_double_press)
					send_to_back (rectangle)
					rectangle.disable_dashed_line_style
					rectangle.remove_background_color
					number_of_figures := 2
				end
				request_update
			end
		end
		
	retrieve_preferences is
			-- Retrieve preferences from shared resources.
		do
			name_label.set_identified_font (bon_cluster_name_font)
			name_label.set_foreground_color (bon_cluster_name_color)
			
			rectangle.set_foreground_color (bon_cluster_line_color)
			if is_iconified then
				if bon_cluster_iconified_fill_color /= Void then
					rectangle.set_background_color (bon_cluster_iconified_fill_color)
				else
					rectangle.remove_background_color
				end
			else
				if bon_cluster_fill_color /= Void then
					rectangle.set_background_color (bon_cluster_fill_color)
				else
					rectangle.remove_background_color
				end
			end
			rectangle.set_line_width (bon_cluster_line_width)
			
			label_rectangle.set_foreground_color (bon_cluster_line_color)
			if bon_cluster_name_area_color /= Void then
				label_rectangle.set_background_color (bon_cluster_name_area_color)
			end
			request_update
		end

end -- class BON_CLUSTER_FIGURE