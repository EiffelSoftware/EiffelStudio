indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A

feature
	f
		require
			r_a
		do
		ensure
			e_a
		end

	r_a: BOOLEAN
		do
			print ("require_a%N")
		end

	e_a: BOOLEAN
		do
			print ("ensure_a%N")
			Result := True
		end

end
