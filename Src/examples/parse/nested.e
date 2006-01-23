indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Parenthesized expressions: "(" SUM ")"

class NESTED 

inherit

	AGGREGATE
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
			Result := "NESTED"
		end; -- construct_name

	production: LINKED_LIST [CONSTRUCT] is
		local
			expression: SUM
		once
			create Result.make
			Result.forth
			keyword ("(")
			commit
			create expression.make
			put (expression)
			keyword (")")
		end -- production

	post_action is
		do       
			child_start
			child_forth
			child.post_action
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


end -- class NESTED

