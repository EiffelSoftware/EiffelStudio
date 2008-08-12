indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_COMMONLY_USED_ASSERTIONS

inherit
	TEST_ASSERTIONS

feature -- Equality

	assert_equal (a_tag: STRING; expected, actual: ANY) is
			-- Check that `expected ~ actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_equal_message (a_tag, expected, actual), expected ~ actual)
		end

	assert_not_equal (a_tag: STRING; expected, actual: ANY) is
			-- Check that `expected /~ actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			disassert (assert_not_equal_message (a_tag, expected, actual), expected ~ actual)
		end

	assert_reference_equal (a_tag: STRING; expected, actual: ANY) is
			-- Check that `expected = actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_equal_message (a_tag, expected, actual), expected = actual)
		end

	assert_not_reference_equal (a_tag: STRING; expected, actual: ANY) is
			-- Check that `expected /= actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			disassert (assert_not_equal_message (a_tag, expected, actual), expected = actual)
		end

	assert_integers_equal (a_tag: STRING; expected, actual: INTEGER) is
			-- Check that `expected = actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_integers_not_equal (a_tag: STRING; expected, actual: INTEGER) is
			-- Check that `expected /= actual'.
		require
			a_tag_not_void: a_tag /= Void
		do
			disassert (assert_strings_not_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_strings_equal (a_tag: STRING; expected, actual: STRING) is
			-- Check that `expected' and `actual' are the same string.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected, actual), expected.is_equal (actual))
		end

	assert_strings_not_equal (a_tag: STRING; expected, actual: STRING) is
			-- Check that `expected' and `actual' are not the same string.
		require
			a_tag_not_void: a_tag /= Void
		do
			disassert (assert_strings_not_equal_message (a_tag, expected, actual), expected.is_equal (actual))
		end

	assert_strings_case_insensitive_equal (a_tag: STRING; expected, actual: STRING) is
			-- Check that `expected' and `actual' are the same string (case insensitive).
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected, actual), expected.is_case_insensitive_equal (actual))
		end

	assert_characters_equal (a_tag: STRING; expected, actual: CHARACTER) is
			-- Check that `expected = actual'
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_characters_not_equal (a_tag: STRING; expected, actual: CHARACTER) is
			-- Check that `expected /= actual'
		require
			a_tag_not_void: a_tag /= Void
		do
			disassert (assert_strings_not_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_booleans_equal (a_tag: STRING; expected, actual: BOOLEAN) is
			-- Check that `expected = actual'
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (assert_strings_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_booleans_not_equal (a_tag: STRING; expected, actual: BOOLEAN) is
			-- Check that `expected /= actual'
		require
			a_tag_not_void: a_tag /= Void
		do
			disassert (assert_strings_not_equal_message (a_tag, expected.out, actual.out), expected = actual)
		end

	assert_attached (a_tag: STRING; object: ANY) is
			-- Check that `object' is attached.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (a_tag, object /= Void)
		end

	assert_void (a_tag: STRING; object: ANY) is
			-- Check that `object' is detached.
		require
			a_tag_not_void: a_tag /= Void
		do
			assert (a_tag, object = Void)
		end

	assert_predicate (a_tag: STRING; pred: PREDICATE [ANY, TUPLE]) is
			-- Check that `pred' evaluates to True.
		require
			a_tag_not_void: a_tag /= Void
			pred_not_void: pred /= Void
			pred_no_argument: pred.empty_operands.count = 0
		do
			assert (a_tag, pred.item (Void))
		end

feature -- Containers

	assert_arrays_equal (a_tag: STRING; expected, actual: ARRAY [ANY]) is
			-- Check that `expected' and `actual' have the same items
			-- in the same order (use `equal' for item comparison).
		require
			a_tag_not_void: a_tag /= Void
			expected_not_void: expected /= Void
			actual_not_void: actual /= Void
		local
			i, nb: INTEGER
			i1, i2: INTEGER
			new_tag, a_message: STRING
			expected_item, actual_item: ANY
		do
			if expected.count /= actual.count then
				create new_tag.make (15)
				new_tag.append_string (a_tag)
				new_tag.append_string ("-count")
				a_message := assert_strings_equal_message (new_tag, expected.count.out, actual.count.out)
			else
				i1 := expected.lower
				i2 := actual.lower
				nb := expected.count
				from i := 1 until i > nb loop
					expected_item := expected.item (i1)
					actual_item := actual.item (i1)
					if expected_item /~ actual_item then
						create new_tag.make (15)
						new_tag.append_string (a_tag)
						new_tag.append_string ("-item #")
						new_tag.append_integer (i)
						a_message := assert_equal_message (new_tag, expected_item, actual_item)
						i := nb + 1
					else
						i1 := i1 + 1
						i2 := i2 + 1
						i := i + 1
					end
				end
			end
			if a_message /= Void then
				assert (a_message, False)
			end
		end

	assert_arrays_reference_equal (a_tag: STRING; expected, actual: ARRAY [ANY]) is
			-- Check that `expected' and `actual' have the same items
			-- in the same order (use '=' for item comparison).
		require
			a_tag_not_void: a_tag /= Void
			expected_not_void: expected /= Void
			actual_not_void: actual /= Void
		local
			i, nb: INTEGER
			i1, i2: INTEGER
			new_tag, a_message: STRING
			expected_item, actual_item: ANY
		do
			if expected.count /= actual.count then
				create new_tag.make (15)
				new_tag.append_string (a_tag)
				new_tag.append_string ("-count")
				a_message := assert_strings_equal_message (new_tag, expected.count.out, actual.count.out)
			else
				i1 := expected.lower
				i2 := actual.lower
				nb := expected.count
				from i := 1 until i > nb loop
					expected_item := expected.item (i1)
					actual_item := actual.item (i1)
					if expected_item /= actual_item then
						create new_tag.make (15)
						new_tag.append_string (a_tag)
						new_tag.append_string ("-item #")
						new_tag.append_integer (i)
						a_message := assert_equal_message (new_tag, expected_item, actual_item)
						i := nb + 1
					else
						i1 := i1 + 1
						i2 := i2 + 1
						i := i + 1
					end
				end
			end
			if a_message /= Void then
				assert (a_message, False)
			end
		end

feature {NONE} -- Messages

	void_or_out (an_any: ANY): STRING is
			-- Return `an_any.out' or Void if `an_any' is Void.
		do
			if an_any /= Void then
				Result := an_any.out
			end
		end

	assert_equal_message (a_tag: STRING; expected, actual: ANY): STRING is
			-- Message stating that `expected' and `actual' should be equal.
		require
			a_tag_not_void: a_tag /= Void
		do
			Result := assert_strings_equal_message (a_tag, void_or_out (expected), void_or_out (actual))
		end

	assert_not_equal_message (a_tag: STRING; expected, actual: ANY): STRING is
			-- Message stating that `expected' and `actual' should not be equal.
		require
			a_tag_not_void: a_tag /= Void
		do
			Result := assert_strings_not_equal_message (a_tag, void_or_out (expected), void_or_out (actual))
		end

	assert_strings_equal_message (a_tag: STRING; expected, actual: STRING): STRING is
			-- Message stating that `expected' and `actual' should be equal.
		require
			a_tag_not_void: a_tag /= Void
		do
			create Result.make (50)
			Result.append_string (a_tag)
			Result.append_string ("%N   expected: ")
			if expected = Void then
				Result.append_string ("Void")
			else
				Result.append_string (expected)
			end
			Result.append_string ("%N   but  got: ")
			if actual = Void then
				Result.append_string ("Void")
			else
				Result.append_string (actual)
			end
		ensure
			message_not_void: Result /= Void
		end

	assert_strings_not_equal_message (a_tag: STRING; expected, actual: STRING): STRING is
			-- Message stating that `expected' and `actual' should not be equal.
		require
			a_tag_not_void: a_tag /= Void
		do
			create Result.make (50)
			Result.append_string (a_tag)
			Result.append_string ("%N   got actual value: ")
			if actual = Void then
				Result.append_string ("Void")
			else
				Result.append_string (actual)
			end
			Result.append_string ("%N   should not match: ")
			if expected = Void then
				Result.append_string ("Void")
			else
				Result.append_string (expected)
			end
		ensure
			message_not_void: Result /= Void
		end

end
