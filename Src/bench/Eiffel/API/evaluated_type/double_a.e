indexing
	description: "Actual type for real type."
	date: "$Date$"
	revision: "$Revision $"

class DOUBLE_A

inherit
	BASIC_A
		redefine
			is_double, associated_class, same_as,
			is_numeric, weight, internal_conform_to
		end

feature -- Property

	is_double: BOOLEAN is True
			-- Is the current type a double type ?

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_double
		end

	associated_class: CLASS_C is
			-- Class DOUBLE
		once
			Result := System.double_class.compiled_class
		end

feature {COMPILER_EXPORTER}

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			if in_generics then
				Result := other.is_double
			else
				Result := {BASIC_A} Precursor (other, False) 
					or else other.actual_type.is_real
			end
		end

	is_numeric: BOOLEAN is True
			-- Is the current type a numeric type ?

	weight: INTEGER is 16
			-- Weight of Current.
			-- Used to evaluate type of an expression with balancing rule.

	type_i: DOUBLE_I is
			-- C type
		once
			Result := Double_c_type
		end

end -- class DOUBLE_A
