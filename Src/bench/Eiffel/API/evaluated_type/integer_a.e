indexing
	description: "Actual type for integer type."
	date: "$Date$"
	revision: "$Revision $"

class
	INTEGER_A

inherit
	BASIC_A
		redefine
			is_integer, associated_class,
			same_as, is_numeric, heaviest, internal_conform_to
		end

feature -- Property

	is_integer: BOOLEAN is True
			-- Is the current type an integer type ?

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_integer
		end

	associated_class: CLASS_C is
			-- Class INTEGER
		once
			Result := System.integer_class.compiled_class
		end

feature {COMPILER_EXPORTER}

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			if in_generics then
				Result := other.is_integer
			else
				Result := {BASIC_A} precursor (other, False)
							or else
							other.is_real
							or else
							other.is_double
			end
		end

	is_numeric: BOOLEAN is True
			-- Is the current type a numeric type ?

	heaviest (type: TYPE_A): TYPE_A is
			-- Heaviest numeric type for balancing rule
		do	
			Result := type
		end

	type_i: LONG_I is
			-- C type
		once
			Result := Long_c_type
		end

end -- class INTEGER_A
