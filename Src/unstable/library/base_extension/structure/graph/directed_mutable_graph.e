note
	description: "Directed mutable graph"
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTED_MUTABLE_GRAPH [V -> HASHABLE]

inherit
	DIRECTED_GRAPH [V]

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			create vertices.make (0)
			create internal_out_bound_vertices.make (0)
		end

feature -- Element Change

	add_connection (a_vertex, a_out_bound_vertex: V)
			-- Add connection to the graph
		local
			l_out_bounds: SEARCH_TABLE [V]
		do
			vertices.force (a_vertex)
			vertices.force (a_out_bound_vertex)
			if attached internal_out_bound_vertices.item (a_vertex) as l_table then
				l_out_bounds := l_table
			else
				create l_out_bounds.make (5)
				internal_out_bound_vertices.force (l_out_bounds, a_vertex)
			end
			l_out_bounds.force (a_out_bound_vertex)
		end

feature -- Access

	vertices: SEARCH_TABLE [V]
			-- Vertices

	out_bound_vertices (v: V): ITERABLE [V]
			-- <Precursor>
		do
			if attached internal_out_bound_vertices.item (v) as l_result then
				Result := l_result
			else
				Result := create {ARRAYED_LIST [V]}.make (0)
			end
		end

feature {NONE} -- Implementation

	internal_out_bound_vertices: HASH_TABLE [SEARCH_TABLE [V], V];
			-- Internal out bound vertices table

note
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
