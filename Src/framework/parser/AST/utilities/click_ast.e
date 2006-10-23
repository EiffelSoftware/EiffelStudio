indexing
	description:
		"To be filled from parser with start, end position and reference to AST,%N%
		%AST being STONABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CLICK_AST
