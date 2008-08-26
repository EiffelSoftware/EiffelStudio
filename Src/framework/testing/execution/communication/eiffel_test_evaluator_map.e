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

	make (a_list: !DS_LINEAR [!EIFFEL_TEST_I])
			-- Initialize `Current'.
			--
			-- `a_list': List of all tests used for map
		local
			l_cursor: DS_LINEAR_CURSOR [!EIFFEL_TEST_I]
			n: NATURAL
		do
			create tests_map.make (a_list.count)
			from
				l_cursor := a_list.new_cursor
				l_cursor.start
				n := 1
			until
				l_cursor.after
			loop
				tests_map.put (n, l_cursor.item)
				n := n + 1
				l_cursor.forth
			end
		end

feature -- Access

	tests: !DS_LINEAR [!EIFFEL_TEST_I]
			-- Tests contained in `Current'
		do
			Result ?= tests_map.keys
		end

feature {NONE} -- Access

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

	remove_test (a_test: !EIFFEL_TEST_I)
			-- Remove test from map.
			--
			-- `a_test': Test to be removed from `tests'
		require
			tests_has_a_test: tests.has (a_test)
		do
			tests_map.remove (a_test)
		ensure
			removed: not tests_map.has (a_test)
		end

end
