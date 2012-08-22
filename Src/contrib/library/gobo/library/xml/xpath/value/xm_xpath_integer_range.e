note

	description:

		"Range of ascending INTEGERs"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_INTEGER_RANGE

inherit

	XM_XPATH_SEQUENCE_VALUE
		redefine
			is_integer_range, as_integer_range,
			count, item_at, display, is_convertible_to_item,
			item_type
		end

create

	make

feature {NONE} -- Initialization

	make (a_start, an_end: INTEGER)
			-- Establish invariant.
		require
			ascending_range: an_end > a_start
		do
			make_value
			minimum := a_start; maximum := an_end
			set_cardinality_many
		ensure
			static_properties_computed: are_static_properties_computed
		end

feature -- Access

	minimum: INTEGER
			-- Start of range

	maximum: INTEGER
			-- End of range

	is_integer_range: BOOLEAN
			-- Is `Current' an integer range?
		do
			Result := True
		end

	as_integer_range: XM_XPATH_INTEGER_RANGE
			-- `Current' seen as an integer range
		do
			Result := Current
		end

	item_type: XM_XPATH_ITEM_TYPE
			-- Data type
		do
			Result := type_factory.integer_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

	count: INTEGER
			-- Number of items in `Current'
		do
			Result := maximum - minimum + 1
		end

	item_at (an_index: INTEGER) :XM_XPATH_ITEM
			-- Item at `an_index'
		do
			create {XM_XPATH_MACHINE_INTEGER_VALUE} Result.make ((minimum + an_index - 1).to_integer_64)
		end

feature -- Comparison

	same_expression (other: XM_XPATH_EXPRESSION): BOOLEAN
			-- Are `Current' and `other' the same expression?
		do
			if	not other.is_integer_range then
				Result := False
			else
				Result := minimum = other.as_integer_range.minimum and then maximum = other.as_integer_range.maximum
			end
		end

feature -- Status report

	is_convertible_to_item (a_context: XM_XPATH_CONTEXT): BOOLEAN
			-- Can `Current' be converted to an `XM_XPATH_ITEM'?
		do
			Result := False
		end

	display (a_level: INTEGER)
			-- Diagnostic print of expression structure to `std.error'
		do
			std.error.put_string (indentation (a_level))
			std.error.put_string (minimum.out + " to " + maximum.out + "%N")
		end

feature -- Evaluation

	create_iterator (a_context: XM_XPATH_CONTEXT)
			-- An iterator over the values of a sequence
		do
			create {XM_XPATH_RANGE_ITERATOR} last_iterator.make (minimum, maximum)
		end

	create_node_iterator (a_context: XM_XPATH_CONTEXT)
			-- Create an iterator over a node sequence
		do
			-- precondition is never met
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	native_implementations: INTEGER
			-- Natively-supported evaluation routines
		do
			Result := Supports_iterator
		end

invariant

	ascending_range: maximum > minimum

end
