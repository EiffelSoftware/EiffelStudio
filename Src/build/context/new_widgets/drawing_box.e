indexing

	description:
		"Widget: Scrolled window with drawing area.%
		%Special area to draw.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DRAWING_BOX 

inherit

	DRAWING_AREA
		rename
			make as drawing_area_create,
			make_unmanaged as drawing_area_create_unmanaged,
			set_size as set_drawing_area_size,
			width as drawing_area_width,
			height as drawing_area_height,
			real_x as old_real_x,
			real_y as old_real_y,
			set_foreground_color as drawing_area_set_foreground_color,
			set_background_color as drawing_area_set_background_color,
			set_background_pixmap as drawing_area_set_background_pixmap
		export
			{ANY} set_drawing_area_size, drawing_area_width, 
			drawing_area_height
		redefine
			x, y, set_x_y, hide, show, realize, 
			set_managed, shown, unrealize, realized,
			managed, unmanage, manage, background_color, set_cursor
-- make_unmanaged,
		end;

	DRAWING_AREA
		rename
			make as drawing_area_create,
			make_unmanaged as drawing_area_create_unmanaged
		redefine
			set_background_pixmap, set_background_color, 
			set_foreground_color, realize, show, hide, shown, set_size, 
			set_x_y, height, width, real_y, real_x, y, x, 
			set_managed, unrealize, realized,
			managed, unmanage, manage, background_color, set_cursor
--make_unmanaged, 
		select
			set_background_pixmap, set_background_color, 
			set_foreground_color, set_size, height, width, real_y,
			real_x
		end

creation

	make, make_unmanaged

feature {NONE}

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a drawing box with `a_name' as identifier,
			-- `a_parent' as parent.
		do
			!!scrolled_window.make (a_name, a_parent);
			drawing_area_create (a_name, scrolled_window);
			!!world.make;
			world.attach_drawing (Current);
			scrolled_window.set_working_area (Current);
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged drawing box with `a_name' as identifier,
			-- `a_parent' as parent.
		do
			!! scrolled_window.make_unmanaged (a_name, a_parent);
			drawing_area_create_unmanaged (a_name, scrolled_window);
			!!world.make;
			world.attach_drawing (Current);
			scrolled_window.set_working_area (Current);
		end;

feature

	scrolled_window: SCROLLED_W;
			-- Scrolled window containing drawing area

	world: WORLD;
			-- World for figures

	set_world (a_world: WORLD) is
			-- Set `a_world' to world.
		do
			world := a_world;
			world.attach_drawing (Current);
		end;

	add_figure (a_figure: FIGURE) is
			-- Add `a_figure' to world.
		do
			world.add (a_figure);
		end;

	remove_figure (a_figure: FIGURE) is
			-- Remove `a_figure' from world.
		do
			world.start;
			world.search (a_figure);
			if not world.after then
				world.remove (a_figure);
			end;
		end;

	current_point: COORD_XY_FIG is
			-- Current point on screen
		local
			x0, y0: INTEGER;
		do
			x0 := screen.x - old_real_x;
			y0 := screen.y - old_real_y;
			!!Result;
			Result.set (x0, y0);
		end;

	set_cursor (a_cursor: SCREEN_CURSOR) is
				-- set `cursor' of current widget to `a_cursor'.
		do
			precursor (a_cursor)
			scrolled_window.set_cursor (a_cursor)
		end

feature -- Color 	
	-- note: foreground and background colors are those of scrolled_window 

	set_foreground_color (a_color: COLOR) is
			-- Set foreground color to `a_color'.
		do
			scrolled_window.set_foreground_color (a_color);
		end;

	set_background_color (a_color: COLOR) is
			-- Set background color to `a_color'.
		do
			scrolled_window.set_background_color (a_color);
		end;

	background_color: COLOR is
		-- Background color of scrolled window
		do
			Result := scrolled_window.background_color
		end 

	set_background_pixmap (a_pixmap: PIXMAP) is
			-- Set background pixmap to `a_pixmap'.
		do
			scrolled_window.set_background_pixmap (a_pixmap);
		end;

	x: INTEGER is
			-- Horizontal position relative to parent
		do
			Result := scrolled_window.x
		end;

	y: INTEGER is
			-- Vertical position relative to parent
		do
			Result := scrolled_window.y
		end;

	real_x: INTEGER is
			-- Vertical position relative to root window
		do
			Result := scrolled_window.real_x
		end;

	real_y: INTEGER is
			-- Horizontal position relative to root window
		do
			Result := scrolled_window.real_y
		end;

	width: INTEGER is
			-- Width of Current drawing box
		do
			Result := scrolled_window.width
		end;

	height: INTEGER is
			-- Height of Current drawing box
		do
			Result := scrolled_window.height
		end;

	set_x_y (new_x, new_y: INTEGER) is
			-- Set horizontal position and
			-- vertical position relative to parent
			-- to `new_x' and `new_y'.
		do
			scrolled_window.set_x_y (new_x, new_y);
		end;

	set_size (new_width, new_height: INTEGER) is
			-- Set width and height to `new_width'
			-- and `new_height'.
		do
			scrolled_window.set_size (new_width, new_height);
		end;

	hide is
			-- Hide Current drawing_box.			
		do
			scrolled_window.hide
		end;

	show is
			-- Show Current drawing_box.			
		do
			scrolled_window.show
		end;


	shown: BOOLEAN is
			-- Is current widget visible?
		do
			Result := scrolled_window.shown;
		end;

	realize is
			-- Create actual screen object of Current
			-- widget and of all children (recursively).
		do
			scrolled_window.realize;
		end;


	realized: BOOLEAN is
			-- Is Current widget realized?
		do
			Result := scrolled_window.realized;
		end;

	unrealize is
			-- Destroy screen window implementation and all
			-- screen window implementations of its children if `flag'.
		do
			scrolled_window.unrealize;
		end;

	set_managed (flag: BOOLEAN) is
			-- Set managed to `flag'.
		do
			scrolled_window.set_managed (flag)
		end;

	manage is
			-- Enable geometry managment.
		do
			scrolled_window.manage;
		end;

	unmanage is
			-- Disable geometry managment.
		do
			scrolled_window.unmanage;
		end;

	managed: BOOLEAN is
			-- Is Current widget subject to
			-- geometry managment?
		do
			Result := scrolled_window.managed;
		end;

end

--|----------------------------------------------------------------
--| EiffelBuild library.
--| Copyright (C) 1995 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
