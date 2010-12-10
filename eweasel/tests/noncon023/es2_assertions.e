note
	description: "Summary description for {ES2_ASSERTIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES2_ASSERTIONS

feature {NONE} -- Access

	internal: INTERNAL
		once
			create Result
		end

feature -- Basic operations

	assert_deep_equal (a_tag: STRING; expected, actual: ANY)
			-- Check that `expected' is deep equal to `actual'.
		require
			a_tag_attached: a_tag /= Void
		local
			l_dea: ES2_DEEP_EQUALITY_ASSERTER
		do
			create l_dea.make (Current)
			l_dea.assert_deep_equal (expected, actual)
		end

feature {NONE} -- Implementation

	assert_deep_equal_message (path: STRING): STRING
		do
				-- TODO: come up with better message
			Result := path
		end

	assert_objects_equal (path: STRING; expected, actual: detachable ANY; visited: ARRAYED_LIST [TUPLE [expected, actual: ANY]])
		require
			path_attached: path /= Void
			expected_attached: expected /= Void
			actual_attached: actual /= Void
			visited_attached: visited /= Void
		do
			if expected /= actual then
				if expected /= Void and actual /= Void then
					from
						visited.start
					until
						visited.after or else visited.item.expected = expected or else visited.item.actual = actual
					loop
						visited.forth
					end
					if visited.after then
						visited.force ([expected, actual])
						assert_fields_equal (path, expected, actual, visited)
					else
					end
				else
				end
			end
		end

	assert_fields_equal (path: STRING; expected, actual: ANY; visited: ARRAYED_LIST [TUPLE [expected, actual: ANY]])
		require
			path_attached: path /= Void
			expected_attached: expected /= Void
			actual_attached: actual /= Void
			visited_attached: visited /= Void
			same_types: expected.same_type (actual)
		local
			l_count, i, l_type: INTEGER
			l_exp, l_act: detachable ANY
			l_path: STRING
		do
			l_count := internal.field_count (expected)
			from
				i := 1
			until
				i > l_count
			loop
				if path.is_empty then
					l_path := internal.field_name (i, expected)
				else
					l_path := path + "." + internal.field_name (i, expected)
				end

				inspect
					internal.field_type (i, expected)
				when {INTERNAL}.pointer_type then
				when {INTERNAL}.boolean_type then
				when {INTERNAL}.character_8_type then
				when {INTERNAL}.character_32_type then
				when {INTERNAL}.integer_8_type then
				when {INTERNAL}.integer_16_type then
				when {INTERNAL}.integer_32_type then
				when {INTERNAL}.integer_64_type then


				when {INTERNAL}.natural_8_type then
				when {INTERNAL}.natural_16_type then
				when {INTERNAL}.natural_32_type then
				when {INTERNAL}.natural_64_type then
				when {INTERNAL}.real_32_type then
				when {INTERNAL}.real_64_type then
				when {INTERNAL}.bit_type then
				when {INTERNAL}.expanded_type then
				when {INTERNAL}.reference_type then
					assert_objects_equal (l_path,
						internal.field (i, expected),
						internal.field (i, actual),
						visited)
				end

				i := i + 1
			end
		end

end
