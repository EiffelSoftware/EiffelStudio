indexing
	description: ""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_EDITOR_COMMAND

inherit
	EV_UNDOABLE_COMMAND

feature {NONE} -- Initialization

	make (a_history: EV_HISTORY) is
			-- Creates the command. The command will
			-- be automatically recorded in the history
			-- as soon as it will be executed.
		require
			history_not_void: a_history /= Void
		do
			history := a_history
		ensure
			history_set: history /= Void and then history = a_history
		end

feature -- Access

	history: EV_HISTORY

feature -- Basic operation

	failed: BOOLEAN
			-- Was the command execution succesful?

feature -- Debug
	print_contents is
		deferred
		end

end -- class EV_TEXT_EDITOR_COMMAND

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
