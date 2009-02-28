note
	description: "[
		Regression tests for {EQA_EXTRACTED_TEST_SET}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	testing: "covers/{EQA_EXTRACTED_TEST_SET}"

class
	EQA_EXTRACTION_TESTS

inherit
	EQA_EXTRACTED_TEST_SET

feature -- Test routines

	test_object_restore
			-- Test general object recovery from `context'.
		require
			string_available: is_string_available
		do
			assert ("object_available", is_object_available)

			run_extracted_test (agent (a_obj: attached EQA_TEST_OBJECT)
				do
					assert ("correct_a_current", a_obj.a_current = a_obj)
					assert ("integer_correct", a_obj.a_integer = 100)
					if attached {STRING} object_for_id ("#2") as l_string then
						assert ("correct_a_string", a_obj.a_string = l_string)
					end
				end, ["#1"])
		end

	test_string_restore
			-- Test {STRING_8} obejct restore from `context'.
		do
			assert ("string_object_available", is_string_available)
			if attached {STRING} object_for_id ("#2") as l_string then
				assert ("correct_content", l_string.is_equal ("This is an extracted string."))
			end
		end

	test_tuple_restore
			-- Test {TUPLE} recovery from `context'.
		require
			object_available: is_object_available
			string_available: is_string_available
		do
			assert ("tuple_available", is_tuple_available)

			run_extracted_test (agent (a_tuple: attached TUPLE [REAL_64, EQA_TEST_OBJECT, STRING_8])
				do
					assert ("correct_object_comparison", a_tuple.object_comparison)

					assert ("correct_real_value", a_tuple.real_64_item (1) = {REAL_64} -9534.358)

					if attached {EQA_TEST_OBJECT} object_for_id ("#1") as l_obj then
						assert ("correct_reference_to_#1", a_tuple.reference_item (2) = l_obj)
					end

					if attached {STRING} object_for_id ("#2") as l_string then
						assert ("correct_reference_to_#2", a_tuple.reference_item (3) = l_string)
					end

					assert ("correct_count", a_tuple.count = 3)
				end, ["#3"])
		end

	test_special_restore
			-- Test {SPECIAL} recovery from `context'.
		do
			assert ("special_available", is_special_available)

			run_extracted_test (agent (a_special: attached SPECIAL [NATURAL_8])
				do
					assert ("correct_value_1", a_special.item (0) = {NATURAL_8} 0)
					assert ("correct_value_2", a_special.item (1) = {NATURAL_8} 1)
					assert ("correct_value_3", a_special.item (2) = {NATURAL_8} 255)
					assert ("correct_count", a_special.count = 3)
				end, ["#4"])
		end

	test_special_any_restore
			-- Test {SPECIAL [ANY]} recovery from `context'.
		require
			object_available: is_object_available
			string_available: is_string_available
			tuple_available: is_tuple_available
			special_available: is_special_available
		do
			run_extracted_test (agent (a_special: attached SPECIAL [attached ANY])
				do
					if attached {EQA_TEST_OBJECT} object_for_id ("#1") as l_obj then
						assert ("correct_reference_to_#1", a_special.item (0) = l_obj)
					end

					if attached {STRING} object_for_id ("#2") as l_string then
						assert ("correct_reference_to_#2", a_special.item (1) = l_string)
					end

					if attached {TUPLE} object_for_id ("#3") as l_tuple then
						assert ("correct_reference_to_#2", a_special.item (2) = l_tuple)
					end

					if attached {SPECIAL [NATURAL_8]} object_for_id ("#4") as l_special then
						assert ("correct_reference_to_#2", a_special.item (3) = l_special)
					end

					assert ("correct_count", a_special.count = 4)
				end, ["#5"])
		end

feature -- Status report

	is_object_available: BOOLEAN
			-- Has {EQA_TEST_OBJECT} object in `context' been instanciated?
		do
			Result := is_valid_id ("#1") and then attached {attached EQA_TEST_OBJECT} object_for_id ("#1") as l_obj
		end

	is_string_available: BOOLEAN
			-- Has {STRING_8} object in `context' been instanciated?
		do
			Result := is_valid_id ("#2") and then attached {attached STRING} object_for_id ("#2") as l_string
		end

	is_tuple_available: BOOLEAN
			-- Has {TUPLE} object in `context' been instanciated?
		do
			Result := is_valid_id ("#3") and then attached {attached TUPLE [REAL_64, EQA_TEST_OBJECT, STRING_8]} object_for_id ("#3") as l_special
		end

	is_special_available: BOOLEAN
			-- Has {SPECIAL [NATURAL_8]} object in `context' been instanciated?
		do
			Result := is_valid_id ("#4") and then attached {attached SPECIAL [NATURAL_8]} object_for_id ("#4") as l_special
		end

feature {NONE} -- Access

	context: attached ARRAY [attached TUPLE [type: attached TYPE [ANY]; attributes: attached TUPLE; inv: BOOLEAN]]
			-- <Precursor>
		do
			Result := <<
				[{attached EQA_TEST_OBJECT}, [
						"a_string",    "#2",
						"a_current",   "#1",
						"a_integer",   {INTEGER} 100
					], True],
				[{attached STRING_8}, ["[
						This is an extracted string.
					]"], True],
				[{attached TUPLE [REAL_64, EQA_TEST_OBJECT, STRING_8]}, [
						True, {REAL_64} -9534.358, "#1", "#2"
					], True],
				[{attached SPECIAL [NATURAL_8]}, [
						{NATURAL_8} 0, {NATURAL_8} 1, {NATURAL_8} 255
					], True],
				[{attached SPECIAL [attached ANY]}, [
						"#1", "#2", "#3", "#4"
					], True]
			>>
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
