indexing
	description: "The window that allows the user to perform actions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		
		

create
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
			create cmd.make (agent my_function)
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
	box_tab:BOX_TAB;

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


end -- class ACTION_WINDOW

