indexing
	description: "Conversion if needed of an expanded to its associated reference type %
		%in assignment of a formal to a type whose formal type's constraint conforms."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_CONVERSION_B

inherit
	EXPR_B
		redefine
			analyze, unanalyze, register,
			set_register, print_register, generate, enlarged,
			pre_inlined_code
		end

create
	make

feature {NONE} -- Initialization

	make (an_expr: EXPR_B; a_type: like type; a_is_boxing: BOOLEAN) is
			-- New BOX_B instance which converts value of `an_expr' into
			-- a box version of `a_type'.
		require
			an_expr_not_void: an_expr /= Void
			a_type_not_void: a_type /= Void
		do
			expr := an_expr
			type := a_type
			is_boxing := a_is_boxing
		ensure
			expr_set: expr = an_expr
			type_set: type = a_type
			is_boxing_set: is_boxing = a_is_boxing
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_formal_conversion_b (Current)
		end

feature -- Access

	expr: EXPR_B
			-- Associated expression whose result is boxed

	type: TYPE_I
			-- Type to which expression should be converted if needed

	is_boxing: BOOLEAN
			-- Does conversion if needed requires boxing?

feature -- Status report

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local or forthcomming dot calls ?
		do
			Result := expr.used (r)
		ensure then
			not_used: not Result
		end

feature -- C code generation

	register: REGISTRABLE
			-- Register used to store metamorphosed value

	set_register (r: REGISTRABLE) is
			-- Assign `r' to `register'
		do
			register := r
		end

	analyze is
			-- Analyze expression
		do
			expr.analyze
			if
				is_conversion_needed (context.real_type (expr.type),
					context.real_type (type))
			then
				get_register
			end
		end

	unanalyze is
			-- Undo the analysis of the expression
		do
			expr.unanalyze
			register := Void
		end

	enlarged: like Current is
			-- Enlarge current
		do
			expr := expr.enlarged
			Result := Current
		end

	generate is
			-- Generate expression
		local
			l_type, l_expr_type: TYPE_I
			basic_i: BASIC_I
			buf: GENERATION_BUFFER
		do
			expr.generate

			l_type := context.real_type (type)
			l_expr_type := context.real_type (expr.type)
			if is_conversion_needed (l_expr_type, l_type) then
					-- Conversion is needed.
				buf := buffer
				if l_expr_type.is_true_expanded then
						-- Expanded objects are cloned
					register.print_register
					buf.put_string (" = ")
					buf.put_string ("RTCL(")
					expr.print_register
					buf.put_character(')')
				else
						-- Simple type objects are metamorphosed
					basic_i ?= l_expr_type		-- Cannot fail
					basic_i.metamorphose
						(register, expr, buf, context.workbench_mode)
				end
				buf.put_character(';')
				buf.put_new_line
			end
		end

	print_register is
			-- Print expression value
		do
			if
				is_conversion_needed (context.real_type (expr.type),
					context.real_type (type))
			then
				register.print_register
			else
				expr.print_register
			end
		end

feature -- Inlining

	pre_inlined_code: FORMAL_CONVERSION_B is
			-- Modified byte code for inlining.
		do
			create Result.make (expr.pre_inlined_code, context.real_type (type), is_boxing)
		end

feature {BYTE_NODE_VISITOR} -- Convenience

	is_conversion_needed (a_source, a_target: TYPE_I): BOOLEAN is
			-- Is conversion needed from `a_source' to `a_target'?
		require
			a_source_not_void: a_source /= Void
			a_target_not_void: a_target /= Void
		do
			Result := a_source.is_expanded and a_target.is_reference
		end

invariant
	expr_not_void: expr /= Void
	type_not_void: type /= Void

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

end -- class FORMAL_CONVERSION_B
