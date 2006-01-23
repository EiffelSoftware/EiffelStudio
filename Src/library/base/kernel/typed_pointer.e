indexing
	description: "[
		References to objects containing reference to object
		meant to be exchanged with non-Eiffel software.
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	assembly: "mscorlib"
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class TYPED_POINTER [G]

inherit
	POINTER_REF
		rename
			item as pointer_item
		export
			{TYPED_POINTER} pointer_item
		end

convert
	to_pointer: {POINTER},
	to_reference: {POINTER_REF, HASHABLE, ANY}

feature -- Conversion

	to_pointer: POINTER is
			-- Convert to POINTER instance.
		do
			-- Built-in
		end

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
