indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLLABLE_AREA_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects.
		local
			cmd1, cmd2: EV_ROUTINE_COMMAND
		do
			{ANY_TAB} Precursor (Void)
				--Create the objects and their commands
			create cmd1.make (~set_horizontal_value)
			create cmd2.make (~get_horizontal_value)
			create f1.make (Current, 0, 0, "Horizontal Value", cmd1, cmd2)

			create cmd1.make (~set_vertical_value)
			create cmd2.make (~get_vertical_value)
			create f2.make (Current, 1, 0, "Vertical Value", cmd1, cmd2)

			create cmd1.make (~set_horizontal_step)
			create cmd2.make (~get_horizontal_step)
			create f3.make (Current, 2, 0, "Horizontal Step", cmd1, cmd2)

			create cmd1.make (~set_vertical_step)
			create cmd2.make (~get_vertical_step)
			create f4.make (Current, 3, 0, "Vertical Step", cmd1, cmd2)

			create cmd1.make (~set_horizontal_leap)
			create cmd2.make (~get_horizontal_leap)
			create f5.make (Current, 4, 0, "Horizontal Leap", cmd1, cmd2)

			create cmd1.make (~set_vertical_leap)
			create cmd2.make (~get_vertical_leap)
			create f6.make (Current, 5, 0, "Vertical Leap", cmd1, cmd2)

			--******* minimum and maximum
			
			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Scrollable"
		end

	current_widget: EV_SCROLLABLE_AREA
			-- Current widget we are working on.

	f1, f2, f3, f4, f5, f6: TEXT_FEATURE_MODIFIER
			-- Some modifiers.

feature -- Execution feature

	set_horizontal_value(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the horizontal value of the scroll bar (%).
		do
			if f1.get_text.is_integer 
			and f1.get_text.to_integer>=0
			and f1.get_text.to_integer<=100 then
				current_widget.set_horizontal_value(f1.get_text.to_integer)
			end
		end

	get_horizontal_value(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the horizontal value of the scroll bar.
		do
			f1.set_text(current_widget.horizontal_value.out)
		end

	set_vertical_value(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the vertical value of the scroll bar (%).
		do
			if f2.get_text.is_integer 
			and f2.get_text.to_integer>=0
			and f2.get_text.to_integer<=100 then
				current_widget.set_vertical_value(f2.get_text.to_integer)
			end
		end

	get_vertical_value(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the vertical value of the scroll bar.
		do
			f2.set_text(current_widget.vertical_value.out)
		end

	set_horizontal_step(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the step of the horizontal scroll bar.
		do
			if f3.get_text.is_integer then
				current_widget.set_horizontal_step(f3.get_text.to_integer)
			end
		end

	get_horizontal_step(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is 
			-- Get the step of the horizontal scroll bar.
		do
			f3.set_text(current_widget.horizontal_step.out)
		end

	set_vertical_step(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the step of the vertical scroll bar.
		do
			if f4.get_text.is_integer then
				current_widget.set_vertical_step(f4.get_text.to_integer)
			end
		end

	get_vertical_step(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is 
			-- Get the step of the vertical scroll bar.
		do
			f4.set_text(current_widget.vertical_step.out)
		end
	
	set_horizontal_leap(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the leap of the horizontal scroll bar.
		do
			if f5.get_text.is_integer then
				current_widget.set_horizontal_leap(f5.get_text.to_integer)
			end
		end

	get_horizontal_leap(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is 
			-- Get the leap of the horizontal scroll bar.
		do
			f5.set_text(current_widget.horizontal_leap.out)
		end

	set_vertical_leap(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the leap of the vertical scroll bar.
		do
			if f6.get_text.is_integer then
				current_widget.set_vertical_leap(f6.get_text.to_integer)
			end
		end

	get_vertical_leap(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is 
			-- Get the leap of the vertical scroll bar.
		do
			f6.set_text(current_widget.vertical_leap.out)
		end
	
end -- class SCROLLABLE_AREA_TAB

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

