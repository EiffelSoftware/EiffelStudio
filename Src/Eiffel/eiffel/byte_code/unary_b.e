note
	description: "Byte node for unary operation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Date$"

deferred class
	UNARY_B

inherit
	EXPR_B
		redefine
			analyze, unanalyze, generate,
			print_register, free_register,
			propagate, enlarged,
			has_gcable_variable, has_call,
			allocates_memory,
			is_unsafe, optimized_byte_node,
			calls_special_features, size,
			pre_inlined_code, inlined_byte_code,
			is_simple_expr
		end

	IL_CONST

feature -- Initialization

	init (a: like access)
			-- Initializes access
		do
			set_access (a)
		end

feature -- Access

	expr: EXPR_B
			-- Expression

	access: ACCESS_B
			-- Access when expression is not a simple type

	type: TYPE_A
			-- Type of the prefixed feature
		do
			Result := access.type
		end

feature -- Settings

	set_expr (e: like expr)
			-- Assign `e' to `expr'.
		do
			expr := e
		end

	set_access (a: like access)
			-- Set `access' to `a'
		do
			access := a
		end

feature -- Status report

	is_built_in: BOOLEAN
			-- Is the unary operation a built-in one ?
		do
			-- Do nothing
		end

	is_simple_expr: BOOLEAN
			-- Is the current expression a simple one ?
			-- Definition: an expression <E> is simple if the assignment
			-- target := <E> is generated as such in C when "target" is a
			-- predefined entity propagated
		do
			Result := expr.is_simple_expr
		end

	has_gcable_variable: BOOLEAN
			-- Is the expression using a GCable variable ?
		do
			Result := expr.has_gcable_variable
		end

	has_call: BOOLEAN
			-- Is the expression using a call ?
		do
			Result := expr.has_call
		end

	allocates_memory: BOOLEAN
		do
			Result := expr.allocates_memory
		end

	used (r: REGISTRABLE): BOOLEAN
			-- Is `r' used in the expression ?
		do
			Result := expr.used (r)
		end

feature -- Code generation

	nested_b: NESTED_B
			-- Change this node into a nested call
		local
			a_access_expr: ACCESS_EXPR_B
		do
			create Result
			create a_access_expr
			a_access_expr.set_expr (expr)
			a_access_expr.set_parent (Result)
			Result.set_target (a_access_expr)
			access.set_parent (Result)
			Result.set_message (access)
		end

	enlarged: EXPR_B
			-- Enlarge the expression
		do
			if not is_built_in then
					-- Change this node into a nested call
				Result := nested_b.enlarged
			else
					-- Enlarge current node
				expr := expr.enlarged
					-- Access is void in UN_OLD_B
				if access /= Void then
					access := access.enlarged_on (context.real_type (expr.type))
				end
				Result := Current
			end
		end

feature -- C code generation

	propagate (r: REGISTRABLE)
			-- Propagate a register in expression.
		do
			if r = No_register or not used (r) then
				if not context.propagated or r = No_register then
					expr.propagate (r)
				end
			end
		end

	free_register
			-- Free register used by expression
		do
			expr.free_register
		end

	analyze
			-- Analyze expression
		do
			context.init_propagation
			expr.propagate (No_register)
			expr.analyze
		end

	unanalyze
			-- Undo the analysis of the expression
		do
			expr.unanalyze
		end

	generate
			-- Generate expression
		do
			expr.generate
		end

	print_register
			-- Print expression value
		do
			real_type (type).c_type.generate_cast (buffer)
			generate_operator (buffer)
			expr.print_register
		end

	generate_operator (a_buffer: GENERATION_BUFFER)
			-- Generate operator in C
		require
			a_buffer_not_void: a_buffer /= Void
		do
				-- Should never be called directly. Descendant of UNARY_B
				-- not redefining `generate_operator' usually redefine
				-- `print_register' and thus they might choose not to
				-- use `generate_operator'.
			check
				False
			end
		end

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			Result := expr.calls_special_features (array_desc) or else
				access.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN
		do
				-- Use the nested form of the byte code (the type resolution
				-- does not work otherwise)
			Result := nested_b.is_unsafe
		end

	optimized_byte_node: EXPR_B
		do
			if is_built_in then
				Result := Current
				expr := expr.optimized_byte_node
				access := access.optimized_byte_node
			else
				Result := nested_b.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER
		do
			Result := expr.size + 1
		end

	pre_inlined_code: EXPR_B
		do
			if not is_built_in then
				Result := nested_b.pre_inlined_code
			else
				Result := Current
				expr := expr.pre_inlined_code
			end
		end

	inlined_byte_code: EXPR_B
		do
			if not is_built_in then
				Result := nested_b.inlined_byte_code
			else
				Result := Current
				expr := expr.inlined_byte_code
			end
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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
