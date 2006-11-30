indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A [G]

feature
	f: TUPLE [t1: G] is
		do
			create Result
		end 

	g is
		local
			v: G
		do
			f.t1 := v
			if v = f.t1 then
			end
		end

end
