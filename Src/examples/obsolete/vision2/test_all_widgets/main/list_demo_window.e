indexing
	description: "LIST_DEMO_WINDOW, demo window to test the list %
			%widget. Belongs to EiffelVision example test_all_widgets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature -- Access

	main_widget: EV_LIST is
			-- The main widget of the demo
		once
			create Result.make (Current)
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
			create item1.make (main_widget)
--			!! pixmap.make_from_file (the_parent.pixname("menu"))
			item1.set_text("This is item1")
			create item2.make (main_widget)
--			!! pixmap.make_from_file (the_parent.pixname("menu"))
			create item3.make (main_widget)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class LIST_DEMO_WINDOW

