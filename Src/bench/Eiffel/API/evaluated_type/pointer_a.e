indexing
	description: "Actual type for pointer type."
	date: "$Date$"
	revision: "$Revision $"

class POINTER_A

inherit
	BASIC_A
		redefine
			is_pointer, type_i, associated_class, same_as,
			internal_conform_to
		end

feature -- Property

	is_pointer: BOOLEAN is True
			-- Is the current type a pointer type ?

	associated_class: CLASS_C is
			-- Class POINTER
		once
			Result := System.pointer_class.compiled_class
		end

feature {COMPILER_EXPORTER}

	type_i: POINTER_I is
			-- Pointer C type
		do
			create Result
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_pointer
		end

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			if in_generics then
				Result := other.is_pointer
			else
				Result := {BASIC_A} precursor (other, False)
			end
		end

end -- class POINTER_A
