indexing
	description: "Accessor to EIFNET_DEBUG_VALUE_FACTORY"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_EIFNET_DEBUG_VALUE_FACTORY

feature {SHARED_EIFNET_DEBUG_VALUE_FACTORY} -- Initialization

	Eifnet_debug_value_factory: EIFNET_DEBUG_VALUE_FACTORY is
		once
			create Result.make
		end

end -- class SHARED_EIFNET_DEBUG_VALUE_FACTORY


