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
		redefine
			build
		end
	
	EV_DEFAULT_COLORS
		export
			{NONE} all
		end

feature {NONE} -- Initialization
	
	make (par: EV_WINDOW) is
			-- Create a window with a parent. Current
			-- window will be closed when the parent is
			-- closed. The parent of window is a window 
			-- (and not any EV_CONTAINER).
		deferred
		end

	make_top_level is
			-- Create a top level window (a Window 
			-- without a parent).
		deferred
		end

feature {EV_WINDOW} -- Initialization

	build is
			-- Common initializations for Gtk and Windows.
		local
			color: EV_COLOR
		do
--			if parent_imp /= Void then
--				set_background_color (parent_imp.background_color.interface)
--				set_foreground_color (parent_imp.foreground_color.interface)
--			else
--				set_background_color (Color_dialog)
--				!! color.make_rgb (0, 0, 0)
--				set_foreground_color (color)
--			end
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

feature -- Element change

	set_maximum_width (max_width: INTEGER) is
			-- Set `maximum_width' to `max_width'.
		require
			exists: not destroyed
			large_enough: max_width >= 0
		deferred
		ensure
			max_width = max_width
		end 

	set_maximum_height (max_height: INTEGER) is
			-- Set `maximum_height' to `max_height'.
		require
			exists: not destroyed
			large_enough: max_height >= 0
		deferred
		ensure
			max_height = max_height
		end

	set_title (new_title: STRING) is
			-- Set `title' to `new_title'.
		require
			exists: not destroyed
			not_title_void: new_title /= Void
		deferred
		end
	
	set_icon_name (new_name: STRING) is
			-- Set `icon_name' to `new__name'.
		deferred
		end

	set_icon_mask (mask: EV_PIXMAP) is
			-- Set `icon_mask' to `mask'.
		require
			exists: not destroyed
			not_mask_void: mask /= Void
		deferred
		end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
			-- Set `icon_pixmap' to `pixmap'.
		require
			exists: not destroyed
			not_pixmap_void: pixmap /= Void
	--XX	valid_pixmap: pixmap.is_valid
		deferred
		end

	set_widget_group (group_widget: EV_WIDGET) is
                        -- Set `widget_group' to `group_widget'.
		require
				exists: not destroyed
		deferred
		end

feature -- Event - command association

	add_close_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executed command when the window is closed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_resize_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executed command when the window is resized.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_move_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executes command when the widget is resized.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature {EV_WINDOW, EV_APPLICATION} -- Implementation
	
	application: EV_APPLICATION
			-- EiffelVision application associated to the
			-- window.
	
	set_application (app: EV_APPLICATION) is
			-- Associate the window with 'app'. Is this 
			-- is done, exiting the window will exit the 
			-- application, unless delete_command is set.
		do
			application := app
		end	

feature {NONE} -- Implementation

--	close_command: EV_COMMAND	
--
--	window_closed is
--			-- Called when the window is deleted (closed).
--			-- If window is the main window of the
--			-- application, this feature will exit
--			-- application if `close_command' is not set).
--		local
--			a: EV_ARGUMENT1[EV_WINDOW]
--			window_interface: EV_WINDOW
--		do
--			if close_command = Void then
--				if application /= Void then
--					application.exit
--				end
--				plateform_closed
--				interface.remove_implementation
--			else
--				window_interface ?= interface
--				check
--					window_interface /= Void
--				end
--				!!a.make (window_interface)
--				close_command.execute (a)
--			end
--		end
       
	plateform_closed is
			-- A specific function for each plateform to definitely
			-- destroy the informations after the manager destroyed
			-- the widget.
		deferred
		ensure
			destroyed: destroyed
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
