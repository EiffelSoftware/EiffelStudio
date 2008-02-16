class TEST2
inherit
	TEST1 [STRING]
		redefine
			new_tuple
		end

feature

	new_tuple: TUPLE [INTEGER, STRING] is
		do

		end


end
