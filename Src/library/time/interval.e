indexing
	description: "Interval of G"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	INTERVAL [G -> ABSOLUTE]

inherit
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
		end;
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
			s_exists: s /= Void;
			e_exists: e /= Void;
			s_before_e: s <= e
		do
			start_bound := deep_clone (s);
			end_bound := deep_clone (e)
		ensure
			start_bound_set: start_bound /= Void
				and then deep_equal (start_bound, s);
			end_bound_set: end_bound /= Void
				and then deep_equal (end_bound, e)
		end;

feature -- Access

	start_bound: G;
			-- Start bound of the current interval
			
	end_bound: G;
			-- End bound of the current interval
			
feature -- Measurement

		duration: DURATION is 
			-- lenght of the interval 
		do
			Result := end_bound.duration - start_bound.duration 
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Are the current interval an `other' the same interval?
		do
			Result := start_bound.is_equal (other.start_bound) and then end_bound.is_equal (other.end_bound)
		end;
	
	intersects (other: like Current): BOOLEAN is
			-- Does the current interval intersect `other'?
		require
			other_exists: other /= Void
		do
			Result := (start_bound.max (other.start_bound)) <= (end_bound.min (other.end_bound))
		end;
	
	infix "<" (other: like Current): BOOLEAN is
			-- Is the current interval strictly before `other'?
		do
			Result := (Current.start_bound < other.start_bound) 
				and then (Current.end_bound < other.end_bound)
		end;
	
	infix "<=" (other: like Current): BOOLEAN is
			-- Is the current interval before `other'?
		do
			Result := (Current < other) or else (Current.is_equal (other))
		end;

	infix ">" (other: like Current): BOOLEAN is
			-- Is the current interval after `other'?
		do
			Result := (other < Current)
		end;
	
	
	infix ">=" (other: like Current): BOOLEAN is
			-- Is the current interval after `other'?
		do
			Result := (other <= Current)
		end;
	
	is_strict_included_by (other: like Current): BOOLEAN is
			-- Is the current interval strictly includded by `other'?
		do
			Result := (start_bound > other.start_bound) and then (end_bound < other.end_bound)
		end;
	
	strict_includes (other: like Current): BOOLEAN is
			-- Does the current interval strictly include `other'?
			-- This feature will be removed when the repeated inheritance bug will be fixed.
		do
			Result := other.is_strict_included_by (Current)
		end;
	
	is_included_by (other: like Current): BOOLEAN is
			-- Is the current interval includded by `other'?
		do
			Result := (start_bound >= other.start_bound) and then (end_bound <= other.end_bound)
		end;
	
	includes (other: like Current): BOOLEAN is
			-- Does the current interval include `other'?
			-- This feature will be removed when the repeated inheritance bug will be fixed
		do
			Result := other.is_included_by (Current)
		end;
	
	overlaps (other: like Current): BOOLEAN is
			-- Does the current interval overlaps `other'?
		require
			other_exists: other /= Void
		do
			Result := (end_bound >= other.start_bound) 
				and then (start_bound <= other.start_bound)
				and then (end_bound < other.end_bound)
		ensure
			result_defition: Result = (strict_before (other.end_bound) and has (other.start_bound))
			symetry: Result = other.is_overlapped_by (Current)
		end;
	
	is_overlapped_by (other: like Current): BOOLEAN is
			-- Is the current interval overlapped by `other'?
		require
			other_exists: other /= Void
		do
			Result := other.overlaps (Current)
		ensure
			symetry: Result = other.overlaps (Current)
		end;
	
	meets (other: like Current): BOOLEAN is
			-- Does the current interval meet `other'?
		require
			other_exists: other /= Void
		do
			Result := end_bound.is_equal (other.start_bound)
		ensure
			symetry: Result = other.is_met_by (Current);
			result_definition: Result = (Current <= other and intersects (other)) 
		end;
	
	is_met_by (other: like Current): BOOLEAN is
			-- Is the current interval met by `other'?
		require
			other_exists: other /= Void
		do
			Result := other.meets (Current)
		ensure
			symetry: Result = other.meets (Current);
		end;
	
