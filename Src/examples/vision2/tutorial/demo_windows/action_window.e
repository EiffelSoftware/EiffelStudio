indexing
	description: "The window that allows the user to perform actions"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ACTION_WINDOW

	inherit
		EV_WINDOW
	rename
		make as
		window_make
	end
		
		

creation
	make

feature -- Initialization

	make(current_widget:EV_ANY; tabs:LINKED_LIST[ANY_TAB]) is
			-- Initialize
		local
			count: INTEGER
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [INTEGER]
			tab_title: STRING
		do
			if destroyed then
				make_top_level
				set_minimum_width(400)
				set_minimum_height(400)
				set_title ("Actions")
				set_x_y(200,200)
				create n1.make(Current)
			end
			from
				tabs.start
			until
				tabs.off
			loop
				tabs.item.set_parent(n1)
				tabs.item.set_current_widget (current_widget)
				tab_title:=tabs.item.name
				n1.append_page(tabs.item,tab_title)
				
				tabs.forth
			end
			create cmd.make (~my_function)
			create arg.make (1)
			add_close_command (cmd, arg)
		end



feature -- Execution features

	my_function (arg: EV_ARGUMENT1 [INTEGER]; data: EV_EVENT_DATA) is
		do
			hide
		end


feature -- Access

	n1: EV_NOTEBOOK
	widget_tab:WIDGET_TAB
	box_tab:BOX_TAB

end -- class ACTION_WINDOW

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

