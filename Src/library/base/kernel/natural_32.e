indexing
	description: "Unsigned integer values coded on 32 bits."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	external_name: "System.UInt32"
	assembly: "mscorlib"
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class NATURAL_32 inherit

	NATURAL_32_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({NATURAL_32_REF}),
	to_real_32: {REAL},
	to_real_64: {DOUBLE},
	to_integer_64: {INTEGER_64},
	to_natural_64: {NATURAL_64}

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

end
