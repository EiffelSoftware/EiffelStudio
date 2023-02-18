note
	description: "A rule that performs a Reaching Definitions analysis."
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CA_RD_ANALYSIS_RULE

inherit
	CA_CFG_FORWARD_RULE

feature -- CFG Node Visitor

	initialize_processing (a_cfg: attached CA_CONTROL_FLOW_GRAPH)
		local
			n, j: INTEGER
			l_init_set: LINKED_SET [INTEGER]
		do
			n := a_cfg.max_label

				-- Initialize Reaching Definitions data structures.
			create rd_entry.make (n)
			create rd_exit.make (n)

			from j := 1
			until j > n
			loop
				rd_entry.extend (create {HASH_TABLE [LINKED_SET [INTEGER], INTEGER]}.make (0))
				rd_exit.extend (create {HASH_TABLE [LINKED_SET [INTEGER], INTEGER]}.make (0))
				j := j + 1
			end

				-- Since local expanded variables are initialized to their default values we
				-- count this as an assignment.
			if current_feature.locals /= Void then
				across current_feature.locals as l_locals loop
					across l_locals.id_list as l_id_list loop
						create l_init_set.make
						l_init_set.extend (0)
						rd_entry.at (a_cfg.start_node.label).extend (l_init_set, l_id_list)
					end
				end
			end

		end

	visit_edge (a_from, a_to: attached CA_CFG_BASIC_BLOCK): BOOLEAN
		do
			if attached {CA_CFG_INSTRUCTION} a_from as l_instr then
				process_instruction (l_instr)
				Result := rd_changed
			else
				process_default (a_from.label)
				Result := rd_changed
			end

			node_union (a_from.label, a_to.label)
			Result := rd_changed or Result
		end

feature {NONE} -- Implementation

	rd_changed: BOOLEAN
			-- Has the last operation (merge, copy, etc.) changed the affected
			-- data structures?

	node_union (a_from, a_to: INTEGER)
			-- Merges the RDs at the exit `a_from' into those
			-- at the entry of `a_to'.
		local
			l_from_table, l_to_table: HASH_TABLE [LINKED_SET [INTEGER], INTEGER]
			l_old_count, l_key: INTEGER
			l_item, l_new: LINKED_SET [INTEGER]
		do
			rd_changed := False

			l_from_table := rd_exit.at (a_from)
			l_to_table := rd_entry.at (a_to)

			from l_from_table.start
			until l_from_table.after loop

				l_key := l_from_table.key_for_iteration
				l_item := l_from_table.item_for_iteration

				if l_to_table.has (l_key) then
					l_old_count := l_to_table.at (l_key).count
					l_to_table.at (l_key).merge (l_item)
					rd_changed := (l_old_count /= l_to_table.at (l_key).count) or rd_changed
				else
					create l_new.make
					l_new.copy (l_item)
					l_to_table.extend (l_new, l_key)
					rd_changed := True
				end

				l_from_table.forth
			end
		end

	process_default (a_label: INTEGER)
			-- Processes a node (with label `a_label') that is not an assignment.
		local
			l_entry_table, l_exit_table: HASH_TABLE [LINKED_SET [INTEGER], INTEGER]
			l_old_count, l_key: INTEGER
			l_item, l_new: LINKED_SET [INTEGER]
		do
			rd_changed := False

			l_entry_table := rd_entry [a_label]
			l_exit_table := rd_exit [a_label]

			from l_entry_table.start
			until l_entry_table.after loop

				l_key := l_entry_table.key_for_iteration
				l_item := l_entry_table.item_for_iteration

				if l_exit_table.has (l_key) then
					l_old_count := l_exit_table.at (l_key).count
					l_exit_table [l_key].copy (l_item)
					rd_changed := (l_old_count /= l_exit_table [l_key].count) or rd_changed
				else
					create l_new.make
					l_new.copy (l_item)
					l_exit_table.extend (l_new, l_key)
					rd_changed := True
				end

				l_entry_table.forth
			end
		end

	process_instruction (a_instr: attached CA_CFG_INSTRUCTION)
			-- Processes the instruction node `a_instr'.
		local
			l_old_count, l_label, l_var_id: INTEGER
			l_rd: LINKED_SET [INTEGER]
		do
			l_label := a_instr.label
			l_old_count := rd_exit [l_label].count

			if
				attached {ASSIGN_AS} a_instr.instruction as l_assign
				and then attached {ACCESS_ID_AS} l_assign.target as l_id
				and then l_id.is_local
			then
				l_var_id := l_id.feature_name.name_id

					-- Remove all previous RD entries.
				rd_exit [l_label].remove (l_var_id)
				create l_rd.make
				l_rd.extend (l_label)
				rd_exit [l_label].extend (l_rd, l_var_id)
			else
					-- Just copy from entry to exit.
				process_default (l_label)
			end

			rd_changed := (l_old_count /= rd_exit [l_label].count) or rd_changed
		end

	rd_entry, rd_exit: ARRAYED_LIST [HASH_TABLE [LINKED_SET [INTEGER], INTEGER]]
			-- Hash table mapping variable IDs to sets of labels where the variable may have been defined.

end
