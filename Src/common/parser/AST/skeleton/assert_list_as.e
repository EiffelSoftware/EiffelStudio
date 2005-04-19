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

feature {NONE} -- Initialization

	initialize (a: like assertions) is
			-- Create a new ASSERTION_LIST AST node.
		do
			assertions := a
		ensure
			assertions_set: assertions = a
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
			-- Assertion list

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if assertions /= Void then
				Result := assertions.start_location
			else
				Result := null_location
			end
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if assertions /= Void then
				Result := assertions.end_location
			else
				Result := null_location
			end
		end

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
			assertions := l
		end
	
end -- class ASSERT_LIST_AS
