indexing
	description:
		"Graphical representations of clusters without%N%
		%commitment to any notation."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLUSTER_FIGURE

inherit
	LINKABLE_FIGURE
		undefine
			position_on_figure
		redefine
			set_origin,
			world,
			cluster_figure
		end

	LINKABLE_FIGURE_GROUP
		rename
			cluster_figures as subclusters,
			class_figures as classes
		undefine
			default_create,
			is_equal
		end

feature {NONE} -- Initialization

	make_with_cluster (lace_cluster: CLUSTER_I) is
			-- Initialize `Current' with lace_cluster.
		require
			lace_cluster_not_void: lace_cluster /= Void
		do
			default_create
			create layout
			create subclusters.make
			create classes.make
			create saved_subclusters.make
			create saved_classes.make
			cluster_i := lace_cluster
			set_name (cluster_i.name_in_upper)
			initialize
			create {CLUSTER_FIGURE_STONE} pebble.make (Current)
			set_accept_cursor (Cursors.cur_Cluster)
			build_figure
		end

	initialize is
		deferred
		end

feature -- Access

	parent: LINKABLE_FIGURE_GROUP
			-- Figure group containing `Current'.

	world: CLUSTER_DIAGRAM is
			-- World `Current' belongs to.
		do
			Result ?= Precursor
		end

	cluster_i: CLUSTER_I
			-- Cluster this figure is a representation of.

	resizer_bottom_right: EV_MOVE_HANDLE is
			-- Mover of `Current'.
		deferred
		end

	resizer_top_left: EV_MOVE_HANDLE is
			-- Mover of `Current'.
		deferred
		end

	resizer_top_right: EV_MOVE_HANDLE is
			-- Mover of `Current'.
		deferred
		end

	resizer_bottom_left: EV_MOVE_HANDLE is
			-- Mover of `Current'.
		deferred
		end

	name_mover: EV_MOVE_HANDLE is
			-- Mover of `Current' name.
		deferred
		end

	center_point: EV_RELATIVE_POINT is
			-- Point at the center of `body', origin of `name_mover'.
		deferred
		end

	cluster_figure: CLUSTER_FIGURE is
			-- Cluster figure `Current' is in directly.
			-- Void if none or more than one.
		do
			Result ?= parent
		end

feature -- Element change

	add_class (a_class: CLASS_FIGURE) is
			-- Add `a_class' to `classes'.
		require
			a_class_not_void: a_class /= Void
		do
			classes.extend (a_class)
			a_class.set_cluster (Current)
			a_class.set_origin (point)
		ensure
			a_class_added: classes.has (a_class)
		end

	remove_class (a_class: CLASS_FIGURE) is
			-- Remove `a_class' from `classes'.
		require
			a_class_not_void: a_class /= Void
		do
			classes.prune_all (a_class)
		ensure
			a_class_removed: not classes.has (a_class)
		end
	
	add_all_classes is
			-- Add class figures representing all items
			-- in `cluster_i'.
		do
			world.include_classes_of_cluster (Current, True)
		end

	add_subcluster (a_cluster: CLUSTER_FIGURE) is
			-- Add `a_cluster' to `subclusters'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			if not subclusters.has (a_cluster) then
				subclusters.extend (a_cluster)
				a_cluster.set_parent (Current)
			-- EA:	a_cluster.point.set_origin (point)
				a_cluster.point.change_origin (point)
			end
		ensure
			a_cluster_added: subclusters.has (a_cluster)
		end

	remove_subcluster (a_cluster: CLUSTER_FIGURE) is
			-- Remove `a_cluster' from `subclusters'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			subclusters.prune_all (a_cluster)
			a_cluster.set_parent (Void)
		ensure
			a_cluster_removed: not subclusters.has (a_cluster)
		end

	set_parent (p: LINKABLE_FIGURE_GROUP) is
			-- Assign `p' to `parent'.
			-- `p' can be Void if `Current' is a top-level cluster in diagram.
		do
			parent := p
			if p = Void and then world /= Void then
				point.set_origin (world.point)
			end
		ensure
			parent_assigned: parent = p
		end

	remove_from_diagram (exclude_needed: BOOLEAN) is
			-- Remove `Current' from its diagram, exclude it if `exclude_needed'.
		local
			d: CLUSTER_DIAGRAM
			saved_cursor: CURSOR
			cf: CLASS_FIGURE
		do
			d := world
			if d.center_cluster /= Current then
				saved_subclusters.wipe_out
				saved_classes.wipe_out
	
				from
					classes.start
				until
					classes.after
				loop
					cf := classes.item
					classes.forth
					saved_cursor := classes.cursor
					saved_classes.extend (cf)
					cf.remove_from_diagram (exclude_needed)
					classes.go_to (saved_cursor)
				end
	
				if exclude_needed then
					d.exclude_cluster (cluster_i)
				else
					d.remove_cluster (cluster_i)	
				end
			end
		end
	
	recursive_remove_from_diagram (exclude_needed: BOOLEAN) is
			-- Remove `Current' from its diagram, exclude it if `exclude_needed',
			-- and remove subclusters as well.
		local
			d: CLUSTER_DIAGRAM
			saved_cursor: CURSOR
			cf: CLASS_FIGURE
			clf: CLUSTER_FIGURE
		do
			d := world
			if d.center_cluster /= Current then
				saved_subclusters.wipe_out
				saved_classes.wipe_out
	
				from
					subclusters.start
				until
					subclusters.after
				loop
					clf := subclusters.item
					subclusters.forth				
					saved_cursor := subclusters.cursor
					saved_subclusters.extend (clf)
					clf.recursive_remove_from_diagram (exclude_needed)
					subclusters.go_to (saved_cursor)
				end
	
				from
					classes.start
				until
					classes.after
				loop
					cf := classes.item
					classes.forth
					saved_cursor := classes.cursor
					saved_classes.extend (cf)
					cf.remove_from_diagram (exclude_needed)
					classes.go_to (saved_cursor)
				end
	
				if exclude_needed then
					d.exclude_cluster (cluster_i)
				else
					d.remove_cluster (cluster_i)	
				end
			end
		end

	put_back_on_diagram (d: CONTEXT_DIAGRAM) is
			-- Put `Current' back on `d'.
		local
			cd: CLUSTER_DIAGRAM
		do
			cd ?= d
			if cd /= Void then
				cd.add_cluster_figure (Current, False)

				from
					saved_subclusters.start
				until
					saved_subclusters.after
				loop
					saved_subclusters.item.put_back_on_diagram (d)
					saved_subclusters.forth
				end
	
				from
					saved_classes.start
				until
					saved_classes.after
				loop
					saved_classes.item.put_back_on_diagram (d)
					saved_classes.forth
				end
			end
		end

	change_origin (new_origin: EV_RELATIVE_POINT) is
			-- Set the point this figure is relative to.
			-- Do not change absolute coordinates.
		do
			point.change_origin (new_origin)
		end

