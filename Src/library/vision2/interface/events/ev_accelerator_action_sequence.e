indexing
	description: "Action sequence for accelerator events."
	status: "Generated!"
	keywords: "ev_accelerator"
	date: "Generated!"
	revision: "Generated!"

class EV_ACCELERATOR_ACTION_SEQUENCE

inherit EV_ACTION_SEQUENCE [TUPLE []]
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
			action_sequence_make ("ev_accelerator", <<>>)
		end

feature -- Access

	wrapper (action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([])
		end

end
