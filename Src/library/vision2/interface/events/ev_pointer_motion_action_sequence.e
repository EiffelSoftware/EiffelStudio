indexing
	description:
		"Action sequence for mouse movement events."
	status: "Generated!"
	keywords: "ev_pointer_motion"
	date: "Generated!"
	revision: "Generated!"

class
	EV_POINTER_MOTION_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]
	-- EV_ACTION_SEQUENCE [TUPLE [x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER]]
	-- (ETL3 TUPLE with named parameters)
	
creation
	default_create

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (~wrapper (?, ?, ?, ?, ?, ?, ?, action))
		end

	wrapper (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
		end
end
