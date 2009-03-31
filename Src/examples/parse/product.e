note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Products: Term "*" Term "*" ... "*" Term

class
	PRODUCT

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
			Result := "PRODUCT"
		end

feature {NONE}

	separator: STRING = "*"

feature

	production: LINKED_LIST [CONSTRUCT]
		local
			base: TERM
		once
			create Result.make
			Result.forth
			create base.make
			put (base)
		end -- production

	post_action
		local
			int_value: INTEGER
			l_child: like child
		do
			if not no_components then
				from
					child_start
					if not child_after then
						int_value := 1
					end
				until
					child_after
				loop
					l_child := child
					check l_child /= Void end -- Implied from `child_after'.
					l_child.post_action
					int_value := int_value * info.child_value
					child_forth
				end;
				info.set_child_value (int_value)
			end
		end -- post_action

feature {PRODUCT} -- Implementation

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


end -- class PRODUCT

