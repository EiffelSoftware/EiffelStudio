note
	description: "[
				Processes a HTTP request, and depending on header, authenticate a current user or not.
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_AUTH_FILTER

inherit
	WSF_FILTER
		rename
			execute as auth_execute
		end

feature {NONE} -- Initialization

	make (a_api: CMS_API)
			-- Initialize Current handler with `a_api'.
		do
			api := a_api
		end

feature -- API Service

	api: CMS_API

feature -- Basic operations

	auth_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
				-- If user is already authenticated, do not try current authenticating filter
				-- and go to next filter directly.
			if api.user_is_authenticated then
				execute_next (req, res)
			else
				execute (req, res)
			end
		end

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		require
			no_user_authenticated: api.user = Void
		deferred
		end

	set_current_user (u: CMS_USER)
		do
			api.set_user (u)
		end

	set_current_inactive_user (u: CMS_USER)
		do
			api.set_inactive_user (u)
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
