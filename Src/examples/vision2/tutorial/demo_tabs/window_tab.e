indexing
	description: "Specific tab for window demonstration."
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

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		local
			cmd: EV_ROUTINE_COMMAND
		do
			{ANY_TAB} Precursor (par)
		
			-- Creates the objects and their commands
			create cmd.make (~get_icon_name)
			create f1.make (Current, 0, 0, "Icon Name", Void, cmd)

			create cmd.make (~raise_window)
			create f2.make (Current, 1, 0, "Z-order", cmd, Void)
			f2.add_item ("Raise", Void)
			f2.add_item ("Lower", Void)

			create cmd.make (~minimize_window)
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

end -- class WINDOW_TAB

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

