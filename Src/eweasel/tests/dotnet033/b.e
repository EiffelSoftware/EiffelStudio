indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	B

inherit
	A
		redefine f end

feature
	f
		require else
			r_b
		do
		ensure then
			e_b
		end

	r_b: BOOLEAN
		do
			print ("require_b%N")
			Result := True
		end

	e_b: BOOLEAN
		do
			print ("ensure_b%N")
			Result := True
		end

end
