indexing
	description: "Shared object used for class positionner."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CASE_DISPLAY_INFO

feature

	Positioner: CASE_DISPLAY_INFO is
			-- Position of an Eiffel class in a CASE cluster.
		once
			!! Result
		end

end -- class SHARED_CASE_DISPLAY_INFO
