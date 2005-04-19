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
			is_equivalent, start_location, end_location
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (l: like lower; u: like upper) is
			-- Create a new INTERVAL AST node.
		require
			l_not_void: l /= Void
		do
			lower := l
			upper := u
		ensure
			lower_set: lower = l
			upper_set: upper = u
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_interval_as (Current)
		end

feature -- Attributes

	lower: ATOMIC_AS
			-- Lower bound

	upper: ATOMIC_AS
			-- Upper bound
			-- Void if constant rather than interval

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := lower.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if upper /= Void then
				Result := upper.end_location
			else
				Result := lower.end_location
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
