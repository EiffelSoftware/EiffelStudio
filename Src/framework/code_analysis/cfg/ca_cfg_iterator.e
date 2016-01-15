note
	description: "Skeleton for a fixed point iteration through a CFG."
	date: "$Date: 2014-02-04 20:47:25 +0400$"
	revision: "$Revision$"

deferred class
	CA_CFG_ITERATOR

feature -- Status report

	is_ready: BOOLEAN
			-- Is current object ready for processing?
		deferred
		end

feature -- Iteration

	process_cfg (a_cfg: attached CA_CONTROL_FLOW_GRAPH)
			-- Iterate through `a_cfg'.
		require
			is_ready: is_ready
		deferred
		end

	initialize_processing (a_cfg: attached CA_CONTROL_FLOW_GRAPH)
			-- Perform initialization before running the worklist algorithm.
		require
			is_ready: is_ready
		deferred
		end

	visit_edge (a_from, a_to: attached CA_CFG_BASIC_BLOCK): BOOLEAN
			-- Visit edge from `a_from' to `a_to'. Continue iteration iff Result is
			-- true.
		deferred
		end

feature {NONE} -- Implementation

	worklist: LINKED_QUEUE [TUPLE [fr, to: CA_CFG_BASIC_BLOCK]]
		-- Worklist with nodes whose processing is still due.

;note
	copyright: "Copyright (c) 2016, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
