note
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			create l_list.make_filled (10)

				-- CA024: From-until loop on ITERABLE can be reduced to across loop.
				-- Incorrectly triggered, as this loop starts from the second item.
			from
				l_list.start
				l_list.forth
			until
				l_list.after
			loop
				io.put_integer (l_list.item)
				l_list.forth
			end
		end

end
