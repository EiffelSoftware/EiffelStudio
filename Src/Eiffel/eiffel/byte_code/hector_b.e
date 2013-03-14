note
	description: "Result of applying `$' on an Eiffel entity but not a routine (in which case it should be an ADDRESS_B)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class HECTOR_B

inherit
	UNARY_B
		redefine
			expr, enlarged, is_hector, type,
			calls_special_features, is_unsafe, optimized_byte_node,
			pre_inlined_code, inlined_byte_code,
			analyze, print_register,
			generate
		end

	SHARED_TYPES
		export
			{NONE} all
		end

create
	make_with_type

feature {NONE} -- Initialization

	make_with_type (a: like expr; t: TYPED_POINTER_A)
			-- Initialization
		require
			a_not_void: a /= Void
			t_not_void: t /= Void
		do
			expr := a
			internal_type := t
		ensure
			expr_set: expr = a
			internal_type_set: internal_type = t
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_hector_b (Current)
		end

feature -- Access

	expr: ACCESS_B
			-- Access on which we do `$'.

	type: TYPE_A
			-- Expression's type
		do
			Result := Pointer_type
		ensure then
			type_not_void: Result /= Void
		end

	enlarged: like Current
			-- Enlarge the expression
		do
			expr := expr.enlarged
			Result := Current
		end

	is_hector: BOOLEAN = True
			-- The expression is an hector one.

feature -- Code generation

	analyze
			-- Analyze expression
		do
			context.init_propagation
			expr.propagate (No_register)
			expr.analyze
			if expr.is_result and then real_type (expr.type).is_basic then
				context.mark_result_used
			end
		end

feature -- C code generation

	print_register
			-- Print expression value
		local
			buf: GENERATION_BUFFER
			l_type: TYPE_A
		do
			l_type := real_type (expr.type)
			if l_type.is_basic then
				buf := buffer
				if expr.is_predefined or expr.is_attribute then
					l_type.c_type.generate_access_cast (buf)
					buf.put_three_character (' ', '&', '(')
					if expr.is_attribute then
						expr.generate_access
					else
						expr.print_register
					end
					buf.put_character (')')
				else
					expr.print_register
				end
			else
				expr.print_register
			end
		end

	generate
			-- Generate expression
		local
			l_type: TYPE_A
		do
			l_type := real_type (expr.type)
			if l_type.is_basic and (expr.is_predefined or expr.is_attribute) then
					-- We don't need to do anything now,
					-- `generate_parameters_list' from EXTERNAL_B(L/W)
					-- will generate the access on the attribute
			else
				expr.generate
			end
		end

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
		end

	is_unsafe: BOOLEAN
		do
		end

	optimized_byte_node: like Current
		do
			Result := Current
		end

feature -- Inlining

	pre_inlined_code: like Current
		do
				-- We now return Current even if usually byte code contains an
				-- HECTOR_B node cannot be inlined. This is to make the manual
				-- inlining of `element_address' and `base_address' of SPECIAL
				-- possible.
			Result := Current
			if attached {like expr} expr.pre_inlined_code as l_expr then
				expr := l_expr
			end
		end

	inlined_byte_code: like Current
		do
			Result := Current
			expr := expr.inlined_byte_code
		end

feature {NONE} -- Implementation

	internal_type: TYPED_POINTER_A
			-- Type associated to Current.
			-- Currently type is not used but it might be in the future when we actually properly
			-- handle TYPED_POINTER [EXP_CLASS] at runtime (see eweasel test#melt078 for example).

invariant
	expr_not_void: expr /= Void
	internal_type_not_void: internal_type /= Void

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
