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
			l_trans: HASH_TABLE [ANY, INTEGER]
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
		end

end -- class TEST
