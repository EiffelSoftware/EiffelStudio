indexing
	description:
		"Graphical representations of an client link without%N%
		%commitment to any notation."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLIENT_SUPPLIER_FIGURE

inherit
	LINK_FIGURE
		rename
			source as client,
			target as supplier
		redefine
			disable_needed_on_diagram,
			is_equal
		end

feature {NONE} -- Initialization

	make_with_classes (a_client, a_supplier: CLASS_FIGURE; data: CASE_SUPPLIER) is
			-- Initialize with `a_client' and `a_supplier'.
		require
			a_client_not_void: a_client /= Void
			a_supplier_not_void: a_supplier /= Void
		local
			cld: CLUSTER_DIAGRAM
		do
			default_create
			create {CLIENT_STONE} pebble.make (Current)
			set_accept_cursor (Cursors.cur_Client_link)
			supplier_data := data
			name := data.name
			supplier := a_supplier
			client := a_client
			if not a_supplier.client_figures.has (Current) then
				a_supplier.client_figures.extend (Current)
			end
			if client /= supplier and then
				not a_client.supplier_figures.has (Current) then
					a_client.supplier_figures.extend (Current)
			end
			data.extend_graphical_link (Current)
			point.set_origin (client.world.point)
			create children_figures.make
			is_valid := True
			build_label
			initialize
			cld ?= client.world
			if cld /= Void then
				enclosing_figure := cld.smallest_cluster_containing_classes (a_client, a_supplier)
			end
			if enclosing_figure = Void then
				enclosing_figure := client.world
			end
			build_figure
			create unset_do_stack.make
			create unset_undo_stack.make
			create reset_do_stack.make
			create reset_undo_stack.make
		end

feature -- Memory management

	recycle is
			-- Frees `Current's memory, and leave `Current' in an unstable state
			-- so that we know whether we're still referenced or not.
		deferred
		end

feature -- Access

	name_figure: EV_FIGURE_TEXT
			-- Graphical representation of `label'.

	name_figure_mover: EV_MOVE_HANDLE
			-- Handle that allows the user to move link label.

	supplier_data: CASE_SUPPLIER
			-- Feature in `client' with return type `supplier'.

	name: STRING
			-- Name of query in `client' that returns `supplier'.

	label: STRING
			-- Full label of `Current'.
			-- Consists at least of `name' and if it has more than
			-- one supplier class, of all suppliers except `supplier'.

	children_figures: LINKED_LIST [CLIENT_SUPPLIER_FIGURE]
			-- Figures `Current' is composed of.

	parent_link: CLIENT_SUPPLIER_FIGURE
			-- Link including `Current'.
			-- Void if `Current' is a top-level link.

	cluster_figure: CLUSTER_FIGURE is
			-- Cluster figure `Current' is in directly.
			-- Void if none or more than one.
		local
			c: CLUSTER_FIGURE
		do
			c := client.cluster_figure
			if c /= Void and then c = supplier.cluster_figure then
				Result := c
			end
		end

feature {EB_DELETE_DIAGRAM_ITEM_COMMAND, EB_LINK_TOOL_COMMAND, CONTEXT_DIAGRAM} -- Access

	link_by_feature_name (a_name: STRING): CLIENT_SUPPLIER_FIGURE is
			-- Client-supplier figure corresponding to `a_name'.
			-- Can be `Current' or an item of `children_figures'.
			-- Void if none.
		require
			a_name_not_void: a_name /= Void
		do
			if name.is_equal (a_name) then
				Result := Current
			else
				from
					children_figures.start
				until
					children_figures.after or Result /= Void
				loop
					if children_figures.item.name.is_equal (a_name) then
						Result := children_figures.item
					end
					children_figures.forth
				end
			end
		end

	feature_names: ARRAY [STRING] is
			-- Names of features represented by `Current'.
		local
			i: INTEGER
		do
			i := 1
			if is_valid then
				create Result.make (1, children_figures.count + 1)
				Result.put (name, i)
				i := i + 1
			else
				create Result.make (1, children_figures.count)
			end
			from
				children_figures.start
			until
				children_figures.after
			loop
				Result.put (children_figures.item.name, i)
				i := i + 1
				children_figures.forth
			end
		ensure
			result_not_void: Result /= Void
		end			

feature -- Element change

	set_parent (csf: CLIENT_SUPPLIER_FIGURE) is
			-- Assign `csf' to `parent_link'.
			-- Add `Current' to `csf' children.
		do
			parent_link := csf
			if csf /= Void then
				csf.children_figures.extend (Current)
				csf.build_label
				csf.update_name_figure
			end
		ensure
			csf_assigned: csf = parent_link
		end

	remove_child (csf: CLIENT_SUPPLIER_FIGURE) is
			-- Remove `csf' from `children_figures'.
		require
			csf_not_void: csf /= Void
		do
			children_figures.prune_all (csf)
			build_label
			update_name_figure
		ensure
			csf_removed: not children_figures.has (csf)
		end

