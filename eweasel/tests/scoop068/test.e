note
	description: "Test for a crash during garbage collection when dealing with ESTRING."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	MEMORY

create
	make, default_create

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			i, count: INTEGER
			l_test: separate TEST
		do
			from
				count := 1000
				i := 1
			until
				i > count
			loop
				create l_test
				test_do_something (l_test)
				full_collect
				i := i + 1
			end
		end

	make_list: separate ARRAYED_LIST [ESTRING_8]
			-- Create a new list.
		local
			count, i: INTEGER
			str: ESTRING_8
		do
			from
				count := 10
				create Result.make (count)
				i := 1
			until
				i > count
			loop
				create str.make_from_string_8 ("list_item_" + i.out)
				list_extend (Result, str)
				i := i + 1
			end
		end

	list_extend (list: separate ARRAYED_LIST [ESTRING_8]; str: ESTRING_8)
		do
			list.extend (str)
		end

	test_do_something (test: separate TEST)
		do
			test.do_something (make_list)
		end

feature

	do_something (list: separate ARRAYED_LIST [ESTRING_8])
		local
			i, count: INTEGER
		do
			from
				i := 1
				count := list.count
			until
				i > count
			loop
					-- The test may also fail when this statement is active.
					-- It looks like the problem has something to do with a nested expanded.
				full_collect
				list [i].out.do_nothing
				i := i + 1
			end
		end

end
