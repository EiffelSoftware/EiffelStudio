indexing

	description: 
	"DEMO_WINDOW, base class for all demo windows. Belongs to EiffelVision example test_all_widgets."
	status: "See notice at end of class"
	note: "A demo window is an empty window, features must be redefine to have a full window."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	DEMO_WINDOW

inherit

	EV_WINDOW
		rename
			make as parent_make
		end
	
	EV_WINDOW
		redefine	
			make
		select 
			make
		end

creation
	make

feature --Access

	main_widget: EV_WIDGET is
		do
		end
	
	actions_window: ACTIONS_WINDOW
			-- Actions window related to this demo

	effective_button: EV_TOGGLE_BUTTON
			-- Button which was pressed when this demo 
			-- window was opened
	
feature -- Initialization
	
	make (par: MAIN_WINDOW) is
		do
			the_parent := par
			parent_make (the_parent)
			set_widgets
			set_values
		end
	
feature -- Access

	the_parent: MAIN_WINDOW

feature -- Status setting
        
	set_widgets is
                do
		end
	
	set_values is
 		do
 		end

-- 	set_commands is
-- 		deferred
-- 		end

	set_effective_button (but: EV_TOGGLE_BUTTON) is
			-- Make `but' the new `effective_button'.
		do
			effective_button := but
		end

feature -- Show the window
	
	activate (win: MAIN_WINDOW) is
		local
			a: EV_ARGUMENT1[DEMO_WINDOW]
			w: EV_ARGUMENT1[EV_WIDGET]
			destroy_c: DESTROY_COMMAND
		do
			show
			!!actions_window.make_with_main_widget (Current, main_widget)
			actions_window.show
			!!destroy_c
			!!w.make (actions_window)
			actions_window.add_close_command (destroy_c, w)
			win.set_insensitive (True)
			!!a.make (Current)
			add_close_command (win, a)
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
