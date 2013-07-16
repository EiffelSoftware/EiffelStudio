note
	description: "Directed graph"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIRECTED_GRAPH [V]

feature -- Access

	vertices: ITERABLE [V]
			-- Vertices
		deferred
		end

	out_bound_vertices (v: V): ITERABLE [V]
			-- Vertices lead away from the vertex `v'.
		deferred
		end

;note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
