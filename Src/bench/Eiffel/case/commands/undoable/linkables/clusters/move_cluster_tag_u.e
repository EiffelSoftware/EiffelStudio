indexing

	description: 
		"Undoable command for moving a cluster tag.";
	date: "$Date$";
	revision: "$Revision $"

class MOVE_CLUSTER_TAG_U 

inherit

	UNDOABLE_EFC

creation

	make

feature -- Initialization

	make (figure: like cluster; x: like relative_x; invert: like invert_tag_location) is
			-- Move a cluster's tag.
		require
			figure_exists: figure /= void
		do
			record
			cluster := figure
			relative_x := x
			invert_tag_location := invert
			redo
		end

feature -- Propery

	name: STRING is "Move cluster's tag"

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			cluster.set_tag_relative_x (cluster.tag_relative_x+relative_x);
			if invert_tag_location then
				cluster.set_tag_south (not cluster.tag_is_south)
			end;
			workareas.change_cluster_tag (cluster)
			workareas.refresh
		end

	undo is
			-- Cancel effect of executing the command.
		do
			cluster.set_tag_relative_x (cluster.tag_relative_x-relative_x);
			if invert_tag_location then
				cluster.set_tag_south (not cluster.tag_is_south)
			end;
			workareas.change_cluster_tag (cluster)
			workareas.refresh
		end

feature {NONE} -- Implementation

	cluster: CLUSTER_DATA;
			-- Figure moved

	relative_x: INTEGER;
			-- Relative horizontal translation

	invert_tag_location: BOOLEAN

invariant

	cluster /= void

end
