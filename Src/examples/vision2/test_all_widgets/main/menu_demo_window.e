indexing

	description: 
	"MENU_DEMO_WINDOW, demo window to test menu widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MENU_DEMO_WINDOW

inherit

	DEMO_WINDOW
	
creation

	make

feature -- Access

	main_widget: EV_MENU_BAR is
		once
			!!Result.make (Current)
		end
	
	
	file_i: EV_MENU_ITEM
	
	new_i: EV_MENU_ITEM
	open_i: EV_MENU_ITEM
	save_i: EV_MENU_ITEM
	quit_i: EV_MENU_ITEM
	
	edit_i: EV_MENU_ITEM
	
	cut_i: EV_MENU_ITEM
	copy_i: EV_MENU_ITEM
	paste_i: EV_MENU_ITEM
	
	test_i: EV_MENU_ITEM
	test1_i: EV_MENU_ITEM
	test_sub_i: EV_MENU_ITEM
	test_sub1_i: EV_MENU_ITEM
	test_sub2_i: EV_MENU_ITEM
	test_sub3_i: EV_MENU_ITEM
	
	
	file_m: EV_MENU
	edit_m: EV_MENU
	test_m: EV_MENU
	test_sub_m: EV_MENU

			-- Push buttons
feature -- Status setting
	
	set_widgets is
		local
			c: DESTROY_COMMAND
			a: EV_ARGUMENT1 [EV_WIDGET]
		do
			
		
			!!file_i.make_with_text (main_widget, "File")
			!!file_m.make (main_widget)
			file_i.set_menu (file_m)			

			!!new_i.make_with_text (file_m, "New")
			!!open_i.make_with_text (file_m, "Open")
			!!save_i.make_with_text (file_m, "Save")
			!!quit_i.make_with_text (file_m, "Quit")
			
			!!c
			!!a.make (Current)
			quit_i.add_activate_command (c, a)
						
			!!edit_i.make_with_text (main_widget, "Edit")
			!!edit_m.make (main_widget)
			edit_i.set_menu (edit_m)
			
			!!cut_i.make_with_text (edit_m, "Cut")
			!!copy_i.make_with_text (edit_m, "Copy")
			!!paste_i.make_with_text (edit_m, "Paste")
			
			  			  
			!!test_i.make_with_text (main_widget, "Test")
			!!test_m.make (main_widget)
			test_i.set_menu (test_m)
			
			!!test1_i.make_with_text (test_m, "Sub menu1")
			!!test_sub_m.make (test_m)
			test1_i.set_menu (test_sub_m)
			
			!!test_sub1_i.make_with_text (test_sub_m, "Selection 1")
			!!test_sub2_i.make_with_text (test_sub_m, "Selection 2")
			!!test_sub3_i.make_with_text (test_sub_m, "Selection 3")
			
			
		end
	
feature -- Status setting
	
	set_values is
		do
			set_title ("Menu demo")
			save_i.set_insensitive (True)
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
