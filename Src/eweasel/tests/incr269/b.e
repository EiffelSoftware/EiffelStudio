indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	B

feature
	f
		require
			(agent: BOOLEAN local a, b: BOOLEAN do Result := a and b end).item ([])
		do
		end

end
