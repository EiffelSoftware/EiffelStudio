indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOX_TAB

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
			-- Create the tab and initialise objects
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
		once
			{ANY_TAB} Precursor (Void)
		
				-- Creates the objects and their commands
			create cmd1.make (~set_border_width_val)
			create cmd2.make (~get_border_width_val)
			create f1.make (Current, "Border Width", cmd1, cmd2)
			
			create cmd1.make (~set_spacing_val)
			create cmd2.make (~get_spacing_val)
			create f2.make (Current, "Spacing", cmd1, cmd2)

			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Box"
		end


feature -- Execution feature  

	set_border_width_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the border width of the demo
		do
			if f1.get_text.is_integer and f1.get_text.to_integer >= 0  then
				current_widget.set_border_width(f1.get_text.to_integer)
			end
		end

	set_spacing_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the spacing of the demo
		do
			if f2.get_text.is_integer and f2.get_text.to_integer >= 0 then
				current_widget.set_spacing(f2.get_text.to_integer)
			end
		end

	get_border_width_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the border width of the demo
		do
			f1.set_text(current_widget.border_width.out)
		end

	get_spacing_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the spacing of the demo
		do
			f2.set_text(current_widget.spacing.out)
		end	

feature -- Access

	current_widget: EV_BOX
	f1,f2:FEATURE_MODIFIER	
end -- class BOX_TAB

