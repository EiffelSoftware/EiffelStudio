note
	description: "Implementation for {EV_DOCKABLE_SOURCE_HINT}, to show the source of the Pick and drop."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOCKABLE_SOURCE_HINT_I

inherit
	EV_ANY_I
		redefine
			interface
		end

	EV_POSITIONABLE_I
		redefine
			interface
		end

feature {EV_ANY}

	activate (a_x, a_y: INTEGER; a_width, a_height: INTEGER)
		deferred
		end

	deactivate
		deferred
		end

	is_activated: BOOLEAN
		deferred
		end

	interface: detachable EV_DOCKABLE_SOURCE_HINT note option: stable attribute end

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
