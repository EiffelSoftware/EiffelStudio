-- Actual type for integer type

class NONE_A

inherit

	BASIC_A
		redefine
			is_none, dump, type_i, associated_class, same_as,
			internal_conform_to
		end

feature

	is_none: BOOLEAN is
			-- Is the current type a none type ?
		do
			Result := True;
		end;

	dump: STRING is "NONE";
			-- Dumped trace

	type_i: NONE_I is
			-- Void C type
		once
			!!Result;
		end;

	associated_class: CLASS_C is
		do
			-- No associated class
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_none;
		end;

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			Result := True;
		end;

end
