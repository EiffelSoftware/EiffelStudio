indexing
	description: "Angle"
	author: "pascalf"
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
		undefine
			is_equal
		end

creation
	make, make_in_degrees

feature -- initialization

	make(r: REAL) is
		-- Create Current, 'r' is in radian
		do
			value := r
		end

	make_in_degrees(r: REAL) is
		-- Create Current, 'r' is in degrees
		do
				value := ((Pi*r)/180.0).truncated_to_real
		end

feature -- Comparisons

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := (other.value = value)
		end

feature -- Operations

	infix "+" (other: like Current): like Current is
			-- Sum with `other'
		do
			Create Result.make(other.value + value)
		end

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		do
			Create Result.make(value - other.value)
		end

	infix "*" (r: REAL): like Current is
			-- Product by `r'
		do
			Create Result.make (value * r)
		end

	infix "/" (r: REAL): like Current is
			-- Division by `other'
		require
			possible: r /= 0.0
		do
			Create Result.make (value / r)
		end


	sine: REAL is
			-- Return the sine of Current.
		do
			Result := compute_sine(value)
		end

	cosine: REAL is
			-- Return the cosine of Current.
		do
			Result := compute_cosine(value)
		end

	tangent: REAL is
			-- Return the tangent corresponding to Current.
		require
			cosine_not_nul: cosine /= 0.0
		do
			Result := compute_tangent(value)
		end
	
feature -- Access

	radians: REAL is
			-- value of Current in radians
		do
			Result := value
		end
	
	degrees: REAL is
			-- value of Current in degrees
		do
			if value /= 0.0 then
				Result := 180*(value/Pi).truncated_to_real
			end
		end
	
feature {EV_ANGLE} -- Implementation

	value: REAL
		-- Value of Current, in radians.

end -- class EV_ANGLE
