note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class EXPR_ADDRESS_B

inherit

	EXPR_B
		redefine
			enlarged, is_type_fixed,
			allocates_memory, has_call, has_gcable_variable,
			is_hector, inlined_byte_code, pre_inlined_code, size,
			optimized_byte_node, is_unsafe, calls_special_features
		end

	SHARED_TYPES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (e: EXPR_B)
			-- Set `expr' to `e'
		require
			e_not_void: e /= Void
		do
			expr := e
		ensure
			expr_set: expr = e
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_expr_address_b (Current)
		end

feature -- Attributes

	expr: EXPR_B;
		-- Expression to address

feature -- Status report

	is_type_fixed: BOOLEAN = True
			-- Is type of the expression statically fixed,
			-- so that there is no variation at run-time?

feature

	type: POINTER_A
			-- Address type
		do
			Result := pointer_type
		end

	enlarged: EXPR_ADDRESS_BL
			-- Enlarge the expression
		do
			create Result.make (expr.enlarged)
		end;

	is_hector: BOOLEAN = True;
			-- The expression is an hector one.

	has_gcable_variable: BOOLEAN
			-- Is the expression using a GCable variable ?
		do
			Result := expr.has_gcable_variable;
		end;

	has_call: BOOLEAN
			-- Is the expression using a call ?
		do
			Result := expr.has_call;
		end;

	allocates_memory: BOOLEAN
		do
			Result := expr.allocates_memory
		end;

	used (r: REGISTRABLE): BOOLEAN
			-- Is `r' used in the expression ?
		do
			Result := expr.used (r);
		end;

feature -- Byte code generation

	make_protected_byte_code (ba: BYTE_ARRAY; pointer_pos, value_pos: INTEGER)
			-- Generate byte code for parenthesized expression.
		require
			is_protected: is_protected
		do
			ba.append ({BYTE_CONST}.Bc_object_expr_addr);
			ba.append_uint32_integer (pointer_pos);
			ba.append_uint32_integer (value_pos);
		end

	is_protected: BOOLEAN
			-- Is the expression protected with some special byte code?
		do
			Result := context.real_type (expr.type).is_basic
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
			Result := Current;
			expr := expr.pre_inlined_code
		end

	inlined_byte_code: like Current
		do
			Result := Current
			expr := expr.inlined_byte_code
		end

invariant
	expr_not_void: expr /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
