indexing
	description: "EiffelVision list item list, gtk implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_LIST_ITEM_LIST_IMP

inherit
	EV_LIST_ITEM_LIST_I
		redefine
			call_pebble_function,
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			call_pebble_function,
			initialize,
			interface,
			pre_pick_steps
		end

	EV_ITEM_LIST_IMP [EV_LIST_ITEM]
		redefine
			interface,
			insert_i_th,
			remove_i_th,
			initialize
		end

	EV_LIST_ITEM_LIST_ACTION_SEQUENCES_IMP

	EV_KEY_CONSTANTS

	EV_PND_DEFERRED_ITEM_PARENT

feature {NONE} -- Initialization

	initialize is
			-- Set up `Current'
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			initialize_pixmaps
			initialize_model
		end

	initialize_model is
			-- Create our data model for `Current'
		do
			list_store := new_list_store
		end

feature -- Access

	selected_items: ARRAYED_LIST [EV_LIST_ITEM] is
			-- `Result is all items currently selected in `Current'.
		deferred
		end

feature -- Status report

	row_from_y_coord (a_y: INTEGER): EV_PND_DEFERRED_ITEM is
			-- Retrieve the Current row from `a_y' coordinate
		do
		end

	update_pnd_status is
			-- Update PND status of list and its children.
		local
			a_enable_flag: BOOLEAN
			i: INTEGER
			a_cursor: CURSOR
			a_list_item_imp: EV_LIST_ITEM_IMP
		do
			from
				a_cursor := child_array.cursor
				child_array.start
				i := 1
			until
				i > child_array.count or else a_enable_flag
			loop
				child_array.go_i_th (i)
				if child_array.item /= Void then
					a_list_item_imp ?= child_array.item.implementation
					a_enable_flag := a_list_item_imp.is_transport_enabled
				end
				i := i + 1
			end
			child_array.go_to (a_cursor)
			update_pnd_connection (a_enable_flag)
		end

	update_pnd_connection (a_enable: BOOLEAN) is
			-- Update the PND connection of `Current' if needed.
		do
			if not is_transport_enabled then
				if a_enable or pebble /= Void then
					is_transport_enabled := True
				end
			elseif not a_enable and pebble = Void then
				is_transport_enabled := False
			end
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
				-- Steps to perform before transport initiated.
			do
				temp_accept_cursor := accept_cursor
				temp_deny_cursor := deny_cursor
				app_implementation.on_pick (pebble)
				if pnd_row_imp /= Void then
					if pnd_row_imp.pick_actions_internal /= Void then
						pnd_row_imp.pick_actions_internal.call ([a_x, a_y])
					end
					accept_cursor := pnd_row_imp.accept_cursor
					deny_cursor := pnd_row_imp.deny_cursor
				else
					if pick_actions_internal /= Void then
						pick_actions_internal.call ([a_x, a_y])
					end
				end
				pointer_x := a_screen_x
				pointer_y := a_screen_y
				if pnd_row_imp = Void then
					if (pick_x = 0 and then pick_y = 0) then
						App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
					else
						if pick_x > width then
							pick_x := width
						end
						if pick_y > height then
							pick_y := height
						end
						App_implementation.set_x_y_origin (pick_x + (a_screen_x - a_x), pick_y + (a_screen_y - a_y))
					end
				else
					if (pnd_row_imp.pick_x = 0 and then pnd_row_imp.pick_y = 0) then
						App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
					else
						if pick_x > width then
							pick_x := width
						end
						if pick_y > row_height then
							pick_y := row_height
						end
						App_implementation.set_x_y_origin (
							pnd_row_imp.pick_x + (a_screen_x - a_x),
							pnd_row_imp.pick_y + (a_screen_y - a_y) + ((child_array.index_of (pnd_row_imp.interface, 1) - 1) * row_height)
						)
					end
				end
			end

	row_height: INTEGER is
			-- Default height of rows
		do
			Result := 10
		end

	pnd_row_imp: EV_LIST_ITEM_IMP
			-- Implementation object of the current row if in PND transport.

	temp_pebble: ANY

	temp_pebble_function: FUNCTION [ANY, TUPLE [], ANY]
			-- Returns data to be transported by PND mechanism.

	temp_accept_cursor, temp_deny_cursor: EV_CURSOR

	call_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Set `pebble' using `pebble_function' if present.
		do
			temp_pebble := pebble
			temp_pebble_function := pebble_function
			if pnd_row_imp /= Void then
				pebble := pnd_row_imp.pebble
				pebble_function := pnd_row_imp.pebble_function
			end

			if pebble_function /= Void then
				pebble_function.call ([a_x, a_y]);
				pebble := pebble_function.last_result
			end
		end

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Select item at one based index, `an_index'.
		deferred
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at one based index, `an_index'.
		deferred
		end

