indexing
	description: "Objects that provide access to a GB_DEFERRED_BUILDER"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_DEFERRED_BUILDER

feature {NONE} -- Implementation

	deferred_builder: GB_DEFERRED_BUILDER is
			-- `Result' is the GB_DEFERRED_BUILDER used by
			-- the system. There should only be one.
			-- Any class that needs access, simply inherits from
			-- this class.
		once
			create Result.initialize
		end

end -- class GB_ACCESSIBLE_DEFERRED_BUILDER
