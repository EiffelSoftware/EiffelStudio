indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST2
inherit
	TEST1
		redefine
			g
		end

feature

	g: INTEGER is
			--
		do
			print ("")
		end

end
