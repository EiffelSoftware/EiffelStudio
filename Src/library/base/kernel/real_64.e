indexing
	description: "Real values, double precision"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	external_name: "System.Double"
	assembly: "mscorlib"
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class REAL_64 inherit

	DOUBLE_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({DOUBLE_REF}),
	to_reference: {DOUBLE_REF, NUMERIC, COMPARABLE, PART_COMPARABLE, HASHABLE, ANY},
	truncated_to_real: {REAL}

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

end -- class REAL_64
