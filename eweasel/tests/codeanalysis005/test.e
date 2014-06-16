note
	description: "project2 application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit

	ARGUMENTS

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

	call_back
			-- Calls `make' back, so that we don't get a "Feature never called" warning.
		do
			if not already_called_back then
				already_called_back := True
				make
			end
		end

	already_called_back: BOOLEAN
			-- Was `call_back' already invoked?

end
