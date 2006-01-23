indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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


create
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
			but: EV_BUTTON
			item: EV_LIST_ITEM
		do
			Precursor {ANY_TAB} (Void)

			-- Creates the objects and their commands
			create cmd1.make (agent set_homogeneous_value)
			create cmd2.make (agent get_homogeneous_value)
			create f1.make (Current, 0, 0, "Homogeneous", cmd1, cmd2)
			create iTrue.make_with_text (f1.combo, "True")
			create iFalse.make_with_text (f1.combo, "False")

			create cmd1.make (agent set_border_width_val)
			create cmd2.make (agent get_border_width_val)
			create f2.make (Current, 1, 0, "Border Width", cmd1, cmd2)
			
			create cmd1.make (agent set_spacing_val)
			create cmd2.make (agent get_spacing_val)
			create f3.make (Current, 2, 0, "Spacing", cmd1, cmd2)

			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Box"
		end

	current_widget: EV_BOX
			-- Current feature we are working on.

	f1: COMBO_FEATURE_MODIFIER
			-- Combo modifier for homogeneous.

	f2, f3: TEXT_FEATURE_MODIFIER
			-- Some modifiers.

	iTrue, iFalse: EV_LIST_ITEM
			-- The choice for homogeneous

feature -- Execution feature  

	set_homogeneous_value (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Make the box homogeneous.
		do
			if f1.combo.selected then
				if f1.combo.selected_item = iTrue then
					current_widget.set_homogeneous (True)
				else
					current_widget.set_homogeneous (False)
				end
			end
		end

	get_homogeneous_value (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Return the homogeneous value of the box.
		do
			if current_widget.is_homogeneous then
				iTrue.set_selected (True)
			else
				iFalse.set_selected (True)
			end
		end

	set_border_width_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the border width of the demo
		do
			if f2.get_text.is_integer and f2.get_text.to_integer >= 0  then
				current_widget.set_border_width (f2.get_text.to_integer)
			end
		end

	set_spacing_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the spacing of the demo
		do
			if f3.get_text.is_integer and f3.get_text.to_integer >= 0 then
				current_widget.set_spacing (f3.get_text.to_integer)
			end
		end

	get_border_width_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the border width of the demo
		do
			f2.set_text (current_widget.border_width.out)
		end

	get_spacing_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the spacing of the demo
		do
			f3.set_text (current_widget.spacing.out)
		end	

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


end -- class BOX_TAB

