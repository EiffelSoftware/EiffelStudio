indexing
	description: "Actual type for real type."
	date: "$Date$"
	revision: "$Revision $"

class DOUBLE_A

inherit
	BASIC_A
		redefine
			is_double, associated_class, same_as,
			is_numeric, heaviest, internal_conform_to,
			associated_eclass
		end

feature -- Property

	is_double: BOOLEAN is True
			-- Is the current type a double type ?

feature -- Access

	associated_eclass: CLASS_C is
			-- Associated eiffel class
		once
			Result := System.double_class.compiled_class
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_double
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

	heaviest (type: TYPE_A): TYPE_A is
			-- Heaviest numeric type for balancing rule
		do	
			Result := Current
		end

	type_i: DOUBLE_I is
			-- C type
		once
			Result := Double_c_type
		end

	associated_class: CLASS_C is
			-- Class DOUBLE
		require else
			double_class_compiled: System.double_class.compiled
		once
			Result := System.double_class.compiled_class
		end

end -- class DOUBLE_A
