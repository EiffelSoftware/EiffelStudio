indexing
	description: "Accessor to EIFNET_DEBUG_VALUE_FORMATTER"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_EIFNET_DEBUG_VALUE_FORMATTER

feature {SHARED_EIFNET_DEBUG_VALUE_FORMATTER} -- Initialization

	Edv_formatter: EIFNET_DEBUG_VALUE_FORMATTER is
		once
			create Result
		end
		
--	Edv_external_formatter: EIFNET_DEBUG_EXTERNAL_FORMATTER is
--		once
--			create Result
--		end

end

