indexing
	description: "Intervals between absolute values"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class INTERVAL [G -> ABSOLUTE] inherit

	PART_COMPARABLE
		redefine
			is_equal, 
			infix "<=",
			infix ">=",
			infix "<",
			infix ">",
			out
		select
			infix ">", 
			infix "<", 
			infix ">=", 
			infix "<="
		end
		
	PART_COMPARABLE
		rename
			infix "<" as is_strict_included_by,
			infix ">" as strict_includes,
			infix "<=" as is_included_by,
			infix ">=" as includes
		redefine
			strict_includes, 
			is_included_by, 
			includes, 
			is_equal,
			out
		end

create 
	make

feature -- Initialization

	make (s, e: G) is
			-- Sets `start_bound' and `end_bound' to `s' and `e' respectively.
		require
			start_exists: s /= Void
			end_exists: e /= Void
			start_before_end: s <= e
		do
			start_bound := deep_clone (s)
			end_bound := deep_clone (e)
		ensure
			start_bound_set: start_bound /= Void and then 
				deep_equal (start_bound, s)
			end_bound_set: end_bound /= Void and then 
				deep_equal (end_bound, e)
		end

feature -- Access

	start_bound: G
			-- Start bound of the current interval
			
	end_bound: G
			-- End bound of the current interval
			
feature -- Measurement

	duration: DURATION is 
		-- Length of the interval 
	do
		Result := end_bound.duration - start_bound.duration 
	end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is current interval equal to `other'?
		do
			Result := start_bound.is_equal (other.start_bound) and then 
				end_bound.is_equal (other.end_bound)
		end
	
	intersects (other: like Current): BOOLEAN is
			-- Does current interval intersect `other'?
		require
			other_exists: other /= Void
		do
			Result := (start_bound.max (other.start_bound)) <= 
				(end_bound.min (other.end_bound))
		end
	
	infix "<" (other: like Current): BOOLEAN is
			-- Is current interval strictly before `other'?
		do
			Result := (Current.start_bound < other.start_bound) and then 
				(Current.end_bound < other.end_bound)
		end
	
	infix "<=" (other: like Current): BOOLEAN is
			-- Is current interval before `other'?
		do
			Result := (Current < other) or else (Current.is_equal (other))
		end

	infix ">" (other: like Current): BOOLEAN is
			-- Is current interval after `other'?
		do
			Result := (other < Current)
		end
	
	
	infix ">=" (other: like Current): BOOLEAN is
			-- Is current interval after `other'?
		do
			Result := (other <= Current)
		end
	
	is_strict_included_by (other: like Current): BOOLEAN is
			-- Is current interval strictly included by `other'?
		do
			Result := (start_bound > other.start_bound) and then 
				(end_bound < other.end_bound)
		end
	
	strict_includes (other: like Current): BOOLEAN is
			-- Does current interval strictly include `other'?
		do
			Result := other.is_strict_included_by (Current)
		end
	
	is_included_by (other: like Current): BOOLEAN is
			-- Is current interval included by `other'?
		do
			Result := (start_bound >= other.start_bound) and then 
				(end_bound <= other.end_bound)
		end
	
	includes (other: like Current): BOOLEAN is
			-- Does current interval include `other'?
		do
			Result := other.is_included_by (Current)
		end
	
	overlaps (other: like Current): BOOLEAN is
			-- Does current interval overlap `other'?
		require
			other_exists: other /= Void
		do
			Result := (end_bound >= other.start_bound) 
				and then (start_bound <= other.start_bound)
				and then (end_bound < other.end_bound)
		ensure
			result_defition: Result = (strict_before (other.end_bound) and 
				has (other.start_bound))
			symmetry: Result = other.is_overlapped_by (Current)
		end
	
	is_overlapped_by (other: like Current): BOOLEAN is
			-- Is current interval overlapped by `other'?
		require
			other_exists: other /= Void
		do
			Result := other.overlaps (Current)
		ensure
			symmetry: Result = other.overlaps (Current)
		end
	
	meets (other: like Current): BOOLEAN is
			-- Does current interval meet `other'?
		require
			other_exists: other /= Void
		do
			Result := end_bound.is_equal (other.start_bound)
		ensure
			symmetry: Result = other.is_met_by (Current)
			result_definition: Result = (Current <= other and 
					intersects (other)) 
		end
	
	is_met_by (other: like Current): BOOLEAN is
			-- Is current interval met by `other'?
		require
			other_exists: other /= Void
		do
			Result := other.meets (Current)
		ensure
			symmetry: Result = other.meets (Current)
		end
	
feature -- Status report

	empty: BOOLEAN is
			-- Is current interval empty?
		do
			Result := start_bound.is_equal (end_bound)
		ensure
			result_definition: Result = duration.is_equal (duration.zero)
		end
	
	has (v: G): BOOLEAN is
			-- Does current interval have `v' between its bounds?
		require
			exists: v /= Void
		do
			Result := (start_bound <= v) and then (end_bound >= v)
		ensure
			result_definition: Result xor not ((start_bound <= v) and then 
				(end_bound >= v))
		end
	
	strict_before (v: G): BOOLEAN is
			-- Is the current interval strictly before `v'?
		require
			exists: v /= Void
		do
			Result := (end_bound < v)
		ensure
			result_definition: Result xor (not (end_bound < v))
		end
	
	strict_after (v: G): BOOLEAN is
			-- Is the current interval strictly after `v'?
		require
			exists: v /= Void
		do
			Result := (start_bound > v)
		ensure
			result_definition: Result = (start_bound > v)
		end
	
	before (v: G): BOOLEAN is
			-- Is the current interval before `v'?
		require
			exists: v /= Void
		do
			Result := (end_bound <= v)
		ensure
			result_definition: Result = (end_bound <= v)
		end
	
	after (v: G): BOOLEAN is
			-- Is the current interval after `v'?
		require
			exists: v /= Void
		do
			Result := (start_bound >= v)
		ensure
			result_definition: Result = (start_bound >= v)
		end
	
