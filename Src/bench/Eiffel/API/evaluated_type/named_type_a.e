indexing
	description: "Types that are presented as a class name or generic parameter"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NAMED_TYPE_A
	
inherit
	TYPE_A
		redefine
			is_named_type
		end
		
	HASHABLE

feature -- Property

	is_named_type: BOOLEAN is True
			-- Current is a named type

end -- class NAMED_TYPE_A
