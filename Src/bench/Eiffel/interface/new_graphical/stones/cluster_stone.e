indexing
	description: "Stone representing a cluster"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_STONE

inherit
	SHARED_EIFFEL_PROJECT

	FILED_STONE
		redefine
			is_valid,
			synchronized_stone,
			same_as
		end

creation
	make

feature {NONE} -- Initialization

	make (clu: CLUSTER_I) is
		require
			valid_cluster: clu /= Void
		do
			cluster_i := clu
		ensure
			status_up_to_date: cluster_i = clu
		end

feature -- Access

	cluster_i: CLUSTER_I

	stone_signature: STRING is
		do
			Result := clone (cluster_i.cluster_name)
		--	Result.to_upper
		end

	header: STRING is
		do
			Result := history_name + Interface_names.l_Located_in + cluster_i.path
		end

	history_name: STRING is
			-- What represents `Current' in the history.
		do
			Result := Interface_names.s_Cluster_stone + stone_signature
		end

	file_name: FILE_NAME is
			-- Indexing clause file of the cluster.
--| FIXME XR: What is really the file name of the indexing clause????
		do
			create Result.make_from_string (cluster_i.path)
			Result.set_file_name (cluster_i.cluster_name)
			Result.add_extension ("txt")
		end
 
	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Cluster
		end
 
	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_cluster
		end
 
 	is_valid: BOOLEAN is
 			-- Does `Current' represent a valid cluster?
 		do
 			Result := Eiffel_project.initialized and then
 				cluster_i /= Void and then
 				Eiffel_universe.has_cluster_of_name (cluster_i.cluster_name)
 		end
 
 	synchronized_stone: STONE is
 			-- Return a valid stone representing the same object after a recompilation.
 		do
 			if is_valid then
 				cluster_i := Eiffel_universe.cluster_of_name (cluster_i.cluster_name)
 				Result := Current
 			else
 				Result := Void
 			end
 		end
 
 	same_as (other: STONE): BOOLEAN is
 			-- Does `other' and `Current' represent the same cluster?
 		local
 			conv_clu: CLUSTER_STONE
 		do
 			conv_clu ?= other
 			Result := conv_clu /= Void and then
 				conv_clu.cluster_i = cluster_i
 		end
 
end -- class CLUSTER_STONE
