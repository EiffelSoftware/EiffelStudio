indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Double"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DOUBLE

inherit
	DOUBLE_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({DOUBLE_REF}),
	to_reference: {DOUBLE_REF, NUMERIC, COMPARABLE, PART_COMPARABLE, HASHABLE, ANY},
	truncated_to_real: {REAL}

feature -- Access

	frozen min_value: DOUBLE is -1.79769313486232E+308

	frozen max_value: DOUBLE is 1.79769313486232E+308

	frozen epsilon: DOUBLE is 4.94065645841247E-324

end -- class DOUBLE
