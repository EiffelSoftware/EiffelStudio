note
	description:
		"Action sequence for mouse button up/down events."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "ev_pointer_button"
	date: "Generated!"
	revision: "Generated!"

class
	EV_POINTER_BUTTON_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER]]

create
	default_create

create {EV_POINTER_BUTTON_ACTION_SEQUENCE}
	make_filled

feature -- Access

	force_extend (action: PROCEDURE)
			-- Extend without type checking.
		obsolete
			"Use `extend' instead and provide the right type of agent. [2017-05-31]"
		do
			extend (agent wrapper (?, ?, ?, ?, ?, ?, ?, ?, action))
		end

	wrapper (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER; action: PROCEDURE)
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		obsolete
			"Call `action' directly instead. [2017-05-31]"
		do
			action.call ([a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
		end

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end