feature -- Status report

	is_reflexive: BOOLEAN is
			-- Is `client' a supplier of itself?
		do
			Result := client = supplier	
		end

	is_bidirectional: BOOLEAN is
			-- Is `client' a client of `supplier' and vice versa.
		do
			-- To be implemented.
		end

	is_aggregate: BOOLEAN is
			-- Is `supplier' an expanded attribute in `client'?
		do
			Result := supplier_data.is_expanded
		end

	is_valid: BOOLEAN
			-- Is `Current' representing a feature in the system?
			--| FIXME this would need refactoring (`children_figures' as well).
		
feature -- Status setting

	set_bidirectional (b: BOOLEAN) is
			-- Assign `b' to `is_bidirectional'.
		do
			-- To be implemented.
		end

	hide_label is
			-- Hide `Current' label.
		deferred
		end

	show_label is
			-- Show `Current' label.
		deferred
		end

	disable_needed_on_diagram is
			-- Set `needed_on_diagram' to False for `Current'
			-- and items of `children_figures'.
		do
			Precursor
			from
				children_figures.start
			until
				children_figures.after
			loop
				children_figures.item.disable_needed_on_diagram
				children_figures.forth
			end
		end

feature {CONTEXT_DIAGRAM} -- Status setting

	apply_right_angles is
			-- Make `Current' use right angles.
		local
			figure_right, figure_left, figure_top, figure_bottom: LINKABLE_FIGURE
			client_x, client_y, supplier_x, supplier_y: INTEGER
		do
			if not is_reflexive then
				client_x := client.x_position
				client_y := client.y_position
				supplier_x := supplier.x_position
				supplier_y := supplier.y_position
				if client_x = supplier_x or
					client_y = supplier_y then
						reset
				else
					if client_x < supplier_x then
						figure_left := client
						figure_right := supplier
					else
						figure_right := client
						figure_left := supplier
					end
					if client_y < supplier_y then
						figure_top := client
						figure_bottom := supplier
					else
						figure_bottom := client
						figure_top := supplier
					end
					if figure_top = client and figure_left = client then
						put_handle_left
					elseif figure_top = supplier and figure_left = supplier then
						put_handle_right
					elseif figure_bottom = supplier and figure_left = supplier then
						put_handle_right
					elseif figure_bottom = client and figure_left = client then
						put_handle_left
					end
				end
			end
		end

	enable_is_valid is
			-- Set `is_valid' to True.
		do
			is_valid := True
		end

feature {EB_DELETE_DIAGRAM_ITEM_COMMAND} -- Status setting

	disable_is_valid is
			-- Set `is_valid' to False.
		do
			is_valid := False
		end
		
feature {LINKABLE_FIGURE} -- Status setting

	mask is
			-- `Current' no longer needs to be displayed.
		do
			hide
			disable_sensitive
		end

	unmask is
			-- `Current' needs to be displayed again, if possible.
		do
			if client.is_show_requested and supplier.is_show_requested then
				show
				enable_sensitive
			end
		end

