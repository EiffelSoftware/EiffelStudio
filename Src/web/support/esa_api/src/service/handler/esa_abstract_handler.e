note
	description: "Abstrat Eiffel Support API Handler."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_ABSTRACT_HANDLER

inherit
	WSF_HANDLER

	ESA_HANDLER

	SHARED_CONNEG_HELPER

feature -- Change

	set_esa_config (a_esa_config: like esa_config)
		do
			esa_config := a_esa_config
		end

feature -- Access

	esa_config: ESA_CONFIG
		-- Configuration

	api_service: ESA_API_SERVICE
			-- Service
		do
			Result := esa_config.api_service
		end

end
