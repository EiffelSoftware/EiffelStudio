indexing

	description: 
		"Abstract class for iconifying/deiconfying clusters.";
	date: "$Date$";
	revision: "$Revision $"


deferred class ICONIZATION

inherit

	UNDOABLE_EFC

feature -- Update

	graphicals_update is
		do
			workareas.refresh;
			System.set_is_modified
		end;

	redo is
		-- Re-execute command (after it was undone)
		deferred
		end; -- redo

	undo is
		-- Cancel effect of executing the command
		deferred
		end -- undo

feature {NONE} -- Implementation property

	cluster : CLUSTER_DATA
			-- New cluster iconized/deiconized

feature {NONE} -- Implementation

	iconize is
			-- iconize 'cluster'
		do
			cluster.set_icon (true);
			workareas.iconify_cluster (cluster);
		end; -- iconize

	deiconize is
			-- deiconize 'cluster'
		do
			cluster.set_icon (false);
			workareas.uniconify_cluster (cluster);
		end -- deiconize

invariant

	has_cluster : cluster /= Void

end -- ICONIZATION
