indexing
	description:
		"The demo that goes with the progress bar demo";
	date: "$Date$";
	revision: "$Revision$"

class
	PROGRESS_WINDOW

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
			hbox: EV_HORIZONTAL_BOX
			vbox: EV_VERTICAL_BOX
			lab: EV_LABEL
			cmd: EV_ROUTINE_COMMAND
		do
			{EV_VERTICAL_BOX} Precursor (Void)
			set_spacing (10)
			set_vertical_resize (False)
			set_horizontal_resize (False)

			create hbox.make (Current)

			create vbox.make (hbox)
			vbox.set_spacing (5)
			vbox.set_expand (False)
			create but.make_with_text (vbox, "h")
			but.set_expand (False)
			create hbar.make (vbox)
			hbar.set_minimum_height (100)
			hbar.set_continuous
			create cmd.make (~hours)
			but.add_click_command (cmd, Void)

			create vbox.make (hbox)
			vbox.set_spacing (5)
			vbox.set_horizontal_resize (False)
			create but.make_with_text (vbox, "m")
			but.set_expand (False)
			create mbar.make (vbox)
			mbar.set_minimum_height (100)
			create cmd.make (~minutes)
			but.add_click_command (cmd, Void)

			create vbox.make (hbox)
			vbox.set_spacing (5)
			vbox.set_expand (False)
			create but.make_with_text (vbox, "s")
			but.set_expand (False)
			create sbar.make (vbox)
			sbar.set_minimum_height (100)
			sbar.set_continuous
			create cmd.make (~secondes)
			but.add_click_command (cmd, Void)

			create hbox.make (Current)
			hbox.set_spacing (5)
			hbox.set_vertical_resize (False)
			create lab.make_with_text (hbox, "Day")
			lab.set_expand (False)
			create dbar.make (hbox)
			dbar.set_minimum_width (100)

			set_parent (par)
		end

feature -- Access

	hbar, mbar, sbar: EV_VERTICAL_PROGRESS_BAR
		-- An horizontal bar

	dbar: EV_HORIZONTAL_PROGRESS_BAR
		-- A vertical progress bar

	but, time: EV_BUTTON
		-- Buttons

feature -- Execute fonctions

	hours (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Increase the hours
		do
			hbar.set_percentage (50)
			dbar.set_percentage (50)
		end


	minutes (arg: EV_ARGUMENT1 [EV_PROGRESS_BAR]; data: EV_EVENT_DATA) is
			-- Increase the minutes
		do
			mbar.set_percentage (50)
		end

	secondes (arg: EV_ARGUMENT1 [EV_PROGRESS_BAR]; data: EV_EVENT_DATA) is
			-- Increase the secondes
		do
			sbar.set_percentage (50)
		end

end -- class PROGRESS_WINDOW

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
