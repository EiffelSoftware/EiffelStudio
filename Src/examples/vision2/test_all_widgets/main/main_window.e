indexing

	description: 
	"MAIND_WINDOW, main window for the application. Belongs to EiffelVision example."
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
	
	EV_COMMAND
	

creation

	make

feature --Access
	
	buttons: LINKED_LIST[MAIN_WINDOW_BUTTON]
	container: EV_VERTICAL_BOX
			-- Push buttons
	
	current_demo_window: DEMO_WINDOW
	
feature -- Initialization
	
	make is
		local
			b: MAIN_WINDOW_BUTTON
			c1: LABEL_DEMO_WINDOW
			c2: FIXED_DEMO_WINDOW
			c3: BOX_DEMO_WINDOW
			c4: NOTEBOOK_DEMO_WINDOW
			c5: ENTRY_DEMO_WINDOW
			c6: MULTI_LINE_ENTRY_DEMO_WINDOW
		do
			Precursor
			!!container.make (Current)
			
			
			!!c1.make
			!!c2.make
			!!c3.make
			!!c4.make
			!!c5.make
			!!c6.make
			
			!!buttons.make
			!!b.make_button (Current, "Label", c1)
			buttons.extend (b)
			!!b.make_button (Current, "Fixed", c2)
			buttons.extend (b)
			!!b.make_button (Current, "Box", c3)
			buttons.extend (b)
			!!b.make_button (Current, "Notebook", c4)
			buttons.extend (b)
			!!b.make_button (Current, "Entry", c5)
			buttons.extend (b)
			!!b.make_button (Current, "Multi line entry", c6)
			buttons.extend (b)
			
			set_values
		end
	
feature -- Status setting
	

	
	execute (arg: EV_ARGUMENT1[DEMO_WINDOW]) is
		-- called when actions window is deleted
		do
 			arg.first.actions_window.destroy
			set_insensitive (False)
		end
		
feature -- Status setting
	
	set_values is
		do
			set_title ("Test all widgets")
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
