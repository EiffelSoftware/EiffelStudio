note
	description: "Byte code for multi-branch expression."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INSPECT_EXPRESSION_B

inherit
	ABSTRACT_INSPECT_B [CASE_EXPRESSION_B, EXPR_B]
		undefine
			free_register,
			get_register,
			need_enlarging,
			print_register
		redefine
			analyze,
			enlarged,
			register,
			set_register
		end

	EXPR_B
		undefine
			assigns_to,
			calls_special_features,
			enlarge_tree,
			generate,
			inlined_byte_code,
			is_unsafe,
			optimized_byte_node,
			pre_inlined_code,
			size
		redefine
			analyze,
			enlarged,
			free_register,
			register,
			set_register,
			unanalyze
		end

create
	make

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_inspect_expression_b (Current)
		end

feature -- Access

	type: TYPE_A
			-- Expression type.

feature -- Status report

	has_else_code: BOOLEAN = True
			-- <Precursor>

	is_expression: BOOLEAN = True
			-- <Precursor>

feature -- Modification

	set_type (t: like type)
			-- Set `type` to `t`.
		do
			type := t
		ensure
			type_set: type = t
		end

feature -- Access: C code generation

	register: REGISTRABLE
			-- <Precursor>

feature -- Code generation: C

	used (r: REGISTRABLE): BOOLEAN
			-- <Precursor>
		do
			Result :=
				switch.used (r) or else
				attached else_part as p and then p.used (r) or else
				attached case_list as cs and then ∃ c: cs ¦ c.used (r)
		end

	set_register (r: REGISTRABLE)
			-- <Precursor>
		do
			register := r
		end

	free_register
			-- <Precursor>
		do
			if attached register as r then
				r.free_register
			else
				check register_attached: False end
			end
		end

	analyze
		do
				-- Allocate a register for the expression result.
			get_register
				-- Do the analysis.
			Precursor {ABSTRACT_INSPECT_B}
		end

	unanalyze
			-- <Precursor>
		do
			Precursor
			register := Void
		end

	enlarged: INSPECT_EXPRESSION_B
			-- <Precursor>
		do
			switch := switch.enlarged
			if attached case_list as c then
				c.enlarge_tree
			end
			if attached else_part as p then
				else_part := p.enlarged
			end
			Result := Current
		end

feature {NONE} -- Code generation: C

	generate_effect (c: EXPR_B)
			-- <Precursor>
		do
			generate_frozen_debugger_hook
			c.generate_for_attachment (register, type)
		end

;note
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
