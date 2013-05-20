note
	description: "Summary description for {WSF_SESSION_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_SESSION_FACTORY [G -> WSF_SESSION]

feature -- Access

	new_session (req: WSF_REQUEST; a_reuse: BOOLEAN; m: WSF_SESSION_MANAGER): G
		deferred
		end

end
