indexing
	description: "Actual type for pointer type."
	date: "$Date$"
	revision: "$Revision$"

class POINTER_A

inherit
	BASIC_A
		redefine
			is_pointer, type_i, associated_class, same_as,
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize new instance of POINTER_A.
		do
			make (associated_class.class_id)
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
			Result := pointer_c_type
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_pointer
		end

end -- class POINTER_A
