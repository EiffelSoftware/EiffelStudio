indexing
	description: 
		"EiffelVision application, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_APPLICATION_I
	
feature {EV_APPLICATION} -- Initialization
	
	make is
			-- Create the application.
		deferred
		end

	launch (interface: EV_APPLICATION) is
			-- Launch the main window and the application.
		deferred
		end

feature -- Accelerators - command association

	add_accelerator_command (acc: EV_ACCELERATOR; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when `acc' is completed by the user.
		require
			valid_command: cmd /= Void
		deferred
		end

	remove_accelerator_commands (acc: EV_ACCELERATOR) is
			-- Empty the list of commands to be executed when
			-- `acc' is completed by the user.
		deferred
		end

feature -- Basic operation

	exit is
			-- Exit the application
		deferred
		end

	splash_pixmap (pix: EV_PIXMAP) is
			-- Show the splash screen pixmap `pix'.
		deferred
		end

	splash_screen: EV_UNTITLED_WINDOW_IMP
			-- Splash screen of the application

feature {EV_APPLICATION} -- Implementation
	
	iterate is
			-- Loop the application.
		deferred
		end

feature {EV_UNTITLED_WINDOW_I} -- Root windows management

	root_windows: ARRAYED_LIST [EV_UNTITLED_WINDOW_IMP] is
			-- List of the root windows
		once
			create Result.make (0)
		end

	add_root_window (w: EV_UNTITLED_WINDOW_IMP) is
			-- Add `w' to the list of root windows.
		require
			valid_window: w /= Void
		deferred
		end

	remove_root_window (w: EV_UNTITLED_WINDOW_IMP) is
			-- Remove `w' from the root windows list.
		require
			valid_window: w /= Void
		deferred
		end

end -- class EV_APPLICATION_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
