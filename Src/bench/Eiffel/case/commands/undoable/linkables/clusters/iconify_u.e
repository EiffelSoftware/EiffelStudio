indexing

	description: 
		"Undoable command to iconify a cluster.";
	date: "$Date$";
	revision: "$Revision $"

class ICONIFY_U

inherit

	ICONIZATION

creation

	make

feature -- Initialization

	make (a_cluster : CLUSTER_DATA) is
			-- Iconify a cluster.
		require
			a_cluster /= void;
			not a_cluster.is_icon
		do
			record
			cluster := a_cluster
			!! compress_links_u.make (cluster, True)
			redo
		ensure
			cluster_correctly_set : cluster = a_cluster
		end

feature -- Property

	name: STRING is "Iconify cluster"

feature -- Update

	redo is
			-- Re-execute command (after it was undone)
		do
			compress_links_u.redo
			iconize
			graphicals_update
		end

	undo is
			-- Cancel effect of executing the command
		do
			compress_links_u.undo
			deiconize
			graphicals_update
		end

feature {NONE}

	compress_links_u: COMPRESS_LINKS_U;
			-- Compression of the link

end -- ICONIFY_U
