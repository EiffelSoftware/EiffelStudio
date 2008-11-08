indexing
	description: "[
		Representation of an debugee object that was captured by {EIFFEL_TEST_CAPTURER}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CAPTURED_OBJECT

feature {NONE} -- Initialize

	make_object (a_id: like id; a_type: like type)
			-- Initialize `Current'.
			--
			-- `a_id': Identifier for object.
			-- `a_type': Full type name of captured object
		do
			id := a_id
			type := a_type
		ensure
			id_set: id = a_id
			type_equals_a_type: type.is_equal (a_type)
		end

feature -- Access

	id: NATURAL
			-- Identifier for object
			--
			-- Note: Currently this is just a counter increasing for each object.

	type: !STRING
			-- Full type name of captured object

	items: !DS_LIST [!STRING]
			-- Items captured from original object
			--
			-- Note: The items are representet as manifest values. For example:
			--           The natural number 753 is stored as   {NATURAL_32} 753
			--           the character A is stored as          {CHARACTER_8} 'A'
			--           a reference to an other object        "#10"
		require
			has_items: has_items
		do
		end

	attributes: !DS_HASH_TABLE [!STRING, !STRING]
			-- Attribues captured from original object
			--
			-- keys: Atttribute names
			-- values: The attribute values when the object was captured
			-- Note: The values are representet as manifest values. For example:
			--           The natural number 753 is stored as   {NATURAL_32} 753
			--           the character A is stored as          {CHARACTER_8} 'A'
			--           a reference to an other object        "#10"
		require
			has_attributes: has_attributes
		do
		end

	string: !STRING
			-- Content of original string object
		require
			is_string: is_string
		do
		end

feature -- Status report

	is_invariant_applicable: BOOLEAN
			-- Should object satisfy its invariants?
			--
			-- Note: if this is False it means the object was part of the call stack when capturing the
			--       application state, so it does not necessarily satisfy its invariants.

	has_items: BOOLEAN
			-- Does `Current' represent an object with items?
			--
			-- Note: namely these are SPECIAL, TUPLE and descendants of ROUTINE
		do
		end

	has_attributes: BOOLEAN
			-- Does `Current' represent an object with attributes?
		do
		end

	is_string: BOOLEAN
			-- Does `Current' represent a string object?
		do
		end

feature -- Status setting

	set_invariant_applicable (a_is_invariant_applicable: like is_invariant_applicable)
			-- Set `is_invariant_applicable' to `a_is_invariant_applicable'.
		do
			is_invariant_applicable := a_is_invariant_applicable
		ensure
			is_invariant_applicable_set: is_invariant_applicable = a_is_invariant_applicable
		end

invariant
	invariant_clause: True -- Your invariant here

end
