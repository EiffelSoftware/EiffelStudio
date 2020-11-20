note
	description: "Byte code for access to an expression."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class ACCESS_EXPR_B

inherit

	ACCESS_B
		redefine
			allocates_memory,
			analyze,
			calls_special_features,
			enlarged,
			free_register,
			generate,
			has_call,
			has_gcable_variable,
			inlined_byte_code,
			is_attribute,
			is_feature,
			is_hector,
			is_polymorphic,
			is_predefined,
			is_result,
			is_temporary,
			is_type_fixed,
			is_unsafe,
			optimized_byte_node, size,
			pre_inlined_code,
			print_checked_target_register,
			print_register,
			propagate,
			register,
			register_name,
			unanalyze,
			used
		end

create
	make

feature {NONE} -- Creation

	make (e: EXPR_B)
			-- Initialize with expression `e`.
		do
			expr := e
		ensure
			expr = e
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_access_expr_b (Current)
		end

feature

	expr: EXPR_B
			-- The expression

feature -- Status report

	is_type_fixed: BOOLEAN
			-- Is type of the expression statically fixed,
			-- so that there is no variation at run-time?
		do
			Result := expr.is_type_fixed
		end

	is_result: BOOLEAN
			-- <Precursor>
		do
			Result := expr.is_result
		end

	is_attribute: BOOLEAN
			-- <Precursor>
		do
			Result := expr.is_attribute
		end

	is_feature: BOOLEAN
			-- <Precursor>
		do
			Result := expr.is_feature
		end

	is_polymorphic: BOOLEAN
			-- <Precursor>
		do
			Result := attached {ACCESS_B} expr as a and then a.is_polymorphic
		end

	is_hector: BOOLEAN
			-- Is the current expression an hector one ?
			-- Definition: an expression <E> is hector if <E>
			-- is of the form $<A> and <A> is an attribute
			-- or a local variable.
		do
			Result := expr.is_hector
		end

feature -- Status

	type: TYPE_A
			-- Expression type
		do
			Result := expr.type
		end

	enlarged: like Current
			-- Enlarge the expressionю
		do
			expr := expr.enlarged
			Result := Current
		end

	has_gcable_variable: BOOLEAN
			-- Is the expression using a GCable variable?
		do
			Result := expr.has_gcable_variable
		end

	has_call: BOOLEAN
			-- Is the expression using a call?
		do
			Result := expr.has_call
		end

	allocates_memory: BOOLEAN
		do
			Result := expr.allocates_memory
		end

	used (r: REGISTRABLE): BOOLEAN
			-- Is `r' used in the expression?
		do
			Result := expr.used (r)
		end

feature -- C code generation

	propagate (r: REGISTRABLE)
			-- Propagate a register in expression.
		do
			expr.propagate (r)
		end

	register: REGISTRABLE
			-- <Precursor>
		do
			Result := expr.register
		end

	free_register
			-- Free register used by expressionю
		do
			expr.free_register
		end

	analyze
			-- Analyze expression.
		do
			expr.analyze
		end

	unanalyze
			-- Undo the analysis of the expression.
		do
			expr.unanalyze
		end

	generate
			-- Generate expression.
		do
			expr.generate
		end

	same (other: ACCESS_B): BOOLEAN
			-- Is other the same access as us?
		do
			Result := false
		end

	print_register
			-- Print expression value.
		do
			if
				(expr.register = Void or expr.register = No_register)
				and then not expr.is_simple_expr
			then
				buffer.put_character ('(')
				expr.print_register
				buffer.put_character (')')
			else
					-- No need for parenthesis if expression is held in a
					-- register (e.g. a semi-strict boolean op).
				expr.print_register
			end
		end

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			Result := expr.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN
		do
			Result := expr.is_unsafe
		end

	optimized_byte_node: like Current
		do
			Result := Current
			expr := expr.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER
		do
			Result := expr.size
		end

	pre_inlined_code: like Current
		do
			Result := Current
			expr := expr.pre_inlined_code
		end

	is_temporary: BOOLEAN
			-- Is register a temporary one?
		do
			Result := expr.is_temporary
		end

	is_predefined: BOOLEAN
			-- Is register a predefined one ?
		do
			Result := expr.is_predefined
		end

	register_name: STRING
			-- The ASCII representation of the register
		do
			Result := expr.register_name
		end

	inlined_byte_code: ACCESS_B
			-- Redefined for type check
		do
			Result := Current
			expr := expr.inlined_byte_code
		end

feature {REGISTRABLE} -- C code generation

	print_checked_target_register
			-- <Precursor>
		do
			expr.print_checked_target_register
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
