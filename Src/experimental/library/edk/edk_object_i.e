note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDK_OBJECT_I

inherit
	DISPOSABLE

feature {NONE} -- Implementation

	property_flags: NATURAL_8
			-- Used for storing boolean flags to save on memory space.

end
