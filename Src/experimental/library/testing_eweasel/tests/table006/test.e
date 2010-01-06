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
		do
			test1
			test2
		end

	test1 is
		local
			l_trans: HASH_TABLE [detachable ANY, INTEGER]
		do
			create l_trans.make (5)
			l_trans.force (Void, 1)
			l_trans.force (Void, 2)
			l_trans.force (Void, 3)
			l_trans.force (Void, 4)
			l_trans.force (Void, 5)
			l_trans.force (Void, 6)
			l_trans.remove (1)
			l_trans.remove (2)
			l_trans.remove (3)
			l_trans.remove (4)
			l_trans.remove (5)
			l_trans.remove (6)
			l_trans.force (Void, 7)
			l_trans.force (Void, 8)
			l_trans.force (Void, 9)
			l_trans.force (Void, 10)
			l_trans.force (Void, 11)
			l_trans.force (Void, 12)

			create l_trans.make (3)
			l_trans.force (Void, 1)
			l_trans.force (Void, 2)
			l_trans.force (Void, 3)
			l_trans.remove (1)
			l_trans.remove (2)
			l_trans.force (Void, 7)
			l_trans.force (Void, 8)
			l_trans.force (Void, 9)
			l_trans.force (Void, 10)
			l_trans.force (Void, 11)
			l_trans.force (Void, 12)

			create l_trans.make (0)
			l_trans.force (Void, 1)
			l_trans.force (Void, 2)
			l_trans.force (Void, 3)
		end

	test2 is
		local
			h: HASH_TABLE [detachable ANY, INTEGER]
		do
			create h.make (10)

			h.put (Void, 336)
			h.put (Void, 337)
			h.remove (336)
			h.remove (337)

			h.put (Void, 339)
			h.remove (339)

			h.put (Void, 327)
			h.put (Void, 329)
			h.remove (327)
			h.remove (329)

			h.put (Void, 331)
			h.remove (331)

			h.put (Void, 333)

			h.put (Void, 323)
			h.put (Void, 324)
			h.put (Void, 325)
			h.put (Void, 326)
			h.put (Void, 338)
			h.put (Void, 328)
			h.put (Void, 330)
			h.put (Void, 332)

			h.remove (323)
			h.remove (324)
			h.remove (325)
			h.remove (326)
			h.remove (338)
			h.remove (328)
			h.remove (330)
			h.remove (332)

			h.put (Void, 334)
			h.put (Void, 335)

			h.remove (333)
			if h.has (333) then
				io.put_string ("Not OK!")
				io.put_new_line
			end
		end

end -- class TEST
