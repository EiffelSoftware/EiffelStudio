indexing
	description: "Action sequence for keyboard events."
	status: "Generated!"
	keywords: "ev_key"
	date: "Generated!"
	revision: "Generated!"

class EV_KEY_ACTION_SEQUENCE

inherit EV_ACTION_SEQUENCE [TUPLE [INTEGER]]
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
			action_sequence_make ("ev_key", <<"keycode">>)
		end

feature -- Access

	wrapper (a_keycode: INTEGER; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_keycode])
		end

end
