indexing
	description: "Value corresponding to a resource."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	VALUE_RESOURCE

creation
	make

feature -- Creation

	make(s: STRING) is
		require
			not_void: s /= Void and then not s.empty
		do
		end 

feature -- Access

	value: ANY

invariant
	VALUE_RESOURCE_not_void: value /= Void
end -- class VALUE_RESOURCE
