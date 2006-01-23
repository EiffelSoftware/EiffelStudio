indexing
	description: "A very simple implementation of a EG_CLUSTER_FIGURE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_SIMPLE_CLUSTER

inherit
	EG_CLUSTER_FIGURE
		redefine
			default_create,
			update,
			xml_node_name
		end

create
	make_with_model

create {EG_SIMPLE_CLUSTER}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create an empty cluster.
		do
			Precursor {EG_CLUSTER_FIGURE}
			create rectangle
			rectangle.enable_dashed_line_style
			extend (rectangle)
		end

	make_with_model (a_model: EG_CLUSTER) is
			-- Create a cluster using `a_model'.
		require
			a_model_not_void: a_model /= Void
		do
			default_create
			model := a_model
			initialize

			disable_rotating
			disable_scaling

			update
		end

feature -- Access

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
			Result := rectangle.bounding_box
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

	xml_node_name: STRING is
			-- Name of `xml_element'.
		do
			Result := "EG_SIMPLE_CLUSTER"
		end


feature -- Element change

	update_edge_point (p: EV_COORDINATE; an_angle: DOUBLE) is
			-- Set `p' position such that it is on a point on the edge of `Current'.
		local
			m: DOUBLE
			new_x, new_y: DOUBLE
			w2: DOUBLE
			mod_angle: DOUBLE
			l_pi, l_pi2: DOUBLE
			right, left, bottom, top: INTEGER
		do
			left := rectangle.point_a_x
			top := rectangle.point_a_y
			right := rectangle.point_b_x
			bottom := rectangle.point_b_y
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
			l_min_size := minimum_size
			rectangle.set_point_a_position (l_min_size.left, l_min_size.top)
			rectangle.set_point_b_position (l_min_size.right, l_min_size.bottom)
			if is_label_shown then
				name_label.set_point_position (rectangle.point_a_x, rectangle.point_a_y - name_label.height)
			end
			is_update_required := False
		end

feature {NONE} -- Implementation

	set_is_selected (an_is_selected: like is_selected) is
			-- Set `is_selected' to `an_is_selected'.
		do
			if is_selected /= an_is_selected then
				is_selected := an_is_selected
				if is_selected then
					rectangle.set_line_width (rectangle.line_width * 2)
				else
					rectangle.set_line_width (rectangle.line_width // 2)
				end
			end
		end

	rectangle: EV_MODEL_RECTANGLE
			-- The rectangle visualising the border of `Current'.

	number_of_figures: INTEGER is 2
			-- number of figures used to visialize `Current'.
			-- (`name_label' and `rectangle')

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current is
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

invariant
	rectangle_not_void: rectangle /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EG_SIMPLE_CLUSTER

