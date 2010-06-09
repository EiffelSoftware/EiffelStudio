note
	description: "Perform a pre/post actions on each node of a BYTE_NODE tree using agents."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BYTE_NODE_ANNOTATOR

inherit
	BYTE_NODE_ITERATOR
		redefine
			preorder_process,
			postorder_process
		end

create
	make

feature {NONE} -- Initialization

	make (pre, post: detachable ROUTINE [ANY, TUPLE [BYTE_NODE]])
			-- Initialize `pre_actions' and `post_actions' with `pre' and `post'. Those
			-- actions will be called each time a byte node will be processed
		do
			pre_actions := pre
			post_actions := post
		ensure
			pre_actions_set: pre_actions = pre
			post_actions_set: post_actions = post
		end

feature -- Actions

	pre_actions: detachable ROUTINE [ANY, TUPLE [BYTE_NODE]]
	post_actions: detachable ROUTINE [ANY, TUPLE [BYTE_NODE]]
			-- Actions to be called by `preorder_process' and `postorder_process'.

feature -- Code iterator routine

	preorder_process (a_node: BYTE_NODE)
			-- Perform an action on `a_node' before processing any child of `a_node'.
		do
			if attached pre_actions as l_actions then
				l_actions.call ([a_node])
			end
		end

	postorder_process (a_node: BYTE_NODE)
			-- Perform an action on `a_node' after processing any child of `a_node'.
		do
			if attached post_actions as l_actions then
				l_actions.call ([a_node])
			end
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
