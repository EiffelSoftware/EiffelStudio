indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_ATTRIBUTE

feature -- Access

	is_frozen: INTEGER is 1
	is_static: INTEGER is 2
	is_deferred: INTEGER is 4
	is_infix: INTEGER is 8
	is_prefix: INTEGER is 16
	is_public: INTEGER is 32
	is_artificially_added: INTEGER is 32
			-- Possible attributes of a feature.

end -- class FEATURE_ATTRIBUTE
