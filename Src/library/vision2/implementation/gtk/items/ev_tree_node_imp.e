indexing
	description: "Eiffel Vision tree node. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_NODE_IMP

inherit
	EV_TREE_NODE_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		export
			{EV_TREE_IMP}
				child_array
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_TREE_NODE_ACTION_SEQUENCES_IMP
		export
			{EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES}
				expand_actions_internal, collapse_actions_internal
		end

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	destroy is
			-- Clean up `Current'
		do
			if parent_imp /= Void then
				parent_imp.interface.prune_all (interface)
			end
			set_is_destroyed (True)
		end

	make (an_interface: like interface) is
			-- Create the tree item.
		do
			base_make (an_interface)
			internal_text := once ""
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		local
			a_tree_imp: EV_TREE_IMP
		do
			a_tree_imp := parent_tree_imp
			if a_tree_imp /= Void then
				Result := a_tree_imp.selected_item = interface
			end
		end

	is_expanded: BOOLEAN is
			-- is the item expanded?
		local
			a_tree_path: POINTER
			par_tree: EV_TREE_IMP
		do
			par_tree := parent_tree_imp
			a_tree_path := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_path (par_tree.tree_store, list_iter.item)
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_row_expanded (par_tree.tree_view, a_tree_path)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_free (a_tree_path)
		end

feature -- Status setting

	enable_select is
			-- Select `Current' in its parent.
		local
			a_selection: POINTER
			par_tree: EV_TREE_IMP
		do
			par_tree := parent_tree_imp
			if par_tree /= Void then
				a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (par_tree.tree_view)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_select_iter (a_selection, list_iter.item)
				par_tree.ensure_item_visible (interface)
			end
		end

	disable_select is
			-- Disable selection of `Current' in its parent.
		local
			a_selection: POINTER
			par_tree: EV_TREE_IMP
		do
			par_tree := parent_tree_imp
			if par_tree /= Void then
				a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (par_tree.tree_view)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_unselect_iter (a_selection, list_iter.item)
			end
		end

	set_expand (a_flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
		local
			a_tree_path: POINTER
			par_tree: EV_TREE_IMP
			a_success: BOOLEAN
		do
			par_tree := parent_tree_imp
			a_tree_path := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_path (par_tree.tree_store, list_iter.item)
			if a_flag then
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_expand_to_path (par_tree.tree_view, a_tree_path)
			else
				a_success := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_collapse_row (par_tree.tree_view, a_tree_path)
			end
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_free (a_tree_path)
		end

	set_text (a_text: STRING_GENERAL) is
			-- Set 'text' to 'a_text'
		local
			par_tree: EV_TREE_IMP
		do
			internal_text := a_text.twin
			par_tree := parent_tree_imp
			if par_tree /= Void then
				par_tree.set_text_on_position (Current, internal_text)
			end
		end

feature -- PND

	enable_transport is
			-- Enable PND transport
		do
			is_transport_enabled := True
			if parent_tree_imp /= Void then
				parent_tree_imp.update_pnd_status
			end
		end

	disable_transport is
			-- Disable PND transport
		do
			is_transport_enabled := False
			if parent_tree_imp /= Void then
				parent_tree_imp.update_pnd_status
			end
		end

	draw_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	enable_capture is
		do
			check
				do_not_call: False
			end
		end

	disable_capture is
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER) is
        	-- Start PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER) is
			-- End PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (curs: EV_CURSOR) is
			-- Set 'pointer_style' to 'curs' (not needed)
		do
			check
				do_not_call: False
			end
		end

	is_transport_enabled_iterator: BOOLEAN is
			-- Has 'Current' or a child of 'Current' pnd transport enabled?
		local
			a_cursor: CURSOR
			a_tree_node_imp: EV_TREE_NODE_IMP
			i: INTEGER
		do
			if is_transport_enabled then
				Result := True
			elseif count > 0 then
				from
					a_cursor := child_array.cursor
					i := 1
				until
					i > child_array.count or else Result
				loop
					if child_array.i_th (i) /= Void then
						a_tree_node_imp ?= child_array.i_th (i).implementation
						Result := a_tree_node_imp.is_transport_enabled_iterator
					end
					i := i + 1
				end
				child_array.go_to (a_cursor)
			end
		end

feature {EV_TREE_IMP} -- Implementation

	set_pebble_void is
			-- Resets pebble from Tree_Imp.
		do
			pebble := Void
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is the row able to transport data with `a_button' click.
		do
			Result := is_transport_enabled and
			((a_button = 1 and mode_is_drag_and_drop) or
			(a_button = 3 and (mode_is_pick_and_drop or mode_is_target_menu)))
		end

