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
		redefine
			main_widget,
			set_widgets,
			set_values
		end

creation
	make

feature -- Access

	main_widget: EV_LIST is
			-- The main widget of the demo
		once
			!! Result.make (Current)
		end
	
feature -- Access

	item1, item2, item3: EV_LIST_ITEM
		-- List items to put in the list

feature -- Status setting
        
	set_widgets is
			-- Set the widgets in the demo windows.
		local
			pixmap: EV_PIXMAP
			arg: EV_ARGUMENT1[LIST_DEMO_WINDOW]
		do
			!! item1.make (main_widget)
--			!! pixmap.make_from_file (the_parent.pixname("menu"))
			item1.set_text("This is item1")
			!!item2.make (main_widget)
--			!! pixmap.make_from_file (the_parent.pixname("menu"))
			!!item3.make (main_widget)
--			!! pixmap.make_from_file (the_parent.pixname("menu"))
			item3.set_text ("item3")
       	end
	
	set_values is
			-- Set the values on the widgets of the window.
		local
			item: EV_LIST_ITEM
		do
			item2.set_selected (True)
			set_title ("List demo")
			item := main_widget.selected_item
		end

end -- class LIST_DEMO_WINDOW

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

