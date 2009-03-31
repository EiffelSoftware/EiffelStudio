note
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

feature {POLY_INTEGER} -- Implementation

	clone_node (n: like Current): like Current
			-- <precursor>
		do
			create Result.make
			Result.copy_node (n)
		end

	new_tree: like Current
			-- <precursor>
		do
			create Result.make
		end

feature {NONE}

	action
		local
			l_token: like token
		do
			l_token := token
			if l_token /= Void then
				info.set_child_value (l_token.string_value.to_integer)
			end
		end -- action

note
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

