indexing
	description: "Windows that allow the user to set Client/Supplier/Ancestor/Descendants Depth"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONTEXT_DEPTH_DIALOG

inherit
	EV_DIALOG

	EV_KEY_CONSTANTS
		undefine
			default_create, copy
		end

	EB_CONSTANTS
		undefine
			default_create, copy
		end

create
	make_for_class_view,
	make_for_cluster_view

feature {NONE} -- Initialization

	make_for_class_view is
			-- Build the dialog box for a class view.
		local
			l: EV_LABEL
			sep: EV_HORIZONTAL_SEPARATOR
			hb, hb2, hb_view, hb_cluster: EV_HORIZONTAL_BOX
			main_vb, vb, vb2, vb_view, vb_include, vb_cluster: EV_VERTICAL_BOX
			frm, frm2, frm3: EV_FRAME
		do
			default_create
			cancelled := False
			ancestor_depth := 1
			descendant_depth := 1
			client_depth := 1
			supplier_depth := 1
			set_title (Interface_names.t_Diagram_context_depth)

			create ok_button.make_with_text_and_action (Interface_names.b_Ok, ~ok_action)
			Layout_constants.set_default_size_for_button (ok_button)
			create cancel_button.make_with_text_and_action (Interface_names.b_Cancel, ~cancel_action)
			Layout_constants.set_default_size_for_button (cancel_button)
			create frm.make_with_text ("Include")
			create frm2.make_with_text ("Up to depth of")
			create frm3.make_with_text ("View")
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			create hb2
			hb2.set_padding (Layout_constants.Small_padding_size)
			create hb_view
			hb_view.set_padding (Layout_constants.Small_padding_size)
			create hb_cluster
			hb_cluster.set_padding (Layout_constants.Small_padding_size)
			create main_vb
			main_vb.set_padding (Layout_constants.Small_padding_size)
			main_vb.set_border_width (Layout_constants.Default_border_size)
			create vb
			vb.set_padding (Layout_constants.Small_padding_size)
			create vb2
			vb2.set_padding (Layout_constants.Small_padding_size)
			create vb_view
			vb_view.set_padding (Layout_constants.Small_padding_size)
			create vb_include
			vb_include.set_padding (Layout_constants.Small_padding_size)
			create vb_cluster
			vb_cluster.set_padding (Layout_constants.Small_padding_size)

			create cb_only.make_with_text ("Only classes in same cluster")
			vb_cluster.extend (cb_only)
			create cb_all.make_with_text ("All classes in same cluster")
			vb_cluster.extend (cb_all)
			
			hb_cluster.extend (create {EV_CELL})
			hb_cluster.extend (vb_cluster)

			vb_include.extend (hb_cluster)

			create sep
			vb_include.extend (sep)
			vb_include.disable_item_expand (sep)

			create l.make_with_text ("Ancestors")
			vb.extend (create {EV_CELL})
			vb.extend (l)

			create l.make_with_text ("Descendants")
			vb.extend (l)

			create l.make_with_text ("Clients")
			vb.extend (l)

			create l.make_with_text ("Suppliers")
			vb.extend (l)

			hb.extend (vb)

            create sb_ancestor
			sb_ancestor.set_minimum_width (125)
			vb2.extend (sb_ancestor)	

            create sb_descendant
			sb_descendant.set_minimum_width (125)
			vb2.extend (sb_descendant)	
			
            create sb_client
			sb_client.set_minimum_width (125)
			vb2.extend (sb_client)	
			
	        create sb_supplier
			sb_supplier.set_minimum_width (125)
			vb2.extend (sb_supplier)	

			vb_include.extend (hb)
			vb_include.extend (create {EV_CELL})
			frm.extend (vb_include)
			frm2.extend (vb2)
			hb.extend (frm2)
			main_vb.extend (frm)

			create l.make_with_text ("Apply changes to view named: ")
			hb_view.extend (l)
			create view_selector.make_default
			hb_view.extend (view_selector)
			vb_view.extend (create {EV_CELL})
			vb_view.extend (hb_view)
			create l.make_with_text ("Select another view if you want to save current placement.")
			vb_view.extend (l)
			vb_view.extend (create {EV_CELL})
			frm3.extend (vb_view)
			main_vb.extend (frm3)
			
			hb2.set_padding (Layout_constants.Small_padding_size)
			hb2.extend (create {EV_CELL})
			hb2.extend (ok_button)
			hb2.disable_item_expand (ok_button)
			hb2.extend (cancel_button)
			hb2.disable_item_expand (cancel_button)

			main_vb.extend (hb2)
			main_vb.disable_item_expand (hb2)
			extend (main_vb)

			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
			is_for_class_view := True
			disable_user_resize
		end

	make_for_cluster_view is
			-- Build the dialog box for a cluster view.
		local
			l: EV_LABEL
			main_vb, vb, vb2, vb_view, vb_include: EV_VERTICAL_BOX
			frm, frm2, frm3: EV_FRAME
			hb, hb2, hb_view: EV_HORIZONTAL_BOX
		do
			default_create
			cancelled := False
			supercluster_depth := 1
			subcluster_depth := 1
			set_title (Interface_names.t_Diagram_context_depth)

			create ok_button.make_with_text_and_action (Interface_names.b_Ok, ~ok_action)
			Layout_constants.set_default_size_for_button (ok_button)
			create cancel_button.make_with_text_and_action (Interface_names.b_Cancel, ~cancel_action)
			Layout_constants.set_default_size_for_button (cancel_button)
			create frm.make_with_text ("Include")
			create frm2.make_with_text ("Up to depth of")
			create frm3.make_with_text ("View")
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			create hb2
			hb2.set_padding (Layout_constants.Small_padding_size)
			create hb_view
			hb_view.set_padding (Layout_constants.Small_padding_size)
			create main_vb
			main_vb.set_padding (Layout_constants.Small_padding_size)
			main_vb.set_border_width (Layout_constants.Default_border_size)
			create vb
			vb.set_padding (Layout_constants.Small_padding_size)
			create vb2
			vb2.set_padding (Layout_constants.Small_padding_size)
			create vb_view
			vb_view.set_padding (Layout_constants.Small_padding_size)
			create vb_include
			vb_include.set_padding (Layout_constants.Small_padding_size)

			create l.make_with_text ("Super-clusters")
			vb.extend (create {EV_CELL})
			vb.extend (l)

			create l.make_with_text ("Sub-clusters")
			vb.extend (l)

			hb.extend (vb)

            create sb_supercluster
			sb_supercluster.set_minimum_width (125)
			vb2.extend (sb_supercluster)	

            create sb_subcluster
			sb_subcluster.set_minimum_width (125)
			vb2.extend (sb_subcluster)	

			vb_include.extend (hb)
			vb_include.extend (create {EV_CELL})
			frm.extend (vb_include)
			frm2.extend (vb2)
			hb.extend (frm2)
			main_vb.extend (frm)

			create l.make_with_text ("Apply changes to view named: ")
			hb_view.extend (l)
			create view_selector.make_default
			hb_view.extend (view_selector)
			vb_view.extend (create {EV_CELL})
			vb_view.extend (hb_view)
			create l.make_with_text ("Select another view if you want to save current placement.")
			vb_view.extend (l)
			vb_view.extend (create {EV_CELL})
			frm3.extend (vb_view)
			main_vb.extend (frm3)

			hb2.set_padding (Layout_constants.Small_padding_size)
			hb2.extend (create {EV_CELL})
			hb2.extend (ok_button)
			hb2.disable_item_expand (ok_button)
			hb2.extend (cancel_button)
			hb2.disable_item_expand (cancel_button)

			main_vb.extend (hb2)
			main_vb.disable_item_expand (hb2)
			extend (main_vb)

			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
			is_for_class_view := False
			disable_user_resize
		end

