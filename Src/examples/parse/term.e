note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Terms: SIMPLE_VAR | POLY_INTEGER | NESTED

class
	TERM

inherit

	CHOICE
		redefine
			post_action
		end

	POLYNOM
		undefine
			copy, is_equal
		end

create
	make

feature

	construct_name: STRING
		once
			Result := "TERM"
		end -- construct_name

	production: LINKED_LIST [CONSTRUCT]
		local
			id: SIMPLE_VAR;
			val: POLY_INTEGER;
			nest: NESTED
		once
			create Result.make
			Result.forth
			create id.make
			put (id)
			create val.make
			put (val)
			create nest.make
			put (nest)
		end -- production

	post_action
		do
			if attached retained as l_retained then
				l_retained.post_action
			end
		end -- post_action

feature {TERM} -- Implementation

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


end -- class TERM

