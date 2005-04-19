indexing
	description: "AST representation of a deferred routine."
	date: "$Date$"
	revision: "$Revision$"

class DEFERRED_AS

inherit
	ROUT_BODY_AS
		redefine
			is_deferred, has_instruction, index_of_instruction,
			is_equivalent
		end

	LEAF_AS

create
	make_with_location

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_deferred_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	is_deferred: BOOLEAN is True
			-- Is the current routine body a defferred one ?

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Has the current routine body an instruction `i'?
		do
			Result := False
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this deferred feature.
			-- Result is `0'.
		do
			Result := 0
		end

end -- class DEFERRED_AS
