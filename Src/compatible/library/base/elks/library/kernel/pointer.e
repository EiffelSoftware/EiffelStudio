note
	description: "References to objects meant to be exchanged with non-Eiffel software."
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class POINTER inherit

	POINTER_REF
		redefine
			hash_code,
			plus,
			to_integer_32,
			out
		end

create
	default_create,
	make_from_reference

convert
	make_from_reference ({POINTER_REF})

feature -- Access

	hash_code: INTEGER
			-- Hash code value
		external
			"built_in"
		end

feature -- Operations

	plus alias "+" (offset: INTEGER): POINTER
			-- Pointer moved by an offset of `offset' bytes.
		external
			"built_in"
		end

feature -- Conversion

	to_integer_32: INTEGER_32
			-- Convert `item' into an INTEGER_32 value.
		external
			"built_in"
		end

feature -- Output

	out: STRING
			-- Printable representation of pointer value
		external
			"built_in"
		end

end
