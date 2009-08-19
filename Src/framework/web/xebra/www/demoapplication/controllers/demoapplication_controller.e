note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	DEMOAPPLICATION_CONTROLLER

inherit

	ANY
		undefine
			default_create
		end

	G_SHARED_DEMOAPPLICATION_GLOBAL_STATE
		undefine
			default_create
		end

	XWA_CONTROLLER


create

	default_create

feature {NONE} -- Initialization	

feature -- Status Repost

	authenticated: BOOLEAN
			-- Tests if session contains authenticated flag.
		do
			Result := False
			if attached session.get ("auth") as item then
				Result := True
			end
		end

	authenticated_admin: BOOLEAN
			-- Tests if session contains authenticated flag and user is admin
		do
			Result := False
			if attached {USER} session.get ("auth") as session_user then
				if session_user.is_admin then
					Result := True
				end
			end
		end

	not_authenticated: BOOLEAN
			-- Helper
		do
			Result := not authenticated
		end

	not_authenticated_admin: BOOLEAN
			-- Helper
		do
			Result := not authenticated_admin
		end

	username: STRING
			-- Gets username of logged in user
		do
			Result := ""
			if attached {USER} session.get ("auth") as user then
				Result := user.name
			end

		ensure
			Result_attached: Result /= Void
		end

end
