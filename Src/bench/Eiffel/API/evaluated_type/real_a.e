-- Actual type for real type

class REAL_A

inherit

	BASIC_A
		rename
			internal_conform_to as old_conform_to
		redefine
			is_real, dump, associated_class, same_as, is_numeric, heaviest
		end;
	BASIC_A
		redefine
			is_real, dump, associated_class, same_as, is_numeric, heaviest,
			internal_conform_to
		select
			internal_conform_to
		end

feature

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			if in_generics then
				Result := other.is_real;
			else
				Result := 	old_conform_to (other, False)
							or else
							other.actual_type.is_double
			end;
		end;

	is_numeric: BOOLEAN is
			-- Is the current type a numeric type ?
		do
			Result := True;
		end;

	is_real: BOOLEAN is
			-- Is the current type a real type ?
		do
			Result := True;
		end;

	heaviest (type: TYPE_A): TYPE_A is
			-- Heaviest numeric type for balancing rule
		do	
			if type.is_double then
				Result := type
			else
				Result := Current
			end;
		end;

	dump: STRING is "REAL";
			-- Dumped trace

	type_i: FLOAT_I is
			-- C type
		once
			Result := Float_c_type;
		end;

	associated_class: CLASS_C is
			-- Class REAL
		require else
			real_class_compiled: System.real_class.compiled
		once
			Result := System.real_class.compiled_class;
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_real;
		end;

end
