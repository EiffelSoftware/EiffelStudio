indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Parameter expression

class PARAMETER_B

inherit

	EXPR_B
		redefine
			enlarged, is_hector,
			is_simple_expr, has_gcable_variable, has_call,
			stored_register, is_unsafe, optimized_byte_node,
			calls_special_features, size,
			pre_inlined_code, inlined_byte_code,
			allocates_memory
		end;

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_parameter_b (Current)
		end

feature {PARAMETER_B} -- Implementation

	internal_attachment_type: TYPE_A
			-- Type to which the expression is attached

feature -- Access

	expression: EXPR_B;
			-- Expression

	attachment_type: TYPE_A is
			-- Type to which the expression is attached
		do
			if
				not system.il_generation and then context.final_mode and then
				is_formal and then parent.is_polymorphic and then not parent.has_one_signature
			then
				Result := system.any_type
			else
				Result := internal_attachment_type
			end
		end

 feature {PARAMETER_B} -- Status report

	is_formal: BOOLEAN
			-- Is type of the corresponding argument
			-- of the routine seed formal?

	parent: ACCESS_B
			-- Feature which is called with this parameter

feature -- Modification

	set_expression (e: EXPR_B) is
			-- Assign `e' to `expression'.
		do
			expression := e
		end

	set_attachment_type (t: TYPE_A) is
			-- Assign `t' to `attachment_type'.
		do
			internal_attachment_type := t
		end

	set_is_formal (v: BOOLEAN) is
			-- Specify whether the associated formal argument
			-- of the routine seed is formal.
		do
			is_formal := v
		end

	set_parent (p: ACCESS_B) is
			-- Set parent of this parameter to `p'.
		do
			parent := p
		end

feature -- Status report

	type: TYPE_A is
			-- Expression type
		do
			Result := expression.type
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- Is `r' used in the expression ?
		do
			Result := expression.used (r)
		end

	is_hector: BOOLEAN is
			-- Is the expression a non-protected one ?
		do
			Result := expression.is_hector
		end

	is_simple_expr: BOOLEAN is
			-- Is the current expression a simple one ?
		do
			Result := expression.is_simple_expr;
		end;

	has_gcable_variable: BOOLEAN is
			-- Does the expression have a GCable variable ?
		do
			Result := expression.has_gcable_variable;
		end;

	has_call: BOOLEAN is
			-- Does the expression have a call ?
		do
			Result := expression.has_call;
		end;

	allocates_memory: BOOLEAN is
		do
			Result := expression.allocates_memory or else expression.allocates_memory_for_type (attachment_type)
		end

	stored_register: REGISTRABLE is
			-- The register in which the expression is stored
		do
			Result := expression.stored_register;
		end;

	enlarged:  PARAMETER_BL is
			-- Enlarge the expression
		do
			create Result;
			Result.fill_from (Current);
		end;

	target_type_name: STRING is
			-- Name of the target C type
		do
			if is_compaund then
				Result := "EIF_TYPED_VALUE"
			else
				Result := real_type (attachment_type).c_type.c_string
			end
		end

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := expression.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := expression.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			expression := expression.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := expression.size
		end

	pre_inlined_code: like Current is
		do
			Result := Current
				-- Adapt type in current context for better results. We have to remove
				-- the anchors otherwise it does not work, see eweasel test#final055.		
			internal_attachment_type := context.real_type (internal_attachment_type.deep_actual_type).instantiated_in (context.context_cl_type)
			expression := expression.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			internal_attachment_type := context.real_type (internal_attachment_type)
			expression := expression.inlined_byte_code
		end

feature {NONE} -- Status report

	is_compaund: BOOLEAN is
			-- Shall a structure be used to pass the argument value?
		do
			Result := context.workbench_mode
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
