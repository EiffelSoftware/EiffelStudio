indexing
	description: "EiffelVision window. Window is a visible window%
				% on the screen."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_WINDOW

inherit
	EV_CONTAINER
		redefine
			implementation,
			parent
		end

creation
	make,
	make_top_level
	
feature {NONE} -- Initialization

    make (par: EV_WINDOW) is
			-- Create a window with a parent. Current
			-- window will be closed when the parent is
			-- closed. The parent of window is a window 
			-- (and not any EV_CONTAINER).
		do
			!EV_WINDOW_IMP!implementation.make (par)
			implementation.set_interface (Current)
			implementation.plateform_build (par.implementation)
			implementation.build
		end
	
    make_top_level is
			-- Create a top level window (a Window 
			-- without a parent).
		require
			-- toolkit initialized XXX
		do
			!EV_WINDOW_IMP!implementation.make_top_level 
			implementation.set_interface (Current)
			implementation.plateform_build (Void)
			implementation.build
		end
	
feature  -- Access
 
	parent: EV_WINDOW is
			-- The parent of the Current window: a window
			-- If the widget is an EV_WINDOW without parent,
			-- this attribute will be `Void'
		do
			if implementation.parent_imp /= Void then
				Result ?= implementation.parent_imp.interface
				check
					result_not_void: Result /= Void
				end
			else
				Result := Void
			end
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

	icon_name: STRING is
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified 
		require
			exists: not destroyed
		do
			Result := implementation.icon_name
		end 
	
	icon_mask: EV_PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		require
			exists: not destroyed
		do
			Result := implementation.icon_mask
		end

	icon_pixmap: EV_PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		require
			exists: not destroyed
		do
			Result := implementation.icon_pixmap
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
		do
			Result := implementation.widget_group
		end 

feature -- Status report

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		require
			exists: not destroyed
		do
			Result := implementation.is_iconic_state
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

	set_iconic_state is
			-- Set start state of the application
			-- to be iconic.
		require
			exists: not destroyed
		do
			implementation.set_iconic_state
		end

	set_normal_state is
			-- Set start state of the application to be normal.
		require
			exists: not destroyed
		do
			implementation.set_normal_state
		end

	set_maximize_state is
			-- Set start state of the application to be
			-- maximized.
		require
			exists: not destroyed
		do
			implementation.set_maximize_state
		end

feature -- Element change

	set_maximum_width (max_width: INTEGER) is
			-- Make `max_width' the new `maximum_width'.
		require
			exists: not destroyed
			large_enough: max_width >= 0
		do
			implementation.set_maximum_width (max_width)
		ensure
			max_width = max_width
		end 

	set_maximum_height (max_height: INTEGER) is
			-- Make `max_height' the new `maximum_height'.
		require
			exists: not destroyed
			large_enough: max_height >= 0
		do
			implementation.set_maximum_height (max_height)
		ensure
			max_height = max_height
		end

	set_title (new_title: STRING) is
                        -- Set `title' to `new_title'.
                require
                        exists: not destroyed
                        not_title_void: new_title /= Void
                do
                        implementation.set_title (new_title)
                end

	set_icon_name (new_name: STRING) is
			-- Set `icon_name' to `new_name'.
		require
			exists: not destroyed
			Valid_name: new_name /= Void
		do
			implementation.set_icon_name (new_name)
		end

	set_icon_mask (mask: EV_PIXMAP) is
                        -- Set `icon_mask' to `mask'.
                require
                        exists: not destroyed
                        not_mask_void: mask /= Void
                do
                        implementation.set_icon_mask (mask)
                end

	set_icon_pixmap (pixmap: EV_PIXMAP) is
                        -- Set `icon_pixmap' to `pixmap'.
                require
                        exists: not destroyed
                        not_pixmap_void: pixmap /= Void
--XX                        valid_pixmap: pixmap.is_valid
                do
                        implementation.set_icon_pixmap (pixmap)
                end

	set_widget_group (group_widget: EV_WIDGET) is
                        -- Set `widget_group' to `group_widget'.
                require
                        exists: not destroyed
                do
                        implementation.set_widget_group (group_widget)
                end

feature -- Event - command association

	add_close_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executed command when the window is closed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_close_command (cmd, arg)
		end

	add_resize_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executed command when the window is resized.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_resize_command (cmd, arg)
		end

	add_move_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executes command when the widget is resized.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_move_command (cmd, arg)
		end

feature -- Implementation

	implementation: EV_WINDOW_I
			-- Implementation of window

feature {EV_APPLICATION, EV_APPLICATION_IMP} -- Implementation
	
	application: EV_APPLICATION
			-- EiffelVision application associated to the
			-- window.
	
	set_application (app: EV_APPLICATION) is
			-- Associate the window with 'app'. Is this 
			-- is done, exiting the window will exit the 
			-- application, unless delete_command is set.
		do
			implementation.set_application (app)
		end
		
invariant

--        Depth_is_zero: depth = 0
--        Has_no_parent: parent = Void

		
end -- class EV_WINDOW

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

