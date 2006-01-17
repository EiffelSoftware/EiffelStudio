indexing

	description: 
		"Lowest rectangle containing a figure."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class REFRESH_AREA 

create

	make

feature -- Initialization

	make is
			-- Create a closure
		do
			empty := true
		end -- make

feature -- Properties

	up_left_x: INTEGER;
			-- Upper left corner x

	up_left_y: INTEGER;
			-- Upper left corner y

	down_right_x: INTEGER;
			-- Bottom right corner x

	down_right_y: INTEGER;
			-- Bottom right corner y

	empty: BOOLEAN;
			-- Is the area empty

	up_left: COORD_XY is
		do
			create Result;
			Result.set (up_left_x, up_left_y)
		end

feature -- Access

	to_clip: CLIP is
			-- Covert coordinates to a Clip rectangle
		do
			create Result;
			Result.set (up_left, down_right_x - up_left_x, 
				down_right_y - up_left_y)			
		end

feature -- Element change

	set (x, y, width, height: INTEGER) is
			-- Set coordinates and size of closure.
		require
			width >= 0;
			height >= 0
		do
			if width+height > 0 then
				up_left_x := x;
				up_left_y := y;
				down_right_x := x+width;
				down_right_y := y+height;
				empty := false
			else
				empty := true
			end
		end; 

	merge (other: like Current) is
			-- Enlarge the rectangle in order to include `other'.
		require
			rectangle_exists: other /= Void;
		do
			if not other.empty then
				if empty then
					up_left_x := other.up_left_x;
					up_left_y := other.up_left_y;
					down_right_x := other.down_right_x;
					down_right_y := other.down_right_y;
					empty := false
				else
					up_left_x := up_left_x.min (other.up_left_x);
					up_left_y := up_left_y.min (other.up_left_y);
					down_right_x := down_right_x.max (other.down_right_x);
					down_right_y := down_right_y.max (other.down_right_y);
				end;
			end
		end; 

	merge_clip (clip: CLIP) is
			-- Enlarge the rectangle in order to include `clip'.
		require
			not (clip = Void)
		local
			clos: REFRESH_AREA
		do
			create clos.make;
			clos.set (clip.upper_left.x, clip.upper_left.y,
						clip.width, clip.height);
			merge (clos);
		ensure
			not_empty: not empty
		end; 

feature -- Removal

	wipe_out is
			-- Wipe out the closure
		do
			empty := true
		ensure
			empty: empty
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

end -- class REFRESH_AREA 
