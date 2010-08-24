note
	description: "Byte node used to deactivate and reactive RTHOOK generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HIDDEN_B

inherit
	BYTE_NODE
		redefine
			enlarge_tree, analyze, generate,
			assigns_to, is_unsafe, optimized_byte_node,
			calls_special_features, size, pre_inlined_code,
			inlined_byte_code
		end

create
	make

feature {NONE} -- Initialization

	make (a_node: BYTE_NODE)
			-- Initialization	
		do
			node := a_node
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_hidden_b (Current)
		end

feature -- Access

	node: detachable BYTE_NODE

feature -- Code analyzis

	analyze
			-- Loop over `list' and analyze each item
		do
			if attached node as l_node then
				l_node.analyze
			end
		end

feature -- C generation

	generate
			-- Generate `node'
		do
			if attached node as l_node then
				context.enter_hidden_code
				l_node.generate
				context.exit_hidden_code
			end
		end

feature -- Tree enlargment

	enlarge_tree
			-- Loop ovet `list' and enlarges each item
		do
			if attached node as l_node then
				if l_node.need_enlarging then
					node := l_node.enlarged
				else
					l_node.enlarge_tree
				end
			end
		end

feature -- Array optimization

	assigns_to (n: INTEGER): BOOLEAN
		do
			if attached node as l_node then
				Result := l_node.assigns_to (n)
			end
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			if attached node as l_node then
				Result := l_node.calls_special_features (array_desc)
			end
		end

	is_unsafe: BOOLEAN
		do
			if attached node as l_node then
				Result := l_node.is_unsafe
			end
		end

	optimized_byte_node: like Current
		do
			Result := Current
			if attached node as l_node then
				node := l_node.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER
		do
			if attached node as l_node then
				Result := l_node.size
			end
		end

	pre_inlined_code: like Current
		do
			Result := Current
			if attached node as l_node then
				node := l_node.pre_inlined_code
			end
		end

	inlined_byte_code: like Current
		do
			Result := Current
			if attached node as l_node then
				node := l_node.inlined_byte_code
			end
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

