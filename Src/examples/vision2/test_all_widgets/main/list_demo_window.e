indexing
	description: "LIST_DEMO_WINDOW, demo window to test the list %
			%widget. Belongs to EiffelVision example test_all_widgets."
	status: "See notice at end of class"
	id: "$$"
	date: "$$"
	revision: "$$"
	
class 
	LIST_DEMO_WINDOW

inherit
	
	DEMO_WINDOW
	
creation
	make


feature -- Access

	main_widget: EV_LIST is
		once
			!!Result.make (Current)
		end
	
feature -- Access

	item1, item2, item3: EV_LIST_ITEM

feature -- Status setting
        
	set_widgets is
		do
			main_widget.set_multiple_selection
			!!item1.make_with_text (main_widget, "item1")
			!!item2.make_with_text (main_widget, "item2")
			!!item3.make_with_text (main_widget, "item3") 
	       	end

	
	set_values is
		do
			item2.set_selected (True)
			set_title ("List demo")
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
