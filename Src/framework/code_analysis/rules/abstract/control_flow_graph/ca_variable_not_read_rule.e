note
	description: "[
			RULE #20: Variable not read after assignment.
	
			An assignment to a local variable has no
			effect at all if the variable is not read after the assignment, and
			before it is reassigned or out of scope. This rule is only checked on
			variables of expanded types.
		]"
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_VARIABLE_NOT_READ_RULE

inherit
	CA_CFG_BACKWARD_RULE
		redefine
			check_feature
		end

	AST_ITERATOR
		redefine
			process_access_id_as,
			process_converted_expr_as
		end

	SHARED_LOCALE

create
	make

feature {NONE} -- Initialization

	make
			-- Creates the rule and initializes it for checking.
		do
			make_with_defaults
			default_severity_score := 70
			create assignment_nodes.make
			create lv_entry.make (1)
			create lv_exit.make (1)
		ensure
			is_empty: is_empty
		end

feature -- Status report

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result :=
				assignment_nodes.is_empty and then
				lv_entry.is_empty and then
				lv_exit.is_empty
		ensure then
			assignment_nodes_is_empty: Result implies assignment_nodes.is_empty
			lv_entry_is_empty: Result implies lv_entry.is_empty
			lv_exit_is_empty: Result implies lv_exit.is_empty
		end

feature -- Initialization

	wipe_out
			-- <Precursor>
		do
			assignment_nodes.wipe_out
			lv_entry.wipe_out
			lv_exit.wipe_out
		end

feature {NONE} -- From {CA_CFG_RULE}

	check_feature (a_class: CLASS_C; a_feature: E_FEATURE)
			-- Checks `a_feature' from `a_class' for dead assignments.
		local
			l_assigned_id: INTEGER
		do
			Precursor (a_class, a_feature)
				-- Iterate through all assignments in search for dead assignments.
			across assignment_nodes as l_assigns loop
				if attached {ASSIGN_AS} l_assigns.instruction as l_assign then
					l_assigned_id := extract_assigned (l_assign.target)
					if
						l_assigned_id /= -1 and then
						not lv_exit.at (l_assigns.label).has (l_assigned_id) and then
							-- There is no good replacement for assignments of detachable expressions to a variable,
							-- because, in such cases, the assignment "target := source" cannot be replaced with "source.do_nothing".
						current_context.checking_class.lace_class.is_void_safe_conformance and then
						attached current_context.node_type (l_assign.source, current_feature.associated_feature_i) as t and then
						t.is_attached
					then
						put_violation
							(locale.translation_in_context ("Local {1} is not read after assignment.", once "code_analyzer.violation"),
							<<agent {TEXT_FORMATTER}.process_local_text (l_assign.target, l_assign.target.access_name_32)>>,
							locale.translation_in_context ("The value assigned to the local variable {1} is never read.", once "code_analyzer.violation"),
							<<agent {TEXT_FORMATTER}.process_local_text (l_assign.target, l_assign.target.access_name_32)>>,
							l_assign.target.index)
					end
				elseif attached {CREATION_AS} l_assigns.instruction as l_creation then
					l_assigned_id := extract_assigned (l_creation.target)
					if
						l_assigned_id /= -1 and then
						not lv_exit.at (l_assigns.label).has (l_assigned_id)
					then
						put_violation
							(locale.translation_in_context ("Local {1} is not read after initialization by creation instruction.", once "code_analyzer.violation"),
							<<agent {TEXT_FORMATTER}.process_local_text (l_creation.target, l_creation.target.access_name_32)>>,
							locale.translation_in_context ("The value attached to the local variable {1} by the creation instruction is never read.", once "code_analyzer.violation"),
							<<agent {TEXT_FORMATTER}.process_local_text (l_creation.target, l_creation.target.access_name_32)>>,
							l_creation.target.index)
					end
				end
			end
		end

