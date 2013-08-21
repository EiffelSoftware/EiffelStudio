indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A [G]

feature
	f: TUPLE [t1: G] is
		local
			x: G
		do
			Result := [x]
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
