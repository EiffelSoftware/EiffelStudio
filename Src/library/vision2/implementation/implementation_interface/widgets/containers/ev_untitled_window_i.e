indexing
	description: "EiffelVision untitled window, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_UNTITLED_WINDOW_I

inherit
	EV_CONTAINER_I
		export
			{NONE} set_expand
			{NONE} set_parent
		redefine
			set_default_colors
		end

feature {NONE} -- Initialization

	make is
			-- create the untitled window.
		deferred
		end

	make_root is
			-- Create a root window for the application.
		local
			window_imp: EV_UNTITLED_WINDOW_IMP
		do
			window_imp ?= Current
			make

			if (application.item /= Void) then
				application.item.add_root_window (window_imp)
			end
		end

	make_with_owner (par: EV_UNTITLED_WINDOW) is
			-- Create a window with `par' as parent.
			-- The life of the window will depend on
			-- the one of `par'.
		deferred
		end

feature {EV_UNTITLED_WINDOW} -- Initialization

	set_default_colors is
			-- Initialize the colors of the widget
		local
			default_colors: EV_DEFAULT_COLORS
			color: EV_COLOR
		do
			create default_colors
			set_background_color (default_colors.Color_dialog)
			create color.make_rgb (0, 0, 0)
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

feature -- Status setting

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

	set_modal is
			-- Make the window modal
		require
			exists: not destroyed
		deferred
		end

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

	set_widget_group (widget: EV_WIDGET) is
			-- Make Current part of the group of `widget'.
		require
			exists: not destroyed
			valid_widget: is_valid (widget)
		deferred
		end

feature -- Miscellaneous

	WINDOW_POSITION_NONE: INTEGER is 0
			-- Constant to use to have the window first displayed
			-- at .

	WINDOW_POSITION_CENTER: INTEGER is 1
			-- Constant to use to have the window first displayed
			-- at the center of the screen.


	WINDOW_POSITION_MOUSE: INTEGER is 2
			-- Constant to use to have the window first displayed
			-- at the mouse position.

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

end -- class EV_UNTITLED_WINDOW_I

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

