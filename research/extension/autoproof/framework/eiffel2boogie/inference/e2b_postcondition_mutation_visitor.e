note
	description: "Visitor to process the iv universe and perform postcondition mutation of loops to create invariants"

class
	E2B_POSTCONDITION_MUTATION_VISITOR

inherit

	IV_UNIVERSE_VISITOR

	IV_STATEMENT_VISITOR

	E2B_SHARED_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (a_universe: IV_UNIVERSE; a_verifier: E2B_VERIFIER)
			-- Initialize universe visitor.
		do
			universe := a_universe
			verifier := a_verifier
		end

feature {NONE} -- {IV_POSTCONDITION_MUTATION} -- Implementation

	universe: IV_UNIVERSE
			--the IV_UNIVERSE this AST was taken from

	implementation: IV_IMPLEMENTATION
			--the implementation that is currently being worked on.

	verifier: E2B_VERIFIER
			-- Verifier used for verification.

feature

	display_invariant(a_implementation: IV_IMPLEMENTATION; a_output: LIST[IV_EXPRESSION])
			-- This displays the generated invariants on the screen, in autoproofs window. a_implementation is the implementation of the procedure that the inviariant belongs to.
		local
--			out_inv : E2B_SUCCESSFUL_VERIFICATION
--			--add this if a new invariant was found.
--			vio: E2B_VIOLATION
--			expr_2_eiffel: IV_EXPRESSION_2_EIFFEL_POSTCONDITION
		do
--			create out_inv.set_procedure_name (a_implementation.procedure.name)
--			if not a_output.is_empty then
--				create expr_2_eiffel.make
--				--display if feature verified without invariant
--				across verifier.last_result.verified_procedures as ver_procs loop
--					if ver_procs.item.procedure_name.is_equal (a_implementation.procedure.name) then
--						--display the suggested invariants.
--						across a_output as outs loop
--							expr_2_eiffel.reset
--							outs.item.process (expr_2_eiffel)
----							ver_procs.item.add_suggested_invarant (expr_2_eiffel.output)
--							create vio.make_with_description ("code", "(message Suggested invariant) ", "Loop invariant: " + expr_2_eiffel.output)
--							ver_procs.item.add_original_error (vio)
--						end
--					end
--				end
--				-- display if feature has other parts which couldn't be verified.
--				across verifier.last_result.verification_errors as failed_procs loop
--					if failed_procs.item.procedure_name.is_equal (a_implementation.procedure.name) then
--						--display the suggested invariants.
--						across a_output as outs loop
--							expr_2_eiffel.reset
--							outs.item.process (expr_2_eiffel)
--							create vio.make_with_description ("code", "(message Suggested invariant) ", "Loop invariant: " + expr_2_eiffel.output)
--							failed_procs.item.errors.force (vio) --add the suggested invariant to errors so it is displayed.
----							failed_procs.item.add_suggested_invarant (expr_2_eiffel.output)
--						end
--					end
--				end


--			end

		end

feature -- Universe Visitor: needed processors

	process_implementation (a_implementation: IV_IMPLEMENTATION)
			-- <Precursor>
		local
			body: IV_BLOCK
		do
			implementation := a_implementation
			body := a_implementation.body
			across body.statements as st loop
				--go through all statements, find all outer loops.
				st.process (Current)
			end
		end

feature -- Statement Visitor: needed processors

	process_conditional (a_conditional: IV_CONDITIONAL)
			-- <Precursor>
		do
			--outer loops can be within if else statements.
			a_conditional.then_block.process (Current)
			a_conditional.else_block.process (Current)
		end

	process_block (a_block: IV_BLOCK)
			-- <Precursor>
		local
			body: IV_BLOCK
			mut: E2B_LOOP_INV_INFERENCE_BY_MUTATION
		do
			if a_block.name.has_substring ("loop_head") then
				if is_debugging_enabled then
					print("%NFound loop: ")
					print(a_block.name)
				end
				create mut.make (universe)
				implementation.process (mut)
				display_invariant (implementation, mut.output)
			end
		end

feature -- Universe Visitor: empty processors


	process_function (a_function: IV_FUNCTION)
			-- <Precursor>
		do
		end

	process_variable (a_variable: IV_VARIABLE)
			-- <Precursor>
		do
		end

	process_constant (a_constant: IV_CONSTANT)
			-- <Precursor>
		do
		end

	process_axiom (a_axiom: IV_AXIOM)
			-- <Precursor>
		do
		end

	process_procedure (a_procedure: IV_PROCEDURE)
			-- <Precursor>
		do
		end


feature -- Statement Visitor: empty processors

	process_assert (a_assert: IV_ASSERT)
			-- <Precursor>
		do
		end

	process_assume (a_assume: IV_ASSERT)
			-- <Precursor>
		do
		end

	process_assignment (a_assignment: IV_ASSIGNMENT)
			-- <Precursor>
		do
		end


	process_havoc (a_havoc: IV_HAVOC)
			-- <Precursor>
		do
		end

	process_label (a_label: IV_LABEL)
			-- <Precursor>
		do
		end

	process_loop (a_loop: IV_LOOP)
			-- <Precursor>
		do
		end

	process_goto (a_goto: IV_GOTO)
			-- <Precursor>
		do
		end

	process_procedure_call (a_call: IV_PROCEDURE_CALL)
			-- <Precursor>
		do
		end

	process_return (a_return: IV_RETURN)
			-- <Precursor>
		do
		end

feature {NONE}

	is_debugging_enabled: BOOLEAN = False

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2014 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
