indexing
	description: "Actual type for real 64 bits type."
	date: "$Date$"
	revision: "$Revision $"

class REAL_64_A

inherit
	BASIC_A
		redefine
			is_real_64, associated_class, same_as,
			is_numeric, default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize new instance of REAL_64_A.
		do
			make (associated_class.class_id)
		end

feature -- Property

	is_real_64: BOOLEAN is True
			-- Is the current type a real 64 bits type ?

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_real_64
		end

	associated_class: CLASS_C is
			-- Class DOUBLE
		once
			Result := System.real_64_class.compiled_class
		end

feature {COMPILER_EXPORTER}

	is_numeric: BOOLEAN is True
			-- Is the current type a numeric type ?

	type_i: REAL_64_I is
			-- C type
		do
			Result := real64_c_type
		end

end -- class REAL_64_A
