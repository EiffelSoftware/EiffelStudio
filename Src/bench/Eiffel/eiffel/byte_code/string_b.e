indexing
	description: "Byte code for Eiffel string (allocated each time)."
	date: "$Date$"
	revision: "$Revision$"

class STRING_B 

inherit
	EXPR_B
		redefine
			enlarged, make_byte_code, generate_il,
			is_simple_expr, allocates_memory
		end

create
	make

feature {NONE} -- Initialization

	make (v: STRING) is
			-- Assign `v' to `value'.
		require
			v_not_void: v /= Void
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Access

	value: STRING
			-- Character value

feature -- Properties

	type: CL_TYPE_I is
			-- String type
		once
			create Result.make (System.string_id)
		end

	enlarged: STRING_BL is
			-- Enlarge node
		do
			create Result.make (value)
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- Register `r' is not used for string value computation
		do
		end

	is_simple_expr: BOOLEAN is True
			-- A string is a simple expression

	allocates_memory: BOOLEAN is True
			-- Current always allocates memory.

feature -- IL code generation

	generate_il is
			-- Generate IL code for a manifest string.
		do
			il_generator.put_manifest_string (value)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a manifest string
		do
			ba.append (Bc_string)
			ba.append_integer (value.count)
			ba.append_raw_string (value)
		end

invariant
	value_not_void: value /= Void

end -- class STRING_B
