indexing
	description: "Actual type for real 32 bits type."
	date: "$Date$"
	revision: "$Revision $"

class REAL_32_A

inherit
	BASIC_A
		redefine
			is_real_32, associated_class, same_as, is_numeric,
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize new instance of REAL_32_A.
		do
			make (associated_class.class_id)
		end

feature -- Property

	is_real_32: BOOLEAN is True
			-- Is the current type a real 32 bits type ?

	associated_class: CLASS_C is
			-- Class REAL
		once
			Result := System.real_32_class.compiled_class
		end

feature {COMPILER_EXPORTER}

	is_numeric: BOOLEAN is True
			-- Is the current type a numeric type ?

	type_i: REAL_32_I is
			-- C type
		do
			Result := real32_c_type
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_real_32
		end

end -- class REAL_32_A
