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
		end

	f: ANY
		local
$COMMENT			t1: TEST1
		do
$COMMENT			print (t1 ["S"])
			t := "s"
		end

	t: ANY

end -- class TEST
