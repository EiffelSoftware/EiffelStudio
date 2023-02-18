note
	description: "Provides functionality to build a Control Flow Graph from an Abstract Syntax Tree."
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_CFG_BUILDER

inherit
	AST_ITERATOR
		redefine
			process_if_as,
			process_elseif_as,
			process_loop_as,
			process_inspect_as,
			process_case_as,
			process_assigner_call_as,
			process_assign_as,
			process_check_as,
			process_creation_as,
			process_debug_as,
			process_guard_as,
			process_instr_call_as,
			process_retry_as,
			process_routine_as
		end

create
	make,
	make_with_feature

feature {NONE} -- Initialization

	make
			-- Initialization.
		do

		end

	make_with_feature (a_feature: attached FEATURE_AS)
			-- Initialization for `Current' using feature AST `a_feature'.
		do
			current_feature := a_feature
		ensure
			feature_set: current_feature = a_feature
		end

feature -- Actions

	set_feature (a_feature: attached FEATURE_AS)
			-- Sets the feature whose CFG shall be built to `a_feature'.
		do
			current_feature := a_feature
		ensure
			feature_set: current_feature = a_feature
		end

	build_cfg
			-- Builds the CFG for the feature that has been set.
		require
			feature_set: current_feature /= Void
			is_routine: current_feature.body.is_routine
			is_written_routine: attached {INTERNAL_AS} current_feature.body.as_routine.routine_body
		do
			if attached {INTERNAL_AS} current_feature.body.as_routine.routine_body as l_body then
				if attached l_body.compound as l_compound then
					current_label := 1
					create cfg.make (current_label, current_label + 1)
					current_label := current_label + 2
					last_block := cfg.start_node
						-- Iterate through the feature.
					process_feature_as (current_feature)
						-- Connect the last processed block to the end node.
					add_edge (last_block, cfg.end_node)
					cfg.set_max_label (current_label)
				else
						-- Create a dummy control flow graph.
					create cfg.make (1, 2)
					add_edge (cfg.start_node, cfg.end_node)
					cfg.set_max_label (2)
				end
			end
		end

	cfg: detachable CA_CONTROL_FLOW_GRAPH
			-- Last CFG that has been built.

	current_feature: detachable FEATURE_AS
			-- Feature whose CFG shall be built.

feature {NONE} -- AST Visitor

	last_block: detachable CA_CFG_BASIC_BLOCK
			-- Last processed block. Useful to connect instructions.

	exit_block: detachable CA_CFG_SKIP
			-- Block of code where all branches of an if or inspect
			-- statement go to at the end of the last instruction of the branch.

	rescue_block: detachable CA_CFG_SKIP
			-- Block of code where all instructions of a body are connected to
			-- when there is a rescue clauses.

	process_if_as (a_if: IF_AS)
		local
			l_old_jump_back, l_skip: CA_CFG_SKIP
			l_if_block: CA_CFG_IF
		do
				-- Save the jump-back of the outer compound.
			l_old_jump_back := exit_block

			create l_if_block.make_complete (a_if.condition, current_label)
			current_label := current_label + 1
			add_edge (last_block, l_if_block)
				-- The following blocks will follow this if block.
			last_block := l_if_block
				-- Create a dummy jump-back block.
			create exit_block.make (current_label)
			current_label := current_label + 1

				-- Processing the if compound.
			if a_if.compound = Void then
					-- Create direct edge to jump-back.
				add_true_edge (l_if_block, exit_block)
			else
				safe_process (a_if.compound)
				add_edge (last_block, exit_block)
			end

				-- Insert an intermediate block.
			create l_skip.make (current_label)
			current_label := current_label + 1
			add_false_edge (l_if_block, l_skip)
			last_block := l_skip

			safe_process (a_if.elsif_list)
			safe_process (a_if.else_part)
				-- The last block must be an instruction.
			add_edge (last_block, exit_block)

			last_block := exit_block

				-- Restore the old jump-back.
			exit_block := l_old_jump_back
		end

	process_elseif_as (a_elseif: ELSIF_AS)
		local
			l_elseif_block: CA_CFG_IF
			l_skip: CA_CFG_SKIP
		do
			create l_elseif_block.make_complete (a_elseif.expr, current_label)
			current_label := current_label + 1
			add_edge (last_block, l_elseif_block)

			last_block := l_elseif_block

			if a_elseif.compound = Void then
				add_true_edge (l_elseif_block, exit_block)
			else
				safe_process (a_elseif.compound)
				add_edge (last_block, exit_block)
			end

				-- Insert an intermediate block.
			create l_skip.make (current_label)
			current_label := current_label + 1
			add_false_edge (l_elseif_block, l_skip)
			last_block := l_skip
		end

	process_loop_as (a_loop: LOOP_AS)
		local
			l_after_loop: CA_CFG_SKIP
			l_loop: CA_CFG_LOOP
		do
			safe_process (a_loop.iteration)

			safe_process (a_loop.from_part)

			create l_loop.make (a_loop, current_label)
			current_label := current_label + 1

			add_edge (last_block, l_loop)

			create l_after_loop.make (current_label)
			current_label := current_label + 1

			last_block := l_loop

			if a_loop.compound = Void then
				add_self_loop_edge (l_loop)
			else
				safe_process (a_loop.compound)
				add_loop_in_edge (last_block, l_loop)
			end

			add_exit_edge (l_loop, l_after_loop)
			last_block := l_after_loop
		end

	process_inspect_as (a_inspect: INSPECT_AS)
		local
			l_inspect_block: CA_CFG_INSPECT
			l_intervals: LINKED_LIST [EIFFEL_LIST [INTERVAL_AS]]
			l_old_jump_back, l_skip: CA_CFG_SKIP
		do
			l_old_jump_back := exit_block
				-- Create a dummy jump-back block.
			create exit_block.make (current_label)
			current_label := current_label + 1

				-- Extract intervals.
			create l_intervals.make
			if a_inspect.case_list /= Void then
				across a_inspect.case_list as l_cases loop
					l_intervals.extend (l_cases.interval)
				end
			end
			create l_inspect_block.make_complete (a_inspect.switch, l_intervals,
				a_inspect.else_part /= Void, current_label)
			current_label := current_label + 1
			add_edge (last_block, l_inspect_block)
			last_block := l_inspect_block

			case_number := 1
			safe_process (a_inspect.case_list)
			if a_inspect.else_part /= Void then
					-- Insert intermediate label so that the compound
					-- will be processed correctly.
				create l_skip.make (current_label)
				current_label := current_label + 1
				add_else_edge (l_inspect_block, l_skip)
				last_block := l_skip
				safe_process (a_inspect.else_part)
				add_edge (last_block, exit_block)
			end
			last_block := exit_block

			exit_block := l_old_jump_back
		end

	case_number: INTEGER
			-- The index of the current when branch inside an inspect instruction.

	process_case_as (a_case: CASE_AS)
		local
			l_inspect_block: CA_CFG_BASIC_BLOCK
		do
			l_inspect_block := last_block
			safe_process (a_case.compound)
			add_edge (last_block, exit_block)
			last_block := l_inspect_block
			case_number := case_number + 1
		end

	process_assigner_call_as (a_assigner_call: ASSIGNER_CALL_AS)
		do
			build_instruction_block (a_assigner_call)
		end

	process_assign_as (a_assign: ASSIGN_AS)
		do
			build_instruction_block (a_assign)
		end

	process_check_as (a_check: CHECK_AS)
		do
			build_instruction_block (a_check)
		end

	process_creation_as (a_creation: CREATION_AS)
		do
			build_instruction_block (a_creation)
		end

	process_debug_as (a_debug: DEBUG_AS)
		do
			build_instruction_block (a_debug)
		end

	process_guard_as (a_guard: GUARD_AS)
		do
			build_instruction_block (a_guard)
		end

	process_instr_call_as (a_instr_call: INSTR_CALL_AS)
		do
			build_instruction_block (a_instr_call)
		end

	process_retry_as (a_retry: RETRY_AS)
		local
			l_retry_instr: CA_CFG_INSTRUCTION
		do
			create l_retry_instr.make_complete (a_retry, current_label)
			current_label := current_label + 1
				-- Add normal edge between the previous instruction and the retry one.
			add_edge (last_block, l_retry_instr)
				-- Add a special edge between the retry and the beginning of the routine.
			add_edge (l_retry_instr, cfg.start_node)
		end

	process_routine_as (l_as: ROUTINE_AS)
		local
			l_rescue_clause: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
				-- If the rescue clause is missing or empty, we ignore it.
			l_rescue_clause := l_as.rescue_clause
			if l_rescue_clause /= Void and l_rescue_clause.is_empty then
				l_rescue_clause := Void
			end
				-- We create a node to represent the beginning of the rescue clauses.
				-- We will then link all assignment nodes to this one in the body.
			if l_rescue_clause /= Void then
				create rescue_block.make (current_label)
				current_label := current_label + 1
			end
			safe_process (l_as.precondition)
			safe_process (l_as.internal_locals)
			l_as.routine_body.process (Current)
			if l_rescue_clause /= Void then
					-- The last instruction processed in the body
					-- of the routine goes straight to the end.
				add_edge (last_block, cfg.end_node)
					-- When processing a rescue clause, it is as if we were starting
					-- from the beginning, not from the end of the body of the routine.
				add_edge (cfg.start_node, rescue_block)
				last_block := rescue_block
					-- When handling the rescue clauses, we do not create an edge to go back
					-- to the beginning of the routine.
				rescue_block := Void
				l_rescue_clause.process (Current)
			end
			safe_process (l_as.postcondition)
		end

feature {NONE} -- (New) Implementation

	build_instruction_block (a_instr: attached INSTRUCTION_AS)
			-- Creates an instruction CFG block for `a_instr' and inserts it
			-- into the graph at the current position.
		local
			l_new_instr_block: CA_CFG_INSTRUCTION
		do
			create l_new_instr_block.make_complete (a_instr, current_label)
			current_label := current_label + 1

			if attached {CA_CFG_IF} last_block as l_if then
				add_true_edge (l_if, l_new_instr_block)
			elseif attached {CA_CFG_LOOP} last_block as l_loop then
				add_loop_edge (l_loop, l_new_instr_block)
			elseif attached {CA_CFG_INSPECT} last_block as l_inspect then
				add_when_edge (l_inspect, l_new_instr_block, case_number)
			else
				add_edge (last_block, l_new_instr_block)
			end
			if attached rescue_block as l_block then
					-- There is a rescue clause, we need to create an edge from
					-- the current instruction to the beginning of the rescue clause
				add_edge (l_new_instr_block, l_block)
			end

			last_block := l_new_instr_block
		end