feature -- Status report

	empty: BOOLEAN is
			-- Is the current interval empty?
		do
			Result := start_bound.is_equal (end_bound)
		ensure
			result_definition: Result = duration.is_equal(duration.zero)
		end;
	
	has (g: G): BOOLEAN is
			-- Does the current interval have `g' between its bounds?
		require
			g_exist: g /= Void
		do
			Result := (start_bound <= g) and then (end_bound >= g)
		ensure
			result_definition: Result xor not ((start_bound <= g) and then (end_bound >= g))
		end;
	
	strict_before (g: G): BOOLEAN is
			-- Is the current interval strictly before `g'?
		require
			g_exist: g /= Void
		do
			Result := end_bound < g
		ensure
			result_definition: Result xor (not (end_bound < g))
		end;
	
	strict_after (g: G): BOOLEAN is
			-- Is the current interval strictly after `g'?
		require
			g_exist: g /= Void
		do
			Result := start_bound > g
		ensure
			result_definition: Result = (start_bound > g)
		end;
	
	before (g: G): BOOLEAN is
			-- Is the current interval before `g'?
		require
			g_exist: g /= Void
		do
			Result := end_bound <= g
		ensure
			result_definition: Result = (end_bound <= g)
		end;
	
	after (g: G): BOOLEAN is
			-- Is the current interval after `g'?
		require
			g_exist: g /= Void
		do
			Result := start_bound >= g
		ensure
			result_definition: Result = (start_bound >= g)
		end;
	
feature -- Element change

	set_start_bound (s: G) is
				-- Set `start_bound' to `s'.
		require
			s_before_end_bound: s /= Void and then s <= end_bound
		do
			start_bound := deep_clone (s)
		ensure
			start_bound_set: start_bound /= Void
				and then start_bound.is_equal (s)
		end	

	set_end_bound (e: G) is
				-- Set `end_bound' to `e'.
		require
			e_after_end_bound: e /= Void and then e >= start_bound
		do
			end_bound := deep_clone (e)
		ensure
			end_bound_set: end_bound /= Void
				and then end_bound.is_equal (e)							
		end	

feature -- Conversion 
 
	out: STRING is 
			-- Printable representation of the current interval 
		do 
			Result := ("[");	
			Result.append (start_bound.out); 
			Result.append (" - "); 
			Result.append (end_bound.out); 
			Result.extend (']'); 
		end 
			
feature -- Basic operations

	union (other: like Current): like Current is
			-- Union with `other'
		require
			other_exists: other /= Void;
			intersects: intersects (other)
		do
			create Result.make (start_bound.min (other.start_bound), end_bound.max (other.end_bound))
		ensure
			result_exists: Result /= Void;
			result_includes_current: Result.includes (Current);
			result_includes_other: Result.includes (other)
		end;
	
	intersection (other: like Current): like Current is
			-- Intersection with `other'
		require
			other_exists: other /= Void
		local
			s, e: G
		do
			s := start_bound.max (other.start_bound);
			e := end_bound.min (other.end_bound);
			if s <= e then
				create Result.make(s, e)
			end
		ensure
			intersects_validity: intersects (other) implies Result /= Void;
			result_is_included_by_current: intersects (other) implies includes (Result);
			result_is_included_by_other: intersects (other) implies other.includes (Result)
		end;

	gather (other: like Current): like Current is
			-- Union of `other' and current interval if `other' meets current interval
		require
			other_exist: other /= Void;
			meeting_interval: meets (other)
		do
			create Result.make (start_bound, other.end_bound)
		ensure
			result_exist: Result /= Void;
			result_same_as_union: Result.is_equal (union (other))
		end;
	
invariant
	start_bound_exists: start_bound /= Void;
	end_bound_exists: end_bound /= Void;
	start_bound_before_end_bound: start_bound <= end_bound;
	current_intersection: intersection (Current).is_equal (Current);
	current_union: union (Current).is_equal (Current);
	has_bounds: has (start_bound) and has (end_bound);
	between_bound: after (start_bound) and before (end_bound);
	
end -- class INTERVAL


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


