indexing
	description: "Actual type for real type."
	date: "$Date$"
	revision: "$Revision $"

class DOUBLE_A

inherit
	BASIC_A
		redefine
			is_double, associated_class, same_as,
			is_numeric, default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize new instance of DOUBLE_A.
		do
			make (associated_class.class_id)
		end

feature -- Property

	is_double: BOOLEAN is True
			-- Is the current type a double type ?

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_double
		end

	associated_class: CLASS_C is
			-- Class DOUBLE
		once
			Result := System.double_class.compiled_class
		end

feature {COMPILER_EXPORTER}

	is_numeric: BOOLEAN is True
			-- Is the current type a numeric type ?

	type_i: DOUBLE_I is
			-- C type
		do
			Result := double_c_type
		end

end -- class DOUBLE_A
