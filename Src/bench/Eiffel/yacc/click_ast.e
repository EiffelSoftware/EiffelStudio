indexing
	description:
		"To be filled from parser with start, end position and reference to AST,%N%
		%AST being STONABLE."
	date: "$Date$"
	revision: "$Revision$"

class
	CLICK_AST 

create
	initialize

feature {NONE} -- Initialization

	initialize (n: like node; l, s, e: INTEGER) is
			-- Create a new clickable element for `n'.
		require
			n_not_void: n /= Void
		do
			node := n
			start_line_number := l
			start_position := s
			end_position := e
		ensure
			node_set: node = n
			start_line_number_set: start_line_number = l
			start_position_set: start_position = s
			end_position_set: end_position = e
		end

feature -- Access

	start_line_number: INTEGER
			-- Line number of clickable.

	start_position: INTEGER
			-- Start position of clickable.

	end_position: INTEGER
			-- End position of clickable.

	node: CLICKABLE_AST
			-- Node AST that has a position.

feature -- Element change

	set_node (n: like node) is
			-- Set `node' to `n'.
		do
			node := n
		end

end -- class CLICK_AST
