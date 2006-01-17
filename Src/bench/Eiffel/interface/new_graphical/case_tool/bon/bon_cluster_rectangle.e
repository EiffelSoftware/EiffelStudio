indexing
	description: "Objects that is the rectangle used in BON_CLUSTER_FIGURE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLUSTER_RECTANGLE
	
inherit
	EV_MODEL_ROUNDED_RECTANGLE
		redefine
			default_create,
			set_width,
			set_height,
			set_point_a_position,
			set_point_b_position,
			recursive_transform,
			assign_draw_id
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create a BON_CLUSTER_RECTANGLE.
		do
			Precursor {EV_MODEL_ROUNDED_RECTANGLE}
			create polyline_points.make (5)	
			polyline_points.put (create {EV_COORDINATE}, 0)
			polyline_points.put (create {EV_COORDINATE}, 1)
			polyline_points.put (create {EV_COORDINATE}, 2)
			polyline_points.put (create {EV_COORDINATE}, 3)
			polyline_points.put (create {EV_COORDINATE}, 4)
		end
		
feature -- Element change
		
	set_width (a_width: INTEGER) is
			-- Set `width' to `a_width'.
		local
			l_points: like polyline_points
			p0: EV_COORDINATE
		do
			Precursor {EV_MODEL_ROUNDED_RECTANGLE} (a_width)
			l_points := polyline_points
			p0 := l_points.item (0)
			l_points.item (1).set_precise (p0.x_precise + a_width, l_points.item (1).y_precise)
			l_points.item (2).set_precise (p0.x_precise + a_width, l_points.item (2).y_precise)
		end
	
	set_height (a_height: INTEGER) is
			-- Set `height' to `a_height'.
		local
			l_points: like polyline_points
			p0: EV_COORDINATE
		do
			Precursor {EV_MODEL_ROUNDED_RECTANGLE} (a_height)
			l_points := polyline_points
			p0 := l_points.item (0)
			l_points.item (2).set_precise (l_points.item (2).x_precise, p0.y_precise + a_height)
			l_points.item (3).set_precise (l_points.item (3).x_precise, p0.y_precise + a_height)
		end

	set_point_a_position (ax, ay: INTEGER) is
			-- Set position of `point_a' to position (`ax', `ay').
		local
			l_points: like polyline_points
		do
			Precursor {EV_MODEL_ROUNDED_RECTANGLE} (ax, ay)
			l_points := polyline_points
			l_points.item (2).set_precise (ax, ay)
			l_points.item (1).set_precise (ax, l_points.item (1).y_precise)
			l_points.item (3).set_precise (l_points.item (3).x_precise, ay)
		end
		
	set_point_b_position (ax, ay: INTEGER) is
			-- Set position of `point_b' to position (`ax', `ay').
		local
			l_points: like polyline_points
		do
			Precursor {EV_MODEL_ROUNDED_RECTANGLE} (ax, ay)
			l_points := polyline_points
			l_points.item (0).set_precise (ax, ay)
			l_points.item (4).set_precise (ax, ay)
			l_points.item (1).set_precise (l_points.item (1).x_precise, ay)
			l_points.item (3).set_precise (ax, l_points.item (3).y_precise)
		end

feature {EV_MODEL_GROUP} -- Transformation
		
	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		local
			l_points: like polyline_points
		do
			l_points := polyline_points
			a_transformation.project (l_points.item (0))
			a_transformation.project (l_points.item (1))
			a_transformation.project (l_points.item (2))
			a_transformation.project (l_points.item (3))
			a_transformation.project (l_points.item (4))
			
			Precursor {EV_MODEL_ROUNDED_RECTANGLE} (a_transformation)
		end
		
feature {BON_CLUSTER_FIGURE} -- Implementation

	polyline_points: SPECIAL [EV_COORDINATE]
			-- Polyline from edge to edge starting at top left corner.

feature {NONE} -- Implementation

	assign_draw_id is
			-- Assign same id as EV_FIGURE_ROUNDED_RECTANGLE.
		do
			draw_id := (create {EV_MODEL_ROUNDED_RECTANGLE}).draw_id
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

end -- class BON_CLUSTER_RECTANGLE
