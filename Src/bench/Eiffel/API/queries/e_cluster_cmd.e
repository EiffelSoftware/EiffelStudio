indexing
	description:
		"General notion of an eiffel query command (semantic unity)%
		%for a cluster. Display output for current command for%
		%associated cluster to output_window."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	E_CLUSTER_CMD

inherit
	E_OUTPUT_CMD
		rename
			make as cmd_make
		export
			{NONE} cmd_make
		redefine
			executable, execute
		end

feature -- Initialization

	make (a_cluster: CLUSTER_I) is
			-- Make current command with current_cluster as
			-- `a_cluster'.
		require
			valid_a_cluster_i: a_cluster /= Void
		do
			current_cluster := a_cluster	
			create structured_text.make
		ensure
			cluster_set: current_cluster = a_cluster
			structured_text_exists: structured_text /= Void
		end

feature -- Property

	current_cluster: CLUSTER_I
			-- Class for current action

	executable: BOOLEAN is
			-- Is the Current able to be executed?
		do
			Result := current_cluster /= Void and then
				structured_text /= Void
		ensure then
			good_result: Result implies current_cluster /= Void
		end

feature -- Execution

	execute is
			-- Execute the current command. Add a before and after
			-- declaration to `structured_text'
			-- and invoke `work'.
		do
			structured_text.add (ti_Before_cluster_declaration)
			work
			structured_text.finish
			structured_text.add (ti_After_cluster_declaration)
		end

	work is
			-- Perform the command only.
		deferred
		end

feature {NONE} -- Implementation

	sorted_list (list: LINKED_LIST [CLASS_C]): SORTED_TWO_WAY_LIST [CLASS_I] is
			-- Sorted `list' based on `class_name' from `CLASS_I'
		require
			valid_list: list /= Void
		do
			create Result.make
			from
				list.start
			until
				list.after
			loop
				Result.put_front (list.item.lace_class)
				list.forth
			end
			Result.sort
		ensure
			valid_Result: Result /= Void
			sorted: Result.sorted
		end
--| FIXME
--| christophe, 1 dec 1999
--| Is this feature useful? It has been copied from E_CLASS_CMD.

end -- class E_CLUSTER_CMD
