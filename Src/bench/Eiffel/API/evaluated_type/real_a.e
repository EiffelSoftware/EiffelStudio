indexing

	description: 
		"Actual type for real type."
	date: "$Date$"
	revision: "$Revision $"

class REAL_A

inherit
	BASIC_A
		redefine
			is_real, associated_class, same_as, is_numeric, heaviest,
			internal_conform_to
		end

feature -- Property

	is_real: BOOLEAN is True
			-- Is the current type a real type ?

	associated_class: CLASS_C is
			-- Class REAL
		once
			Result := System.real_class.compiled_class
		end

feature {COMPILER_EXPORTER}

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			if in_generics then
				Result := other.is_real
			else
				Result := 	{BASIC_A} precursor (other, False)
							or else
							other.actual_type.is_double
			end
		end

	is_numeric: BOOLEAN is True
			-- Is the current type a numeric type ?

	heaviest (type: TYPE_A): TYPE_A is
			-- Heaviest numeric type for balancing rule
		do	
			if type.is_double then
				Result := type
			else
				Result := Current
			end
		end

	type_i: FLOAT_I is
			-- C type
		once
			Result := Float_c_type
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_real
		end

end -- class REAL_A
