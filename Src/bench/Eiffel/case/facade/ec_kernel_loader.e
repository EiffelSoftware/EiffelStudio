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

creation
	make

feature -- Creation

	make is
		do
			create system_classes.make(100)
			text_bar := windows_manager.first_window.text_bar
			progress_bar := windows_manager.first_window.progress_bar
		end

feature -- Process

	initialize(cluster_name: STRING) is
			-- Initialize a Cluster Loading.
		require
			not_void: cluster_name /= Void
		do
			cluster_data := Void
			cluster_to_load := universe.cluster_of_name(cluster_name)
			system_classes.wipe_out	
		--	case_system.system_classes.wipe_out		
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
		local
			cluster_info: EC_CLUSTER_INFO
			inherit_info: EC_INHERIT_INFO
			client_info: EC_CLIENT_INFO
			i,j,total: INTEGER
			s: STRING
		do
			-- Create the Clusters and the Classes
			text_bar.set_text("Preparing Classes and Clusters ...")
			total := compute_total(cluster_to_load)
			create cluster_info.make(clone(cluster_to_load),system_classes,0,total)
			cluster_data := cluster_info.cluster
			cluster_data.set_is_root

			-- Create the links
			text_bar.set_text("Preparing links ... ")
			from
				i := 0
				total := system_classes.count
				system_classes.start
				create inherit_info.make(system_classes)
				create client_info.make(system_classes)
			until
				system_classes.after
			loop
				j := (i*100)//total
				s:=j.out
				s.append(" %%")
				progress_bar.set_text(j.out)
				inherit_info.build(system_classes.item_for_iteration)
				client_info.build(system_classes.item_for_iteration)
				i:= i+1
				system_classes.forth
			end
			progress_bar.set_text("")
			text_bar.set_text("")
		end

	compute_total(cl: CLUSTER_I): INTEGER is
		do
			from
				cl.sub_clusters.start
			until
				cl.sub_clusters.after
			loop
				Result := compute_total(cl.sub_clusters.item) + Result
				cl.sub_clusters.forth
			end
			Result := Result + cl.classes.count
		end

feature -- Implementation

	cluster_to_load: CLUSTER_I
		-- Root of the Ebench Kernel Structure

	cluster_data: CLUSTER_DATA
		-- Root of the Case Kernel Structure

	system_classes: HASH_TABLE [ EC_CLASS_INFO, INTEGER ]
		-- Classes in system.

feature -- graphical

	text_bar: EV_STATUS_BAR_ITEM
		-- Progress bar

	progress_bar: EV_STATUS_BAR_ITEM
		-- For the moment

invariant
	EC_KERNEL_LOADER_not_void: system_classes /= Void and text_bar /= Void

end -- class EC_KERNEL_LOADER
