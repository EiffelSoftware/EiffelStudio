indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	B
inherit
	A [STRING]
		redefine test end

feature
	test (s: STRING): STRING is
		do
		end

end
