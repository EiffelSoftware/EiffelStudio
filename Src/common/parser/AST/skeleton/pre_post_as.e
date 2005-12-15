indexing
	description:
		"[
			Objects that store pre and post terminals of a non-terminal structure.
			pre and post terminals often appear before and after a list.
			For example,
			Formal generic parameters: [ G, H -> STRING ]
			here, `[' is a pre terminal and `]' is a post terminal.

			Another example:
			Rename
				foo1 as goo1,
				foo2 as goo2
			...
			here, Rename is a pre terminal of the renamed feature list. and there is no
			post terminal here.

			This reason to store pre and post terminals into a list is in this way, we
			allow multiple pre- and post- terminals.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PRE_POST_AS

feature -- Extend operation

	extend_pre_as_list (l_as: AST_EIFFEL) is
			-- extend `l_as' in front of `pre_as_list'.
		do
			if pre_as_list = Void then
				create pre_as_list.make (initial_capacity)
			end
			pre_as_list.put_front (l_as)
		end

	extend_post_as_list (l_as: AST_EIFFEL) is
			-- extend `l_as' at the end of `post_as_list'.
		do
			if post_as_list = Void then
				create post_as_list.make (initial_capacity)
			end
			post_as_list.finish
			post_as_list.put_right (l_as)
		end

feature -- Access

	pre_as_list: EIFFEL_LIST [AST_EIFFEL]
		-- List to store terminals that appear in front of a non-terminal structure

	post_as_list: EIFFEL_LIST [AST_EIFFEL]
		-- List to store terminals that appear at the end of a non-terminal structure

feature{NONE} -- Implementation

	initial_capacity: INTEGER is 1
		-- Initial capacity of `pre_as_list' and `post_as_list'.
end