feature -- Element change

	set_start_bound (s: G) is
				-- Set `start_bound' to `s'.
		require
			start_bound_exists: s /= Void
			start_before_end_bound: s <= end_bound
		do
			start_bound := deep_clone (s)
		ensure
			start_bound_set: equal (start_bound, s)
		end	

	set_end_bound (e: G) is
				-- Set `end_bound' to `e'.
		require
			end_bound_exists: e /= Void
			end_after_start_bound: e >= start_bound
		do
			end_bound := deep_clone (e)
		ensure
			end_bound_set: equal (end_bound, e)
		end	

feature -- Basic operations

	union (other: like Current): like Current is
			-- Union with `other'
		require
			other_exists: other /= Void
			intersects: intersects (other)
		do
			create Result.make (start_bound.min (other.start_bound), 
				end_bound.max (other.end_bound))
		ensure
			result_exists: Result /= Void
			result_includes_current: Result.includes (Current)
			result_includes_other: Result.includes (other)
		end
	
	intersection (other: like Current): like Current is
			-- Intersection with `other'
		require
			other_exists: other /= Void
		local
			s: G
			e: G
		do
			s := start_bound.max (other.start_bound)
			e := end_bound.min (other.end_bound)
			if s <= e then
				create Result.make (s, e)
			end
		ensure
			intersects_validity: intersects (other) implies Result /= Void
			result_is_included_by_current: intersects (other) implies 
				includes (Result)
			result_is_included_by_other: intersects (other) implies 
				other.includes (Result)
		end

	gather (other: like Current): like Current is
			-- Union of `other' and current interval if `other' meets 
			-- current interval
		require
			other_exist: other /= Void
			meeting_interval: meets (other)
		do
			create Result.make (start_bound, other.end_bound)
		ensure
			result_exist: Result /= Void
			result_same_as_union: Result.is_equal (union (other))
		end
	
feature -- Output
 
	out: STRING is 
			-- Printable representation of the current interval 
		do 
			Result := ("[");	
			Result.append (start_bound.out); 
			Result.append (" - "); 
			Result.append (end_bound.out); 
			Result.extend (']'); 
		end 
			
invariant

	start_bound_exists: start_bound /= Void
	end_bound_exists: end_bound /= Void
	start_bound_before_end_bound: start_bound <= end_bound
	current_intersection: intersection (Current).is_equal (Current)
	current_union: union (Current).is_equal (Current)
	has_bounds: has (start_bound) and has (end_bound)
	between_bound: after (start_bound) and before (end_bound)
	
end -- class INTERVAL


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

