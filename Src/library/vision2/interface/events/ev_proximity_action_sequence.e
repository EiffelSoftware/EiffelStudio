indexing
	description: "Action sequence for proximity in/out events."
	status: "Generated!"
	keywords: "ev_proximity"
	date: "Generated!"
	revision: "Generated!"

class EV_PROXIMITY_ACTION_SEQUENCE

inherit EV_ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER]]
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
			action_sequence_make ("ev_proximity", <<"x", "y">>)
		end

feature -- Access

	wrapper (a_x: INTEGER; a_y: INTEGER; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_x, a_y])
		end

end
