indexing
	description: "An Eiffel expression."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EXPR_B

inherit
	REGISTRABLE
		redefine
			get_register, free_register, print_register
		end

	BYTE_NODE
		redefine
			need_enlarging, enlarged, optimized_byte_node,
			pre_inlined_code, inlined_byte_code
		end

	SHARED_C_LEVEL
	SHARED_TABLE

feature -- Access

	type: TYPE_I is
			-- Expression type
		deferred
		end

	c_type: TYPE_C is
			-- C type of the expression
		do
			Result := real_type (type).c_type
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local or forthcomming dot calls ?
		deferred
		end

feature -- Evaluation

	evaluate: VALUE_I is
			-- Evaluate current expression, if possible.
		once
			create {NO_VALUE_I} Result
		ensure
			evaluate_not_void: Result /= Void
		end

feature -- Il code generation

	is_fast_as_local: BOOLEAN is
			-- Is expression calculation as fast as loading a local?
			-- In other words: does it make sense to store a result of the expression
			-- in a temporary local variable for multiple uses or is it equivalent
			-- in performance to "recalculating" the expression every time?
			-- (In the latter case it's better to avoid creating a temporary
			-- variable to reduce stack memory footprint and register pressure.)
		do
		end

feature -- Status report

	is_constant_expression: BOOLEAN is
			-- Does current represent a node which is constant?
			-- Case of manifest constants, and tuples/arrays with
			-- constant expressions.
		do
			-- Default: False
		end

feature -- C generation

	get_register is
			-- Get a temporary register to hold result of expr. If a register
			-- has already been propagated, then `register' is not void and
			-- nothing has to be done.
		local
			tmp_register: REGISTER
			ctype: TYPE_C
		do
			if register = Void then
				ctype := c_type
				if not ctype.is_void then
					create tmp_register.make (ctype)
					set_register (tmp_register)
				end
			end
		ensure then
			register_exists: register = Void implies type.is_void
		end

	free_register is
			-- Free register used by expr, if necessary
		do
			if register /= Void then
				register.free_register
			end
		end

	print_register is
			-- Print register.
		do
			register.print_register
		end

	is_simple_expr: BOOLEAN is
			-- Is the current expression a simple one ?
			-- Definition: an expression <E> is simple if the assignment
			-- target := <E> is generated as such in C when "target" is a
			-- predefined entity propagated in <E>.
			-- Currently, the only simple expressions are the calls
			-- the manifest strings and the constants.
		do
		end

	is_hector: BOOLEAN is
			-- Is the current expression an hector one ?
			-- Definition: an expression <E> is hector if it is a parameter
			-- of an external function call, <E> is of the form $<A> and <A>
			-- is an attribute or a local variable.
		do
		end

	has_gcable_variable: BOOLEAN is
			-- Does the expression have a GCable variable ?
			-- Definition: a GCable variable is a variable which is placed
			-- under the control of the garbage collector, directly or
			-- indirectly via the hooks.
		do
		end

	has_call: BOOLEAN is
			-- Does the expression have a call ?
		do
		end

	allocates_memory: BOOLEAN is
			-- Does the expression allocates memory ?
		do
		end

	unanalyze is
			-- Undo the effect of analyze.
		do
		end

	stored_register: REGISTRABLE is
			-- The register in which the expression is stored
		do
			Result := register
			if Result = Void then
				Result := Current
			end
		end

	need_enlarging: BOOLEAN is true
			-- All the expressions need enlarging

	enlarged: EXPR_B is
			-- Redefined for type check
		do
			Result := Current
		end

	register_name: STRING is
			-- Do nothing
		do
		end

	is_register_required (target_type: TYPE_I): BOOLEAN is
			-- Is register required if expression is about
			-- to be assigned or compared to the type `target_type'?
		local
			source_type: TYPE_I
		do
			source_type := context.real_type (type)
			Result :=
				target_type.is_reference and then source_type.is_expanded or else
				target_type.is_true_expanded or else source_type.is_reference
		end

	generate_for_type (target_register: REGISTRABLE; target_type: TYPE_I) is
			-- Generate expression which is about
			-- to be assigned or compared to the type `target_type'.
		require
			target_type_not_void: target_type /= Void
			target_register_not_void: is_register_required (target_type) implies target_register /= Void
		local
			expression_type: TYPE_I
			basic_i: BASIC_I
			buf: GENERATION_BUFFER
		do
			generate
			buf := buffer
			expression_type := context.real_type (type)
			if target_type.is_reference and then expression_type.is_expanded then
				if expression_type.is_basic then
					basic_i ?= expression_type
					basic_i.metamorphose (target_register, Current, buf, context.workbench_mode)
				else
					target_register.print_register
					buf.put_string (" = ")
					buf.put_string ("RTRCL(")
					print_register
					buf.put_character (')')
				end
				buf.put_character (';')
				buf.put_new_line
			elseif target_type.is_true_expanded then
				target_register.print_register
				buf.put_string (" = ")
				buf.put_string ("RTRCL(")
				print_register
				buf.put_string (gc_rparan_semi_c)
				buf.put_new_line
			elseif expression_type.is_reference then
				target_register.print_register
				buf.put_string (" = ")
				generate_dynamic_clone (Current, expression_type)
				buf.put_character (';')
				buf.put_new_line
			end
		end

	generate_dynamic_clone (source_register: REGISTRABLE; source_type: TYPE_I) is
			-- Generate expression that clones `source_register' depending on
			-- dynamic type of object of static type `source_type'.
		require
			source_register_not_void: source_register /= Void
			source_type_not_void: source_type /= Void
			source_type_is_reference: source_type.is_reference
		local
			buf: like buffer
			cl_type_i: CL_TYPE_I
			has_expanded_descendants: BOOLEAN
		do
			buf := buffer
			has_expanded_descendants := True
			if
				context.original_body_index = context.twin_body_index or else
				source_type.is_frozen or else
				source_type.is_none
			then
					-- Avoid infinite recursion in "ANY.twin".
					-- Avoid dynamic check of object type if we know
					-- in advance that the type cannot be expanded.
				has_expanded_descendants := False
			elseif system.in_final_mode then
					-- Avoid dynamic check of object type if we know
					-- in advance that the type cannot be expanded.
				cl_type_i ?= source_type
				if cl_type_i /= Void then
					has_expanded_descendants := context.has_expanded_descendants (cl_type_i.associated_class_type.type_id)
				end
			end
			if has_expanded_descendants then
				buf.put_string ("RTCCL(")
				source_register.print_register
				buf.put_character (')')
			else
				source_register.print_register
			end
		end

feature -- Array optimization

	optimized_byte_node: EXPR_B is
			-- Redefined for type check
		do
			Result := Current
		end

feature -- Inlining

	pre_inlined_code: EXPR_B is
			-- Redefined for type check
		do
			Result := Current
		end

	inlined_byte_code: EXPR_B is
			-- Redefined for type check
		do
			Result := Current
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
