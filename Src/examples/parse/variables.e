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

	production: LINKED_LIST [IDENTIFIER]
		local
			base: VAR
		once
			create Result.make
			Result.forth
			create base.make
			put (base)
		end; -- production

	post_action
		do
			if not no_components then
				from
					child_start
				until
					child_after
				loop
					child.post_action
					child_forth
				end
			end
		end -- post_action

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