feature {EV_ANY_I} -- Implementation

	set_list_iter (a_iter: EV_GTK_TREE_ITER_STRUCT) is
			-- Set `list_iter' to `a_iter'
		do
			list_iter := a_iter
		end

	list_iter: EV_GTK_TREE_ITER_STRUCT
		-- Object representing position of `Current' in parent tree model

	set_parent_imp (par_imp: like parent_imp) is
		do
			parent_imp := par_imp
		end

	parent_imp: EV_ITEM_LIST_IMP [EV_TREE_NODE]

	parent_tree_imp: EV_TREE_IMP is
		do
			if parent_tree /= Void then
				Result ?= parent_tree.implementation
			end
		end

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Implementation

	add_item_and_children_to_parent_tree (a_parent_tree: EV_TREE_IMP; a_parent_node: EV_TREE_NODE_IMP; a_index: INTEGER)  is
			-- Used for setting items within parent tree
		local
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
			i: INTEGER
			item_imp: EV_TREE_NODE_IMP
			a_parent_iter: POINTER
		do
			if a_parent_node /= Void then
				a_parent_iter := a_parent_node.list_iter.item
			end
			create a_tree_iter.make
			set_list_iter (a_tree_iter)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_store_insert (a_parent_tree.tree_store, a_tree_iter.item, a_parent_iter, a_index - 1)
			a_parent_tree.set_text_on_position (Current, text)
			a_parent_tree.update_row_pixmap (Current)
			from
				i := 1
			until
				i > child_array.count
			loop
				item_imp ?= (child_array @ i).implementation
				item_imp.add_item_and_children_to_parent_tree (a_parent_tree, Current, i)
				i := i + 1
			end
		end

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Implementation

	ensure_expandable is
			-- Ensure `Current' is displayed as expandable.
		do
			insert_i_th (create {EV_TREE_ITEM}, 1)
				-- Now remove the new item from `child_array'
				-- as we do not wish the item to be accessible from the interface.
			child_array.wipe_out
		end

	remove_expandable is
			-- Ensure `Current' is no longer displayed as expandable.
		local
			l_parent_tree: EV_TREE_IMP
		do
			l_parent_tree ?= parent_imp
			if l_parent_tree /= Void then
				-- Check if 'child_array' count is less than actual count, if so remove last item
			else
				-- Nothing needs to be done if parent tree is Void
			end
		end

	text: STRING_32 is
			-- Text displayed.
		local
			par_t_imp: EV_TREE_IMP
		do
			if internal_text = Void then
				par_t_imp := parent_tree_imp
				Result := par_t_imp.get_text_from_position (Current)
			else
				Result := internal_text.twin
			end
		ensure then
			text_not_void: Result /= Void
		end

	tooltip: STRING_32 is
			-- Tooltip if any.
		do
			if internal_tooltip = Void then
				Result := ""
			else
				Result := internal_tooltip.twin
			end
		ensure then
			tooltip_not_void: Result /= Void
		end

	remove_internal_text is
			-- Make `internal_text' Void
		do
			internal_text := Void
		end

	set_internal_text (a_text: STRING_GENERAL) is
			-- Set `internal_text' to `a_text'
		do
			internal_text := a_text
		end

	internal_text: STRING_32
		-- Internal representation of `text'.

	internal_tooltip: STRING_32
		-- Internal representation of `tooltip'.

	set_tooltip (a_text: STRING_GENERAL) is
			-- Set `a_text' to `tooltip'.
		do
			internal_tooltip := a_text
		end

	remove_tooltip is
			-- Remove text of `tooltip'.
		do
			internal_tooltip := ""
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set the pixmap for 'Current'.
		local
			a_pix_imp: EV_PIXMAP_IMP
			par_tree: EV_TREE_IMP
		do
				-- Clean up previous pixmap if any
			dispose
			a_pix_imp ?= a_pixmap.implementation
			gdk_pixbuf := a_pix_imp.pixbuf_from_drawable
			par_tree := parent_tree_imp
			if par_tree /= Void then
				par_tree.update_row_pixmap (Current)
			end
		end

	pix_width, pix_height: INTEGER
			-- Height and width of pixmap in Tree.

	remove_pixmap is
			-- Remove the pixmap for `Current'
		local
			par_tree: EV_TREE_IMP
		do
			if gdk_pixbuf /= default_pointer then
				{EV_GTK_EXTERNALS}.object_unref (gdk_pixbuf)
				gdk_pixbuf := default_pointer
			end
			par_tree := parent_tree_imp
			if par_tree /= Void then
				par_tree.update_row_pixmap (Current)
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmap displayed in 'Current' if any.
		local
			pix_imp: EV_PIXMAP_IMP
		do
			if gdk_pixbuf /= default_pointer then
				create Result
				pix_imp ?= Result.implementation
				pix_imp.set_pixmap_from_pixbuf (gdk_pixbuf)
			end
		end

	gdk_pixbuf: POINTER
		-- Stored gdk pixbuf data

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_TREE_NODE_IMP
			par_t_imp: EV_TREE_IMP
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)
			child_array.go_i_th (i)
			child_array.put_left (v)

				-- Using a local prevents recalculation
			par_t_imp := parent_tree_imp
			if par_t_imp /= Void then
				item_imp.add_item_and_children_to_parent_tree (par_t_imp, Current, i)
				item_imp.remove_internal_text
				if item_imp.is_transport_enabled_iterator then
					par_t_imp.update_pnd_connection (True)
				end
			end
				-- Resume expansion status from last node removal
			if count = 1 and then par_t_imp /= Void then
				if expand_actions_internal /= Void then
					expand_actions_internal.block
				end
				set_expand (expanded_on_last_item_removal)
				if expand_actions_internal /= Void then
					expand_actions_internal.resume
				end
			end
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item at `a_position'
		local
			item_imp: EV_TREE_NODE_IMP
			par_tree_imp: EV_TREE_IMP
		do
			if count = 1 then
				if parent_tree /= Void then
					expanded_on_last_item_removal := is_expanded
				else
					expanded_on_last_item_removal := False
				end
			end
			item_imp ?= (child_array @ (a_position)).implementation

				-- Remove from tree if present
			par_tree_imp := parent_tree_imp
			if par_tree_imp /= Void then
				item_imp.set_internal_text (par_tree_imp.get_text_from_position (item_imp))
				{EV_GTK_EXTERNALS}.gtk_tree_store_remove (par_tree_imp.tree_store, item_imp.list_iter.item)
			end
			item_imp.set_parent_imp (Void)
			child_array.go_i_th (a_position)
			child_array.remove

			if par_tree_imp /= Void then
				par_tree_imp.update_pnd_status
			end
		end

	expanded_on_last_item_removal: BOOLEAN
		-- Was `Current' expanded upon removal of last item

feature {NONE} -- Redundant implementation

	real_pointed_target: EV_PICK_AND_DROPABLE is
		do
			check do_not_call: False end
		end

feature {NONE} -- Implementation

	dispose is
			-- Clean up
		do
			if not is_in_final_collect and then gdk_pixbuf /= default_pointer then
					{EV_GTK_EXTERNALS}.object_unref (gdk_pixbuf)
					gdk_pixbuf := default_pointer
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_NODE;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TREE_NODE_IMP

