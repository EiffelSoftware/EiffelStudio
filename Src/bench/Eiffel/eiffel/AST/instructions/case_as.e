indexing
	description	: "Abstract description ao an alternative of a multi_branch %
				  %instruction. Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class CASE_AS

inherit
	AST_EIFFEL
		redefine
			number_of_breakpoint_slots, is_equivalent,
			type_check, byte_node
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

feature {NONE} -- Type check, byte code production, dead code removal

	type_check is
			-- Type check a multi-branch alternative
		do
			interval.type_check
			if compound /= Void then
				compound.type_check
			end
		end

	byte_node: CASE_B is
			-- Associated byte code
		local
			intervals: SORTABLE_ARRAY [INTERVAL_B]
			interval_b: INTERVAL_B
			next_interval_b: INTERVAL_B
			tmp: BYTE_LIST [INTERVAL_B]
			i: INTEGER
			j: INTEGER
			n: INTEGER
		do
				-- Collect all intervals in an array
			from
				n := interval.count
				i := n
				j := n + 1
				create intervals.make (1, i)
			until
				i <= 0
			loop
				interval_b := interval.i_th (i).byte_node
				if interval_b /= Void then
					j := j - 1
					intervals.put (interval_b, j)
				end
				i := i - 1
			end
			if j <= n then
					-- Array of intervals is not empty
					-- Remove voids (if any)
				intervals.conservative_resize (j, n)
					-- Sort an array
				intervals.sort
					-- Copy intervals to `tmp' merging adjacent intervals
				from
					create tmp.make (n - j + 1)
					interval_b := intervals.item (j)
					tmp.extend (interval_b)
					j := j + 1
				until
					j > n
				loop
					next_interval_b := intervals.item (j)
					if interval_b.upper.is_next (next_interval_b.lower) then
							-- Merge intervals
						interval_b.set_upper (next_interval_b.upper)
					else
							-- Add new interval
						interval_b := next_interval_b
						tmp.extend (interval_b)
					end
					j := j + 1
				end
				create Result
				Result.set_interval (tmp)
				if compound /= Void then
					Result.set_compound (compound.byte_node)
				end
				Result.set_line_number (interval.start_location.line)
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
