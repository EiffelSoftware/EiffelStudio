indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DYNTABLE_TAB

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
		do
			{ANY_TAB} Precursor (Void)
		
			-- Creates the objects and their commands
			create cmd2.make (~get_row_layout)
			create f1.make (Current, "Uses Row Layout?", cmd1, cmd2)
			create cmd1.make (~set_finite_dimens)
			create cmd2.make (~get_finite_dimens)
			create f2.make (Current, "Finite Dimension", cmd1, cmd2)
			create cmd1.make(~set_row_layout)
			create b1.make_with_text (Current, "Row Layout")
			b1.add_click_command(cmd1, Void)
			b1.set_vertical_resize(False)
			create cmd1.make (~set_column_layout)
			create b2.make_with_text (Current, "Column layout")
			b2.add_click_command(cmd1, Void)
			b2.set_vertical_resize(False)

			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Dynamic Table"
		end

	current_widget: EV_DYNAMIC_TABLE
			-- Current widget we are working on.

	b1, b2:EV_BUTTON
			-- Buttons.

	f1, f2: TEXT_FEATURE_MODIFIER	
			-- Some modifier.

feature -- Execution feature  

	get_row_layout (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Are the children layed out in rows?
		do
			if current_widget.is_row_layout then
				f1.set_text("Yes")
			else
				f1.seT_text("No")
			end	
		end

	set_row_layout (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the layout to rows.
		do
			current_widget.set_row_layout
		end


	set_column_layout (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the layout to columns.
		do
			current_widget.set_column_layout
		end

	set_finite_dimens (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the finite dimension of the table
		do
			if f2.get_text.is_integer and
			f2.get_text.to_integer>0 then
				current_widget.set_finite_dimension(f2.get_text.to_integer)
			end
		end

	get_finite_dimens (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the finite dimension of the table
		do
			f2.set_text(current_widget.finite_dimension.out)
		end

end -- class DYNTABLE_TAB

 

