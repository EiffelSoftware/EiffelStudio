indexing
	description:"Class which allows Ebench and Ecase to interact."
	author: "pascalf"

CLASS EC_FACADE

inherit
	WINDOWS_MANAGER

feature -- Operations on Ebench Side

	display_class_tool(class_name: STRING) is
		-- Popup the Ebench Class Tool, with class "Class_name".
		do

		end

	Update_bench is
		-- Update Bench part, since something happened on the Ecase Side.
		do

		end

	want_to_popup_cluster(cluster_name: STRING) is
		-- the user wants to popup the cluster 'cluster_name'.
		-- It did from Ecase Side.
		require
			not_void: cluster_name /= Void
		do
			internal_error := ""
			kernel_loader.initialize(cluster_name)
			if kernel_loader.has_cluster then
				kernel_loader.build_case_kernel
			else
				internal_error := "No Cluster found with this name."
			end
		end

feature  -- Operations on Ecase Side

	popup_screen is
			-- Popup the screen of Ecase, if not already displayed.
		do
			first_window.show
		end

	popdown_screen is
		-- Popdown the screen of Ecase.
		do

		end

	update_case is
		-- Update case part, since something happened on the Ebench Side.
		do

		end

	load_cluster(cluster_name: STRING) is
			-- (re)load a the cluster 'cluster'.
		do

		end

feature -- Implementation

	kernel_loader: EC_KERNEL_LOADER is 
		-- Module responsible for loading the clusters within 
		-- Ecase structure
		once
			create result
		end

	internal_error: STRING
		-- Error that we may have encountered.
invariant
	EC_FACADE_not_void: kernel_loader /= Void 
end -- EC_FACADE