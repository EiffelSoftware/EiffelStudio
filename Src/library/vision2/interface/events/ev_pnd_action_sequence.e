indexing
	description: "Action sequence for pick and drop events."
	status: "Generated!"
	keywords: "ev_pnd"
	date: "Generated!"
	revision: "Generated!"

class EV_PND_ACTION_SEQUENCE

inherit EV_ACTION_SEQUENCE [TUPLE [ANY, EV_PND_TYPE]]
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
			action_sequence_make ("ev_pnd", <<"data", "data_type">>)
		end

feature -- Access

	wrapper (a_data: ANY; a_data_type: EV_PND_TYPE; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_data, a_data_type])
		end

end
