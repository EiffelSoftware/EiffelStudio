indexing

	description:
		"General notion of command (semantic unity). %
		%To write an actual command inherit from this %
		%class and implement the `execute' feature"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	EV_COMMAND 

feature -- Access

	event_data: EV_EVENT_DATA
			-- Information related to Current command,
			-- provided by the underlying user interface 
			-- mechanism

feature -- Status report
	
	
	--XX check the purpose of this this
	is_template: BOOLEAN is
			-- Is the current command a template, in other words,
			-- should it be cloned before execution?
			-- If true, EiffelVision will clone Current command 
			-- whenever it is invoked as a callback
		do
		end

	event_data_useful: BOOLEAN is
			-- Should the context data be available
			-- when Current command is invoked as a
			-- callback
		do
		end

feature -- Basic operations

	execute (arguments: EV_ARGUMENTS) is
			-- Execute Current command.
			-- `arguments' is automatically passed by
			-- EiffelVision when Current command is
			-- invoked as a callback.
		deferred
		end
	
	execute_address: POINTER is
			-- Address of feature execute 
		do
			Result := routine_address($execute)
		end
	
feature {NONE} -- Implementation
	
	routine_address (routine: POINTER): POINTER is
		do
			Result := routine
		end

feature {EV_WIDGET_I, EV_EVENT_HANDLER_IMP} -- Element change

 	set_event_data (data: EV_EVENT_DATA) is
 			-- Set `event_data' to `data'.
			-- This is used internally by EiffelVision to 
			-- set event data given by the windowing system
 		do
 			event_data := data
 		ensure
 			event_data = data
 		end

end -- class EV_COMMAND


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

