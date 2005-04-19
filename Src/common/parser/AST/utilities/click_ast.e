indexing
	description:
		"To be filled from parser with start, end position and reference to AST,%N%
		%AST being STONABLE."
	date: "$Date$"
	revision: "$Revision$"

class
	CLICK_AST
	
inherit
	ANY
		redefine
			is_equal
		end
		
create
	initialize

feature {NONE} -- Initialization

	initialize (n: AST_EIFFEL; real_node: CLICKABLE_AST) is
			-- Create a new clickable element for syntaxic element `n' using `real_node'
			-- as associated clickable.
		require
			n_not_void: n /= Void
			real_node_not_void: real_node /= Void
		do
			node := real_node
			start_position := n.start_position
			end_position := n.end_position
		ensure
			node_set: node = real_node
			start_position_set: start_position = n.start_position
			end_position_set: end_position = n.end_position
		end

feature -- Access

	start_position: INTEGER
			-- Start position of clickable.

	end_position: INTEGER
			-- End position of clickable.

	node: CLICKABLE_AST
			-- Node AST that has a position.

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := start_position = other.start_position and 
				end_position = other.end_position and
				node.is_equivalent (other.node)
		end

invariant
	node_not_void: node /= Void

end -- class CLICK_AST
