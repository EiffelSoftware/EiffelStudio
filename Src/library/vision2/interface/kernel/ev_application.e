indexing
	description: 
		"EiffelVision application. This class is used in every%
		% EiffelVision program. The purpose of the class is to%
		% initialize the underlying toolkit and hide the%
		% implementation specific details from the application%
		% developer."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_APPLICATION
	

feature {NONE} -- Initialization
	
	make is
			-- Create the application.
		do
			create {EV_APPLICATION_IMP} implementation.make
			implementation.launch (Current)
			implementation.iterate
		end

feature	-- Access
	
	main_window: EV_WINDOW is
			-- Must be defined as a once funtion to create
			-- the application's main_window.
		deferred
		end

feature -- Accelerators - Initialization

	init_accelerators is
			-- Redefine this feature to add your global
			-- accelerators to the application.
		do
		end

feature -- Accelerators - command association

	add_accelerator_command (acc: EV_ACCELERATOR; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when `acc' is completed by the user.
		require
			valid_command: cmd /= Void
		do
			implementation.add_accelerator_command (acc, cmd, arg)
		end

	remove_accelerator_commands (acc: EV_ACCELERATOR) is
			-- Empty the list of commands to be executed when
			-- `acc' is completed by the user.
		do
			implementation.remove_accelerator_commands (acc)
		end

feature -- Basic operation

	exit is
			-- Exit the application
		do
			implementation.exit
		end

feature {NONE} -- Implementation
	
	implementation: EV_APPLICATION_I

end -- class EV_APPLICATION

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
