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
		end

feature -- Access

	tool_b,hide_show_b: EV_BUTTON
	v1: EV_VERTICAL_BOX

feature -- Updates

	update is
		do
		--	set_entity (main_window.entity)
		--	clear
		--	create_cluster (entity, tree)
		end

	update_from(cluster: CLUSTER_DATA) is
			-- Update Current with cluster 'cluster'.
		require else
			cluster_exists: cluster /= Void
		do
			create_cluster ( cluster, tree )
		end

	clear is 
		-- Clear the tree.
		do 
		end


feature {NONE} -- Internal operations 
	
	create_cluster ( cluster: CLUSTER_DATA; elem: EV_TREE_ITEM_HOLDER) is
		local
			element: LINKABLE_TREE_ITEM
			caller_w: ECASE_WINDOW

			class_pixmap: EV_PIXMAP
			cluster_pixmap: EV_PIXMAP
		do
			if cluster /= Void then
				class_pixmap := pixmaps.class_pixmap
				cluster_pixmap := pixmaps.cluster_pixmap
		
				caller_w ?= caller_window
				from
					cluster.classes.start
				until
					cluster.classes.after
				loop
					!! element.make_with_linkable(elem,cluster.classes.item, class_pixmap)
-- 					observer_management.add_observer(cluster.classes.item, caller_w )
					cluster.classes.forth
				end
				from
					cluster.clusters.start
				until
					cluster.clusters.after
				loop
					!! element.make_with_linkable (elem,cluster.clusters.item, cluster_pixmap)
					create_cluster(cluster.clusters.item, element )
-- 					observer_management.add_observer(cluster.clusters.item, caller_w )
					cluster.clusters.forth
				end
			end
		end

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
			elem ?= tree.selected_item
			clu ?= elem.linkable
			if clu=Void or else not clu.is_root then
				if elem.linkable.is_hidden then
					!! show_linkable_u.make (elem.linkable)
					elem.unset_pixmap
				else
					!! hide_linkable_u.make (elem.linkable)
					elem.set_pixmap(pixmaps.add_attr_clone)
				end
			end
		end

feature  -- Implementation

	main_window: MAIN_WINDOW

	tree: EV_TREE

end -- class TREE_COMPONENT
