-- Actual type for integer type

class INTEGER_A

inherit

	BASIC_A
		rename
			internal_conform_to as old_conform_to
		redefine
			is_integer, associated_class,
			same_as, is_numeric, heaviest
		end;
	BASIC_A
		redefine
			is_integer, associated_class,
			same_as, is_numeric, heaviest, internal_conform_to
		select
			internal_conform_to
		end

feature

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			if in_generics then
				Result := other.is_integer;
			else
				Result := 	old_conform_to (other, False)
							or else
							other.is_real
							or else
							other.is_double;
			end;
		end;

	is_integer: BOOLEAN is
			-- Is the current type an integer type ?
		do
			Result := True;
		end;

	is_numeric: BOOLEAN is
			-- Is the current type a numeric type ?
		do
			Result := True;
		end;

	heaviest (type: TYPE_A): TYPE_A is
			-- Heaviest numeric type for balancing rule
		do	
			Result := type;
		end;

	type_i: LONG_I is
			-- C type
		once
			Result := Long_c_type;
		end;

	associated_class: CLASS_C is
			-- Class INTEGER
		require else
			integer_class_compiled: System.integer_class.compiled;
		once
			Result := System.integer_class.compiled_class;
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_integer;
		end;

end
