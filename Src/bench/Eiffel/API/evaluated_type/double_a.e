-- Actual type for real type

class DOUBLE_A

inherit

	BASIC_A
		rename
			internal_conform_to as old_conform_to
		redefine
			is_double, associated_class, same_as,
			is_numeric, heaviest, associated_eclass
		end;
	BASIC_A
		redefine
			is_double, associated_class, same_as,
			is_numeric, heaviest, internal_conform_to,
			associated_eclass
		select
			internal_conform_to
		end

feature -- Access

	is_double: BOOLEAN is
			-- Is the current type a double type ?
		do
			Result := True;
		end;

	associated_eclass: E_CLASS is
			-- Associated eiffel class
		once
			Result := associated_class.e_class;
				--- **** TO BE FIXED System should not
				-- have COMPILED class but E_CLASS
		end;

feature

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			if in_generics then
				Result := other.is_double;
			else
				Result := old_conform_to (other, False) or else
				other.actual_type.is_real
			end;
		end;

	is_numeric: BOOLEAN is
			-- Is the current type a numeric type ?
		do
			Result := True;
		end;

	heaviest (type: TYPE_A): TYPE_A is
			-- Heaviest numeric type for balancing rule
		do	
			Result := Current
		end;

	type_i: DOUBLE_I is
			-- C type
		once
			Result := Double_c_type;
		end;

	associated_class: CLASS_C is
			-- Class DOUBLE
		require else
			double_class_compiled: System.double_class.compiled
		once
			Result := System.double_class.compiled_class;
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_double;
		end

end
