indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	ICOR_DEBUG_ENUM_WITH_NEXT_AND_FRAME [G -> ICOR_OBJECT_WITH_FRAME create make_by_pointer end]

inherit
	ICOR_DEBUG_ENUM_WITH_NEXT [G]
		redefine
			icor_object_made_by_pointer
		end

	ICOR_OBJECT_WITH_FRAME
		undefine
			init_icor
		end	

feature {NONE} -- Implementation

	icor_object_made_by_pointer (a_p: POINTER): G is
			-- 
		do
			create Result.make_by_pointer (a_p)
			Result.set_associated_frame (associated_frame)
		end
		
end

