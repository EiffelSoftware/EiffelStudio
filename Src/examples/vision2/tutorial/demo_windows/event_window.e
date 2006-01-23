indexing
	description: "The window that allows the user to perform actions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT_WINDOW

	inherit
		EV_WINDOW
	rename
		make as
		window_make
	end
		
		

create
	make

feature -- Initialization

	make(current_widget:EV_ANY;) is
			-- Initialize
		local
			count: INTEGER
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [INTEGER]
			b1: EV_BUTTON
		do
			if destroyed then
				make_top_level
				set_minimum_width(400)
				set_minimum_height(300)
				set_title ("Events")
				set_x_y(200,200)
				create box.make (Current)
				create list.make (box)
				create b1.make_with_text (box, "Clear Event List")
				b1.set_vertical_Resize (False)
				box.set_child_expandable (b1, False)
				create cmd.make (agent clear_events)
				b1.add_click_command (cmd, Void)
				create b2.make_with_text (box, "Enable Motion Tracking")
				b2.set_vertical_Resize (False)
				box.set_child_expandable (b2, False)
				create cmd.make (agent toggle_motion_tracking)
				b2.add_click_command (cmd, Void)
			end
			create cmd.make (agent my_function)
			create arg.make (1)
			add_close_command (cmd, arg)
		end

	display (new_text: STRING) is
			-- Adds a new text to `list' 
		local
			new_item: EV_LIST_ITEM	
		do
			create new_item.make_with_text (list,new_text)
			list.select_item (list.count)
		end

	displayi (new_text: STRING) is
			-- Adds a new indented text to `list'
		local
			new_item: EV_LIST_ITEM
			temp_string: STRING
		do
			temp_string := "        "
			temp_string.append_string (new_text)
			create new_item.make_with_text (list, temp_string)
			list.select_item (list.count)
		end

feature -- Execution features

	my_function (arg: EV_ARGUMENT1 [INTEGER]; data: EV_EVENT_DATA) is
		do
			hide
		end

	toggle_motion_tracking (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Toggle `motion_tracking_on'
		do
			motion_tracking_on := not motion_tracking_on
			if motion_tracking_on then
				b2.set_text ("Disable Motion Tracking")
			else
				b2.set_text ("Enable Motion Tracking")
			end
		end

	clear_events (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Clear `list'
		do
			list.clear_items
		end

feature -- Access

	widget_tab:WIDGET_TAB
	box_tab:BOX_TAB
	list: EV_LIST
	motion_tracking_on: BOOLEAN
	box: EV_VERTICAL_BOX
	b2: EV_BUTTON;


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


end -- class EVENT_WINDOW
