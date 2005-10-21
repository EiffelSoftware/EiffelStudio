indexing
	description: "Data corresponding to an Eiffel Project's Window management session."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SESSION

inherit
	EB_SHARED_PREFERENCES
		redefine
			default_create
		end

feature {NONE} -- Creation

	default_create is
			-- Create and initialize session data.
		do
			create window_session_data.make (5)
		end

feature -- Access
		
	window_session_data: ARRAYED_LIST [EB_DEVELOPMENT_WINDOW_SESSION_DATA]
		-- Meta data about each development window used for restoration between project sessions.

end -- ES_SESSION
