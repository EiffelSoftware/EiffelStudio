note
	description: "Byte code for check instruction with body."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class GUARD_B

inherit
	CHECK_B
		redefine
			analyze,
			calls_special_features,
			enlarge_tree,
			generate,
			inlined_byte_code,
			is_unsafe,
			optimized_byte_node,
			pre_inlined_code,
			process,
			size
		end

create
	make

feature {NONE} -- Creation

	make (a: like check_list; c: like compound; e: like end_location)
			-- Create a new check instruction byte node with the specified
			-- assertion list `a', compound `c' and end location `e'
		do
			check_list := a
			compound := c
			end_location := e
		ensure
			check_list_set: check_list = a
			compound_set: compound = c
			end_location_set: end_location = e
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- <Precursor>
		do
			v.process_guard_b (Current)
		end

feature -- Access

	compound: BYTE_LIST [BYTE_NODE]
			-- Compound {list of INSTR_B}

feature -- Code generation

	enlarge_tree
			-- <Precursor>
		do
			if attached check_list as c then
				c.enlarge_tree
			end
			if attached compound as c then
				c.enlarge_tree
			end
		end

	analyze
			-- <Precursor>
		do
			if attached check_list as c then
				if context.workbench_mode then
					context.add_dt_current
				end
				c.analyze
			end
			if attached compound as c then
				c.analyze
			end
		end

	generate
			-- <Precursor>
		do
			generate_line_info
			if attached check_list as c then
				context.set_assertion_type (In_check)
				c.generate
				context.set_assertion_type (0)
			end
			if attached compound as c then
				c.generate
			end
		end

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result :=
				attached check_list as c and then c.calls_special_features (array_desc) or else
				attached compound as c and then c.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN
			-- <Precursor>
		do
			Result :=
				attached check_list as c and then c.is_unsafe or else
				attached compound as c and then c.is_unsafe
		end

	optimized_byte_node: like Current
			-- <Precursor>
		do
			Result := Current
			if attached check_list as c then
				check_list := c.optimized_byte_node
			end
			if attached compound as c then
				compound := c.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER
			-- <Precursor>
		do
			if attached check_list as c then
				Result := c.size
			end
			if attached compound as c then
				Result := Result + c.size
			end
		end

	pre_inlined_code: like Current
			-- <Precursor>
		do
			Result := Current
			if attached check_list as c then
				check_list := c.pre_inlined_code
			end
			if attached compound as c then
				compound := c.pre_inlined_code
			end
		end

	inlined_byte_code: like Current
			-- <Precursor>
		do
			Result := Current
			if attached check_list as c then
				check_list := c.inlined_byte_code
			end
			if attached compound as c then
				compound := c.inlined_byte_code
			end
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
