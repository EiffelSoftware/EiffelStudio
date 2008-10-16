indexing
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

			run_extracted_test (agent (a_obj: !EQA_TEST_OBJECT)
				do
					assert ("correct_a_current", a_obj.a_current = a_obj)
					assert ("integer_correct", a_obj.a_integer = 100)
					if {l_string: !STRING} object_for_id ("#2") then
						assert ("correct_a_string", a_obj.a_string = l_string)
					end
				end, ["#1"])
		end

	test_string_restore
			-- Test {STRING_8} obejct restore from `context'.
		do
			assert ("string_object_available", is_string_available)
			if {l_string: !STRING} object_for_id ("#2") then
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

			run_extracted_test (agent (a_tuple: !TUPLE [REAL_64, EQA_TEST_OBJECT, STRING_8])
				do
					assert ("correct_object_comparison", a_tuple.object_comparison)

					assert ("correct_real_value", a_tuple.real_64_item (1) = {REAL_64} -9534.358)

					if {l_obj: !EQA_TEST_OBJECT} object_for_id ("#1") then
						assert ("correct_reference_to_#1", a_tuple.reference_item (2) = l_obj)
					end

					if {l_string: !STRING} object_for_id ("#2") then
						assert ("correct_reference_to_#2", a_tuple.reference_item (3) = l_string)
					end

					assert ("correct_count", a_tuple.count = 3)
				end, ["#3"])
		end

	test_special_restore
			-- Test {SPECIAL} recovery from `context'.
		do
			assert ("special_available", is_special_available)

			run_extracted_test (agent (a_special: !SPECIAL [NATURAL_8])
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
			run_extracted_test (agent (a_special: !SPECIAL [!ANY])
				do
					if {l_obj: !EQA_TEST_OBJECT} object_for_id ("#1") then
						assert ("correct_reference_to_#1", a_special.item (0) = l_obj)
					end

					if {l_string: !STRING} object_for_id ("#2") then
						assert ("correct_reference_to_#2", a_special.item (1) = l_string)
					end

					if {l_tuple: !TUPLE} object_for_id ("#3") then
						assert ("correct_reference_to_#2", a_special.item (2) = l_tuple)
					end

					if {l_special: !SPECIAL [NATURAL_8]} object_for_id ("#4") then
						assert ("correct_reference_to_#2", a_special.item (3) = l_special)
					end

					assert ("correct_count", a_special.count = 4)
				end, ["#5"])
		end

feature -- Status report

	is_object_available: BOOLEAN
			-- Has {EQA_TEST_OBJECT} object in `context' been instanciated?
		do
			Result := is_valid_id ("#1") and then {l_obj: !EQA_TEST_OBJECT} object_for_id ("#1")
		end

	is_string_available: BOOLEAN
			-- Has {STRING_8} object in `context' been instanciated?
		do
			Result := is_valid_id ("#2") and then {l_string: !STRING} object_for_id ("#2")
		end

	is_tuple_available: BOOLEAN
			-- Has {TUPLE} object in `context' been instanciated?
		do
			Result := is_valid_id ("#3") and then {l_special: !TUPLE [REAL_64, EQA_TEST_OBJECT, STRING_8]} object_for_id ("#3")
		end

	is_special_available: BOOLEAN
			-- Has {SPECIAL [NATURAL_8]} object in `context' been instanciated?
		do
			Result := is_valid_id ("#4") and then {l_special: !SPECIAL [NATURAL_8]} object_for_id ("#4")
		end

feature {NONE} -- Access

	context: !ARRAY [!TUPLE [type: !TYPE [ANY]; attributes: !TUPLE; inv: BOOLEAN]]
			-- <Precursor>
		do
			Result := <<
				[{EQA_TEST_OBJECT}, [
						"a_string",    "#2",
						"a_current",   "#1",
						"a_integer",   {INTEGER} 100
					], True],
				[{STRING_8}, ["[
						This is an extracted string.
					]"], True],
				[{TUPLE [REAL_64, EQA_TEST_OBJECT, STRING_8]}, [
						True, {REAL_64} -9534.358, "#1", "#2"
					], True],
				[{SPECIAL [NATURAL_8]}, [
						{NATURAL_8} 0, {NATURAL_8} 1, {NATURAL_8} 255
					], True],
				[{SPECIAL [ANY]}, [
						"#1", "#2", "#3", "#4"
					], True]
			>>
		end

end
