-- VOID actual type

class VOID_A

inherit

	TYPE_A
		redefine
			is_void, same_as
		end

feature

	is_void: BOOLEAN is
			-- Is the current actual type a void type ?
		do
			Result := True;
		end; -- is_void

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			Result := other.actual_type.is_void;
		end;

	dump: STRING is "Void";
			-- Dumped trace

	type_i: VOID_I is
			-- Void type
		once
			!!Result;
		end;

	associated_class: CLASS_C is
		do
			-- No associated calss
		end;

	create_info: CREATE_INFO is
		do
			-- Do nothing
		ensure then
			False
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is `other' the same as Current ?
		do
			Result := other.is_void
		end;

end
