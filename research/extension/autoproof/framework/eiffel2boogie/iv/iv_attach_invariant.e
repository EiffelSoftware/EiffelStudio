note
	description: "attach invariant in form of IV_EXPRESSION to the head of a loop"

class
	IV_ATTACH_INVARIANT

inherit
	IV_UNIVERSE_VISITOR

	IV_STATEMENT_VISITOR
create
	make

feature {NONE}

	make(a_loop_head: IV_BLOCK; a_invariant: IV_EXPRESSION)
		do
			loop_head := a_loop_head
			the_invariant := a_invariant
			is_attached := False
			attached_to_procedure := Void
		end

feature --output

	attached_to_procedure: IV_PROCEDURE
		-- the procedure in which the loop is that the invariant was attached to. Void if invariant wasn't attached anywhere.

feature	{IV_ATTACH_INVARIANT}

	loop_head: IV_BLOCK
		--loop head that the invariant should be attached to
	the_invariant: IV_EXPRESSION
		--invariant that should be attached to the loop.

feature -- universe visitor

	process_implementation (a_implementation: IV_IMPLEMENTATION)
			-- Process implementation `a_implementation'.
		do
			is_attached := False
			across a_implementation.body.statements as st loop
				st.process (Current)
			end
			if is_attached then
				attached_to_procedure := a_implementation.procedure
				is_attached := False
			end

		end

	-- features that are left empty do not need to be further inspected.
	process_function (a_function: IV_FUNCTION)
			-- Process function `a_function'.
		do
			--TODO
		end

	process_variable (a_variable: IV_VARIABLE)
			-- Process variable `a_variable'.
		do
			--TODO
		end

	process_constant (a_variable: IV_CONSTANT)
			-- Process variable `a_constant'.
		do
			--TODO
		end

	process_axiom (a_axiom: IV_AXIOM)
			-- Process axiom `a_axiom'.
		do
			--TODO
		end

	process_procedure (a_procedure: IV_PROCEDURE)
			-- Process procedure `a_procedure'.
		do
			--TODO FIXME is this needed?
		end

feature -- Statement Visitor

	process_assert (a_assert: IV_ASSERT)
			-- Process `a_assert'.
		do
			--TODO
		end

	process_assume (a_assume: IV_ASSERT)
			-- Process `a_assume'.
		do
			--TODO
		end

	process_assignment (a_assignment: IV_ASSIGNMENT)
			-- Process `a_assignment'.
		do
			--TODO
		end

	process_block (a_block: IV_BLOCK)
			-- Process `a_block'.
		local
--			ass: IV_ASSERT
--				--the loop invariant to be added.
--			ass_inf: IV_ASSERTION_INFORMATION
--			done: BOOLEAN
		do
--			--if there already is an invariant, the new one is set to the position before that one,so it is the first statement handling an invariant, otherwise it is set as the first statement overall.
--			if a_block.is_deep_equal(loop_head) then--this should also work if 2 loops are exactly the same in the eiffel code, since they will have different numbering in their names in the AST.
--				done:= False
--				ass:= Void
--				from
--					a_block.statements.start
--				until
--					a_block.statements.after
--				loop
--					if attached {IV_ASSERT} a_block.statements.item as asserti then
--						if asserti.information.type ~ "loop_inv" then
--							if not done then
--								ass_inf := asserti.information
--								create ass.make (the_invariant.twin)
--								ass.set_origin_information (asserti.origin_information)
--								ass.set_information (ass_inf)
--								ass.set_attribute_string (asserti.attribute_string)
--								done:= True
--								a_block.statements.put_left (ass)
--							end
--							if is_debugging_enabled then
--								print("%Nadded as first invariant.")
--							end
--						end
--					end
--					a_block.statements.forth
--				end
--				if ass = void then -- code if there is no previous invariant attached.
--					create ass.make (the_invariant.twin)
--					ass.set_assertion_type ("loop_inv")
----					a_block.add_statement (ass) --this doesn't work since then the statement before this one is a goto, and this one is never called.
----					a_block.add_statement_before_last (ass) --last statement is a goto, anything after this statement is ignored.
--					a_block.statements.put_front (ass) -- seems to be best option to have it in the beginning.
--				end
--				is_attached := True
--			else
--				across a_block.statements as stmtns loop
--					stmtns.item.process (Current)
--				end
--			end
		end

	process_conditional (a_conditional: IV_CONDITIONAL)
			-- Process `a_conditional'.
		do
			across a_conditional.then_block.statements as blocks loop
				blocks.process (Current)
			end
			across a_conditional.else_block.statements as blocks loop
				blocks.process (Current)
			end
		end

	process_havoc (a_havoc: IV_HAVOC)
			-- Process `a_havoc'.
		do
			--TODO
		end

	process_label (a_label: IV_LABEL)
			-- Process `a_label'.
		do
			--TODO
		end

	process_loop (a_loop: IV_LOOP)
			-- Process `a_loop'.
		do
			--TODO
		end

	process_goto (a_goto: IV_GOTO)
			-- Process `a_goto'.
		do
			--TODO
		end

	process_procedure_call (a_call: IV_PROCEDURE_CALL)
			-- Process `a_call'.
		do
			--TODO
		end

	process_return (a_return: IV_RETURN)
			-- Process `a_return'.
		do
			--TODO
		end

feature {NONE}

	is_debugging_enabled: BOOLEAN = False

feature {NONE} --implementation

	is_attached: BOOLEAN
		-- set to true as soon as the invariant has been attached.

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
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
