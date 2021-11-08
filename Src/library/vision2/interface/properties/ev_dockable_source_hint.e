note
	description: "UI effect to show the source of the current pick and drop."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DOCKABLE_SOURCE_HINT

inherit
	EV_ANY
		redefine
			implementation
		end

create
	default_create

feature -- Status

	is_activated: BOOLEAN
		do
			Result := implementation.is_activated
		end

feature -- Execution		

	activate (a_x, a_y: INTEGER; a_width, a_height: INTEGER; a_pebble_src: EV_PICK_AND_DROPABLE)
		require
			not is_activated
		do
			implementation.activate (a_x, a_y, a_width, a_height, a_pebble_src)
		ensure
			is_activated
		end

	deactivate
		require
			is_activated
		do
			implementation.deactivate
		ensure
			not is_activated
		end

feature {EV_ANY} -- Implementation

	implementation: EV_DOCKABLE_SOURCE_HINT_I

	create_implementation
			-- Create `implementation'.
			-- Must be defined in each descendant to create the
			-- appropriate `implementation' object.
		do
			create {EV_DOCKABLE_SOURCE_HINT_IMP} implementation.make
		end

	create_interface_objects
			-- Create objects to be used by `Current' in `initialize'
			-- Implemented by descendants to create attached objects
			-- in order to adhere to void-safety due to the implementation bridge pattern.
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
