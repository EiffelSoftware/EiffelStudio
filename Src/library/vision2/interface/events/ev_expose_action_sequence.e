indexing
	description: "Action sequence for expose events."
	status: "Generated!"
	keywords: "ev_expose"
	date: "Generated!"
	revision: "Generated!"

class EV_EXPOSE_ACTION_SEQUENCE

inherit EV_ACTION_SEQUENCE [TUPLE [EV_CLIP]]
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
			action_sequence_make ("ev_expose", <<"clip_region">>)
		end

feature -- Access

	wrapper (a_clip_region: EV_CLIP; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([a_clip_region])
		end

end
