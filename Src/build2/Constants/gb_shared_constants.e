indexing
	description: "Objects that provide once access to the constant handler."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_CONSTANTS

feature -- Access

	constants: GB_CONSTANTS_HANDLER is
			-- Once access to instance of constant handler.
		once
			create Result
		end

invariant
	constants_not_void: constants /= Void

end -- class GB_SHARED_CONSTANTS