feature {CONTEXT_DIAGRAM} -- Removal
	
	remove_unneeded_figures is
			-- Remove items of `children_figures' where `needed_on_diagram' is False.
		local
			a_cursor: CURSOR
		do
			from
				children_figures.start
			until
				children_figures.after
			loop
				a_cursor := children_figures.cursor
				if not children_figures.item.needed_on_diagram then
					children_figures.item.remove_from_diagram
					if not children_figures.after then
						children_figures.go_to (a_cursor)
					end
				else
					children_figures.forth
				end
			end
		end

feature {CONTEXT_DIAGRAM} -- Status report

	has_supplier_data (data: CASE_SUPPLIER): BOOLEAN is	
			-- Is `Current' representing a client-supplier relation corresponding to `data'?
		do
			Result := supplier_data = data
			if not Result then
				from
					children_figures.start
				until
					Result or else children_figures.after
				loop
					Result := children_figures.item.supplier_data = data
					children_figures.forth
				end
			end
		end

feature {CASE_SUPPLIER, CONTEXT_DIAGRAM, CLIENT_SUPPLIER_FIGURE} -- Removal

	remove_from_diagram is
			-- Remove `Current' graphically.
		local
			d: CONTEXT_DIAGRAM
		do
			if world /= Void then
				is_valid := False
				if children_figures.is_empty then
					d := world
					d.client_supplier_layer.prune_all (Current)
					d.label_mover_layer.prune_all (name_figure_mover)
				end
			elseif parent_link /= void then
				parent_link.remove_child (Current)
				if parent_link.children_figures.is_empty and not parent_link.is_valid then
					parent_link.remove_from_diagram
				end
			end
			supplier.supplier_figures.prune_all (Current)
			client.client_figures.prune_all (Current)
		end

feature {CASE_SUPPLIER, EB_DELETE_DIAGRAM_ITEM_COMMAND} -- Retrieving

	put_on_diagram (d: CONTEXT_DIAGRAM) is
			-- Put `Current' back on `d'.
		do
			if d.has_linkable_figure (client) and then
				d.has_linkable_figure (supplier) then			
					d.add_client_supplier_figure (Current)
					supplier.client_figures.extend (Current)
					client.supplier_figures.extend (Current)
					update_origin
					d.context_editor.projector.project
			end
		end

feature {CLIENT_SUPPLIER_FIGURE, CONTEXT_DIAGRAM, EB_DELETE_DIAGRAM_ITEM_COMMAND} -- Implementation

	update_name_figure is
			-- `label' has changed, figure should follow.
		deferred
		end

	build_label is
			-- Initialize `label'.
			--| FIXME: there could also be a label for links involving clusters.
		local
			cf: CLASS_FIGURE
		do
			if is_valid then
				cf ?= supplier
				if cf /= Void then
					label := clone (name)
					if not supplier_data.is_single then
						label.append (": ")
						label.append (supplier_data.type_label (cf.class_i))
					end
				end
				if not children_figures.is_empty then
						label.append (",...")
				end
			elseif not children_figures.is_empty then
				cf ?= children_figures.first.supplier
				if cf /= Void then
					label := clone (children_figures.first.name)
					if not supplier_data.is_single then
						label.append (": ")
						label.append (supplier_data.type_label (cf.class_i))
					end
				end
				if children_figures.count > 1 then
						label.append (",...")
				end
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' represent the same query as `Current'?
		do
			Result := other.name.is_equal (name)
				and other.client.is_equal (client)
				and other.supplier.is_equal (supplier)
		end
		
feature {NONE} -- Implementation

	enclosing_figure: LINKABLE_FIGURE_GROUP
			-- Smallest cluster containing `Current' in its whole.
			-- Diagram if none.

end -- class CLIENT_SUPPLIER_FIGURE
