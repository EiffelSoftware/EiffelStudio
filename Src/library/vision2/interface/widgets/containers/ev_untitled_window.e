indexing
	description: "EiffelVision untitled window. Window without the overlapped title."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_WINDOW

inherit
	EV_CONTAINER
		export
			{NONE} set_expand
			{NONE} set_parent
		redefine
			implementation,
			parent,
			show,
			widget_make,
			parent_needed
		end

creation
	make_root,
	make_top_level,
	make

feature {NONE} -- Initialization

	make_root is
			-- Create a root window for the application.
		do
			create {EV_UNTITLED_WINDOW_IMP} implementation.make_root
			widget_make (Void)
		end

	make_top_level is
			-- Create a top level window (a Window 
			-- without a parent).
		do
			create {EV_UNTITLED_WINDOW_IMP} implementation.make
			widget_make (Void)
		end

	make (par: EV_UNTITLED_WINDOW) is
			-- Create a window with a parent. Current
			-- window will be closed when the parent is
			-- closed. The parent of window is a window 
			-- (and not any EV_CONTAINER).
		do
			create {EV_UNTITLED_WINDOW_IMP} implementation.make_with_owner (par)
			widget_make (par)
		end

	widget_make (par: EV_CONTAINER) is
			-- This is a general initialization for 
			-- widgets and has to be called by all the 
			-- widgets.
		do
			implementation.widget_make (Current)
			if par /= Void then
				managed := False
			end
		end

feature  -- Access
 
	parent: like Current is
			-- The parent of the Current window: a window
			-- If the widget is an EV_UNTITLED_WINDOW without parent,
			-- this attribute will be `Void'
		do
			Result ?= {EV_CONTAINER} Precursor
		end

	maximum_width: INTEGER is
			-- Maximum width that application wishes widget
			-- instance to have
		require
			exists: not destroyed
		do
			Result := implementation.maximum_width
		ensure
			Result >= 0
		end

	maximum_height: INTEGER is
			-- Maximum height that application wishes widget
			-- instance to have
		require
			exists: not destroyed
		do
			Result := implementation.maximum_height
		ensure
			Result >= 0
		end

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		require
			exists: not destroyed
		do
			Result := implementation.title
		end

	widget_group: EV_WIDGET is
			-- Widget with wich current widget is associated.
			-- By convention this widget is the "leader" of a group
			-- widgets. Window manager will treat all widgets in
			-- a group in some way; for example, it may move or
			-- iconify them together
		require
			exists: not destroyed
		do
			Result := implementation.widget_group
		end 

feature -- Status setting

	forbid_resize is
			-- Forbid the resize of the window.
		require
			exists: not destroyed
		do
			implementation.forbid_resize
		end

	allow_resize is
			-- Allow the resize of the window.
		require
			exists: not destroyed
		do
			implementation.allow_resize
		end

	set_modal is
			-- Make the window modal
		require
			exists: not destroyed
		do
			implementation.set_modal
		end

	set_maximum_width (value: INTEGER) is
			-- Make `value' the new `maximum_width'.
		require
			exists: not destroyed
			large_enough: value >= 0
		do
			implementation.set_maximum_width (value)
		ensure
			maximum_width_set: maximum_width = value
		end 

	set_maximum_height (value: INTEGER) is
			-- Make `value' the new `maximum_height'.
		require
			exists: not destroyed
			large_enough: value >= 0
		do
			implementation.set_maximum_height (value)
		ensure
			maximum_height_set: maximum_height = value
		end

	set_title (txt: STRING) is
			-- Make `text' the new title.
		require
			exists: not destroyed
			valid_title: txt /= Void
		do
			implementation.set_title (txt)
		end

	set_widget_group (widget: EV_WIDGET) is
			-- Make Current part of the group of `widget'.
		require
			exists: not destroyed
			valid_widget: is_valid (widget)
		do
			implementation.set_widget_group (widget)
		end

	show is
		 	-- Make widget visible on the screen. (default)
			-- Redefined of show from EV_WIDGET because
			-- a window can have no parent (ex: main_window)
		require else
			exists: not destroyed
		do
			implementation.show
		end

feature -- Event - command association

	add_close_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the window is closed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_close_command (cmd, arg)
		end

	add_resize_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the window is resized.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_resize_command (cmd, arg)
		end

	add_move_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget is moved.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_move_command (cmd, arg)
		end

feature -- Event -- removing command association

	remove_close_commands is
			-- Empty the list of commands to be executed
			-- when the window is closed.
		require
			exists: not destroyed
		do
			implementation.remove_close_commands
		end

	remove_resize_commands is
			-- Empty the list of commands to be executed
			-- when the window is resized.
		require
			exists: not destroyed
		do
			implementation.remove_resize_commands
		end

	remove_move_commands is
			-- Empty the list of commands to be executed
			-- when the widget is resized.
		require
			exists: not destroyed
		do
			implementation.remove_move_commands
		end

feature -- Assertion features

	parent_needed: BOOLEAN is
			-- Is a parent needed by the widget
		do
			Result := True
		end

feature -- Implementation

	implementation: EV_UNTITLED_WINDOW_I
			-- Implementation of window

end -- class EV_UNTITLED_WINDOW

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

