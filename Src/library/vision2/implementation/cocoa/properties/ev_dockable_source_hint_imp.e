note
	description: "Summary description for {EV_DOCKABLE_SOURCE_HINT_IMP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DOCKABLE_SOURCE_HINT_IMP

inherit
	EV_DOCKABLE_SOURCE_HINT_I

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current' empty.
		do
			assign_interface (an_interface)
		end

	make
		do

		end

feature {EV_ANY}

	is_activated: BOOLEAN = False

	activate (a_x, a_y: INTEGER; a_width, a_height: INTEGER)
		do
		end

	deactivate
		do
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	destroy
		do
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
