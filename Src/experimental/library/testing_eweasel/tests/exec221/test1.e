indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST1

inherit
	DISPOSABLE

feature

	dispose is
		local
			i: INTEGER
		do
			i := i + 1
			i.io.do_nothing
		end

end
