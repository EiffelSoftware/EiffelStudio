indexing
	description	: "Abstract description of an Eiffel list of assertions%
				  %Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class ASSERT_LIST_AS

inherit
	AST_EIFFEL
		redefine
			number_of_breakpoint_slots
		end

	ASSERTION_FILTER

feature {NONE} -- Initialization

	initialize (a: like assertions) is
			-- Create a new ASSERTION_LIST AST node.
		do
			full_assertion_list := a
			assertions := filter_tagged_list (full_assertion_list)
		ensure
			full_assertion_list_set: full_assertion_list = a
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			if assertions /= Void then
				Result := assertions.number_of_breakpoint_slots
			end
		end

feature -- Attributes

	assertions: EIFFEL_LIST [TAGGED_AS]
			-- Assertion list (only complete assertions are included)
			-- e.g. "tag:expr", "expr"

feature -- Roundtrip

	full_assertion_list: like assertions
			-- Assertion list that contains both complete and incomplete assertions.
			-- e.g. "tag:expr", "tag:", "expr"

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (assertions, other.assertions)
		end

feature -- Access

	has_assertion (a: TAGGED_AS): BOOLEAN is
			-- Does current list have assertion `a'?
		local
			cur: CURSOR
		do
			cur := assertions.cursor

			from
				assertions.start
			until
				assertions.after or else Result
			loop
				Result := assertions.item.is_equiv (a)
				assertions.forth
			end

			assertions.go_to (cur)
		end

feature {ASSERT_LIST_AS} -- Replication

	set_assertions (l: like assertions) is
		do
			full_assertion_list := l
			assertions := filter_tagged_list (full_assertion_list)
		end

end -- class ASSERT_LIST_AS
