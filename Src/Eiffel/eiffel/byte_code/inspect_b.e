note
	description: "Byte code for multi-branch instruction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INSPECT_B

inherit
	ABSTRACT_INSPECT_B [CASE_B, detachable BYTE_LIST [BYTE_NODE]]
		undefine
			enlarged,
			is_temporary,
			line_number,
			print_register,
			set_line_number
		end

	INSTR_B
		undefine
			analyze,
			assigns_to,
			calls_special_features,
			enlarge_tree,
			generate,
			inlined_byte_code,
			is_unsafe,
			optimized_byte_node,
			pre_inlined_code,
			size
		end

	VOID_REGISTER
		rename
			unused_context as context
		export
			{NONE} all
		undefine
			context
		end

create
	make

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_inspect_b (Current)
		end

feature -- Status report

	has_else_code: BOOLEAN
			-- <Precursor>
		do
			Result := attached else_part as e and then not e.is_empty
		end

	is_expression: BOOLEAN = False
			-- <Precursor>

feature {NONE} -- Code generation: C

	generate_effect (c: detachable BYTE_LIST [BYTE_NODE])
			-- <Precursor>
		do
			if attached c then
				c.generate
			end
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