feature -- Node Visitor

	initialize_processing (a_cfg: CA_CONTROL_FLOW_GRAPH)
			-- Prepares data structures for the worklist algorithm on
			-- the CFG `a_cfg'.
		local
			n, j: INTEGER
		do
			n := a_cfg.max_label
			lv_entry.grow (n)
			lv_exit.grow (n)
			from
				j := 1
			until
				j > n
			loop
				lv_entry.extend (create {LINKED_SET [INTEGER]}.make)
				lv_exit.extend (create {LINKED_SET [INTEGER]}.make)
				j := j + 1
			end
		end

	visit_edge (a_from, a_to: CA_CFG_BASIC_BLOCK): BOOLEAN
			-- Is called when a CFG edge from `a_from' to `a_to' is being visited. Here, the data
			-- about live variables at the nodes will be updated.
		do
			Result := node_union (a_from.label, a_to.label)
			if attached {CA_CFG_INSTRUCTION} a_from as l_instr then
				Result := process_instr (l_instr) or Result
			elseif attached {CA_CFG_IF} a_from as l_if then
				Result := process_if (l_if) or Result
			elseif attached {CA_CFG_LOOP} a_from as l_loop then
				Result := process_loop (l_loop) or Result
			elseif attached {CA_CFG_INSPECT} a_from as l_inspect then
				Result := process_inspect (l_inspect) or Result
			else
				Result := process_default (a_from.label) or Result
			end
		end

