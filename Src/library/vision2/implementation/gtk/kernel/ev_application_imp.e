indexing

	description: 
		"EiffelVision application, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_APPLICATION_IMP
	
	
inherit
	EV_GTK_GENERAL_EXTERNALS
	
	EV_APPLICATION_I
creation 
	
	make
	
feature {NONE} -- Initialization
	
	make is
			-- Create the application
		do
			init_windowing
		end

	launch (interface: EV_APPLICATION) is
			-- Launch the main window and the application.
		local
			w: EV_UNTITLED_WINDOW_IMP
		do
			-- Prepare and show the splash_screen
			interface.initialize

			w ?= interface.first_window.implementation

			-- Add the window in `root_windows'.
			add_root_window (w)

			-- set the widget's attribut `application' to `interface'.
			w.application.put (Current)
		end

feature -- Access

	main_window: EV_WINDOW_IMP
			-- Implementation of the main window of
			-- the application.

feature -- Accelerators - command association

	add_accelerator_command (acc: EV_ACCELERATOR; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when `acc' is completed by the user.
		do
		end

	remove_accelerator_commands (acc: EV_ACCELERATOR) is
			-- Empty the list of commands to be executed when
			-- `acc' is completed by the user.
		do
		end

feature -- Basic operation

	exit is
			-- Exit
		do
			gtk_main_quit
		end	

	splash_pixmap (pix: EV_PIXMAP) is
			-- Show the splash screen pixmap `pix'.
		do
			create splash_screen.make
			splash_screen.set_background_pixmap (pix)
			splash_screen.set_minimum_size (pix.width, pix.height)
			splash_screen.show
		end

feature {NONE} -- Implementation
	
	init_windowing is
			-- Initialize the toolkit.
			-- (force call to once routines).
		do
			c_gtk_init_toolkit
		end
	
       iterate is
                        -- Loop the application.
                do
			-- Destroy the spalsh screen if there is one.
			if (splash_screen /= void) then
				splash_screen.destroy
			end

			-- Start the application.
                        gtk_main
                end

	exit_from_main_window is
			-- Exit the application after the user
			-- closed the main window.
		do
			if not main_window.has_close_command then
				exit
			end
		end

feature {EV_UNTITLED_WINDOW_I} -- Root windows management

	add_root_window (w: EV_UNTITLED_WINDOW_IMP) is
			-- Add `w' to the list of root windows.
		do
			-- Add the window in the windows array.
			root_windows.extend (w)

			-- connect its life to remove_root_window
			 w.connect_to_application ($remove_root_window, $Current, $w)			
		end

	remove_root_window (w: EV_UNTITLED_WINDOW_IMP) is
			-- Remove `w' from the root windows list.
		require else
			root_windows_non_empty: root_windows.count > 0
		do
			-- Remove the window from the windows array.
			root_windows.start
			root_windows.prune (w)

			-- Test if `root_windows' is empty.
			-- If so, we have to end the application.
			if (root_windows.empty) then
				exit
			end
		end

end -- class EV_APPLICATION_IMP

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
