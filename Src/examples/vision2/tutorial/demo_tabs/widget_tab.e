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

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
		do
			{ANY_TAB} Precursor (par)
				

				-- Create the features of the window	

					

				-- Creates the commands for the buttons	

			!!cmd1.make (~set_xcoor)
			!!cmd2.make (~get_xcoor)
			create f1.make(Current, "X", cmd1, cmd2)
			!!cmd1.make (~set_ycoor)
			!!cmd2.make (~get_ycoor)
			create f2.make (Current, "Y", cmd1, cmd2)
			!!cmd1.make (~set_width_val)
			!!cmd2.make (~get_width)
			create f3.make (Current, "Width", cmd1, cmd2)
			!!cmd1.make (~set_height_val)
			!!cmd2.make (~get_height)
			create f4.make (Current, "Height", cmd1, cmd2)
			!!cmd1.make (~set_min_width)
			!!cmd2.make (~get_min_width)
			create f5.make (Current, "Min Width", cmd1, cmd2)
			!!cmd1.make (~set_min_height)
			!!cmd2.make (~get_min_height)
			create f6.make (Current, "Min Height", cmd1, cmd2)

			set_parent(par) 

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

	f1, f2, f3, f4, f5, f6: TEXT_FEATURE_MODIFIER
			-- Some modifiers.


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

end -- class WIDGET_TAB
