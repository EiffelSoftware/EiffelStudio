indexing
	description: "Utilities for serializing/deserializing objects"
	date: "$Date$"
	revision: "$Revision$"

class
	SED_UTILITIES

feature {NONE} -- Implementation

	is_special_flag: NATURAL_8 is 0x01
	is_tuple_flag: NATURAL_8 is 0x02
			-- Various flags for storing objects

end
