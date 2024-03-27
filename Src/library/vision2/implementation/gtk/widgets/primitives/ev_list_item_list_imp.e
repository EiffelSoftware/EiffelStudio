note
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
			reset_pebble_function,
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			call_pebble_function,
			reset_pebble_function,
			make,
			interface,
			pre_pick_steps,
			post_drop_steps,
			ready_for_pnd_menu,
			pebble_source,
			able_to_transport
		end

	EV_ITEM_LIST_IMP [EV_LIST_ITEM]
		redefine
			interface,
			make
		end

	EV_KEY_CONSTANTS

	EV_PND_DEFERRED_ITEM_PARENT

feature {NONE} -- Initialization

	make
			-- Set up `Current'
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			initialize_pixmaps
			initialize_model
		end

	initialize_model
			-- Create our data model for `Current'
		do
			list_store := new_list_store
		end

feature -- Access

	selected_items: ARRAYED_LIST [EV_LIST_ITEM]
			-- `Result is all items currently selected in `Current'.
		deferred
		end

feature -- Status report

	item_from_coords (a_x, a_y: INTEGER): detachable EV_PND_DEFERRED_ITEM
			-- Retrieve the Current row from `a_y' coordinate
		do
		end

	update_pnd_status
			-- Update PND status of list and its children.
		local
			a_enable_flag: BOOLEAN
			i: INTEGER
			a_cursor: CURSOR
			a_list_item_imp: detachable EV_LIST_ITEM_IMP
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
					check a_list_item_imp /= Void end
					if a_list_item_imp /= Void then
						a_enable_flag := a_list_item_imp.is_transport_enabled
					end
				end
				i := i + 1
			end
			child_array.go_to (a_cursor)
			update_pnd_connection (a_enable_flag)
		end

	update_pnd_connection (a_enable: BOOLEAN)
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

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
				-- Steps to perform before transport initiated.
			local
				l_pnd_row_imp: like pnd_row_imp
				l_pebble: like pebble
			do
				temp_accept_cursor := accept_cursor
				temp_deny_cursor := deny_cursor
				l_pebble := pebble
				if l_pebble /= Void then
					app_implementation.on_pick (Current, l_pebble)
				end
				l_pnd_row_imp := pnd_row_imp
				if l_pnd_row_imp /= Void then
					if l_pnd_row_imp.pick_actions_internal /= Void then
						l_pnd_row_imp.pick_actions.call ([a_x, a_y])
					end
					accept_cursor := l_pnd_row_imp.accept_cursor
					deny_cursor := l_pnd_row_imp.deny_cursor
				else
					if pick_actions_internal /= Void then
						pick_actions_internal.call ([a_x, a_y])
					end
				end
				pointer_x := a_screen_x.to_integer_16
				pointer_y := a_screen_y.to_integer_16
				if l_pnd_row_imp = Void then
					if (pick_x = 0 and then pick_y = 0) then
						App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
					else
						if pick_x > width then
							pick_x := width.to_integer_16
						end
						if pick_y > height then
							pick_y := height.to_integer_16
						end
						App_implementation.set_x_y_origin (pick_x + (a_screen_x - a_x), pick_y + (a_screen_y - a_y))
					end
				else
					if (l_pnd_row_imp.pick_x = 0 and then l_pnd_row_imp.pick_y = 0) then
						App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
					else
						if pick_x > width then
							pick_x := width.to_integer_16
						end
						if pick_y > row_height then
							pick_y := row_height.to_integer_16
						end
						App_implementation.set_x_y_origin (
							l_pnd_row_imp.pick_x + (a_screen_x - a_x),
							l_pnd_row_imp.pick_y + (a_screen_y - a_y) + ((child_array.index_of (l_pnd_row_imp.attached_interface, 1) - 1) * row_height)
						)
					end
				end
				modify_widget_appearance (True)
			end

	post_drop_steps (a_button: INTEGER)
			-- Steps to perform once an attempted drop has happened.
		do
			Precursor (a_button)
			accept_cursor := temp_accept_cursor
			deny_cursor := temp_deny_cursor

			temp_accept_cursor := Void
			temp_deny_cursor := Void

			pnd_row_imp := Void
		end

	row_height: INTEGER
			-- Height of rows in `Current'
		do
			--| FIXME Implement correctly.
			Result := 10
		end

	pebble_source: EV_PICK_AND_DROPABLE
			-- Source of pebble, used for widgets with deferred PND implementation
			-- such as EV_TREE and EV_MULTI_COLUMN_LIST.
		do
			if attached pnd_row_imp as l_pnd_row_imp then
				Result := l_pnd_row_imp.attached_interface
			else
				Result := Precursor
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN
			-- Is list or row able to transport PND data using `a_button'.
		do
			if attached pnd_row_imp as l_pnd_row_imp then
				Result := l_pnd_row_imp.able_to_transport (a_button)
			else
				Result := Precursor (a_button)
			end
		end

	ready_for_pnd_menu (a_button: INTEGER_32; a_press: BOOLEAN): BOOLEAN
			-- Is list or row able to display PND menu using `a_button'
		do
			if attached pnd_row_imp as l_pnd_row_imp then
				Result := l_pnd_row_imp.ready_for_pnd_menu (a_button, a_press)
			else
				Result := Precursor (a_button, a_press)
			end
		end

	pnd_row_imp: detachable EV_LIST_ITEM_IMP
			-- Implementation object of the current row if in PND transport.

	temp_pebble: detachable ANY

	temp_pebble_function: detachable FUNCTION [detachable ANY]
			-- Returns data to be transported by PND mechanism.

	temp_accept_cursor, temp_deny_cursor: detachable EV_POINTER_STYLE

	call_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Set `pebble' using `pebble_function' if present.
		do
			temp_pebble := pebble
			temp_pebble_function := pebble_function
			if attached pnd_row_imp as l_pnd_row_imp then
				pebble := l_pnd_row_imp.pebble
				pebble_function := l_pnd_row_imp.pebble_function
			end

			if attached pebble_function as l_pebble_function then
				pebble := l_pebble_function.item ([a_x, a_y])
			end
		end

	reset_pebble_function
			-- Reset `pebble_function'.
		do
			pebble := temp_pebble
			pebble_function := temp_pebble_function
			temp_pebble := Void
			temp_pebble_function := Void
		end

feature -- Status setting

	select_item (an_index: INTEGER)
			-- Select item at one based index, `an_index'.
		deferred
		end

	deselect_item (an_index: INTEGER)
			-- Deselect item at one based index, `an_index'.
		deferred
		end

feature -- Insertion

	set_text_on_position (a_row: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Set cell text at (a_column, a_row) to `a_text'.
		local
			a_cs: EV_GTK_C_STRING
			str_value: POINTER
			a_list_item_imp: detachable EV_LIST_ITEM_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			a_cs := App_implementation.reusable_gtk_c_string
			a_cs.share_with_eiffel_string (a_text)
			str_value := g_value_string_struct
			{GOBJECT}.g_value_take_string (str_value, a_cs.item)
			a_list_item_imp ?= child_array.i_th (a_row).implementation
			check a_list_item_imp /= Void end
			if a_list_item_imp /= Void then
				l_list_iter := a_list_item_imp.list_iter
				check l_list_iter /= Void end
				if l_list_iter /= Void then
					{GTK2}.gtk_list_store_set_value (list_store, l_list_iter.item, 1, str_value)
				end
			end
		end

	g_value_string_struct: POINTER
			-- Optimization for GValue struct access
		once
			Result := {GTK2}.c_g_value_struct_allocate
			{GOBJECT}.g_value_init_string (Result)
		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP)
			-- Set row `a_row' pixmap to `a_pixmap'.
		local
			pixmap_imp: detachable EV_PIXMAP_IMP
			a_list_item_imp: detachable EV_LIST_ITEM_IMP
			a_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
			a_pixbuf: POINTER
		do
			pixmap_imp ?= a_pixmap.implementation
			check pixmap_imp /= Void then end
			a_pixbuf := pixmap_imp.pixbuf_from_drawable_with_size (pixmaps_width, pixmaps_height)
			a_list_item_imp ?= child_array.i_th (a_row).implementation
			check a_list_item_imp /= Void then end
			a_list_iter := a_list_item_imp.list_iter
			check a_list_iter /= Void then end
			{GTK2}.gtk_list_store_set_pixbuf (list_store, a_list_iter.item, 0, a_pixbuf)
			{GTK2}.object_unref (a_pixbuf)
		end

	remove_row_pixmap (a_row: INTEGER)
			-- Set row `a_row' pixmap to `a_pixmap'.
		local
			a_list_item_imp: detachable EV_LIST_ITEM_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			a_list_item_imp ?= child_array.i_th (a_row).implementation
			check a_list_item_imp /= Void then end
			l_list_iter := a_list_item_imp.list_iter
			check l_list_iter /= Void then end
			{GTK2}.gtk_list_store_set_pixbuf (list_store, l_list_iter.item, 0, NULL)
		end

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			item_imp: detachable EV_LIST_ITEM_IMP
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
		do
			item_imp ?= v.implementation
			check item_imp /= Void end
			if item_imp /= Void then
				item_imp.set_parent_imp (Current)

				child_array.go_i_th (i)
				child_array.put_left (v)

					-- Add row to model
				create a_tree_iter.make
				item_imp.set_list_iter (a_tree_iter)
				{GTK2}.gtk_list_store_insert (list_store, a_tree_iter.item, i - 1)
				set_text_on_position (i, v.text)

				if attached v.pixmap as l_pixmap then
					set_row_pixmap (i, l_pixmap)
				end

				if item_imp.is_transport_enabled then
					update_pnd_connection (True)
				end
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_LIST_ITEM_LIST note option: stable attribute end;

feature {EV_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_IMP} -- Implementation

	list_store: POINTER
		-- Pointer to the model which holds all of the column data

feature {NONE} -- Implementation

	remove_i_th (an_index: INTEGER)
		local
			item_imp: detachable EV_LIST_ITEM_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			clear_selection
			item_imp ?= (child_array @ (an_index)).implementation
			check item_imp /= Void end
			if item_imp /= Void then
				item_imp.set_parent_imp (Void)
				l_list_iter := item_imp.list_iter
				check l_list_iter /= Void end
				if l_list_iter /= Void then
					{GTK2}.gtk_list_store_remove (list_store, l_list_iter.item)
				end
				-- remove the row from the `ev_children'
				child_array.go_i_th (an_index)
				child_array.remove
				--update_pnd_status
			end
		end

	new_list_store: POINTER
			-- New instance of a list store.
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_new (2, GDK_TYPE_PIXBUF, G_TYPE_STRING)"
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_LIST_ITEM_LIST_IMP





