note
	description: "Enlarged byte node for a loop expression."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	LOOP_EXPR_BL

inherit
	LOOP_EXPR_B
		rename
			make as make_b
		redefine
			analyze,
			free_register,
			generate,
			register,
			print_register,
			unanalyze
		end

	ASSERT_TYPE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Creation

	make (other: LOOP_EXPR_B)
			-- Create enlarged object from `other'.
		require
			other_attached: other /= Void
		local
			i: detachable BYTE_LIST [BYTE_NODE]
			v: detachable VARIANT_B
		do
			if attached other.invariant_code as inv then
				i := inv.enlarged
				i.enlarge_tree
			end
			if attached other.variant_code as var then
				v := var.enlarged
			end
			make_b (
				other.iteration_code.enlarged,
				i,
				v,
				other.exit_condition_code.enlarged,
				other.expression_code.enlarged,
				other.is_all,
				other.advance_code.enlarged
			)
			iteration_code.enlarge_tree
			advance_code.enlarge_tree
		end

feature -- C code generation

	register: REGISTER
			-- <Precursor>

	analyze
			-- <Precursor>
			-- Analyze loop expression.
		local
			workbench_mode: BOOLEAN
		do
			context.init_propagation
			iteration_code.analyze
				-- Allocate result register so that it's not used by nested byte nodes.
			create register.make (boolean_type.c_type)
				-- Analize nested byte nodes.
			workbench_mode := context.workbench_mode
			if workbench_mode or else context.assertion_level.is_loop then
				if attached invariant_code as i then
					if workbench_mode then
						context.add_dt_current
					end
					i.analyze
				end
				if attached variant_code as v then
					if workbench_mode then
						context.add_dt_current
					end
					v.analyze
				end
			end

			exit_condition_code.propagate (No_register)
			exit_condition_code.analyze
			expression_code.propagate (No_register)
			expression_code.analyze
			advance_code.analyze

			if attached variant_code as v then
				v.free_register
			end
			exit_condition_code.free_register
			expression_code.free_register
		end

	free_register
			-- <Precursor>
		do
			register.free_register
		end

	unanalyze
			-- <Precursor>
		do
			if attached variant_code as v then
				v.unanalyze
			end
			exit_condition_code.unanalyze
			expression_code.unanalyze
			register := Void
		end

	generate
			-- <Precursor>
			-- Generate loop expression.
		local
			buf: GENERATION_BUFFER
			workbench_mode: BOOLEAN
			generate_test_start: PROCEDURE [ANY, TUPLE]
			generate_test_end: PROCEDURE [ANY, TUPLE]
			i: like invariant_code
			v: like variant_code
		do
			buf := buffer
			iteration_code.generate

				-- Initialize result of the loop expression.
			buf.put_new_line
			register.print_register
			if is_all then
				buf.put_string (" = EIF_TRUE;")
			else
				buf.put_string (" = EIF_FALSE;")
			end

			if context.workbench_mode then
				workbench_mode := True
				generate_test_start := agent generate_workbench_test
				generate_test_end := agent generate_end_workbench_test
			else
				generate_test_start := agent generate_final_mode_test
				generate_test_end := agent generate_end_final_mode_test
			end

				-- Record invariant and variant byte code.
				-- First they are generated before the loop execution (at this time variant is set up).
				-- Second they are generated before the loop end (the code generation for variant is different).
			if workbench_mode or else context.assertion_level.is_loop then
				if attached invariant_code as inv then
					i := inv
				end
				if attached variant_code as var then
					v := var
				end
			end

				-- Generate the "invariant" part.
			if i /= Void then
				context.set_assertion_type (In_loop_invariant)
				generate_test_start.call (Void)
				i.generate
				generate_test_end.call (Void)
				context.set_assertion_type (0)
			end

				-- Generate the "variant" part.
			if v /= Void then
				context.set_assertion_type (In_loop_variant)
				generate_test_start.call (Void)
				v.generate
				generate_test_end.call (Void)
				context.set_assertion_type (0)
			end

			buf.put_new_line
			buf.put_string ("for (;;) {")
			buf.indent

				-- Generate the exit condition.
				-- This is done in two steps:
				--    1. Check whether the loop result is ready and terminate it if yes.
				--    2. Check the normal exit condition.

				-- Generate the check of the loop result.
				-- For All_body the loop result is known if its intermediate value is False.
				-- For Some_body the loop result is known if its intermediate value is True.
			buf.put_new_line
			if is_all then
				buf.put_string ("if (!")
			else
				buf.put_string ("if (")
			end
			register.print_register
			buf.put_string (") break;")

				-- Generate "normal" exit condition.
			generate_frozen_debugger_hook
			exit_condition_code.generate
			buf.put_new_line
			buf.put_string ("if (")
			exit_condition_code.print_register
			buf.put_string (") break;")

				-- Generate expression.
			expression_code.generate
				-- And save its result to the result variable.
				-- In theory we should do
				--    b := b and then expression -- for All_body
				--    b := b or else expression -- for Some_body
				-- but we'll take the result into account when checking the exit condition.
			buf.put_new_line
			register.print_register
			buf.put_three_character (' ', '=', ' ')
			expression_code.print_register
			buf.put_character (';')

				-- Advance the cursor.
			advance_code.generate

				-- Generate the "invariant" part.
			if i /= Void then
				context.set_assertion_type (In_loop_invariant)
				generate_test_start.call (Void)
				i.generate
				generate_test_end.call (Void)
				context.set_assertion_type (0)
			end

				-- Generate the "variant" part.
			if v /= Void then
				context.set_assertion_type (In_loop_variant)
				generate_test_start.call (Void)
				v.print_register
				generate_test_end.call (Void)
				context.set_assertion_type (0)
			end

			buf.exdent
			buf.put_new_line
			buf.put_character ('}')
		end

	print_register
			-- <Precursor>
		do
			register.print_register
		end

feature {NONE} -- Assertion generation

	generate_workbench_test
			-- Generate dynamic test in workbench mode.
		require
			context.workbench_mode
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("if (RTAL & CK_LOOP) {")
			buf.indent
		end

	generate_end_workbench_test
			-- Generate end of dynamic test in workbench mode.
		require
			context.workbench_mode
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.exdent
			buf.put_new_line
			buf.put_character ('}')
		end

	generate_final_mode_test
			-- Generate dynamic test in final mode.
		require
			not context.workbench_mode
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("if (~in_assertion) {")
			buf.indent
		end

	generate_end_final_mode_test
			-- Generate end of dynamic test in final mode.
		require
			not context.workbench_mode
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.exdent
			buf.put_new_line
			buf.put_character ('}')
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
