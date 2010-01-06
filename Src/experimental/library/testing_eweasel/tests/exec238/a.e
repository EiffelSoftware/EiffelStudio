indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A

feature
	f is
		do
		ensure
			e1: (agent: BOOLEAN do Result := to_be_renamed end).item ([])
		end

	to_be_renamed: BOOLEAN is
		do
		end

end
