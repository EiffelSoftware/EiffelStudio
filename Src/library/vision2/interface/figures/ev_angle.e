indexing
	description: "Angle accessable in either degrees or radians."
	keywords: "angle degrees radians"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ANGLE

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
	make_radians,
	make_degrees

feature -- initialization

	make_radians(r: REAL) is
			-- Create Current, 'r' is in radian
		do
			radians := r
		end

	make_degrees(r: REAL) is
			-- Create Current, 'r' is in degrees
		do
			radians := ((Pi*r)/Pi_in_degrees).truncated_to_real
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
		do
			create Result.make_radians (other.radians + radians)
		end

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		do
			create Result.make_radians (radians - other.radians)
		end

	infix "*" (r: REAL): like Current is
			-- Product by `r'
		do
			create Result.make_radians (radians * r)
		end

	infix "/" (r: REAL): like Current is
			-- Division by `other'
		require
			possible: r /= 0.0
		do
			create Result.make_radians (radians / r)
		end


	sine: REAL is
			-- Return the sine of Current.
		do
			Result := compute_sine(radians)
		end

	cosine: REAL is
			-- Return the cosine of Current.
		do
			Result := compute_cosine(radians)
		end

	tangent: REAL is
			-- Return the tangent corresponding to Current.
		require
			cosine_not_nul: cosine /= 0.0
		do
			Result := compute_tangent(radians)
		end
	
feature -- Access

	radians: REAL
			-- Value of Current, in radians.
	
	degrees: REAL is
			-- value of Current in degrees
		do
			if value /= 0.0 then
				Result := Pi_in_degrees*(radians/Pi).truncated_to_real
			end
		end

feature {NONE} -- Implementation constants

	Pi_in_degrees: REAL is 180.0
			-- Pi radians in degrees

end -- class EV_ANGLE
