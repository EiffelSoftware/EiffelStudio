indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_DEBUG_VALUE_KEEPER


feature {EB_OBJECT_TOOL, EB_PRETTY_PRINT_DIALOG} -- Initialization

	Debug_value_keeper: DEBUG_VALUE_KEEPER is
		once
			create Result.make
		end

end -- class SHARED_DEBUG_VALUE_KEEPER
