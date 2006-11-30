indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	X
feature
	f do g end
	
	g
		require
			h
		do
		end

	h: BOOLEAN
		require
			(agent: BOOLEAN do print ("I should not be seen") end).item ([])
		do
			Result := True
		end
end
