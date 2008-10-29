
indexing

	description:

		"Test features of class ERL_LIST"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class ERL_G_TEST_LIST

inherit

	CDD_TEST_CASE

feature -- Tests

	test_access is
		local
			a_list: ERL_LIST [INTEGER]
		do
			create a_list.make
			a_list.force_last (10)
			assert_equal ("correct item for count = 1", 10, a_list.item (1))
			assert_equal ("correct first for count = 1", 10, a_list.first)
			assert_equal ("correct last for count = 1", 10, a_list.last)
			a_list.force_last (20)
			a_list.force_last (30)
			assert_equal ("correct item for count > 1", 20, a_list.item (2))
			assert_equal ("correct first for count > 1", 10, a_list.first)
			assert_equal ("correct last for count > 1", 30, a_list.last)
		end

	test_measurement is
		local
			a_list: ERL_LIST [INTEGER]
		do
			create a_list.make
			assert_equal ("correct capacity with void storage", 0, a_list.capacity)
			a_list.force_last (10)
			assert_equal ("correct capacity with one element", 2, a_list.capacity)
			a_list.force_last (20)
			a_list.force_last (30)
			assert_equal ("correct capacity with several elements", 6, a_list.capacity)
		end

	test_status_report is
		local
			a_list: ERL_LIST [INTEGER]
		do
			create a_list.make
			assert ("new list empty", a_list.is_empty)
			assert ("correct has for empty list", not a_list.has (10))
			a_list.force_last (10)
			assert ("list with one element not empty", not a_list.is_empty)
			assert ("correct has for one element 1", a_list.has (10))
			assert ("correct has for one element 2", not a_list.has (20))
			a_list.force_last (20)
			a_list.force_last (30)
			assert ("correct has for several elements 1", a_list.has (30))
			assert ("correct has for several elements 2", not a_list.has (40))
		end

	test_element_change is
		local
			a_list: ERL_LIST [INTEGER]
		do
			create a_list.make_with_capacity (1)
			a_list.put_last (10)
			assert_equal ("correct put_last on new list", 10, a_list.last)
			a_list.put (11, 1)
			assert_equal ("correct put on list with one element", 11, a_list.last)
			a_list.force_last (20)
			a_list.force_last (30)
			a_list.put_last (40)
			assert_equal ("correct put_last on list with several elements", 40, a_list.last)
			a_list.put (22, 2)
			assert_equal ("correct put on list with several elements", 22, a_list.item (2))

			create a_list.make_with_capacity (0)
			a_list.force_last (10)
			assert_equal ("correct force_last if list resized", 10, a_list.last)
			a_list.force_last (20)
			assert_equal ("correct force_last if list not resized", 20, a_list.last)
		end

	test_removal is
		local
			a_list: ERL_LIST [INTEGER]
		do
			create a_list.make
			a_list.wipe_out
			assert ("correct wipe_out for empty list", a_list.is_empty)
			a_list.force_last (10)
			a_list.remove_last
			assert ("correct remove_last for list with one element", a_list.is_empty)
			a_list.force_last (10)
			a_list.remove (1)
			assert ("correct remove for list with one element", a_list.is_empty)

			a_list.force_last (10)
			a_list.force_last (20)
			a_list.force_last (30)
			a_list.wipe_out
			assert ("correct wipe_out for list with several elements", a_list.is_empty)

			a_list.force_last (10)
			a_list.force_last (20)
			a_list.force_last (30)
			a_list.remove_last
			assert ("correct remove_last for list with several elements", not a_list.has (30))

			a_list.force_last (30)
			a_list.remove (2)
			assert ("correct remove for list with several elements", not a_list.has (20))
		end

	test_resizing is
		local
			a_list: ERL_LIST [INTEGER]
		do
			create a_list.make
			a_list.resize (1)
			assert_equal ("correct resize for void storage", 1, a_list.capacity)

			a_list.resize (4)
			assert_equal ("correct resize for non-void storage", 4, a_list.capacity)

			a_list.resize (3)
			assert_equal ("correct resize when no actual resize", 4, a_list.capacity)
		end

end
