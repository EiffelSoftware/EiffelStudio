note
	description	: "Enlarged byte code for Eiffel loops."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class LOOP_BL

inherit
	LOOP_B
		redefine
			analyze, generate
		end

	VOID_REGISTER
		export
			{NONE} all
		end

	ASSERT_TYPE
		export
			{NONE} all
		end

feature -- Access

	analyze
			-- Builds a proper context (for C code).
		local
			workbench_mode: BOOLEAN
			check_loop: BOOLEAN
		do
			if attached iteration_initialization as i then
				i.analyze
			end
			if from_part /= Void then
				from_part.analyze
			end
			context.init_propagation
			workbench_mode := context.workbench_mode
			check_loop := workbench_mode or else
				context.assertion_level.is_loop

			if check_loop then
				if variant_part /= Void then
					if workbench_mode then
						context.add_dt_current
					end
					variant_part.analyze
				end
				if invariant_part /= Void then
					if workbench_mode then
						context.add_dt_current
					end
					invariant_part.analyze
				end
			end

			if attached iteration_exit_condition as e then
				e.propagate (No_register)
				e.analyze
			end
			if attached stop as s then
				s.propagate (No_register)
				s.analyze
			end

			if compound /= Void then
				compound.analyze
			end

			if attached advance_code as a then
				a.analyze
			end

			if check_loop and then variant_part /= Void then
				variant_part.free_register
			end
		end

	generate
			-- Generate C code in `buffer'.
		do
			generate_line_info
			generate_assertions
			generate_loop_body
		end

	generate_assertions
		local
			generate_invariant, generate_variant, workbench_mode: BOOLEAN
		do
			workbench_mode := context.workbench_mode
			if workbench_mode or else context.assertion_level.is_loop then
				generate_variant := variant_part /= Void
				generate_invariant := invariant_part /= Void
			end

				-- Generate iteration initialization.
			if attached iteration_initialization as i then
				i.generate
			end

				-- Generate the "from" part
			if from_part /= Void then
				from_part.generate
			end

			if workbench_mode or else system.exception_stack_managed then
					-- Record the place where we will generate
					-- the hook for the invariant
				invariant_breakpoint_slot := get_current_frozen_debugger_hook
			end

				-- Generate the "invariant" part
			if generate_invariant then
				context.set_assertion_type (In_loop_invariant)
				if workbench_mode then
					generate_workbench_test
					invariant_part.generate
					generate_end_workbench_test
				else
					generate_final_mode_test
					invariant_part.generate
					generate_end_final_mode_test
				end
				context.set_assertion_type (0)
			end

				-- Generate the "variant" part
			if generate_variant then
				context.set_assertion_type (In_loop_variant)
				if workbench_mode then
					generate_workbench_test
					variant_part.generate
					generate_end_workbench_test
				else
					generate_final_mode_test
					variant_part.generate
					generate_end_final_mode_test
				end
				context.set_assertion_type (0)
			end
		end

	generate_loop_body
		local
			generate_invariant, generate_variant, workbench_mode: BOOLEAN
			buf: GENERATION_BUFFER
			body_breakpoint_slot: INTEGER
				-- Number of the first breakpoint slot of the
				-- "body" clause.
			check_slot: INTEGER -- debugging purpose
		do
			buf := buffer
			workbench_mode := context.workbench_mode
			if workbench_mode or else context.assertion_level.is_loop then
				generate_invariant := invariant_part /= Void
				generate_variant := variant_part /= Void
			end

			debug ("DEBUGGER_HOOK")
				check_slot := get_current_frozen_debugger_hook
			end

			buffer.put_new_line
			buf.put_string ("for (;;) {")
			buf.indent

			if attached iteration_exit_condition as e then
					-- Generate iteration exit condition.
				e.generate
				buffer.put_new_line
				buf.put_string ("if (")
				e.print_register
				buf.put_string (") break;")
			end

			if attached stop as s then
					-- Generate loop exit condition.
				generate_frozen_debugger_hook
				s.generate
				buffer.put_new_line
				buf.put_string ("if (")
				s.print_register
				buf.put_string (") break;")
			end

			if compound /= Void then
				compound.generate
			end

			if attached advance_code as a then
				a.generate
			end

			if workbench_mode or else system.exception_stack_managed then
					-- Save the hook number
				body_breakpoint_slot := get_current_frozen_debugger_hook
					-- Restore the hook number to the one recorded when
					-- first generating the invariant clause.
				set_current_frozen_debugger_hook (invariant_breakpoint_slot)
			end

				-- Regenerate the invariant clause	
			if generate_invariant then
				context.set_assertion_type (In_loop_invariant)
				if workbench_mode then
					generate_workbench_test
					invariant_part.generate
					generate_end_workbench_test
				else
					generate_final_mode_test
					invariant_part.generate
					generate_end_final_mode_test
				end
				context.set_assertion_type (0)
			end
				-- Regenerate the variant clause	
			if generate_variant then
				if workbench_mode then
					generate_workbench_test
					variant_part.print_register
					generate_end_workbench_test
				else
					generate_final_mode_test
					variant_part.print_register
					generate_end_final_mode_test
				end
			end

			debug ("DEBUGGER_HOOK")
				if get_current_frozen_debugger_hook /= check_slot then
					io.put_string ("LOOP_BL: Error in breakpoint slots generation for loop.%N")
				end
			end

			if workbench_mode or else system.exception_stack_managed then
					-- Restore the hook number
				set_current_frozen_debugger_hook (body_breakpoint_slot)
			end

			buf.exdent
			buf.put_new_line
			buf.put_character ('}')
		end

	generate_workbench_test
			-- Generate dynamic test in workbench mode
		require
			workbench_mode: context.workbench_mode
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("if (RTAL & CK_LOOP) {")
			buf.indent
		end

	generate_end_workbench_test
			-- Generate end of dynamic test in workbench mode
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
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("if (~in_assertion) {")
			buf.indent
		end

	generate_end_final_mode_test
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.exdent
			buf.put_new_line
			buf.put_character ('}')
		end

	fill_from (l: LOOP_B)
			-- Fill in current node
		do
			iteration_initialization := l.iteration_initialization
			if attached iteration_initialization as i then
				i.enlarge_tree
			end
			from_part := l.from_part
			if from_part /= Void then
				from_part.enlarge_tree
			end
			invariant_part := l.invariant_part
			if invariant_part /= Void then
				invariant_part.enlarge_tree
			end
			variant_part := l.variant_part
			if variant_part /= Void then
				variant_part := variant_part.enlarged
			end
			if attached l.iteration_exit_condition as e then
				iteration_exit_condition := e.enlarged
			end
			if attached l.stop as s then
				stop := s.enlarged
			end
			compound := l.compound
			if compound /= Void then
				compound.enlarge_tree
			end
			advance_code := l.advance_code
			if attached advance_code as a then
				a.enlarge_tree
			end
			line_number := l.line_number
		end

feature {NONE} -- Implementation

	invariant_breakpoint_slot: INTEGER;
			-- Number of the first breakpoint slot of the
			-- "invariant/variant" clause.

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
