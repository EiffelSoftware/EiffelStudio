indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_IMP

inherit
	EV_HEADER_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_HEADER_ITEM]
		redefine
			interface,
			initialize
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			destroy,
			needs_event_box,
			on_button_release,
			button_press_switch
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			initialize
		end

	EV_HEADER_ACTION_SEQUENCES_IMP

create
	make

feature -- Initialization

	needs_event_box: BOOLEAN is True

	make (an_interface: like interface) is
			-- Create an empty Tree.
		local
			a_tree_view: POINTER
		do
			base_make (an_interface)
			a_tree_view := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_new
			set_c_object (a_tree_view)
		end

	initialize is
			-- Initialize `Current'
		local
			dummy_imp: EV_HEADER_ITEM_IMP
		do
				-- We don't want the header to steal focus.
			{EV_GTK_EXTERNALS}.gtk_widget_unset_flags (visual_widget, {EV_GTK_EXTERNALS}.gtk_can_focus_enum)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_headers_visible (visual_widget, True)
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}

				-- Add our dummy column to the end to match Windows implementation
			create dummy_item
			dummy_imp ?= dummy_item.implementation
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_min_width (dummy_imp.c_object, 0)
			dummy_imp.set_width (1)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_clickable (dummy_imp.c_object, False)
			resize_model (100)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_insert_column (visual_widget, dummy_imp.c_object, 0)

			set_pixmaps_size (16, 16)

			pointer_button_release_actions.call (Void)

			set_is_initialized (True)
		end

	dummy_item: EV_HEADER_ITEM

	resize_model  (a_columns: INTEGER) is
			-- Resize the data model to match the number of columns
		local
			a_type_array: MANAGED_POINTER
			i: INTEGER
			list_store: POINTER
		do
			create a_type_array.make ((a_columns) * {EV_GTK_DEPENDENT_EXTERNALS}.sizeof_gtype)
			from
				i := 1
			until
				i > a_columns
			loop
				{EV_GTK_DEPENDENT_EXTERNALS}.add_g_type_string (a_type_array.item, (i - 1)  * {EV_GTK_DEPENDENT_EXTERNALS}.sizeof_gtype)
				i := i + 1
			end

			list_store :=  {EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_newv (a_columns, a_type_array.item)

			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_model (visual_widget, list_store)
			model_count := a_columns
		end

feature

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_HEADER_ITEM_IMP
		do
			if count + 2 > model_count then
				resize_model (count + 2)
					-- We are taking the dummy right column in to account
			end
			item_imp ?= v.implementation
			child_array.go_i_th (i)
			child_array.put_left (v)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_insert_column (visual_widget, item_imp.c_object, i - 1)
			item_imp.set_parent_imp (Current)
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item a`a_position'
		local
			item_imp: EV_HEADER_ITEM_IMP
		do
			child_array.go_i_th (a_position)
			item_imp ?=item.implementation
			item_imp.set_parent_imp (Void)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_remove_column (visual_widget, item_imp.c_object)
			child_array.remove
		end

feature {EV_HEADER_ITEM_IMP} -- Implemnentation

	item_resize_tuple: TUPLE [EV_HEADER_ITEM]
		-- Reusable item resize tuple.

	set_call_item_resize_start_actions (a_flag: BOOLEAN) is
			-- Set `call_item_resize_start_actions' to `a_flag'.
		do
			call_item_resize_start_actions := a_flag
		end

	item_has_resized is
			-- The item has finished resizing so call `item_resize_end_actions'.
		do
			item_resize_end_actions.call (item_resize_tuple)
			call_item_resize_end_actions := False
		end

	on_resize (a_item: EV_HEADER_ITEM) is
			-- `a_item' has resized.
		require
			a_item_not_void: a_item /= Void
		do
			if call_item_resize_start_actions then
				item_resize_tuple := [a_item]
				item_resize_start_actions.call (item_resize_tuple)
				set_call_item_resize_start_actions (False)
			end
			if item_resize_tuple /= Void then
					-- We should only call resize actions after the start actions have been called.
				call_item_resize_end_actions := True
				item_resize_actions.call (item_resize_tuple)
			end
		end

	call_item_resize_start_actions: BOOLEAN
	call_item_resize_end_actions: BOOLEAN
		-- Should the appropriate item resize actions be called?

feature {NONE} -- Implementation

	pointed_divider_index: INTEGER is
			-- Index of divider currently beneath the mouse pointer, or
			-- 0 if none.
		local
			gdkwin: POINTER
			a_pointer_x, a_pointer_y: INTEGER
			a_item_imp: EV_HEADER_ITEM_IMP
			a_cursor: like cursor
		do
			gdkwin := {EV_GTK_EXTERNALS}.gdk_window_at_pointer ($a_pointer_x, $a_pointer_y)
			if gdkwin /= default_pointer then
				from
					a_cursor := cursor
					start
				until
					Result > 0 or else off
				loop
					a_item_imp ?= item.implementation
					if {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_struct_window (a_item_imp.c_object) = gdkwin then
						Result := index
					end
					forth
				end
				go_to (a_cursor)
			end
		end

	button_press_switch (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
		local
			a_pointed_divider_index: INTEGER
		do
			set_call_item_resize_start_actions (False)
			a_pointed_divider_index := pointed_divider_index
			if a_pointed_divider_index > 0 then
				set_call_item_resize_start_actions (True)
			end
			Precursor {EV_PRIMITIVE_IMP} (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	on_button_release (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Used for pointer button release events
		do
			if call_item_resize_end_actions then
					-- This is needed as the there may be a slight difference between when the button was released
					-- and when the column width was calculated.
				app_implementation.do_once_on_idle (agent call_item_resize_actions)
			end
			Precursor {EV_PRIMITIVE_IMP} (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	call_item_resize_actions is
			-- Call the item resize end actions.
		do
			item_has_resized
			item_resize_tuple := Void
		end

	model_count: INTEGER
		-- Number of cells available in model

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Implement me
		end

	destroy is
			--
		do
			Precursor {EV_PRIMITIVE_IMP}
		end

	interface: EV_HEADER;

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




end
