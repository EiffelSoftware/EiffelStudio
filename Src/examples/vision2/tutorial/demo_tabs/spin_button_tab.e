indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SPIN_BUTTON_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects.
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
		once
			{ANY_TAB} Precursor (Void)
			create cmd1.make (~set_step)
			create cmd2.make (~get_step)
			create f1.make (Current, 0, 0, "Step Value", cmd1, cmd2)
			
		end

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Spin Button"
		end

	current_widget: EV_RANGE

feature -- Access

	
	set_step (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the step of the spin button
		do
		--	current_widget.set_step(f1.get_text.to_integer)
			f1.set_text("Inapplicable")
		end

	get_step (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the step of the spin button
		do
			f1.set_text(current_widget.step.out)
		end


	f1: TEXT_FEATURE_MODIFIER

end -- class SPIN_BUTTON_TAB
 


--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

