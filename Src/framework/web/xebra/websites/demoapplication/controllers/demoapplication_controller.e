note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	DEMOAPPLICATION_CONTROLLER

inherit
	XWA_CONTROLLER
		redefine
			make
		end
	G_SHARED_DEMOAPPLICATION_GLOBAL_STATE

create
	make

feature {NONE} -- Initialization	

	make
			--
		do
			Precursor
		end


feature -- Access

feature -- Basic Operations



	authenticated: BOOLEAN
			-- Tests if session contains authenticated flag.
		do
			Result := False

			if attached current_session as session then
				if attached session.get ("auth") as item then
					Result := True
				end
			end
		end

	authenticated_admin: BOOLEAN
			-- Tests if session contains authenticated flag and user is admin
		do
			Result := False

			if attached current_session as session then
				if attached {USER} session.get ("auth") as session_user then
					if session_user.is_admin then
						Result := True
					end
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





--	detail_url: STRING
--			-- Generates a url for viewing details of a reservation
--		do
--			Result := "details.xeb?id=" + reservations.item_for_iteration.id.out
--		end



	username: STRING
			-- Gets username of logged in user
		do
			Result := ""

			if attached current_session as session then
				if attached {USER} session.get ("auth") as user then
					Result := user.name
				end
			end
		ensure
			Result_attached: Result /= Void
		end

end
