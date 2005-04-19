indexing
	description	: "Abstract description ao an alternative of a multi_branch %
				  %instruction. Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class CASE_AS

inherit
	AST_EIFFEL
		redefine
			number_of_breakpoint_slots, is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (i: like interval; c: like compound) is
			-- Create a new WHEN AST node.
		require
			i_not_void: i /= Void
		do
			interval := i
			compound := c
		ensure
			interval_set: interval = i
			compound_set: compound = c
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_case_as (Current)
		end

feature -- Attributes

	interval: EIFFEL_LIST [INTERVAL_AS]
			-- Interval of the alternative

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := interval.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if compound /= Void then
				Result := compound.end_location
			else
				Result := interval.end_location
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and
				equivalent (interval, other.interval)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points
		do
			if compound /= Void then
				Result := compound.number_of_breakpoint_slots
			end
		end

feature {CASE_AS} -- Replication

	set_interval (i: like interval) is
		require
			valid_arg: i /= Void
		do
			interval := i
		end

	set_compound (c: like compound) is
		do
			compound := c
		end

invariant
	interval_not_void: interval /= Void

end -- class CASE_AS
