note
	description: "Summary description for {TEST_STRONGLY_CONNECTED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_STRONGLY_CONNECTED

inherit
	EQA_TEST_SET

feature -- Test

	test_empty_graph
			-- Empty graph
		local
			s: TARJAN_STRONGLY_CONNECTED_ALGORITHM [STRING]
			l_graph: DIRECTED_MUTABLE_GRAPH [STRING]
			l_components: ARRAYED_LIST [SEARCH_TABLE [STRING]]
		do
			create l_graph.make
			create s.make_with_graph (l_graph)
			s.compute_cycle
			l_components := s.cycles
			assert ("Emply graph has no connection", l_components.is_empty)
		end

	test_linear
			-- A->B->C
		local
			s: TARJAN_STRONGLY_CONNECTED_ALGORITHM [STRING]
			l_graph: DIRECTED_MUTABLE_GRAPH [STRING]
			l_components: ARRAYED_LIST [SEARCH_TABLE [STRING]]
			a, b, c: STRING
		do
			a := "A"
			b := "B"
			c := "C"

			create l_graph.make
			create s.make_with_graph (l_graph)
			l_graph.add_connection (a, b)
			l_graph.add_connection (b, c)
			s.set_graph (l_graph)
			s.compute_cycle
			l_components := s.cycles
			assert ("Has strong connected component", l_components.is_empty)
		end

	test_cycle2
			-- A↔B
		local
			s: TARJAN_STRONGLY_CONNECTED_ALGORITHM [STRING]
			l_graph: DIRECTED_MUTABLE_GRAPH [STRING]
			l_components: ARRAYED_LIST [SEARCH_TABLE [STRING]]
			a, b: STRING
		do
			a := "A"
			b := "B"

			create l_graph.make
			create s.make_with_graph (l_graph)
			l_graph.add_connection (a, b)
			l_graph.add_connection (b, a)
			s.set_graph (l_graph)
			s.compute_cycle
			l_components := s.cycles
			assert ("Has strong connected component", not l_components.is_empty)
		end

	test_cycle3
	        -- A→B
	        -- ↑ ↓
	        -- └─C
		local
			s: TARJAN_STRONGLY_CONNECTED_ALGORITHM [STRING]
			l_graph: DIRECTED_MUTABLE_GRAPH [STRING]
			l_components: ARRAYED_LIST [SEARCH_TABLE [STRING]]
			a, b, c: STRING
		do
			a := "A"
			b := "B"
			c := "C"

			create l_graph.make
			create s.make_with_graph (l_graph)
			l_graph.add_connection (a, b)
			l_graph.add_connection (b, c)
			l_graph.add_connection (c, a)
			s.set_graph (l_graph)
			s.compute_cycle
			l_components := s.cycles
			assert ("Has strong connected component", not l_components.is_empty)
			assert ("Has A", l_components.first.has (a))
			assert ("Has B", l_components.first.has (b))
			assert ("Has C", l_components.first.has (c))
		end

	test_independent_cycles
	        -- A→B
	        -- ↑ ↓
	        -- └─C
	        -- D→E
	        -- ↑ ↓
	        -- └─F
		local
			s: TARJAN_STRONGLY_CONNECTED_ALGORITHM [STRING]
			l_graph: DIRECTED_MUTABLE_GRAPH [STRING]
			l_components: ARRAYED_LIST [SEARCH_TABLE [STRING]]
			a, b, c, d, e, f: STRING
		do
			a := "A"
			b := "B"
			c := "C"
			d := "D"
			e := "E"
			f := "F"

			create l_graph.make
			create s.make_with_graph (l_graph)
			l_graph.add_connection (a, b)
			l_graph.add_connection (b, c)
			l_graph.add_connection (c, a)

			l_graph.add_connection (d, e)
			l_graph.add_connection (e, f)
			l_graph.add_connection (f, d)
			s.set_graph (l_graph)
			s.compute_cycle
			l_components := s.cycles
			assert ("Has strong connected component", l_components.count = 2)
			assert ("Has corrected numbers", l_components.first.count = 3)
			assert ("Has corrected numbers", l_components.last.count = 3)
			assert ("Element correct", l_components.first.has (a) xor l_components.last.has (a))
			assert ("Element correct", l_components.first.has (b) xor l_components.last.has (b))
			assert ("Element correct", l_components.first.has (c) xor l_components.last.has (c))
			assert ("Element correct", l_components.first.has (d) xor l_components.last.has (d))
			assert ("Element correct", l_components.first.has (e) xor l_components.last.has (e))
			assert ("Element correct", l_components.first.has (f) xor l_components.last.has (f))
		end

	test_cycle_with_stub
	        -- A→B
	        -- ↑ ↓
	        -- └─C→D
		local
			s: TARJAN_STRONGLY_CONNECTED_ALGORITHM [STRING]
			l_graph: DIRECTED_MUTABLE_GRAPH [STRING]
			l_components: ARRAYED_LIST [SEARCH_TABLE [STRING]]
			a, b, c, d: STRING
		do
			a := "A"
			b := "B"
			c := "C"
			d := "D"

			create l_graph.make
			create s.make_with_graph (l_graph)
			l_graph.add_connection (a, b)
			l_graph.add_connection (b, c)
			l_graph.add_connection (c, a)
			l_graph.add_connection (c, d)
			s.set_graph (l_graph)
			s.compute_cycle
			l_components := s.cycles
			assert ("Has strong connected component", not l_components.is_empty)
			assert ("Has A", l_components.first.has (a))
			assert ("Has B", l_components.first.has (b))
			assert ("Has C", l_components.first.has (c))
			assert ("No D", not l_components.first.has (d))
		end

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
