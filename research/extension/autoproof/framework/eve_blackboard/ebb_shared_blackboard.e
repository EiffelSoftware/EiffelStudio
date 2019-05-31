note
	description: "Access to shared instance of the EVE blackboard."
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_SHARED_BLACKBOARD

feature -- Access

	blackboard: EBB_BLACKBOARD
			-- Shared blackboard.
		do
			if
				attached {EBB_BLACKBOARD} (create {SERVICE_CONSUMER [BLACKBOARD_S]}).service as s and then
				s.is_interface_usable
			then
				Result := s
			end
		end

end
