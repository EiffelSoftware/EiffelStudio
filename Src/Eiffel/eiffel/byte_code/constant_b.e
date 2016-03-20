note
	description: "Byte code for constants (hardwired in final mode)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CONSTANT_B

inherit

	ACCESS_B
		redefine
			allocates_memory,
			analyze,
			analyze_on,
			canonical,
			enlarged,
			evaluate,
			free_register,
			generate,
			generate_on,
			generate_parameters,
			has_gcable_variable,
			is_constant,
			is_constant_expression,
			is_single,
			need_target,
			print_register,
			propagate,
			set_multi_constraint_static,
			set_parent,
			unanalyze,
			generate_workbench_separate_call_args,
			generate_finalized_separate_call_args,
			generate_workbench_separate_call_get_result,
			generate_finalized_separate_call_get_result
		end

create
	make

feature {NONE} -- Initialization

	make (v: like value)
			-- Assign `v' to `value'.
		require
			v_not_void: v /= Void
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_constant_b (Current)
		end

feature -- Evaluation

	evaluate: VALUE_I
			-- Evaluate current.
		do
			Result := value
		end

feature -- Access

	value: VALUE_I;
			-- Constant value for hardwiring

	access: ACCESS_B;
			-- Accessing constant when hardwiring not possible

	canonical: CALL_B
			-- Canonical call
		do
			Result := access
		end;

	type: TYPE_A
			-- Access type
		do
			Result := access.type;
		end;

feature -- Status

	is_constant_expression, is_constant: BOOLEAN = True
			-- Current is constant

	need_target: BOOLEAN = False
			-- Current does not need a target to be accessed.

feature -- Setting

	set_access (a: like access)
			-- Assign `a' to `access'.
		do
			access := a;
		end;

	set_parent (n: NESTED_B)
			-- Assign `n' to `parent'.
		do
			parent := n;
			access.set_parent (n);
		end;

feature -- Multi constraint suport

	set_multi_constraint_static (a_type: TYPE_A)
			-- `formal_multi_constraint_static' to `a_type'
		do
			Precursor (a_type)
				-- We also need to set the `multi_constraint_static' to the `access'
				-- otherwise code generation won't be correct.
			if access /= Void then
				access.set_multi_constraint_static (a_type)
			end
		ensure then
			access_multi_constraint_static_set: access /= Void implies access.multi_constraint_static = a_type
		end

feature -- Comparison

	same (other: ACCESS_B): BOOLEAN
			-- Is `other' the same access to constant ?
		local
			o_value: like value
		do
			if attached {CONSTANT_B} other as constant_b then
				o_value := constant_b.value
				Result := value.same_type (o_value) and then
					value.is_equivalent (o_value)
			end
		end

	has_gcable_variable: BOOLEAN
			-- Does current access makes use of a GC-able variable
		do
			if context.workbench_mode then
				Result := access.has_gcable_variable;
			end;
		end;

	is_single: BOOLEAN
			-- Is access a single one ?
		do
			if context.workbench_mode then
				Result := access.is_single;
			else
					-- Hardwired constant is a single access
				Result := true;
			end;
		end;

	propagate (r: REGISTRABLE)
			-- Propagate register accross access
		do
			if context.workbench_mode then
				access.propagate (r);
			end;
		end;

	print_register
			-- Print register value (generates constant)
		do
			if context.workbench_mode then
				access.print_register;
			else
				value.generate (buffer);
			end;
		end;

	free_register
			-- Free register used by constant
		do
			if context.workbench_mode then
				access.free_register;
			end;
		end;

	unanalyze
			-- Undo the analysis
		do
			if context.workbench_mode then
				access.unanalyze;
			end;
		end;

	analyze
			-- Analyze constant
		do
			if context.workbench_mode then
				access.analyze;
			end;
		end;

	analyze_on (reg: REGISTRABLE)
			-- Analyze constant access on `reg'
		do
			if context.workbench_mode then
				access.analyze_on (reg);
			end;
		end;

	generate
			-- Generate constant
		do
			if context.workbench_mode then
				access.generate;
			end;
		end;

	generate_on (reg: REGISTRABLE)
			-- Generate constant access on `reg'
		do
			if context.workbench_mode then
				access.generate_on (reg);
			else
				print_register
			end;
		end;

	generate_parameters (reg: REGISTRABLE)
			-- Generate code for parameters computation.
			-- `reg' ("Current") is not used except for
			-- inlining
		do
			if context.workbench_mode then
				access.generate_parameters (reg)
			else
				Precursor (reg)
			end
		end

	enlarged: like Current
			-- Enlarge access
		do
			if context.workbench_mode then
				access := access.enlarged;
			end;
			Result := Current;
		end;

	allocates_memory: BOOLEAN
		do
			Result := value.is_string
		end

feature {NONE} -- Separate call

	generate_workbench_separate_call_args
			-- <Precursor>
		do
			access.generate_workbench_separate_call_args
		end

	generate_finalized_separate_call_args (a_target: REGISTRABLE; a_has_result: BOOLEAN)
			-- <Precursor>
		do
				-- We don't need anything special for constants.
			buffer.put_string (once "NULL, eif_call_const, 0")
		end


	generate_workbench_separate_call_get_result (a_result: REGISTRABLE)
			-- <Precursor>
		do
			access.generate_workbench_separate_call_get_result (a_result)
		end


	generate_finalized_separate_call_get_result (a_result: REGISTRABLE)
			-- <Precursor>
		local
			buf: like buffer
		do
			buf := buffer
			buf.put_new_line
			a_result.print_register
			buf.put_three_character (' ', '=', ' ')
			print_register
			buf.put_character (';')
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
