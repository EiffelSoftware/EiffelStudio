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
	
	make (interf: EV_APPLICATION) is
		local
			w: EV_WINDOW
		do
			init_windowing
			w := interf.main_window
			check
				valid_main_window: w /= Void
			end
			main_window ?= w.implementation
			check
				valid_implementation: main_window /= Void
			end
			main_window.connect_to_application ($exit_from_main_window, $Current)
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

	exit is
			-- Exit
		do
			gtk_main_quit
		end	

	exit_from_main_window is
			-- Exit the application after the user
			-- closed the main window.
		do
			if not main_window.has_close_command then
				exit
			end
		end

	main_window: EV_WINDOW_IMP
			-- Implementation of the main window of
			-- the application.

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