feature {NONE} -- Implementation

	current_label: INTEGER
			-- Current label counter.

	add_edge (a_from, a_to: attached CA_CFG_BASIC_BLOCK)
			-- Updates `a_from' and `a_to' so that they both have information
			-- about the edge from `a_from' to `a_to'.
		do
			a_from.add_out_edge (a_to)
			a_to.add_in_edge (a_from)
		end

	add_true_edge (a_from: attached CA_CFG_IF; a_to: attached CA_CFG_BASIC_BLOCK)
			-- Adds a "true" edge from `a_from' to `a_to'.
		do
			a_from.set_true_branch (a_to)
			a_to.add_in_edge (a_from)
		end

	add_false_edge (a_from: attached CA_CFG_IF; a_to: attached CA_CFG_BASIC_BLOCK)
			-- Adds a "false" edge from `a_from' to `a_to'.
		do
			a_from.set_false_branch (a_to)
			a_to.add_in_edge (a_from)
		end

	add_when_edge (a_from: attached CA_CFG_INSPECT; a_to: attached CA_CFG_BASIC_BLOCK; a_index: INTEGER)
			-- Adds a "when" edge from `a_from' to `a_to'.
		do
			a_from.set_when_branch (a_to, a_index)
			a_to.add_in_edge (a_from)
		end

	add_else_edge (a_from: attached CA_CFG_INSPECT; a_to: attached CA_CFG_BASIC_BLOCK)
			-- Adds an "else" edge from `a_from' to `a_to'.
		do
			a_from.set_else_branch (a_to)
			a_to.add_in_edge (a_from)
		end

	add_loop_edge (a_from: attached CA_CFG_LOOP; a_to: attached CA_CFG_BASIC_BLOCK)
			-- Adds a "loop" edge from `a_from' to `a_to'.
		do
			a_from.set_loop_branch (a_to)
			a_to.add_in_edge (a_from)
		end

	add_exit_edge (a_from: attached CA_CFG_LOOP; a_to: attached CA_CFG_BASIC_BLOCK)
			-- Adds an "exit" edge from `a_from' to `a_to'.
		do
			a_from.set_exit_branch (a_to)
			a_to.add_in_edge (a_from)
		end

	add_loop_in_edge (a_from: attached CA_CFG_BASIC_BLOCK; a_to: attached CA_CFG_LOOP)
			-- Adds a "loop-in" edge from `a_from' to `a_to'.
		do
			a_from.add_out_edge (a_to)
			a_to.set_loop_in (a_from)
		end

	add_self_loop_edge (a_loop: attached CA_CFG_LOOP)
			-- Sets edges for `a_loop' representing a loop with an
			-- empty compound.
		require
			empty_compound: a_loop.ast.compound = Void
		do
			a_loop.set_loop_branch (a_loop)
			a_loop.set_loop_in (a_loop)
		end

end
