indexing
	description: 
		"EiffelVision events queue manager. This class provides facilities%
		%to manage the event queue between two main iterations (e.g to%
		%refresh a progress bar)."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_EVENTS_QUEUE

create
	make

feature {NONE} -- Initialization

	make is
			-- Create the event queue manager.
		do
			create {EV_EVENTS_QUEUE_IMP} implementation
		end


feature -- Basic operations

	process is
			-- Process all the events of the event queue.
		do
			implementation.process
		end

feature {NONE} -- Implementation
	
	implementation: EV_EVENTS_QUEUE_I

end -- class EV_EVENTS_QUEUE

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
