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
			cmd1,cmd2: EV_ROUTINE_COMMAND
		once
			{ANY_TAB} Precursor (Void)
				--Create the objects and their commands
			create cmd1.make (~set_horizontal_value)
			create cmd2.make (~get_horizontal_value)
			create f1.make (Current, "Horizontal Value", cmd1, cmd2)
			create cmd1.make (~set_vertical_value)
			create cmd2.make (~get_vertical_value)
			create f2.make (Current, "Vertical Value", cmd1, cmd2)
			create cmd1.make (~set_horizontal_step)
			create cmd2.make (~get_horizontal_step)
			create f3.make (Current, "Horizontal Step", cmd1, cmd2)
			create cmd1.make (~set_vertical_step)
			create cmd2.make (~get_vertical_step)
			create f4.make (Current, "Vertical Step", cmd1, cmd2)
			create cmd1.make (~set_horizontal_leap)
			create cmd2.make (~get_horizontal_leap)
			create f5.make (Current, "Horizontal Leap", cmd1, cmd2)
			create cmd1.make (~set_vertical_leap)
			create cmd2.make (~get_vertical_leap)
			create f6.make (Current, "Vertical Leap", cmd1, cmd2)
			--******* minimum and maximum
			


			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Scrollable"
		end

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
	

feature -- Access

	current_widget: EV_SCROLLABLE_AREA
	f1,f2,f3,f4,f5,f6: FEATURE_MODIFIER

end -- class SCROLLABLE_AREA_TAB