feature -- Initialization

	preset_for_class_view (cd: CONTEXT_DIAGRAM) is
			-- Assign text fields with current values.
		require
			is_for_class_view: is_for_class_view
			cd_not_void: cd /= Void
			view_name_not_empty: not cd.current_view.is_empty
		local
			current_index: INTEGER
			current_views: LINKED_LIST [STRING]
		do
			if cd.include_all_classes_of_cluster then
				cb_all.enable_select
			else
				cb_all.disable_select
			end
			if cd.include_only_classes_of_cluster then
				cb_only.enable_select
			else
				cb_only.disable_select
			end
			ancestor_depth := cd.ancestor_depth
			sb_ancestor.set_value (ancestor_depth)
			descendant_depth := cd.descendant_depth
			sb_descendant.set_value (descendant_depth)
			client_depth := cd.client_depth
			sb_client.set_value (client_depth)
			supplier_depth := cd.supplier_depth
			sb_supplier.set_value (supplier_depth)
			view_selector.select_actions.block
			current_views := cd.available_views
			if not current_views.has (cd.current_view) then
				current_views.extend (cd.current_view)
			end
			view_selector.set_strings (current_views)
			view_selector.set_text (cd.current_view)
			current_index := current_views.index_of (cd.current_view, 1)
			view_selector.select_actions.resume
			view_selector.i_th (current_index).enable_select
		ensure
			new_values_assigned: ancestor_depth = cd.ancestor_depth and
				descendant_depth = cd.descendant_depth and
				client_depth = cd.client_depth and
				supplier_depth = cd.supplier_depth
		end

	preset_for_cluster_view (cd: CLUSTER_DIAGRAM) is
			-- Assign text fields with current values.
		require
			is_for_cluster_view: not is_for_class_view
			cd_not_void: cd /= Void
			view_name_not_empty: not cd.current_view.is_empty
		local
			current_index: INTEGER
			current_views: LINKED_LIST [STRING]
		do
			supercluster_depth := cd.supercluster_depth
			sb_supercluster.set_value (supercluster_depth)
			subcluster_depth := cd.subcluster_depth
			sb_subcluster.set_value (subcluster_depth)
			view_selector.select_actions.block
			current_views := cd.available_views
			if not current_views.has (cd.current_view) then
				current_views.extend (cd.current_view)
			end
			view_selector.set_strings (current_views)
			view_selector.set_text (cd.current_view)
			current_index := current_views.index_of (cd.current_view, 1)
			view_selector.select_actions.resume
			view_selector.i_th (current_index).enable_select
		ensure
			new_values_assigned: supercluster_depth = cd.supercluster_depth and
				subcluster_depth = cd.subcluster_depth
		end

