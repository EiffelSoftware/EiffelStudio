note
	description: "Summary description for {RB_TREE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST1 [G, H, K]

feature

	inserted (a_key: H; a_rec: G): K
		local
			l_interval: LIST [K]
		do
			l_interval.do_nothing
		end

end
