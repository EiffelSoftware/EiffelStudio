indexing
	description: "Abstract description of an assigner call."
	date: "$Date$"
	revision: "$Revision$"

class ASSIGNER_CALL_AS

inherit
	INSTRUCTION_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like target; s: like source) is
			-- Create a new ASSIGNER CALL AST node.
		require
			t_not_void: t /= Void
			s_not_void: s /= Void
		do
			target := t
			source := s
		ensure
			target_set: target = t
			source_set: source = s
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_assigner_call_as (Current)
		end

feature -- Attributes

	target: EXPR_AS
			-- Target of the assignment

	source: EXPR_AS
			-- Source of the assignment

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := target.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := source.end_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (source, other.source) and then
				equivalent (target, other.target)
		end

invariant
	target_not_void: target /= Void
	source_not_void: source /= Void

end
