indexing
	description: "Specific tab for window demonstration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WINDOW_TAB

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
			cmd: EV_ROUTINE_COMMAND
		do
			Precursor {ANY_TAB} (par)
		
			-- Creates the objects and their commands
			create cmd.make (agent get_icon_name)
			create f1.make (Current, 0, 0, "Icon Name", Void, cmd)

			create cmd.make (agent raise_window)
			create f2.make (Current, 1, 0, "Z-order", cmd, Void)
			f2.add_item ("Raise", Void)
			f2.add_item ("Lower", Void)

			create cmd.make (agent minimize_window)
			create f3.make (Current, 2, 0, "Status", cmd, Void)
			f3.add_item ("Minimize", Void)
			f3.add_item ("Maximize", Void)
			f3.add_item ("Restore", Void)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Window"
		end

	current_widget: EV_WINDOW
			-- Current widget we are working on.

	f1: TEXT_FEATURE_MODIFIER
			-- Some modifiers.

	f2, f3: COMBO_FEATURE_MODIFIER
			-- A modifier for the raise and minimized properties.

feature -- Execution feature
	
	get_icon_name (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the icon name of the window
		do
			f1.set_text(current_widget.icon_name)
		end

	raise_window (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the icon name of the window
		do
			inspect f2.combo.selected_item.index
			when 1 then
				current_widget.raise
			when 2 then
				current_widget.lower
			else
			end
		end

	minimize_window (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the icon name of the window
		local
			str: STRING
		do
			inspect f3.combo.selected_item.index
			when 1 then
				current_widget.minimize
			when 2 then
				current_widget.maximize
			else
				current_widget.restore
			end
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


end -- class WINDOW_TAB

