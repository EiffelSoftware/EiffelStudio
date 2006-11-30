indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	B
feature
	b (n: INTEGER)
		require
			(agent: BOOLEAN 
				do
					Result := True
				end).item ([])
			n > 10
		do

		end

	call_a
		do
			(create {DA}).a (0)
		end

	call_b
		do
			(create {DB}).b (0)
		end

end
