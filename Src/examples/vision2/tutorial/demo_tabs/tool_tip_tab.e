indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_TIP_TAB
inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end
	EV_BASIC_COLORS

creation
	make

feature -- Initialization

	make(par: EV_CONTAINER) is
		-- Create the tab and initalise the objects.
			local
				cmd1, cmd2: EV_ROUTINE_COMMAND			
				available_colors: LINKED_LIST[EV_COLOR]
				-- Basic colors available for 'Current_widget'.
				--i1: EV_LIST_ITEM
				l1: EV_LIST_ITEM	
			do
				{ANY_TAB} Precursor (Void)
					-- Creates the objects and their commands.
				create cmd1.make (~set_delay)
				create cmd2.make (~delay)
				create f1.make (Current, 0, 0, "Delay", cmd1, cmd2)
				create cmd2.make (~set_tforeground_color)
				create f2.make (Current, 1, 0, "Foreground Color", cmd2, cmd2)
				create cmd2.make (~set_tbackground_color)
				create f3.make (Current, 2, 0, "Background Color", cmd2, cmd2)
				available_colors:= all_colors
				from
					available_colors.start
				until
					available_colors.off
				loop
					create l1.make_with_text (f2.combo, available_colors.item.name)
					l1.set_data (available_colors.item)
					create l1.make_with_text (f3.combo, available_colors.item.name)
					l1.set_data (available_colors.item)
					available_colors.forth
				end
				create s1.make (Current)
				set_child_position (s1, 3, 0, 4, 3)
				create b1.make_with_text (Current, "Enable")
				b1.set_vertical_Resize (False)
				set_child_position (b1, 4, 0, 5, 1)
				create cmd1.make (~enable)
				b1.add_click_command (cmd1, Void)
				create b2.make_with_text (Current, "Disable")
				b2.set_vertical_Resize (False)
				set_child_position (b2, 4, 1, 5, 2)
				create cmd1.make (~disable)
				b2.add_click_command (cmd1, Void)
				b1.set_insensitive (True)

				set_parent (par)
			end

feature -- Access

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="Tool Tip"
		ensure then
			result_exists: Result /= Void
		end
	
	f1: TEXT_FEATURE_MODIFIER
		-- Feature modifiers for the demo.
	f2,f3: COMBO_FEATURE_MODIFIER
		-- Combo Feature modifiers for the demo
	
	s1: EV_HORIZONTAL_SEPARATOR
		-- A horizontal seperator.

	b1, b2: EV_BUTTON

	current_widget: EV_TOOLTIP
		-- The current demo.

feature -- Execution Features

	set_colors is
			-- Set initial colors and select from `f3.combo'.
		local
			current_color: EV_COLOR
		do
			f2.combo.select_item (6)
			current_color ?= f2.combo.selected_item.data
			current_widget.set_foreground_color(current_color)
			f3.combo.select_item (11)
			current_color ?= f3.combo.selected_item.data
			current_widget.set_background_color(current_color)
		end

	set_delay (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set delay of `current widget'.
		do
			if f1.get_text.is_integer and f1.get_text.to_integer >= 0 then
				current_widget.set_delay (f1.get_text.to_integer)
			end
		end
	
	delay (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- delay of `current widget'.
		do
			f1.set_text (current_widget.delay.out)
		end

	set_tforeground_color (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set foreground color of `current_widget'.
		local
			current_color: EV_COLOR
		do
				if f2.combo.selected then
					current_color ?= f2.combo.selected_item.data
					current_widget.set_foreground_color(current_color)
			end
		end

	set_tbackground_color (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set background color of `current_widget'.
		local
			current_color: EV_COLOR
		do
				if f3.combo.selected then
					current_color ?= f3.combo.selected_item.data
					current_widget.set_background_color(current_color)
			end
		end

	enable (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Enable `current_widget'.
		do
			current_widget.enable
			b1.set_insensitive (True)
			b2.set_insensitive (False)
		end

	disable (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Disable `current_widget'
		do
			current_widget.disable
			b1.set_insensitive (False)
			b2.set_insensitive (True)
		end




end -- class TOOL_TIP_TAB

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

