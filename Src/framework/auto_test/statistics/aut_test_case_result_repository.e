indexing
	description:

		"Test case result repository"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_TEST_CASE_RESULT_REPOSITORY

create

	make

feature {NONE} -- Initialization

	make is
			-- Create new repository.
		do
			create class_equality_tester.make
			create result_table.make_default
			result_table.set_key_equality_tester (class_equality_tester)
			create witnesses.make_default
		end

feature -- Access

	classes: DS_LINEAR [CLASS_C] is
			-- List of classes for which there are test results
		local
			list: DS_ARRAYED_LIST [CLASS_C]
			cs: DS_HASH_TABLE_CURSOR [DS_LIST [AUT_TEST_CASE_RESULT], CLASS_C]
		do
			from
				create list.make (result_table.count)
				list.set_equality_tester (class_equality_tester)
				Result := list
				cs := result_table.new_cursor
				cs.start
			until
				cs.off
			loop
				list.force_last (cs.key)
				cs.forth
			end
		ensure
			classes_not_void: Result /= Void
			classes_doesnt_have_void: not Result.has (Void)
		end

	results_by_feature_and_class (a_feature: FEATURE_I; a_class: CLASS_C): AUT_TEST_CASE_RESULT_SET is
			-- List of test case results of `a_feature' of class `a_class'
		require
			a_feature_not_void: a_feature /= Void
			a_class_not_void: a_class /= Void
		local
			list: DS_ARRAYED_LIST [AUT_TEST_CASE_RESULT]
			cs: DS_LINEAR_CURSOR [AUT_TEST_CASE_RESULT]
		do
			result_table.search (a_class)
			if not result_table.found then
				create list.make (0)
			else
				create list.make (result_table.found_item.count)
				from
					cs := result_table.found_item.new_cursor
					cs.start
				until
					cs.off
				loop
					if cs.item.feature_ = a_feature then
						list.force_last (cs.item)
					end
					cs.forth
				end
			end
			create Result.make (list)
		ensure
			results_not_void: Result /= Void
		end

	results_by_class (a_class: CLASS_C): AUT_TEST_CASE_RESULT_SET is
			-- List of test case results of any feature of class `a_class'
		require
			a_class_not_void: a_class /= Void
		do
			result_table.search (a_class)
			if not result_table.found then
				create Result.make_empty
			else
				create Result.make (result_table.found_item)
			end
		ensure
			results_not_void: Result /= Void
		end

	results: AUT_TEST_CASE_RESULT_SET is
			-- All results
		local
			cs: DS_HASH_TABLE_CURSOR [DS_LIST [AUT_TEST_CASE_RESULT], CLASS_C]
			list: DS_ARRAYED_LIST [AUT_TEST_CASE_RESULT]
		do
			from
				create list.make (result_table.count * 1000)
				cs := result_table.new_cursor
				cs.start
			until
				cs.off
			loop
				list.append_last (cs.item)
				cs.forth
			end
			create Result.make (list)
		ensure
			results_not_void: Result /= Void
		end

	witnesses: DS_ARRAYED_LIST [AUT_WITNESS]
		-- All witnesses used by results

feature -- Element change

	add_witness (a_witness: AUT_WITNESS) is
			-- Add `a_witness' to `witnesses'.
		require
			a_witness_not_void: a_witness /= Void
		local
			cs: DS_LINEAR_CURSOR [AUT_TEST_CASE_RESULT]
		do
			witnesses.force_last (a_witness)
			check
				classifications_ok: a_witness.classifications.count <= 1
			end
			from
				cs := a_witness.classifications.new_cursor
				cs.start
			until
				cs.off
			loop
				add_result (cs.item)
				cs.forth
			end
		ensure
			witnesses.has (a_witness)
		end

feature {NONE} -- Implementation

	add_result (a_result: AUT_TEST_CASE_RESULT) is
				-- Add `a_result' to the repository.
		require
			a_result_not_void: a_result /= Void
		local
			list: DS_ARRAYED_LIST [AUT_TEST_CASE_RESULT]
		do
			result_table.search (a_result.class_)
			if result_table.found then
				result_table.found_item.force_last (a_result)
			else
				create list.make_default
				list.force_last (a_result)
				result_table.force (list, a_result.class_)
			end
		end

	result_table: DS_HASH_TABLE [DS_LIST [AUT_TEST_CASE_RESULT], CLASS_C]
			-- Table storing all results grouped by class

	class_equality_tester: AUT_CLASS_EQUALITY_TESTER
			-- Equality tester for classes

invariant

	result_table_not_void: result_table /= Void
	result_table_does_not_have_void: not result_table.has (Void)
	class_equality_tester_not_void: class_equality_tester /= Void
	witnesses_not_void: witnesses /= Void
	no_witness_void: not witnesses.has (Void)

end
