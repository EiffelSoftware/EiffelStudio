indexing

	description:
		"Widget: Permanent Window.%
		%A permanent window is present on the screen%
		%throughout an entire application.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PERM_WIND 

inherit

	EB_BULLETIN
		rename
			make as eb_bulletin_create
		redefine
			show, hide,
			x, y, set_x_y,
			set_x, set_y,
			width, height, set_size,
			set_width, set_height,
			real_x, real_y,
			realize,
			unrealize, realized,
			raise, lower, shown
		end

creation

	make

feature {NONE}

	make (a_name: STRING; a_screen: SCREEN) is
		do
			!!top_shell.make (a_name, a_screen);
			eb_bulletin_create (a_name, top_shell);
			top_shell.set_action ("<Configure>", Current, Current);
		end;

feature

	top_shell: TOP_SHELL;
			-- Top shell widget contain the eb_bulletin

	parent_shell: TOP_SHELL is
			-- Parent shell of Current
		do
			Result := top_shell;
		ensure
			is_top_shell: Result = top_shell
		end;

	raise is
			-- Raise the Current widget to the top
			-- of its peer stacking order.
		do
			top_shell.raise;
		end

	lower is
			-- Lower the Current widget to the bottom
			-- of its peer stacking order.
		do
			top_shell.lower;
		end;

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		do
			Result := top_shell.title;
		end;

	set_title (a_title: STRING) is
			-- Set title to `a_title'.
		do
			top_shell.set_title (a_title)
		end;

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		do
			top_shell.forbid_resize
		end;

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		do
			top_shell.allow_resize
		end;

	icon_name: STRING is
			-- Short form of application name to be displayed
			-- by the window manager when application is iconified.
		do
			Result := top_shell.icon_name
		end;

	set_icon_name (a_name: STRING) is
			-- Set `icon_name' to `a_name'.
		do
			top_shell.set_icon_name (a_name)
		end;

	is_iconic_state: BOOLEAN is
			-- Does Current start in iconic state?
		do
			Result := top_shell.is_iconic_state
		end;

	set_iconic_state (flag: BOOLEAN) is
			-- Set start state of the application to be iconic.
		do
			if flag then
				top_shell.set_iconic_state
			else
				top_shell.set_normal_state
			end;
		end;

	set_icon_pixmap (a_pixmap: PIXMAP) is
			-- Set `icon_pixmap' to `a_pixmap'.
		do
			top_shell.set_icon_pixmap (a_pixmap);
		end;

	set_icon_pixmap_by_name (a_pixmap_name: STRING) is
			-- Draw `a_pixmap_name' into the perm_wind icon.
		require
			a_pixmap_name_exist: not (a_pixmap_name = Void)
		local
			a_pixmap: PIXMAP;
		do
			!!a_pixmap.make;
			a_pixmap.read_from_file (a_pixmap_name);
			set_icon_pixmap (a_pixmap);
		end

	icon_pixmap: PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		do
			Result := top_shell.icon_pixmap;
		end;

	show is
			-- Show Current widget.
		do
			top_shell.show
		end;

	shown: BOOLEAN is
			-- Is current widget visible?
		do
			Result := top_shell.shown
		end;

	hide is
			-- Hide Current widget.
		do
			top_shell.hide
		end;

	x: INTEGER is
			-- Horizontal position relative to parent
		do
			Result := top_shell.x
		end;

	y: INTEGER is
			-- Vertical position relative to parent
		do
			Result := top_shell.y
		end;

	real_x: INTEGER is
			-- Horizontal position relative to root window
		do
			Result := top_shell.real_x
		end;

	real_y: INTEGER is
			-- Vertical position relative to root window
		do
			Result := top_shell.real_y
		end;

	set_x_y (new_x, new_y: INTEGER) is
			-- Set horizontal position and
			-- vertical position relative to parent
			-- to `new_x' and `new_y'.
		do
			top_shell.set_x_y (new_x, new_y);
		end;

	set_x (new_x: INTEGER) is
			-- Set  horizontal position relative
			-- to parent to `new_x'.
		do
			top_shell.set_x (new_x);
		end;

	set_y (new_y: INTEGER) is
			-- Set vertical position relative
			-- to parent to `new_y'.
		do
			top_shell.set_y (new_y);
		end;

	width: INTEGER is
			-- Width of widget
		do
			Result := top_shell.width
		end;

	height: INTEGER is
			-- Height of widget
		do
			Result := top_shell.height
		end;

	set_size (new_w, new_h: INTEGER) is
			-- Set width and height to `new_w'
			-- and `new_h'.
		do
			top_shell.set_size (new_w, new_h);
		end;

	set_width (new_w: INTEGER) is
			-- Set width to `new_w'.
		do
			top_shell.set_width (new_w);
		end;

	set_height (new_h: INTEGER) is
			-- Set height to `new_h'.
		do
			top_shell.set_height (new_h);
		end;

	set_min_width (new_w: INTEGER) is
			-- Set minimum width for the window.
		do
			top_shell.set_min_width (new_w)
		end

	set_min_height (new_h: INTEGER) is
			-- Set minimum height for the window.
		do
			top_shell.set_min_height (new_h)

		end

	set_max_width (new_w: INTEGER) is
			-- Set maximum width for the window.
		do
			top_shell.set_max_width (new_w)
		end

	set_max_height (new_h: INTEGER) is
			-- Set maximum height for the window.
		do
			top_shell.set_max_height (new_h)
		end

	realize is
			-- Create actual screen object of Current
			-- widget and of all children (recursively).
		do
			top_shell.realize
		end;

	unrealize is
			-- Destroy screen window implementation and all
			-- screen window implementations of its children.
		do
			top_shell.unrealize
		end;

	realized: BOOLEAN is
			-- Is Current widget realized?
		do
			Result := top_shell.realized
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
