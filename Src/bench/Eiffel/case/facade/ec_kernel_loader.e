indexing
	description: "Class responsible for loading/translating %
					%Ebench structure within Ecase kernel."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_KERNEL_LOADER

inherit
	SHARED_WORKBENCH
		rename
			system as bench_system
		end

	ONCES
		rename
			system as case_system
		end

feature -- Process

	initialize(cluster_name: STRING) is
			-- Initialize a Cluster Loading.
		require
			not_void: cluster_name /= Void
		do
			cluster_to_load := universe.cluster_of_name(cluster_name)			
		end

	has_cluster: BOOLEAN is
			-- Has the cluster with 'cluster_name' found ?
		do
			Result := cluster_to_load /= Void	
		end

	build_case_kernel is
			-- Build the structure
		require
			has_cluster
		do
			!! cluster_data.make_root_for_window(cluster_to_load)
		end

feature -- Implementation

	cluster_to_load: CLUSTER_I
		-- Root of the Ebench Kernel Structure

	cluster_data: CLUSTER_DATA
		-- Root of the Case Kernel Structure

end -- class EC_KERNEL_LOADER
