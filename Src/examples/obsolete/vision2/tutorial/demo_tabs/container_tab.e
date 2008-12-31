note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature -- Initialization

	make (par: EV_CONTAINER)
			-- Create the tab and initialise objects.
		local
			cmd1, cmd2: EV_ROUTINE_COMMAND
		do
			Precursor {ANY_TAB} (Void)
		
			-- Create the objects and their commands
			create cmd2.make (agent get_client_width)
			create f1.make (Current, 0, 0, "client width", Void, cmd2)

			create cmd2.make (agent get_client_height)
			create f2.make (Current, 1, 0, "client height", Void, cmd2)

			create cmd2.make (agent get_managed)
			create f3.make (Current, 2, 0, "Managed", Void, cmd2)
			set_parent(par)
		end

feature -- Access

	name:STRING
			-- Returns the name of the tab
		do
			Result:="Container"
		end

	current_widget: EV_CONTAINER
			-- Current widget we are working on.

	f1, f2, f3: TEXT_FEATURE_MODIFIER
			-- Some modifiers.

feature -- Execution feature

	get_client_width (arg: EV_ARGUMENT; data: EV_EVENT_DATA)
			-- Get the width of the client
		do
			f1.set_text(current_widget.client_width.out)
		end

	get_client_height (arg: EV_ARGUMENT; data: EV_EVENT_DATA)
			-- Get the height of the client
		do
			f2.set_text(current_widget.client_height.out)
		end

	get_managed (arg: EV_ARGUMENT; data: EV_EVENT_DATA)
			-- Is the client managed?
		do
			if current_widget.managed then
				f3.set_text("Yes")
			else
				f3.set_text("No")
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CONTAINER_TAB
 


