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

	initialize (t: like target; s: like source; a_as: like assignment_symbol) is
			-- Create a new ASSIGNER CALL AST node.
		require
			t_not_void: t /= Void
			s_not_void: s /= Void
		do
			target := t
			source := s
			assignment_symbol := a_as
		ensure
			target_set: target = t
			source_set: source = s
			assignment_symbol_set: assignment_symbol = a_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_assigner_call_as (Current)
		end

feature -- Roundtrip

	assignment_symbol: SYMBOL_AS
			-- Symbol ":=" associated with this structure

feature -- Attributes

	target: EXPR_AS
			-- Target of the assignment

	source: EXPR_AS
			-- Source of the assignment

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := target.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := source.complete_end_location (a_list)
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
