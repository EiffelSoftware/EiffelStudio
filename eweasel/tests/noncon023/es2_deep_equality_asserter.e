note
	description: "Summary description for {ES2_DEEP_EQUALITY_ASSERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES2_DEEP_EQUALITY_ASSERTER

inherit {NONE}
	ES2_BREADTH_FIRST_HEAP_TRAVERSAL
		rename
			make as make_traversal
		export
			{NONE} all
			{ANY} is_traversing
		redefine
			forth,
			process_field,
			process_special_field,
			process_tuple_field
		end

create
	make

feature {NONE} -- Initialize

	make (an_assertions: like assertions)
		do
			assertions := an_assertions
			actual_dispenser := new_dispenser
			create path_dispenser.make (default_dispenser_size)
			create equal_references.make (default_sequence_size)
			current_path := default_path
			make_traversal
		ensure
			not_traversing: not is_traversing
		end

feature {NONE} -- Assertions

	assertions: ES2_ASSERTIONS

	actual_dispenser: like new_dispenser

	actual_object: like object
		require
			traversing: is_traversing
		do
			check attached actual_current_object as l_result then
				Result := l_result
			end
		ensure
			result_attached: Result /= Void
		end

	actual_current_object: like current_object

	current_path: STRING

	path_dispenser: ARRAYED_QUEUE [STRING]

	equal_references: ARRAYED_LIST [TUPLE [expected, actual: ANY]]
			-- References which are considered equal
			--
			-- Note: expected and actual references are marked

feature -- Basic operations

	assert_deep_equal (expected, actual: ANY)
		require
			not_traversing: not is_traversing
		do
			prepare (expected)
			actual_current_object := actual
			traverse_recursive
			cleanup
		ensure
			not_traversing: not is_traversing
		end

feature {NONE} -- Basic operations

	assert (a_tag: STRING; a_condition: BOOLEAN)
		do
			if not a_condition then
				print ("violation at " + current_path)
				print ("%NReason: ")
				print (a_tag)
			end
		end

	process_references (expected, actual: detachable ANY; a_path: STRING)
			-- Process two references at once.
		local
			l_equals: like equal_references
			l_expected_found, l_actual_found: BOOLEAN
		do
			if
				expected /= Void and then actual /= Void and then
				not expected.generating_type.is_expanded and then
				not actual.generating_type.is_expanded
			then
					-- `expected' and `actual' are both attached reference types,
					-- even if they point to the same object (e.g. after shallow copy)
					-- they can be handled the same as two different references.

				if is_marked (expected) then
					assert ("both marked", is_marked (actual))
					from
						l_equals := equal_references
						l_equals.start
					until
						l_expected_found
					loop
						l_expected_found := l_equals.item_for_iteration.expected = expected
						l_actual_found := l_equals.item_for_iteration.actual = actual
						assert (a_path, l_expected_found = l_actual_found)
						l_equals.forth
					end
				else
					assert ("both not marked", not is_marked (actual))
						-- Process `expected' reference
					process_reference (expected)
						-- Do the same for `actual' reference
					mark (actual)
					actual_dispenser.put (actual)
					if current_path.is_empty then
						path_dispenser.put (a_path)
					else
						path_dispenser.put (current_path + "." + a_path)
					end
					equal_references.force ([expected, actual])
				end
			else
				assert ("both Void or same expanded value", expected = actual)
			end
		end

	process_field (an_expected: ANY; a_field_index: INTEGER)
			-- <Precursor>
		do
			check
				current_actual_object_consistent:
				attached actual_current_object as l_actual and then
				dynamic_type (an_expected) = dynamic_type (l_actual)
			then
				process_references (
					field (a_field_index, an_expected),
					field (a_field_index, l_actual),
					field_name (a_field_index, an_expected))
			end
		end

	process_special_field (an_expected: SPECIAL [detachable ANY]; a_field: INTEGER_32)
			-- <Precursor>
		do
			check
				current_actual_object_consistent:
				attached {SPECIAL [detachable ANY]} actual_current_object as l_actual and then
				dynamic_type (an_expected) = dynamic_type (l_actual)
			then
				process_references (
					an_expected[a_field],
					l_actual[a_field],
					"item(" + a_field.out + ")")
			end
		end

	process_tuple_field (an_expected: TUPLE; a_field: INTEGER_32)
			-- <Precursor>
		do
			check
				current_actual_object_consistent:
				attached {TUPLE} actual_current_object as l_actual and then
				dynamic_type (an_expected) = dynamic_type (l_actual)
			then
				process_references (
					an_expected.at (a_field),
					l_actual.at (a_field),
					"at(" + a_field.out + ")")
			end
		end

feature {NONE} -- Element change

	forth
			-- <Precursor>
		do
			if dispenser.is_empty then
				actual_current_object := Void
				current_path := default_path
			else
				actual_current_object := actual_dispenser.item
				current_path := path_dispenser.item
				actual_dispenser.remove
				path_dispenser.remove
			end
			Precursor
		end

feature {NONE} -- Constants

	default_path: STRING = ""

invariant
	dispensers_have_equal_count: dispenser.count = actual_dispenser.count and
		dispenser.count = path_dispenser.count
	current_objects_have_same_attachment: (current_object /= Void) = (actual_current_object /= Void)
--	dispenser_have_same_count: dispenser.count = actual_dispenser.count
--	equal_references_empty_or_traversing: is_traversing or equal_references.is_empty

end
