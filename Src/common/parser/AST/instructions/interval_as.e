indexing

	description:
			"Abstract node for alternative values of a multi-branch %
			%instruction. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INTERVAL_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (l: like lower; u: like upper; d_as: like dotdot_symbol) is
			-- Create a new INTERVAL AST node.
		require
			l_not_void: l /= Void
		do
			lower := l
			upper := u
			dotdot_symbol := d_as
		ensure
			lower_set: lower = l
			upper_set: upper = u
			dotdot_symbol_set: dotdot_symbol = d_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_interval_as (Current)
		end

feature -- Roundtrip

	dotdot_symbol: SYMBOL_AS
			-- Symbol ".." associated with this structure

feature -- Attributes

	lower: ATOMIC_AS
			-- Lower bound

	upper: ATOMIC_AS
			-- Upper bound
			-- Void if constant rather than interval

feature -- Roundtrip

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := lower.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if upper /= Void then
				Result := upper.complete_end_location (a_list)
			else
				Result := lower.complete_end_location (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (lower, other.lower) and
				equivalent (upper, other.upper)
		end

feature {INTERVAL_AS} -- Replication

	set_lower (l: like lower) is
			-- Set `lower' to `l'.
		require
			l_not_void: l /= Void
		do
			lower := l
		end

	set_upper (u: like upper) is
			-- Set `upper' to `u'.
		do
			upper := u
		end

invariant
	lower_not_void: lower /= Void

end -- class INTERVAL_AS
