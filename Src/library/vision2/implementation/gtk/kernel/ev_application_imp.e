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
		do
			main_window ?= interface.main_window.implementation
			main_window.connect_to_application ($exit_from_main_window, $Current)
		ensure then
			valid_window: main_window /= Void
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
