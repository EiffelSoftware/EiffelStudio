indexing
	description: "Action sequence for mouse movement events."
	status: "Generated!"
	keywords: "ev_pointer_motion"
	date: "Generated!"
	revision: "Generated!"

class EV_POINTER_MOTION_ACTION_SEQUENCE

inherit EV_ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, REAL, REAL, REAL]]
		rename
			make as action_sequence_make
		redefine
			default_create
		end

creation
	default_create

feature {NONE} -- Initialization
	
	default_create is
			-- Create a ready to use action sequence.
		do
			action_sequence_make ("ev_pointer_motion", <<"x", "y", "x_tilt", "y_tilt", "pressure">>)
		end

feature -- Access

	wrapper (a_x: INTEGER; a_y: INTEGER; a_x_tilt: REAL; a_y_tilt: REAL; a_pressure: REAL; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_x, a_y, a_x_tilt, a_y_tilt, a_pressure])
		end

end
