indexing
	description: "Abstract class representing a target in which %
				%pick and drop data may be dropped."
	status: "See notice at end of class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_TARGET

feature -- Access

	add_pnd_command (type: EV_PND_TYPE; cmd: EV_COMMAND; args: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed when
			-- a data of type `type' is dropped into current target.
		require
			valid_type: type /= Void
			valid_command: cmd /= Void
		do
			implementation.add_pnd_command (type, cmd, args)
		end


	add_default_pnd_command (cmd: EV_COMMAND; args: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed when
			-- any data is dropped into current target.
		require
			valid_command: cmd /= Void
		do
			implementation.add_default_pnd_command (cmd, args)
		end

feature {NONE} -- Implementation

	implementation: EV_PND_TARGET_I
			-- Implementation of current pick and drop target

end -- class EV_PND_TARGET

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

