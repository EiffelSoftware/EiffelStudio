indexing

	description: "Description of point (implementation for X)";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	POINT 

inherit

	OPEN_FIG
		redefine
			conf_recompute
		end;

	INTERIOR	
		rename
			make as interior_make
		end;

	COORD_XY_FIG
		rename
			duplicate as coord_duplicate
		undefine
			unset_conf_modified,
			set_conf_modified,
			set_conf_modified_with
		redefine
			conf_recompute
		end;		

	COORD_XY_FIG
		undefine
			set_conf_modified_with,
			set_conf_modified,
			unset_conf_modified
		redefine
			duplicate,
			conf_recompute
		select
			duplicate
		end

creation

	make

feature -- Initialization 

	make is
			-- Create a point.
		do
			init_fig (Void);
			interior_make ;
			logical_function_mode := GXcopy;
		end;

feature -- Duplication

	duplicate: like Current is
			-- Create a copy of current point.
		do
			Result := coord_duplicate;
			Result.set_foreground_color (foreground_color)
		ensure then
			Result.is_superimposable (Current);
			Result.foreground_color = foreground_color
		end;

feature -- Output

	draw is
			-- Draw current point.
		do
			if drawing.is_drawable then
				set_drawing_attributes (drawing);
				drawing.draw_point (Current)
			end
		end;


feature {CONFIGURE_NOTIFY} -- Updating

	conf_recompute is
		do
			surround_box.set (x, y, 1, 1);
		end;

invariant

	origin_user_type <= 2

end -- class POINT


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

