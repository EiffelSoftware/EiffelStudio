indexing
	description: "A very simple view for a EG_NODE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_SIMPLE_NODE

inherit
	EG_LINKABLE_FIGURE
		redefine
			update,
			default_create,
			xml_node_name,
			model
		end

create
	make_with_model

create {EG_SIMPLE_NODE}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create an EG_SIMPLE_NODE.
		do
			Precursor {EG_LINKABLE_FIGURE}
			create node_figure.make_with_positions (-figure_size // 2, -figure_size // 2, figure_size // 2, figure_size // 2)
			node_figure.set_background_color (color)
			extend (node_figure)
			set_center
		end

	make_with_model (a_model: EG_NODE) is
			-- Create a EG_SIMPLE_NODE using `a_model'.
		require
			a_model_not_void: a_model /= Void
		do
			default_create
			model := a_model
			initialize
			update
		end

feature -- Access

	model: EG_NODE
			-- Model `Current' is a view for.

	port_x: INTEGER is
			-- x position where links are starting.
		do
			Result := point_x
		end

	port_y: INTEGER is
			-- y position where links are starting.
		do
			Result := point_y
		end

	size: EV_RECTANGLE is
			-- Size of `Current'.
		do
			Result := node_figure.bounding_box
		end

	height: INTEGER is
			-- Height in pixels.
		do
			Result := node_figure.radius2 * 2
		end

	width: INTEGER is
			-- Width in pixels.
		do
			Result := node_figure.radius1 * 2
		end

	xml_node_name: STRING is
			-- Name of `xml_element'.
		do
			Result := "EG_SIMPLE_NODE"
		end

feature -- Element change

	update_edge_point (p: EV_COORDINATE; an_angle: DOUBLE) is
			-- Set `p' position such that it is on a point on the edge of `Current'.
		local
			ax, ay, l: DOUBLE
			a, b: INTEGER
		do
				-- Some explanation for those you have forgotten about their math classes.
				-- We have two equations:
				-- 1 - the ellipse: x^2/a^2 + y^2/b^2 = 1
				-- 2 - the line which has an angle `an_angle': y = tan(an_angle) * x
				--
				-- The solution of the problem is to find the point (x, y) which is
				-- common to both equations (1) and (2). Because `tangent' only applies for
				-- angle values between ]-pi / 2, pi / 2 [, we have to get the result
				-- for the other quadrant of the ellipse by mirroring the value of x
				-- and of y.
				-- With `l = tan(an_angle)', we can write the following equivalences:
				-- x^2/a^2 + y^2/b^2 = 1 <=> x^2/a^2 + (l^2*x^2)/b^2 = 1
				-- x^2/a^2 + y^2/b^2 = 1 <=> x^2*b^2 + l^2*x^2*a^2 = a^2*b^2
				-- x^2/a^2 + y^2/b^2 = 1 <=> x^2*(b^2 + l^2*a^2) = a^2*b^2
				-- x^2/a^2 + y^2/b^2 = 1 <=> x^2 = a^2*b^2 / (b^2 + l^2*a^2)
				-- x^2/a^2 + y^2/b^2 = 1 <=> x = a*b / sqrt(b^2 + l^2*a^2)
			l := tangent (an_angle)
			a := node_figure.radius1
			b := node_figure.radius2
			if a = 0 and b = 0 then
				ax := 0
				ay := 0
			else
				ax := (a * b) / sqrt (b^2 + l^2 * a^2)
				ay := l * ax

				if cosine (an_angle) < 0 then
						-- When we are in ]pi/2, 3*pi/2[, then we need to reverse
						-- the coordinates. It looks strange like that, but don't forget
						-- that although `ax' is always positive, `ay' might be negative depending
						-- on the sign of `l'. This is why we need to reverse both coordinates,
						-- but because we also need to reverse the `ay' value because in a figure world
						-- the `ay' coordinates go down and not up, the effect is null, thus no operation
						-- on `ay'.
					ax := -ax
				else
						-- We need to reverse the y value, because in a figure world, the y coordinates
						-- go down and not up.
					ay := -ay
				end
			end
			p.set_precise (port_x + ax, port_y - ay)
		end

feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update is
			-- Some properties may have changed.
		do
			if is_label_shown then
				name_label.set_point_position (point_x + figure_size // 2, point_y + figure_size // 2)
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
					node_figure.set_line_width (node_figure.line_width * 2)
				else
					node_figure.set_line_width (node_figure.line_width // 2)
				end
			end
		end

	figure_size: INTEGER is
			-- Size of figure in pixel.
		do
			Result := 20
		end

	color: EV_COLOR is
			-- color of figure.
		once
			create Result.make_with_rgb (1,0,0)
		ensure
			result_not_void: Result /= Void
		end

	node_figure: EV_MODEL_ELLIPSE
			-- The figure visualizing `Current'.

	number_of_figures: INTEGER is 2
			-- Number of figures used to visualize `Current'.
			-- (`name_label' and `node_figure')

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current is
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

invariant
	node_figure_not_void: node_figure /= Void

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




end -- class EG_SIMPLE_NODE

