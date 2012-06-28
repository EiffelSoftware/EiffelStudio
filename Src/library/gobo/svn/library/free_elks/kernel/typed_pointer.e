note
	description: "[
		References to objects containing reference to object
		meant to be exchanged with non-Eiffel software.
		]"
	assembly: "mscorlib"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2004, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class TYPED_POINTER [G]

inherit
	POINTER_REF
		rename
			item as to_pointer
		end

convert
	to_pointer: {POINTER}

end