feature -- Insertion

	set_text_on_position (a_row: INTEGER; a_text: STRING_GENERAL) is
			-- Set cell text at (a_column, a_row) to `a_text'.
		local
			a_cs: EV_GTK_C_STRING
			str_value: POINTER
			a_list_item_imp: EV_LIST_ITEM_IMP
		do
			a_cs := App_implementation.reusable_gtk_c_string
			a_cs.share_with_eiffel_string (a_text)
			str_value := g_value_string_struct
			{EV_GTK_DEPENDENT_EXTERNALS}.g_value_take_string (str_value, a_cs.item)
			a_list_item_imp ?= child_array.i_th (a_row).implementation
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_value (list_store, a_list_item_imp.list_iter.item, 1, str_value)
		end

	g_value_string_struct: POINTER is
			-- Optimization for GValue struct access
		once
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.c_g_value_struct_allocate
			{EV_GTK_DEPENDENT_EXTERNALS}.g_value_init_string (Result)
		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Set row `a_row' pixmap to `a_pixmap'.
		local
			pixmap_imp: EV_PIXMAP_IMP
			a_list_item_imp: EV_LIST_ITEM_IMP
			a_pixbuf: POINTER
		do
			pixmap_imp ?= a_pixmap.implementation
			a_pixbuf := pixmap_imp.pixbuf_from_drawable_with_size (pixmaps_width, pixmaps_height)
			a_list_item_imp ?= child_array.i_th (a_row).implementation
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_pixbuf (list_store, a_list_item_imp.list_iter.item, 0, a_pixbuf)
			{EV_GTK_EXTERNALS}.object_unref (a_pixbuf)
		end

	remove_row_pixmap (a_row: INTEGER) is
			-- Set row `a_row' pixmap to `a_pixmap'.
		local
			a_list_item_imp: EV_LIST_ITEM_IMP
		do
			a_list_item_imp ?= child_array.i_th (a_row).implementation
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_pixbuf (list_store, a_list_item_imp.list_iter.item, 0, NULL)
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_LIST_ITEM_IMP
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)

			child_array.go_i_th (i)
			child_array.put_left (v)

				-- Add row to model
			create a_tree_iter.make
			item_imp.set_list_iter (a_tree_iter)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_insert (list_store, a_tree_iter.item, i - 1)
			set_text_on_position (i, v.text)

			if v.pixmap /= Void then
				set_row_pixmap (i, v.pixmap)
			end

			if item_imp.is_transport_enabled then
				update_pnd_connection (True)
			end
		end

feature {EV_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_IMP} -- Implementation

	interface: EV_LIST_ITEM_LIST

	list_store: POINTER
		-- Pointer to the model which holds all of the column data

feature {NONE} -- Implementation

	remove_i_th (an_index: INTEGER) is
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			clear_selection
			item_imp ?= (child_array @ (an_index)).implementation
			item_imp.set_parent_imp (Void)
			{EV_GTK_EXTERNALS}.gtk_list_store_remove (list_store, item_imp.list_iter.item)
			-- remove the row from the `ev_children'
			child_array.go_i_th (an_index)
			child_array.remove
			--update_pnd_status
		end

	new_list_store: POINTER is
			-- New instance of a list store.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_list_store_new (2, GDK_TYPE_PIXBUF, G_TYPE_STRING)"
		end

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




end -- class EV_LIST_ITEM_LIST_IMP

