indexing
	description: "EG_CIRCLE_LAYOUT arranges the nodes in a circle around a center with a radius."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_CIRCLE_LAYOUT

inherit
	EG_LAYOUT
		redefine
			default_create
		end

	EV_MODEL_DOUBLE_MATH
		undefine
			default_create
		end
	
create
	make_with_world
	
feature {NONE} -- Initialization

	default_create is
			-- Create a EG_CIRCLE_LAYOUT.
		do
			Precursor {EG_LAYOUT}
			exponent := 1.0
		end
	
feature -- Access
		
	center_x: INTEGER
				-- X position of the center of the circle.
				
	center_y: INTEGER
				-- Y position of the center of the circle
				
	radius: INTEGER
				-- Radius of largest circle.
				
	exponent: DOUBLE
				-- Exponent used to reduce radius per level:
				-- (`radius' / cluster_level ^ `exponent')
				
feature -- Element change

	set_center (ax, ay: like center_x) is
			-- Set `center_x' to `ax' and `center_y' to `ay'.
		do
			center_x := ax
			center_y := ay
		ensure
			set: center_x = ax and center_y = ay
		end
		
	set_radius (a_radius: like radius) is
			-- Set `radius' to `a_radius'.
		require
			a_radius_larger_zero: a_radius > 0
		do
			radius := a_radius
		ensure
			set: radius = a_radius
		end
		
	set_exponent (an_exponent: like exponent) is
			-- Set `exponent' to `an_exponent'.
		require
			an_exponent_larger_equal_one: an_exponent >= 1.0
		do
			exponent := an_exponent
		ensure
			set: exponent = an_exponent
		end

feature {NONE} -- Implementation

	layout_linkables (linkables: ARRAYED_LIST [EG_LINKABLE_FIGURE]; level: INTEGER; cluster: EG_CLUSTER_FIGURE) is
			-- arrange `linkables'.
		local
			l_count: INTEGER
			level_radius: DOUBLE
			d_angle, angle: DOUBLE
			i: INTEGER
			l_link: EG_LINKABLE_FIGURE
		do
			l_count := linkables.count
			if l_count = 1 then
				level_radius := 0
			else
				level_radius := (1 / level ^ exponent) * radius
				d_angle := 2 * pi / l_count
			end
			from
				i := 1
				angle := 0
			until
				i > l_count
			loop
				l_link := linkables.i_th (i)
				if level = 1 then
					l_link.set_port_position ((cosine (angle) * level_radius).truncated_to_integer + center_x, (sine (angle) * level_radius).truncated_to_integer + center_y)
				else
					l_link.set_port_position ((cosine (angle) * level_radius).truncated_to_integer + l_link.cluster.port_x, (sine (angle) * level_radius).truncated_to_integer + l_link.cluster.port_y)
				end
				angle := angle + d_angle
				i := i + 1
			end
		end
		
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




end -- class EG_CIRCLE_LAYOUT

