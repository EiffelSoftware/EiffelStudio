indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONTAINER_TAB

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
		
			-- Create the objects and their commands
			create cmd2.make (~get_client_width)
			create f1.make (Current, 0, 0, "client width", Void, cmd2)

			create cmd2.make (~get_client_height)
			create f2.make (Current, 1, 0, "client height", Void, cmd2)

			create cmd2.make (~get_managed)
			create f3.make (Current, 2, 0, "Managed", Void, cmd2)
			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Container"
		end

	current_widget: EV_CONTAINER
			-- Current widget we are working on.

	f1, f2, f3: TEXT_FEATURE_MODIFIER
			-- Some modifiers.

feature -- Execution feature

	get_client_width (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the width of the client
		do
			f1.set_text(current_widget.client_width.out)
		end

	get_client_height (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the height of the client
		do
			f2.set_text(current_widget.client_height.out)
		end

	get_managed (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Is the client managed?
		do
			if current_widget.managed then
				f3.set_text("Yes")
			else
				f3.set_text("No")
			end
		end

end -- class CONTAINER_TAB
 


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

