--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Angle accessable in either degrees or radians."
	keywords: "angle degrees radians"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ANGLE

obsolete
	"Will be removed. Do not use anymore."

inherit
	EV_ANGLE_ROUTINES
		rename
			tangent as compute_tangent,
			sine as compute_sine,
			cosine as compute_cosine
		redefine
			is_equal
		end

creation
	default_create,
	make_radians,
	make_degrees

feature -- initialization

	make_radians(r: REAL) is
			-- Create Current, 'r' is in radian
			-- Any real value is valid
		do
			radians := r
		ensure
			angle_set: radians = r
		end

	make_degrees(r: REAL) is
			-- Create Current, 'r' is in degrees
			-- Any real value is valid
		do
			set_degrees (r)
		ensure
			(degrees - r).abs < Error_margin
		end

feature -- Comparisons

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := (other.radians = radians)
		end

feature -- Operations

	infix "+" (other: like Current): like Current is
			-- Sum with `other'
		require
			other_not_void: other /= Void
		do
			create Result.make_radians (other.radians + radians)
		ensure
			sum_computed: Result.radians = radians + other.radians
		end

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		require
			other_not_void: other /= Void
		do
			create Result.make_radians (radians - other.radians)
		ensure
			difference_computed: Result.radians = radians - other.radians
		end

	infix "*" (r: REAL): like Current is
			-- Product by `r'
		require
			other_not_void: r /= Void
		do
			create Result.make_radians (radians * r)
		ensure
			product_computed: Result.radians = radians * r
		end

	infix "/" (r: REAL): like Current is
			-- Division by `other'
		require
			possible: r /= 0.0
		do
			create Result.make_radians (radians / r)
		ensure
			division_computed: Result.radians = radians / r
		end


	sine: REAL is
			-- Return the sine of Current.
		do
			Result := compute_sine(radians)
		ensure
			sine_within_range: Result.abs <= 1.0
		end

	cosine: REAL is
			-- Return the cosine of Current.
		do
			Result := compute_cosine(radians)
		ensure
			cosine_within_range: Result.abs <= 1.0
		end

	tangent: REAL is
			-- Return the tangent corresponding to Current.
		require
			cosine_not_nul: cosine /= 0.0
		do
			Result := compute_tangent(radians)
		ensure
			tangent_within_range: Result /= 0.0
		end
	
feature -- Access

	radians: REAL
			-- Value of Current, in radians.

	set_radians (r: REAL) is
			-- Set Create to 'r' radians
			-- Any real value is valid
		do
			radians := r
		ensure
			angle_set: radians = r
		end
	
	degrees: REAL is
			-- value of Current in degrees
		do
			if radians /= 0.0 then
				Result := Pi_in_degrees*(radians/Pi).truncated_to_real
			end
		end

	set_degrees (r: REAL) is
			-- Set Create to 'r' degrees
			-- Any real value is valid
		do
			radians := ((Pi*r)/Pi_in_degrees).truncated_to_real
		ensure
			angle_set: (degrees - r).abs < Error_margin
		end
	

feature {NONE} -- Implementation constants

	Pi_in_degrees: REAL is 180.0
			-- Pi radians in degrees

	Error_margin: REAL is 
			-- 1/1000th of an arc.
		do
			Result := Pi / 1000	
		end

invariant
	units_consistant: (radians - (degrees*Pi)/Pi_in_degrees).abs < Error_margin
			-- Ensure that the two units agree to withing 1/1000th of an arc

end -- class EV_ANGLE

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2000/02/18 23:16:50  brendel
--| Added obsolete clause.
--|
--| Revision 1.10  2000/02/18 17:28:12  brendel
--| Unreleased.
--| May still be in system. Use REAL anywhere you find this class.
--|
--| Revision 1.9  2000/02/14 11:40:46  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.4.2.2.4  2000/02/08 00:58:43  oconnor
--| added default_create
--|
--| Revision 1.7.4.2.2.3  2000/02/04 07:52:36  oconnor
--| released
--|
--| Revision 1.7.4.2.2.2  2000/01/27 19:30:32  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.4.2.2.1  1999/11/24 17:30:37  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
