indexing

	description: 
	"WINDOW1, main window for the application. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MAIN_WINDOW

inherit

	EV_WINDOW
		redefine	
			make
		end
	

creation

	make

feature --Access

	label_b, fixed_b, box_b, notebook_b, entry_b, multi_line_entry_b: EV_BUTTON
	box: EV_VERTICAL_BOX
			-- Push buttons
	
	current_demo_window: DEMO_WINDOW
	
feature -- Initialization
	
	make is
		do
			Precursor
			!!box.make (Current)
			!!label_b.make (box)
			!!fixed_b.make (box)
			!!box_b.make (box)
			!!notebook_b.make (box)
			!!entry_b.make (box)
			!!multi_line_entry_b.make (box)
			set_values
			set_commands
		end
	
feature -- Status setting
	
	set_values is
		do
			set_title ("Test all widgets")
--			label_b.set_width (300)
			label_b.set_text ("Label")
			fixed_b.set_text ("Fixed")
			box_b.set_text ("Box")
			notebook_b.set_text ("Notebook")
			entry_b.set_text ("Entry")
			multi_line_entry_b.set_text ("Multi line entry")
		end


	set_commands is
		local
			c1: LABEL_DEMO_WINDOW
			c2: FIXED_DEMO_WINDOW
			c3: BOX_DEMO_WINDOW
			c4: NOTEBOOK_DEMO_WINDOW
			c5: ENTRY_DEMO_WINDOW
			c6: MULTI_LINE_ENTRY_DEMO_WINDOW
			e: EV_EVENT
			a: EV_ARGUMENT1 [STRING]
		do
			!!e.make ("clicked")
			!!a.make ("sss")
			!!c1.make
			!!c2.make
			!!c3.make
			!!c4.make
			!!c5.make
			!!c6.make
			label_b.add_command (e, c1, a)
			fixed_b.add_command (e, c2, a)
			box_b.add_command (e, c3, a)
			notebook_b.add_command (e, c4, a)
			entry_b.add_command (e, c5, a)
			multi_line_entry_b.add_command (e, c6, a)
		end
end
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