feature -- Status report

	iconified: BOOLEAN
			-- Is `Current' iconified?

	is_subcluster_of (other: CLUSTER_FIGURE): BOOLEAN is
			-- Is Current a subcluster of `other' (directly or not)?
		require
			other_not_void: other /= Void
		local
			tmp: CLUSTER_FIGURE
		do
			Result := other = Current
			from
				tmp := cluster_figure
			until
				Result = True or tmp = Void
			loop
				if other = tmp then
					Result := True
				end
				tmp := tmp.cluster_figure
			end
		end

	recursive_has_class (a_class: CLASS_FIGURE): BOOLEAN is
			-- Does `a_class' belong to `Current' or to one of its subclusters?
		require
			a_class_not_void: a_class /= Void
		do
			Result := classes.has (a_class)
			from
				subclusters.start
			until
				Result or else subclusters.after
			loop
				Result := subclusters.item.recursive_has_class (a_class)
				subclusters.forth
			end
		end

	position_strictly_on_figure (x, y: INTEGER): BOOLEAN is
   			-- Is the point on (`x', `y') on this figure?
			-- (excluding its subclusters).
		deferred
		end

feature -- Status setting

	set_origin (a_point: EV_RELATIVE_POINT) is
			-- Assign `a_point' to the origin of all
			-- figures related to `Current'.
		do
			point.change_origin (a_point)
		end
	
	update is
			-- `Current' has just been moved/resized.
		do
			from
				subclusters.start
			until
				subclusters.after
			loop
				subclusters.item.update
				subclusters.item.move_to_front
				subclusters.forth
			end
			from
				classes.start
			until
				classes.after
			loop
				classes.item.update
				classes.forth
			end
		end

	set_size (a_width, a_height: INTEGER) is
			-- Resize `Current' to `a_width', `a_height'.
		require
			a_width_non_negative: a_width >= 0
			a_height_non_negative: a_height >= 0
		deferred
		end

	set_minimum_bounds (a_left, a_top, a_right, a_bottom: INTEGER) is
			-- Assign minimum bounds.
		deferred
		end

	update_minimum_size is
			-- Figures have been added/removed in `Current',
			-- minimum size should change.
		deferred
		end

	set_bounds (a_left, a_top, a_right, a_bottom: INTEGER) is
			-- Assign bounds.
		deferred
		end

	set_relative_position_and_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- Assign bounds.
		deferred
		end

	iconify is
			-- Iconify `Current'.
		deferred
		ensure
			is_iconified: iconified
		end

	deiconify is
			-- Deiconify `Current'.
		deferred
		ensure
			is_not_iconified: not iconified
		end

	mask is
			-- `Current' no longer needs to be displayed.
		deferred
		end

	unmask is
			-- `Current' needs to be displayed again.
		deferred
		end

feature {CLUSTER_FIGURE} -- Events

	move_to_front is
			-- Make `Current' appear in front of its peers.
		deferred
		end	

feature {NONE} -- Implementation

	external_client_links: LINKED_LIST [CLIENT_SUPPLIER_FIGURE] is
			-- Client figures which `supplier' is a figure inside `Current',
			-- and `client' is a figure outside `Current'.
		local
			class_client_links: LINKED_LIST [CLIENT_SUPPLIER_FIGURE]
		do
			from
				classes.start
			until
				classes.after
			loop
				class_client_links := classes.item.client_figures
				from
					class_client_links.start
				until
					class_client_links.after
				loop
					if class_client_links.item.client.cluster_figure /= Current then
						Result.extend (class_client_links.item)
					end
					class_client_links.forth
				end
				classes.forth
			end
			--| FIXME: take subclusters into account as well.
		end

	external_supplier_links: LINKED_LIST [CLIENT_SUPPLIER_FIGURE] is
			-- Client figures which `client' is a figure inside `Current',
			-- and `supplier' is a figure outside `Current'.
		local
			class_supplier_links: LINKED_LIST [CLIENT_SUPPLIER_FIGURE]
		do
			from
				classes.start
			until
				classes.after
			loop
				class_supplier_links := classes.item.supplier_figures
				from
					class_supplier_links.start
				until
					class_supplier_links.after
				loop
					if class_supplier_links.item.supplier.cluster_figure /= Current then
						Result.extend (class_supplier_links.item)
					end
					class_supplier_links.forth
				end
				classes.forth
			end
			--| FIXME: take subclusters into account as well.
		end

	saved_subclusters: LINKED_LIST [CLUSTER_FIGURE]
			-- Subclusters backup to undo delete command.

	saved_classes: LINKED_LIST [CLASS_FIGURE]
			-- Classes backup to undo delete command.

	on_pebble_request: ANY is
			-- New CLUSTER_STONE with `Current' as source.
		do
			create {CLUSTER_FIGURE_STONE} Result.make (Current)
		end

	old_width: INTEGER is
			-- Backup of `width' for iconifying.
		deferred
		end

	old_height: INTEGER is
			-- Backup of `height' for iconifying.
		deferred
		end

	minimum_width: INTEGER is
			-- 
		deferred
		end

end -- class CLUSTER_FIGURE




