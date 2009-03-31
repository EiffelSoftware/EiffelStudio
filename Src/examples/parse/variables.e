note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Variable lists

class VARIABLES

inherit

	REPETITION
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
			Result := "VARIABLES"
		end -- construct_name

feature {NONE}

	separator: STRING = ";"

feature

	production: LINKED_LIST [CONSTRUCT]
		local
			base: VAR
		once
			create Result.make
			Result.forth
			create base.make
			put (base)
		end; -- production

	post_action
		local
			l_child: like child
		do
			if not no_components then
				from
					child_start
				until
					child_after
				loop
					l_child := child
					check l_child /= Void end -- Implied by `child_after'
					l_child.post_action
					child_forth
				end
			end
		end -- post_action

feature {VARIABLES} -- Implementation

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


end -- class VARIABLES

