indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIDGET_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget,
			set_current_widget
		end
	EV_BASIC_COLORS

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
			available_colors: LINKED_LIST[EV_COLOR]
			l1: EV_LIST_ITEM
			s1: EV_HORIZONTAL_SEPARATOR
		do
			{ANY_TAB} Precursor (par)
				
			-- Creates the commands for the buttons	
			!!cmd1.make (~set_xcoor)
			!!cmd2.make (~get_xcoor)
			create f1.make(Current, 0, 0, "X", cmd1, cmd2)
			!!cmd1.make (~set_ycoor)
			!!cmd2.make (~get_ycoor)
			create f2.make (Current, 1, 0, "Y", cmd1, cmd2)
			!!cmd1.make (~set_width_val)
			!!cmd2.make (~get_width)
			create f3.make (Current, 2, 0, "Width", cmd1, cmd2)
			!!cmd1.make (~set_height_val)
			!!cmd2.make (~get_height)
			create f4.make (Current, 3, 0, "Height", cmd1, cmd2)
			!!cmd1.make (~set_min_width)
			!!cmd2.make (~get_min_width)
			create f5.make (Current, 4, 0, "Min Width", cmd1, cmd2)
			!!cmd1.make (~set_min_height)
			!!cmd2.make (~get_min_height)
			create f6.make (Current, 5, 0, "Min Height", cmd1, cmd2)
			create cmd2.make (~back_color)
			create c1.make (Current, 6, 0, "Background Color", cmd2, cmd2)
			create cmd2.make (~fore_color)
			create c2.make (Current, 7, 0, "Foreground Color", cmd2, cmd2)
			available_colors:= all_colors
			from
				available_colors.start
			until
				available_colors.off
			loop
				create l1.make_with_text (c1.combo, available_colors.item.name)
				l1.set_data (available_colors.item)
				create l1.make_with_text (c2.combo, available_colors.item.name)
				l1.set_data (available_colors.item)
				available_colors.forth
			end
			create s1.make (Current)
			set_child_position (s1,8,0,9,3)
			create cmd1.make (~hide_show)
			create b1.make_with_text (Current, "Hide")
			b1.add_click_command (cmd1, Void)
			b1.set_vertical_resize (False)
			set_child_position (b1,9,1,10,2)
		end

feature -- element change

	set_current_widget (wid: EV_WIDGET) is
			-- Make `wid' the new widget.
		do
			{ANY_TAB} Precursor (wid)
			if current_widget.managed then
				f1.disable_text
				f2.disable_text
				f3.disable_text
				f4.disable_text
			else
				f1.enable_text
				f2.enable_text
				f3.enable_text
				f4.enable_text
			end
		end	

feature -- Access

	name: STRING is
			-- Returns the name of the tab.
		do
			Result:="Widget"
		end
	
	current_widget: EV_WIDGET
			-- Current widget we are working on. 

	f1, f2, f3, f4, f5, f6, f7, f8: TEXT_FEATURE_MODIFIER
			-- Some text modifiers.
	c1, c2: COMBO_FEATURE_MODIFIER
			-- Combo feture modifiers.
	b1: EV_BUTTON

feature -- Execution feature

	get_xcoor (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		-- Returns the x coor of the demo
		do
			f1.set_text(current_widget.x.out)
		end

	get_ycoor (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the y coor of the demo
		do
			f2.set_text(current_widget.y.out)
		end

	get_width (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the width of the demo
		do
			f3.set_text(current_widget.width.out)
		end

	get_height (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the height of the demo
		do
			f4.set_text(current_widget.height.out)
		end

	get_min_width (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the minimum width of the demo
		do
			f5.set_text(current_widget.minimum_width.out)
		end

	get_min_height (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the minimum height of the demo
		do
			f6.set_text(current_widget.minimum_height.out)
		end

	set_xcoor (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the x position of the demo
		do
			if f1.get_text.is_integer then
				current_widget.set_x(f1.get_text.to_integer)
			end
		end

	set_ycoor (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the y position of the demo
		do
			if f2.get_text.is_integer then
				current_widget.set_y(f2.get_text.to_integer)
			end
		end

	set_width_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the width of the demo
		do
			if f3.get_text.is_integer then
				current_widget.set_width(f3.get_text.to_integer)
			end
		end

	set_height_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the height of the demo
		do
			if f4.get_text.is_integer then
				current_widget.set_height(f4.get_text.to_integer)
			end
		end

	set_min_width (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the minimum width of the demo
		do
			if f5.get_text.is_integer then
				current_widget.set_minimum_width(f5.get_text.to_integer)
			end
		end

	set_min_height (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the minimum height of the demo
		do
			if f6.get_text.is_integer then
				current_widget.set_minimum_height(f6.get_text.to_integer)	
			end
		end

	back_color (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set background color.
		local
			current_color: EV_COLOR
			drawable_test: EV_DRAWING_AREA
		do
			if c1.combo.selected then
				current_color ?= c1.combo.selected_item.data
				current_widget.set_background_color(current_color)
				drawable_test ?= current_widget
					-- Is the current widget a drawing area?
				if drawable_test /= Void then
					drawable_test.clear	
				end
			end
		end

	fore_color (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set foreground color.
		local
			current_color: EV_COLOR
			drawable_test: EV_DRAWING_AREA
		do
			if c2.combo.selected then
				current_color ?= c2.combo.selected_item.data
				current_widget.set_foreground_color(current_color)
				drawable_test ?= current_widget
					-- Is the current widget a drawing area?
				if drawable_test /= Void then
					drawable_test.clear	
				end
			end
		end

	hide_show (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- toggle `current_widget' between hidden and shown.
		do
			if current_widget.shown then
				current_widget.hide
				b1.set_text ("Show")
			else
				current_widget.show
				b1.set_text ("Hide")
			end
		end
end -- class WIDGET_TAB

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

