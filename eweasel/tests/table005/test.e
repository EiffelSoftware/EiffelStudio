indexing
	status:	"See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create

	make

feature {NONE} -- Initialization

	make is
		local
			h: HASH_TABLE [INTEGER, INTEGER]
		do
			create h.make (20)
			h.put (1, 1)
			h.put (2, 2)
			h.put (3, 3)
			h.put (4, 4)
			h.put (5, 5)

			from
				h.start
			until
				h.after
			loop
				io.put_integer (h.item_for_iteration)
				io.put_character (' ')
				io.put_integer (h.key_for_iteration)
				io.new_line
				h.forth
			end

			io.new_line
			h.put (0, 0)

			from
				h.start
			until
				h.after
			loop
				io.put_integer (h.item_for_iteration)
				io.put_character (' ')
				io.put_integer (h.key_for_iteration)
				io.new_line
				h.forth
			end
		end

end -- class TEST
