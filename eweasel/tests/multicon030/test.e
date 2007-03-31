indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	NEW_CLASS_1
		rename
			common_feature as common_renamed_in_root_class1
		end

	NEW_CLASS_2
		rename
			common_feature as common_renamed_in_root_class2
		end

create
	make

feature -- Access

	make is
			--
		local
			c3: NEW_CLASS_3 [NEW_CLASS_1, TEST]
		do
			create c3
			c3.test_completion
		end

feature -- Measurement

	array_test is
			--
		local
			l_arr1: ARRAYED_LIST [TUPLE [a: ARRAYED_LIST [STRING]]]
		do
			create l_arr1.make (1)
			str := l_arr1 [1].a [2].out
		end

	str: STRING

invariant
	invariant_clause: True -- Your invariant here

end
