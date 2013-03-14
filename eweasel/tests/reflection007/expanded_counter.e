note
	description: "Summary description for {EXPANDED_COUNTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXPANDED_COUNTER

feature

	counter: CELL [INTEGER]
		once
			create Result.put (1)
		end

end
