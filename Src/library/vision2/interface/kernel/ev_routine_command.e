indexing
	" Routine notion of command. To create this kind of%
	% command any procedure with the following signature :%
	% execute (arg: EV_ARGUMENT; event_data: EV_EVENT_DATA)%
	% can be used."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ROUTINE_COMMAND

inherit
	EV_COMMAND

creation
	make

feature {NONE} -- Initialization

	make (proc: PROCEDURE [ANY, TUPLE [EV_ARGUMENT, EV_EVENT_DATA]]) is
			-- Create the command that uses `a_routine' as
			-- execution procedure.
		require
			valid_proc: proc /= Void and proc.callable
		do
			procedure := proc
		end

feature -- Access

	procedure: PROCEDURE [ANY, TUPLE [EV_ARGUMENT, EV_EVENT_DATA]]

feature -- Basic operations

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current command.
			-- `args' and `data' are automatically passed by
			-- EiffelVision when Current command is
			-- invoked as a callback.
			-- Call the routine
		do
			procedure.call ([args, data])
		end

end -- class EV_ROUTINE_COMMAND

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
