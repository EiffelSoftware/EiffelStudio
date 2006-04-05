indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Byte code for access to an expression

class ACCESS_EXPR_B

inherit

	ACCESS_B
		redefine
			analyze, unanalyze, generate,
			print_register, propagate,
			free_register, enlarged, used,
			has_gcable_variable, has_call,
			allocates_memory,
			is_unsafe, is_type_fixed,
			calls_special_features,
			optimized_byte_node, size,
			pre_inlined_code,
			is_temporary, is_predefined,
			register_name,
			is_hector
		end;

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_access_expr_b (Current)
		end

feature

	expr: EXPR_B;
			-- The expression

feature -- Status report

	is_type_fixed: BOOLEAN is
			-- Is type of the expression statically fixed,
			-- so that there is no variation at run-time?
		do
			Result := expr.is_type_fixed
		end

feature -- Status

	is_hector: BOOLEAN is
			-- Is the current expression an hector one ?
			-- Definition: an expression <E> is hector if <E>
			-- is of the form $<A> and <A> is an attribute
			-- or a local variable.
		do
			Result := expr.is_hector
		end

	set_expr (e: EXPR_B) is
			-- Set `expr' to `e'
		do
			expr := e;
		end;

	type: TYPE_I is
			-- Expression type
		do
			Result := expr.type;
		end;

	enlarged: like Current is
			-- Enlarge the expression
		do
			expr := expr.enlarged;
			Result := Current;
		end;

	has_gcable_variable: BOOLEAN is
			-- Is the expression using a GCable variable ?
		do
			Result := expr.has_gcable_variable;
		end;

	has_call: BOOLEAN is
			-- Is the expression using a call ?
		do
			Result := expr.has_call;
		end;

	allocates_memory: BOOLEAN is
		do
			Result := expr.allocates_memory
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is `r' used in the expression ?
		do
			Result := expr.used (r);
		end;

	propagate (r: REGISTRABLE) is
			-- Propagate a register in expression.
		do
			if r = No_register or not used (r) then
				if not context.propagated or r = No_register then
					expr.propagate (r);
				end;
			end;
		end;

	free_register is
			-- Free register used by expression
		do
			expr.free_register;
		end;

	analyze is
			-- Analyze expression
		do
			expr.analyze;
		end;

	unanalyze is
			-- Undo the analysis of the expression
		do
			expr.unanalyze;
		end;

	generate is
			-- Generate expression
		do
			expr.generate;
		end;

	same (other: ACCESS_B): BOOLEAN is
			-- Is other the same access as us ?
		do
			Result := false;
		end;

	print_register is
			-- Print expression value
		do
			if
				(expr.register = Void or expr.register = No_register)
				and then not expr.is_simple_expr
			then
				buffer.put_character ('(');
				expr.print_register;
				buffer.put_character (')');
			else
					-- No need for parenthesis if expression is held in a
					-- register (e.g. a semi-strict boolean op).
				expr.print_register;
			end;
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := expr.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := expr.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current;
			expr := expr.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 1 + expr.size
		end

	pre_inlined_code: like Current is
		do
			Result := Current;
			expr := expr.pre_inlined_code
		end

	is_temporary: BOOLEAN is
			-- Is register a temporary one ?
		do
			Result := expr.is_temporary
		end;

	is_predefined: BOOLEAN is
			-- Is register a predefined one ?
		do
			Result := expr.is_predefined
		end;

	register_name: STRING is
			-- The ASCII representation of the register
		do
			Result := expr.register_name
		end
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
