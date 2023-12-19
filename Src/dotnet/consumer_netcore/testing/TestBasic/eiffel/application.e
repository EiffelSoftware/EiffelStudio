note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			abc: ABC
		do
			print (once "TestBasic%N")
			create abc.make
			test_anchors
		end

feature -- Access

	test_anchors
		local
			obj: ANY
		do
			obj := create {ARRAYED_LIST [like list_of_strings.item]}.make (0)
		end

	list_of_strings: detachable LIST [STRING]

feature -- Change

feature {NONE} -- Implementation

invariant
--	invariant_clause: True

end
