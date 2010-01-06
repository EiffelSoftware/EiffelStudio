class TEST1

inherit
	TEST2
		redefine
			list
		end

feature

	list: LIST [TUPLE [INTEGER, INTEGER]]

end
