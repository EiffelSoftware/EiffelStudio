indexing
	description: "Actual type for boolean type."
	date: "$Date$"
	revision: "$Revision $"

class BOOLEAN_A

inherit
	BASIC_A
		redefine
			is_boolean, type_i, associated_class, same_as,
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize new instance of BOOLEAN_A.
		do
			make (associated_class.class_id)
		end

feature -- Property

	is_boolean: BOOLEAN is True
			-- Is the current type a boolean type ?

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_boolean
		end

	associated_class: CLASS_C is
			-- Class BOOLEAN
		once
			Result := System.boolean_class.compiled_class
		end

feature {COMPILER_EXPORTER}

	type_i: BOOLEAN_I is
			-- C type
		do
			Result := boolean_c_type
		end

end -- class BOOLEAN_A
