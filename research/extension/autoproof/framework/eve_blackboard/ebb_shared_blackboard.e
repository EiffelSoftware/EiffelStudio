note
	description: "Access to shared instance of the EVE blackboard."
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_SHARED_BLACKBOARD

feature -- Access

	blackboard: EBB_BLACKBOARD
			-- Shared blackboard.
		local
			l_service_consumer: SERVICE_CONSUMER [BLACKBOARD_S]
		do
			create l_service_consumer
			if l_service_consumer.is_service_available and then l_service_consumer.service.is_interface_usable then
				Result ?= l_service_consumer.service
			end
		end

end
