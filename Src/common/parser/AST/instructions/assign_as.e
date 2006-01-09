indexing
	description: "Abstract description of an assignment."
	date: "$Date$"
	revision: "$Revision$"

class ASSIGN_AS

inherit
	INSTRUCTION_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like target; s: like source; a_as: like assignment_symbol) is
			-- Create a new ASSIGN AST node.
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
			v.process_assign_as (Current)
		end

feature -- Roundtrip

	assignment_symbol: SYMBOL_AS
			-- Symbol ":=" or "?=" associated with this structure


feature -- Attributes

	target: ACCESS_AS
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

feature {ASSIGN_AS}	-- Replication

	set_target (t: like target) is
		require
			valid_arg: t /= Void
		do
			target := t
		end

	set_source (s: like source) is
		require
			valid_arg: s /= Void
		do
			source := s
		end

invariant
	target_not_void: target /= Void
	source_not_void: source /= Void

end -- class ASSIGN_AS
