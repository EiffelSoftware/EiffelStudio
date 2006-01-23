indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Single"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	REAL

inherit
	REAL_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({REAL_REF}),
	to_reference: {REAL_REF, NUMERIC, COMPARABLE, PART_COMPARABLE, HASHABLE, ANY},
	to_double: {DOUBLE}

feature -- Access

	frozen min_value: REAL is -3.402823E+38

	frozen epsilon: REAL is 1.401298E-45

	frozen max_value: REAL is 3.402823E+38;

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class REAL
