indexing
	description: "Tree View of the entities of the system"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_COMPONENT

inherit
	GRAPHICAL_COMPONENT[CLUSTER_DATA]
		redefine
			make,
			update
		end

	ONCES

	CONSTANTS

creation
	make

feature -- Initialization

	make (cont: EV_CONTAINER; caller: EC_EDITOR_WINDOW [ANY]) is
			-- Initialize
		local
			h1: EV_HORIZONTAL_BOX
			com: EV_ROUTINE_COMMAND

			tool_command: CREATE_EDITOR_FROM_TREE
		do
			precursor(cont, caller)
			main_window ?= caller

			if main_window /= Void then
				entity := main_window.entity
			end

			!! v1.make(cont)
			v1.set_homogeneous(FALSE)
			v1.set_minimum_width(100)	
	
			!! tree.make ( v1 )
			!! com.make(~hide_show)
			tree.add_selection_command(com, Void)

			!! h1.make(v1)
			h1.set_expand(FALSE)
			!! hide_show_b.make_with_text(h1,"Hide/Show")
			!! tool_b.make_with_text(h1,widget_names.edit)
			hide_show_b.set_vertical_resize(FALSE)
			tool_b.set_vertical_resize(FALSE)
		
			!! tool_command.make (tree, caller_window)
			tool_b.add_click_command (tool_command, Void)

			observer_management.add_observer (system, Current)

			!! classes.make(20)
			!! clusters.make(20)
		end

feature -- Access

	tool_b,hide_show_b: EV_BUTTON

	v1: EV_VERTICAL_BOX

	root: LINKABLE_TREE_ITEM

	classes: HASH_TABLE [LINKABLE_TREE_ITEM, STRING]
	
	clusters: HASH_TABLE [LINKABLE_TREE_ITEM, STRING]

feature -- Updates

	update is
		do
			update_from(main_window.entity,root)
		end

	update_from(cluster: CLUSTER_DATA;tree_item: LINKABLE_TREE_ITEM) is
			-- Update Current with cluster 'cluster'.
		require else
			cluster_exists: cluster /= Void
		do
			clean_cluster(cluster,tree_item)
			add_entities(cluster,tree_item)
		end

	clean_cluster(cluster: CLUSTER_DATA;tree_item: LINKABLE_TREE_ITEM) is
			-- Updating the content of cluster cluster.
		local
			it,itt: LINKABLE_TREE_ITEM
			cluster_data: CLUSTER_DATA
			linkable_data: LINKABLE_DATA
		do	
			if root = Void then
				 !! root.make_with_linkable(tree, entity, Void)
				 clusters.put(root, root.name)
			end
			-- Cleaning the structure
			from
				classes.start
			until
				classes.after
			loop
				it := classes.item_for_iteration
				linkable_data := classes.item_for_iteration.linkable
				itt := clusters.item(linkable_data.parent_cluster.name)
				if itt /= Void then
					it.set_parent(itt)
				else
					--it.destroy
				end	
				classes.forth
			end

			from
				clusters.start
			until
				clusters.after
			loop
				itt := Void
				it := clusters.item_for_iteration
				cluster_data ?= clusters.item_for_iteration.linkable
				if cluster_data=Void or else not cluster_data.is_root then
					itt := clusters.item(clusters.item_for_iteration.linkable.parent_cluster.name)
				end
				cluster_data ?= it.linkable
				if  not cluster_data.is_root and then it /= itt and then itt /= Void then
					it.set_parent(itt)
				else
					--it.destroy
				end	
				clusters.forth
			end
		end

		add_entities(cluster: CLUSTER_DATA;tree_item: LINKABLE_TREE_ITEM) is
				-- Eventually add new entities.
			local
				it,itt: LINKABLE_TREE_ITEM
				cluster_data: CLUSTER_DATA
				class_data: CLASS_DATA
			do
				-- Add classes/ Clusters
				from
					cluster.clusters.start
				until
					cluster.clusters.after
				loop
					cluster_data := cluster.clusters.item
					it := clusters.item(cluster_data.name)
					if it = Void then
						-- New Cluster
						!! it.make_with_linkable(tree_item,cluster_data,Void)
						clusters.put(it, cluster.clusters.item.name)
					elseif not cluster_data.is_root then
						itt := clusters.item(cluster_data.parent_cluster.name)
						if itt /= Void then
							it.set_parent(itt)
						end
					end
					add_entities(cluster.clusters.item, it)
					cluster.clusters.forth
				end
				from
					cluster.classes.start
				until
					cluster.classes.after
				loop
					class_data := cluster.classes.item
					it := classes.item(class_data.name)
					if it = Void then
						-- New Class
						!! it.make_with_linkable(tree_item,class_data,Void)
						classes.put(it, class_data.name)
					else
						itt := clusters.item(class_data.parent_cluster.name)
						if itt /= Void then
							it.set_parent(itt)
						end
					end
					cluster.classes.forth
				end
			end

	clear is 
		-- Clear the tree.
		do 
			
		end


feature {NONE} -- Internal operations 

feature -- Actions 

	hide_show (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	--	require
	--		element_selected: tree.selected_item /= Void
		local
			elem: LINKABLE_TREE_ITEM
			hide_linkable_u: HIDE_LINKABLE_U;
			show_linkable_u: SHOW_LINKABLE_U;
			clu: CLUSTER_DATA
		do
			--elem ?= tree.selected_item
			--clu ?= elem.linkable
			--if clu=Void or else not clu.is_root then
			--	if elem.linkable.is_hidden then
			--		!! show_linkable_u.make (elem.linkable)
			--		elem.unset_pixmap
			--	else
			--		!! hide_linkable_u.make (elem.linkable)
			--		elem.set_pixmap(pixmaps.add_attr_clone)
			--	end
			--end
		end

feature  -- Implementation

	main_window: MAIN_WINDOW

	tree: EV_TREE

end -- class TREE_COMPONENT
