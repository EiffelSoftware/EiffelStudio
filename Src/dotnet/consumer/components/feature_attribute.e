indexing
	description: "Feature attributes flags"
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_ATTRIBUTE

feature -- Access

	Is_frozen: INTEGER is 1
	Is_static: INTEGER is 2
	Is_deferred: INTEGER is 4
	Is_infix: INTEGER is 8
	Is_prefix: INTEGER is 16
	Is_public: INTEGER is 32
	Is_artificially_added: INTEGER is 64
	Is_property_or_event: INTEGER is 128
			-- Possible attributes of a feature.

end -- class FEATURE_ATTRIBUTE
