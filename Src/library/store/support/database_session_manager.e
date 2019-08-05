note
	description: "Manager to handle database sessions"
	date: "$Date: 2013-05-21 01:15:17 +0200 (Tue, 21 May 2013) $"
	revision: "$Revision: 92557 $"

class
	DATABASE_SESSION_MANAGER

feature -- Access

	current_session: DATABASE_SESSION
			-- Current session
		do
			if attached internal_current_session as l_session then
				Result := l_session
			else
				Result := new_session
				internal_current_session := Result
			end
		end

feature -- Element Change

	set_current_session (a_session: like current_session)
			-- Set `current_session' with `a_session'
		do
			internal_current_session := a_session
		ensure
			session_set: current_session = a_session
		end

feature -- Factory

	new_session: DATABASE_SESSION
			-- Create a new session
		do
			create Result.make
		end

feature {NONE} -- Implementation

	internal_current_session: detachable like current_session
			-- Current session

end
