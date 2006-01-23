indexing
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

	construct_name: STRING is
		once
			Result := "TERM"
		end -- construct_name

	production: LINKED_LIST [CONSTRUCT] is
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

	post_action is
		do
			retained.post_action
		end -- post_action

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


end -- class TERM

