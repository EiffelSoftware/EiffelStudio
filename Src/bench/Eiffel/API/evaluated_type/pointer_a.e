-- Actual type for pointer type

class POINTER_A

inherit

	BASIC_A
		rename
			internal_conform_to as old_conform_to
		redefine
			is_pointer, type_i, associated_class, same_as,
			associated_eclass
		end;
	BASIC_A
		redefine
			is_pointer, type_i, associated_class, same_as,
			internal_conform_to, associated_eclass
		select
			internal_conform_to
		end

feature -- Properties

	is_pointer: BOOLEAN is
			-- Is the current type a pointer type ?
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

	type_i: POINTER_I is
			-- Pointer C type
		once
			!!Result
		end;

	associated_class: CLASS_C is
			-- Class POINTER
		require else
			pointer_compiled: System.pointer_class.compiled
		once
			Result := System.pointer_class.compiled_class;
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_pointer;
		end;

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			if in_generics then
				Result := other.is_pointer;
			else
				Result := old_conform_to (other, False);
			end;
		end;

end
