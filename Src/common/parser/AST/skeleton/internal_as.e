indexing
	description	: "Abstract class representing routines that have a body."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class INTERNAL_AS

inherit
	ROUT_BODY_AS
		redefine
			is_empty,
			has_instruction, index_of_instruction,
			number_of_breakpoint_slots, is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (c: like compound) is
			-- Create a new INTERNAL AST node.
		do
			compound := c
		ensure
			compound_set: compound = c
		end

feature -- Attributes

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if compound /= Void then
				Result := compound.start_location
			else
				Result := null_location
			end
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if compound /= Void then
				Result := compound.end_location
			else
				Result := null_location
			end
		end

feature -- test for empty body

	is_empty : BOOLEAN is
		do
			Result := (compound = Void) or else (compound.is_empty)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			if compound /= Void then
				Result := compound.number_of_breakpoint_slots
			end
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does the current routine body has instruction `i'?
		do
			from
				compound.start
			until
				Result or else compound.off
			loop
				Result := equivalent (compound.item, i)
				compound.forth
			end
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this feature.
		do
			from
				compound.start
			until
				compound.off or else equivalent (i, compound.item)
			loop
				compound.forth
			end

			if not compound.off then
				Result := compound.index
			else
				Result := 0
			end
		end

feature {INTERNAL_AS, CMD, USER_CMD, INTERNAL_MERGER} -- Replication
	
	set_compound (c: like compound) is
		do
			compound := c
		end;	
	
end -- class INTERNAL_AS