feature {NONE} -- Implementation

	node_union (a_from, a_to: INTEGER): BOOLEAN
			-- Merges the live variables at the entry `a_to' into those
			-- at the exit of `a_from'.
		local
			l_old_count: INTEGER
		do
			l_old_count := lv_exit.at (a_from).count
			lv_exit.at (a_from).merge (lv_entry.at (a_to))
			Result := l_old_count /= lv_exit.at (a_from).count
		end

	process_default (a_from: INTEGER): BOOLEAN
			-- Copies the live variables from the exit of `a_from' to
			-- the entry of `a_from'.
		local
			l_old_count: INTEGER
		do
			l_old_count := lv_entry.at (a_from).count
			lv_entry.at (a_from).copy (lv_exit.at (a_from))
			Result := l_old_count /= lv_entry.at (a_from).count
		end

	process_instr (a_from: CA_CFG_INSTRUCTION): BOOLEAN
			-- Processes the instruction node `a_from'. If the instruction
			-- is an assignment or a creation then the live variables will be
			-- pruned. All other free variables will be added to the live variables.
			-- If anything has changed then Result = True, otherwise False.
		local
			l_old_count, l_assigned_id: INTEGER
			l_lv: LINKED_SET [INTEGER]
		do
			l_old_count := lv_entry.at (a_from.label).count
			create l_lv.make
			l_lv.copy (lv_exit.at (a_from.label))
			if attached {ASSIGN_AS} a_from.instruction as l_assign then
				l_assigned_id := extract_assigned (l_assign.target)
				l_lv.prune (l_assigned_id)
				extract_generated (l_assign.source)
				l_lv.merge (generated)
					-- Make sure the node is stored for later lookup:
				if l_assigned_id /= -1 then
					assignment_nodes.extend (a_from)
				end
			elseif attached {CREATION_AS} a_from.instruction as l_creation then
				l_assigned_id := extract_assigned (l_creation.target)
				l_lv.prune (l_assigned_id)
				if attached l_creation.call as l_call then
					extract_generated (l_creation.call)
					l_lv.merge (generated)
				end
				if l_assigned_id /= -1 then
					assignment_nodes.extend (a_from)
				end
			else
				extract_generated (a_from.instruction)
				l_lv.merge (generated)
			end
			lv_entry.at (a_from.label).merge (l_lv)

			Result := l_old_count /= lv_entry.at (a_from.label).count
		end

	process_if (a_from: CA_CFG_IF): BOOLEAN
			-- Adds to lv_entry (`a_from'): lv_exit (`a_from') with gen's added.
			-- If something could be added then Result = True, otherwise False.
		local
			l_old_count: INTEGER
		do
			l_old_count := lv_entry.at (a_from.label).count
			lv_entry.at (a_from.label).copy (lv_exit.at (a_from.label))
			extract_generated (a_from.condition)
			lv_entry.at (a_from.label).merge (generated)
			Result := l_old_count /= lv_entry.at (a_from.label).count
		end

	process_loop (a_from: CA_CFG_LOOP): BOOLEAN
			-- Adds to lv_entry (`a_from'): lv_exit (`a_from') with gen's added.
			-- If something could be added then Result = True, otherwise False.
		local
			l_old_count: INTEGER
		do
			l_old_count := lv_entry.at (a_from.label).count
			lv_entry.at (a_from.label).copy (lv_exit.at (a_from.label))
			if attached a_from.ast.iteration as l_iter then
				extract_generated (l_iter)
				lv_entry.at (a_from.label).merge (generated)
			end
			if attached a_from.ast.stop as l_stop then
				extract_generated (l_stop)
				lv_entry.at (a_from.label).merge (generated)
			end
			Result := l_old_count /= lv_entry.at (a_from.label).count
		end

	process_inspect (a_from: CA_CFG_INSPECT): BOOLEAN
			-- Adds to lv_entry (`a_from'): lv_exit (`a_from') with gen's added.
			-- If something could be added then Result = True, otherwise False.
		local
			l_old_count: INTEGER
		do
			l_old_count := lv_entry.at (a_from.label).count
			lv_entry.at (a_from.label).copy (lv_exit.at (a_from.label))
			extract_generated (a_from.expression)
			lv_entry.at (a_from.label).merge (generated)
			Result := l_old_count /= lv_entry.at (a_from.label).count
		end

feature {NONE} -- Extracting Used Variables

	generated: detachable LINKED_SET [INTEGER]
		-- Set of generated variables, created by `extract_generated'.

	extract_generated (a_ast: AST_EIFFEL)
			-- Extracts all free (and local) variables from `a_ast' and stores them
			-- in `generated'.
		do
			create generated.make
				-- Delegate to AST visitor. We will only look at Access IDs
				-- that occur in `a_ast'.
			a_ast.process (Current)
		end

	process_access_id_as (a_access_id: ACCESS_ID_AS)
			-- Adds a free variable from `a_access_id', if available.
		do
			Precursor (a_access_id)
			if is_local (a_access_id) then
				generated.extend (a_access_id.feature_name.name_id)
			end
		end

	process_converted_expr_as (a_conv: CONVERTED_EXPR_AS)
			-- Needed for expressions like "$foo". Adds a free variable from
			-- `a_conv', if available.
		do
			Precursor (a_conv)
			if attached {ADDRESS_AS} a_conv.expr as l_address then
				generated.extend (l_address.feature_name.feature_name.name_id)
			end
		end

feature {NONE} -- Extracting Assignments

	extract_assigned (a_target: ACCESS_AS): INTEGER
			-- Extracts the variable ID of the target `a_target' of an
			-- assignment if a local variable gets assigned. If no local
			-- variable gets assigned then Result = -1.
		do
			Result := -1
			if attached {ACCESS_ID_AS} a_target as l_id and then is_local (l_id) then
					-- Something is assigned to a local variable.
				Result := l_id.feature_name.name_id
			end
		end

feature {NONE} -- Utilities

	is_local (a_id: ACCESS_ID_AS): BOOLEAN
			-- Is `a_id' a local?
		do
			Result := a_id.is_local
		end

feature {NONE} -- Analysis data

	lv_entry, lv_exit: ARRAYED_LIST [LINKED_SET [INTEGER]]
			-- List containing a set of name IDs (live variables) for the CFG labels.

	assignment_nodes: LINKED_SET [CA_CFG_INSTRUCTION]
			-- Set of CFG nodes that represent an assignment or a creation.

feature -- Properties

	name: STRING = "unread_variable"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.variable_not_read_title
		end

	description: STRING_32
			-- <Precursor>
		do
			Result :=  ca_names.variable_not_read_description
		end

	id: STRING_32 = "CA020"
			-- <Precursor>

	format_violation_description (violation: CA_RULE_VIOLATION; formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
		end

end
