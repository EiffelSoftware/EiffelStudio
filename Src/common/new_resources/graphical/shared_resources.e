indexing
	description: "EiffelBench resources"
	author: "bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_RESOURCES


feature -- Access

	resources: RESOURCES is
		once
			create Result.initialize
		end

end -- class SHARED_RESOURCES
