indexing
	description: 
		"EiffelVision events queue manager. Gtk Implementation.%
		%This class provides facilities to manage the event queue%
		%between two main iterations (e.g to refresh a progress bar)."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_EVENTS_QUEUE_IMP

inherit
	EV_EVENTS_QUEUE_I

	EV_GTK_GENERAL_EXTERNALS

feature -- Basic operations

	process is
			-- Process all the events of the events queue.
		do
			c_gtk_events_process_events_queue ()
		end

end -- class EV_EVENTS_QUEUE_IMP

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
