indexing
	description: "EiffelVision wel_command adapts %
				 %any ev_commands to wel."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_COMMAND
		

inherit
	WEL_COMMAND
		redefine
			set_message_information
		end

creation
	make


feature -- Initialization

	make (a_command: EV_COMMAND; an_arg: EV_ARGUMENTS) is
			-- Create the adapter by setting `event', `command' and `arg'
			-- to the new values
		require
			a_command_not_void: a_command /= Void
		do
			command := a_command
			arg := an_arg
		ensure
			command_set: command = a_command
			argument_set: arg = an_arg
		end


feature -- Access

	command: EV_COMMAND
			-- User-defined command to execute

	arg: EV_ARGUMENTS
			-- Argument to be given to `command' before execution

	
feature {NONE} -- Implementation

	execute (argument: ANY) is
			-- Execute the command with `argument'.
		do
			command.execute (arg)
		end

	set_message_information (mi: WEL_MESSAGE_INFORMATION) is
			-- Translate the wel_message_information' into
			-- the `ev_event_data' attribute of `arg'.
		local
			data_imp: EV_EVENT_DATA_IMP
		do
			message_information := mi
			if command.event_data_useful then
				data_imp ?= command.event_data.implementation
				check
					event_data_useful_not_void: command.event_data_useful /= Void
					data_imp_not_void: data_imp /= Void
				end
				data_imp.fill (mi)
			end
		end

end -- class EV_WEL_COMMAND

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
