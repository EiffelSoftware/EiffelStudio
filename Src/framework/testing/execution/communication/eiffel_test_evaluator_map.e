indexing
	description: "[
		Objects mapping a list of tests to a unique and persistent index.
		
		Note: this class is used to provide a bijective function between the existing tests and the index
		      used in the evaluator to make communication simpler.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_EVALUATOR_MAP

create
	make

feature {NONE} -- Initialization

	make (a_count: INTEGER)
			-- Initialize `Current'.
			--
			-- `a_count': Approximate number of tests that map will contain
		require
			a_count_valid: a_count >= 0
		do
			counter := 1
			create tests_map.make (a_count)
		end

feature -- Access

	tests: !DS_LINEAR [!EIFFEL_TEST_I]
			-- Tests contained in `Current'
		do
			Result ?= tests_map.keys
		end

feature {NONE} -- Access

	counter: NATURAL
			-- Counter for indices

	tests_map: !DS_HASH_TABLE [NATURAL, !EIFFEL_TEST_I]
			-- Internal storage

feature -- Query

	index (a_test: !EIFFEL_TEST_I): NATURAL
			-- Unique index for `a_test'.
		require
			tests_has_a_test: tests.has (a_test)
		do
			Result := tests_map.item (a_test)
		ensure
			definition: Result = tests_map.item (a_test)
		end

feature -- Element change

	add_test (a_test: !EIFFEL_TEST_I)
			-- Add test to map
			--
			-- `a_test': Test to be added to `tests'
		require
			test_not_added: not tests.has (a_test)
		do
			tests_map.put (counter, a_test)
			counter := counter + 1
		ensure
			added: tests.has (a_test)
		end

	remove_test (a_test: !EIFFEL_TEST_I)
			-- Remove test from map.
			--
			-- `a_test': Test to be removed from `tests'
		require
			test_added: tests.has (a_test)
		do
			tests_map.remove (a_test)
		ensure
			removed: not tests_map.has (a_test)
		end

end
