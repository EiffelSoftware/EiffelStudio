indexing
	description:
		"The demo that goes with the gauge demo";
	date: "$Date$";
	revision: "$Revision$"

class
	SCROLL_BAR_WINDOW

inherit
	DEMO_WINDOW

	EV_VERTICAL_BOX
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first without parent because it
			-- is faster.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			{EV_VERTICAL_BOX} Precursor (Void)

			create t1.make (Current)
			create s1.make (Current)
			set_parent (par)
			create cmd.make (~execute1)
			s1.add_change_value_command (cmd, Void)
		end

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			--Executed when we use the scroll bar
		local
	do
		t1.set_text(s1.value.out)
	end
	


feature -- Access

	t1: EV_TEXT_FIELD
	s1: EV_HORIZONTAL_SCROLL_BAR
	
end -- class SCROLL_BAR_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
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

 

