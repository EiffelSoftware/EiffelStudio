note
	description: "Byte code for assignment."

class ASSIGN_B

inherit

	INSTR_B
		redefine
			need_enlarging, enlarged,
			assigns_to, is_unsafe, optimized_byte_node,
			calls_special_features, size, inlined_byte_code,
			pre_inlined_code
		end

create
	make

feature {NONE} -- Creation

	make (t: like target; s: like source)
			-- Initialize with a target `t` and a source `s`.
		require
			t.is_writable
		do
			target := t
			source := s
		ensure
			target = t
			source = s
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_assign_b (Current)
		end

feature

	target: ACCESS_B
			-- Target of the assignment.

	source: EXPR_B
			-- Source of the assignment.

	is_creation_instruction: BOOLEAN
			-- Is instruction used to model creation instruction?
		require
			source_not_void: source /= Void
		do
			if attached {CREATION_EXPR_B} source as c then
				Result := c.is_creation_instruction
			end
		end

	need_enlarging: BOOLEAN = True
			-- This node needs enlarging

	enlarged: ASSIGN_BL
			-- Enlarge current node.
		do
			create Result.make (Current)
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN
		do
			Result := target.assigns_to (i)
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			Result := source.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN
		do
			Result := source.is_unsafe
		end

	optimized_byte_node: like Current
		do
			Result := Current;
			source := source.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER
		do
			Result := 1 + source.size
		end

	pre_inlined_code: like Current
		do
			Result := Current
			source := source.pre_inlined_code
				-- Cannot fail: target is local,
				-- Result or attribute
			target ?= target.pre_inlined_code
		end

	inlined_byte_code: like Current
		do
			Result := Current
			source := source.inlined_byte_code
		end

invariant
	target.is_writable

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
