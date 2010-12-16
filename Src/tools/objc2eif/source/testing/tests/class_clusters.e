note
	description: "Summary description for {CLASS_CLUSTERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_CLUSTERS

inherit
	TESTS_COMMON
		redefine
			run
		end

feature -- Running

	run
			-- Run the tests
		do
			Precursor
			test1
			collect_garbage
		end

feature {NONE} -- Tests

	test1
			-- Test adding a class cluster object to an array and retrieving it
			-- to see if CLASSES_MAPPER works correctly.
		local
			pool: NS_AUTORELEASE_POOL
			array: NS_MUTABLE_ARRAY
		do
			create pool.make
			create array.make
			add_number_to_array (array)
			collect_garbage
			assert (attached {NS_NUMBER} array.object_at_index_ (0))
			check attached {NS_NUMBER} array.object_at_index_ (0) as number then
				assert (number.int_value = 232)
			end
		end

	add_number_to_array (an_array: NS_MUTABLE_ARRAY)
		local
			number: NS_NUMBER
		do
			create number.make_with_int_ (232)
			an_array.add_object_ (number)
		end

end
