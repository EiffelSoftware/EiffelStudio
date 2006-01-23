indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Integer constants, as used for polynomials

class POLY_INTEGER 

inherit

	INT_CONSTANT
		redefine
			action
		end

	POLYNOM
		undefine
			copy, is_equal
		end

create
	make

feature {NONE}

	action is
		do
			info.set_child_value (token.string_value.to_integer)
		end -- action

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class INT_CONSTANT

