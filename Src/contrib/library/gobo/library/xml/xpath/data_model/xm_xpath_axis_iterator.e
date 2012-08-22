note

	description:

		"Objects that iterate over an XPath node axis"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2003, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class XM_XPATH_AXIS_ITERATOR [G -> XM_XPATH_NODE]

inherit

	XM_XPATH_SEQUENCE_ITERATOR [G]
		redefine
			is_node_iterator, is_invulnerable, as_node_iterator,
			is_axis_iterator, as_axis_iterator
		end

feature -- Access

	item: G
			-- Value or node at the current position
		do
			Result := current_item
		end

feature -- Status report

	is_invulnerable: BOOLEAN
			-- Is `Current' guarenteed free of implicit errors?
		do
			Result := True
		end

	is_node_iterator: BOOLEAN
			-- Does `Current' yield a node_sequence?
		do
			Result := True
		end

	is_axis_iterator: BOOLEAN
			-- Is `Current' an axis iterator?
		do
			Result := True
		end

	after: BOOLEAN
			-- Are there any more items in the sequence?
		do
			Result := not before and then current_item = Void
		end

feature -- Conversion

	as_axis_iterator: XM_XPATH_AXIS_ITERATOR [XM_XPATH_NODE]
			-- `Current' seen as an axis iterator
		do
			Result ?= ANY_.to_any (Current)
		end

	as_node_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE]
			-- `Current' seen as a node iterator
		do
			Result ?= ANY_.to_any (Current)
		end

feature {NONE} -- Implementation

	current_item: like item
			-- The item that the iterator is currently pointing to

	advance
			-- Move to the next position
		deferred
		end

end

