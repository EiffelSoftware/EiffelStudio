indexing
	description: 
		"EiffelVision window, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_WINDOW_I
	
inherit
	EV_CONTAINER_I
		export
			{NONE} set_expand
			{NONE} set_parent
		redefine
			set_default_colors,
			show
		end
	
feature {EV_WINDOW} -- Initialization

	set_default_colors is
			-- Initialize the colors of the widget
		local
			default_colors: EV_DEFAULT_COLORS
			color: EV_COLOR
		do
			!! default_colors
			set_background_color (default_colors.Color_dialog)
			!! color.make_rgb (0, 0, 0)
			set_foreground_color (color)
		end

feature  -- Access

	maximum_width: INTEGER is
			-- Maximum width that application wishes widget
			-- instance to have
		require
			exists: not destroyed
		deferred
		ensure
			Result >= 0
		end	
	
	maximum_height: INTEGER is
			-- Maximum height that application wishes widget
			-- instance to have
		require
			exists: not destroyed
		deferred
		ensure
			Result >= 0
		end

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		require
			exists: not destroyed
		deferred
		end

	icon_name: STRING is
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified
		require
			exists: not destroyed
		deferred
		end
	
	icon_mask: EV_PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		require
			exists: not destroyed
		deferred
		end

	icon_pixmap: EV_PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		require
			exists: not destroyed
		deferred
		ensure
			valid_result: Result /= Void
		end
	
	widget_group: EV_WIDGET is
			-- Widget with wich current widget is associated.
			-- By convention this widget is the "leader" of a group
			-- widgets. Window manager will treat all widgets in
			-- a group in some way; for example, it may move or
			-- iconify them together
		require
			exists: not destroyed
		deferred
		end 

feature -- Status report

 	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting

	show is
			-- Make widget visible on the screen.
		require else
			exist: not destroyed
		deferred
		end

	forbid_resize is
			-- Forbid the resize of the window.
		require
			exists: not destroyed
		deferred
		end

	allow_resize is
			-- Allow the resize of the window.
		require
			exists: not destroyed
		deferred
		end

	set_iconic_state is
			-- Set start state of the application to be iconic.
		require
			exists: not destroyed
		deferred
		end

 	set_normal_state is
			-- Set start state of the application to be normal.
		require
			exists: not destroyed
		deferred
		end

	set_maximize_state is
			-- Set start state of the application to be
			-- maximized.
		require
			exists: not destroyed
		deferred
		end

	set_modal is
			-- Make the window modal
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_maximum_width (value: INTEGER) is
			-- Make `value' the new `maximum_width'.
		require
			exists: not destroyed
			large_enough: value >= 0
		deferred
		ensure
			maximum_width_set: maximum_width = value
		end 

	set_maximum_height (value: INTEGER) is
			-- Make `value' the new `maximum_height'.
		require
			exists: not destroyed
			large_enough: value >= 0
		deferred
		ensure
			maximum_height_set: maximum_height = value
		end

	set_title (txt : STRING) is
			-- Make `text' the new title.
		require
			exists: not destroyed
			valid_title: txt /= Void
		deferred
		end
	
	set_icon_name (txt: STRING) is
			-- Make `txt' the new icon name.
		require
			exists: not destroyed
			valid_name: txt /= Void
		deferred
		end

	set_icon_mask (pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon mask.
		require
			exists: not destroyed
			valid_mask: is_valid (pixmap)
		deferred
		end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
			-- Set `icon_pixmap' to `pixmap'.
		require
			exists: not destroyed
			valid_pixmap: is_valid (pixmap)
		deferred
		end

	set_widget_group (widget: EV_WIDGET) is
			-- Make Current part of the group of `widget'.
		require
			exists: not destroyed
			valid_widget: is_valid (widget)
		deferred
		end

feature -- Event - command association

	add_close_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the window is closed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_resize_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the window is resized.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_move_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget is moved.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_close_commands is
			-- Empty the list of commands to be executed
			-- when the window is closed.
		require
			exists: not destroyed
		deferred
		end

	remove_resize_commands is
			-- Empty the list of commands to be executed
			-- when the window is resized.
		require
			exists: not destroyed
		deferred
		end

	remove_move_commands is
			-- Empty the list of commands to be executed
			-- when the widget is resized.
		require
			exists: not destroyed
		deferred
		end

end -- clas EV_WINDOW_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