feature -- Access

	ok_button: EV_BUTTON
			-- Button with label "OK".
			
	cancel_button: EV_BUTTON
			-- Button with label "Cancel".

	view_selector: EB_VIEW_SELECTOR
			-- Combobox to choose view.

feature -- Status report

	client_depth: INTEGER 
			-- Client depth typed by the user.

	supplier_depth: INTEGER 
			-- Supplier depth typed by the user.

	ancestor_depth: INTEGER 
			-- Ancestor depth typed by the user.

	descendant_depth: INTEGER 
			-- Descendant depth typed by the user.

	supercluster_depth: INTEGER 
			-- Supercluster depth typed by the user.

	subcluster_depth: INTEGER 
			-- Subcluster depth typed by the user.

	all_classes_of_cluster: BOOLEAN is
			-- Was `cb_all' checked?
		do
			Result := cb_all.is_selected
		end

	only_classes_of_cluster: BOOLEAN is
			-- Was `cb_only' checked?
		do
			Result := cb_only.is_selected
		end

	cancelled: BOOLEAN
			-- Was the renaming cancelled?

	is_for_class_view: BOOLEAN
			-- Has `Current' been created through `make_for_class_view'?

feature {NONE} -- Implementation

	sb_ancestor, sb_descendant, sb_client, sb_supplier: EV_SPIN_BUTTON
			-- Spin buttons to choose depths for class views.

	sb_supercluster, sb_subcluster: EV_SPIN_BUTTON
			-- Spin buttons to choose depths for cluster views.

	cb_only, cb_all: EV_CHECK_BUTTON
			-- Check buttons for options regarding clusters (on class views).

	ok_action is
			-- Close dialog and store chosen values.
		do
			if is_for_class_view then
				if sb_ancestor.text.is_integer then
					set_ancestor_depth (sb_ancestor.text.to_integer)
				end
				if sb_descendant.text.is_integer then
					set_descendant_depth (sb_descendant.text.to_integer)
				end
				if sb_client.text.is_integer then
					set_client_depth (sb_client.text.to_integer)
				end
				if sb_supplier.text.is_integer then
					set_supplier_depth (sb_supplier.text.to_integer)
				end
			else
				if sb_supercluster.text.is_integer then
					set_supercluster_depth (sb_supercluster.text.to_integer)
				end
				if sb_subcluster.text.is_integer then
					set_subcluster_depth (sb_subcluster.text.to_integer)
				end
			end
			cancelled := False
			destroy
		end

	cancel_action is
			-- Close dialog.
		do
			cancelled := True
			destroy
		end

	set_ancestor_depth (d: INTEGER) is
			-- Assign `d' to `ancestor_depth'
		do
			ancestor_depth := d
		end

	set_descendant_depth (d: INTEGER) is
			-- Assign `d' to `descendant_depth'
		do
			descendant_depth := d
		end

	set_client_depth (d: INTEGER) is
			-- Assign `d' to `client_depth'
		do
			client_depth := d
		end

	set_supplier_depth (d: INTEGER) is
			-- Assign `d' to `supplier_depth'
		do
			supplier_depth := d
		end		

	set_supercluster_depth (d: INTEGER) is
			-- Assign `d' to `supercluster_depth'
		do
			supercluster_depth := d
		end

	set_subcluster_depth (d: INTEGER) is
			-- Assign `d' to `subcluster_depth'
		do
			subcluster_depth := d
		end		

end -- class EB_CONTEXT_DEPTH_DIALOG
