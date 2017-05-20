note
	description:
		"Action sequence for geometry related events."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "ev_geometry"
	date: "Generated!"
	revision: "Generated!"

class
	EV_GEOMETRY_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER]]

create
	default_create

create {EV_GEOMETRY_ACTION_SEQUENCE}
	make_filled

feature -- Access

	force_extend (action: PROCEDURE)
			-- Extend without type checking.
		obsolete
			"Use `extend' instead and provide the right type of agent. [2017-05-31]"
		do
			extend (agent wrapper (?, ?, ?, ?, action))
		end

	wrapper (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER; action: PROCEDURE)
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		obsolete
			"Call `action' directly instead. [2017-05-31]"
		do
			action.call ([a_x, a_y, a_width, a_height])
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

