note
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
			make
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			make,
			needs_event_box,
			call_button_event_actions,
			minimum_width
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

create
	make

feature -- Initialization

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := False
		end

	old_make (an_interface: attached like interface)
			-- Create an empty Tree.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'
		local
			dummy_imp: detachable EV_HEADER_ITEM_IMP
			a_tree_view: POINTER
		do
			a_tree_view := {GTK2}.gtk_tree_view_new
			set_c_object (a_tree_view)
				-- We don't want the header to steal focus.
			{GTK}.gtk_widget_set_can_focus (visual_widget, False)
			{GTK2}.gtk_tree_view_set_headers_visible (visual_widget, True)
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}

				-- Add our dummy column to the end to match Windows implementation
			create dummy_item
				-- Set an empty text to the dummy item so that the minimum height of header takes the default label size in to account.
			dummy_item.set_text ("  ")
			dummy_imp ?= dummy_item.implementation
			check dummy_imp /= Void then end
			{GTK2}.gtk_tree_view_column_set_min_width (dummy_imp.c_object, 0)
			dummy_imp.set_width (dummy_imp.minimum_width)
			{GTK2}.gtk_tree_view_column_set_clickable (dummy_imp.c_object, False)

			resize_model (100)
			{GTK2}.gtk_tree_view_insert_column (visual_widget, dummy_imp.c_object, 0)

			set_pixmaps_size (16, 16)

			pointer_button_release_actions.call (Void)

			set_is_initialized (True)
		end

	dummy_item: EV_HEADER_ITEM

	resize_model  (a_columns: INTEGER)
			-- Resize the data model to match the number of columns
		local
			a_type_array: MANAGED_POINTER
			i: INTEGER
			list_store: POINTER
			l_gtype_size: INTEGER
		do
			l_gtype_size := {GTK2}.sizeof_gtype
			create a_type_array.make ((a_columns) * l_gtype_size)
			from
				i := 1
			until
				i > a_columns
			loop
				{GTK2}.add_g_type_string (a_type_array.item, (i - 1)  * l_gtype_size)
				i := i + 1
			end

			list_store :=  new_list_store (1) --{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_newv (a_columns, a_type_array.item)

			{GTK2}.gtk_tree_view_set_model (visual_widget, list_store)
			model_count := a_columns
		end

	new_list_store (a_columns: INTEGER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_new ((gint) $a_columns, G_TYPE_STRING)"
		end

feature -- Element change

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			item_imp: detachable EV_HEADER_ITEM_IMP
		do
			if count + 2 > model_count then
				resize_model (count + 2)
					-- We are taking the dummy right column in to account
			end
			item_imp ?= v.implementation
			check item_imp /= Void end
			if item_imp /= Void then
				child_array.go_i_th (i)
				child_array.put_left (v)
				{GTK2}.gtk_tree_view_insert_column (visual_widget, item_imp.c_object, i - 1)
				item_imp.set_parent_imp (Current)
			end
		end

	remove_i_th (a_position: INTEGER)
			-- Remove item a`a_position'
		local
			item_imp: detachable EV_HEADER_ITEM_IMP
		do
			child_array.go_i_th (a_position)
			item_imp ?= child_array.item.implementation
			check item_imp /= Void end
			if item_imp /= Void then
				item_imp.set_parent_imp (Void)
				{GTK2}.gtk_tree_view_remove_column (visual_widget, item_imp.c_object)
			end
			child_array.remove
		end

feature {EV_HEADER_ITEM_IMP} -- Implementation

	item_resize_tuple: detachable TUPLE [EV_HEADER_ITEM]
		-- Reusable item resize tuple.

	set_call_item_resize_start_actions (a_flag: BOOLEAN)
			-- Set `call_item_resize_start_actions' to `a_flag'.
		do
			call_item_resize_start_actions := a_flag
		end

	item_has_resized
			-- The item has finished resizing so call `item_resize_end_actions'.
		do
			item_resize_end_actions.call (item_resize_tuple)
			call_item_resize_end_actions := False
		end

	on_resize (a_item: EV_HEADER_ITEM)
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

	pointed_divider_index: INTEGER
			-- Index of divider currently beneath the mouse pointer, or
			-- 0 if none.
		local
			gdkwin, gtkwid: POINTER
			i, l_count, l_x, l_y, l_button_x: INTEGER --l_pointer_x, l_pointer_y: INTEGER
			a_item_imp: detachable EV_HEADER_ITEM_IMP
		do
			-- TODO double check	
			-- With GTK3 the call to the feature `{GDK_HELPERS}.window_at ($a_pointer_x, $a_pointer_y)`
			-- Returns default_pointer, -1, -1
			-- gdkwin := {GDK_HELPERS}.window_at ($a_pointer_x, $a_pointer_y)

			gdkwin := {GTK}.gtk_widget_get_window (c_object)
			if gdkwin /= default_pointer then

				{GDK}.gdk_window_get_position (gdkwin, $l_x, $l_y)
				{GDK}.gdk_window_get_user_data (gdkwin, $gtkwid)

				if gtkwid = c_object then
					from
						i := 1
						l_count := count
					until
						i > l_count
					loop
						a_item_imp ?= i_th (i).implementation
						check a_item_imp /= Void end
						if a_item_imp /= Void then
							l_button_x := {GTK2}.g_object_get_integer (a_item_imp.c_object, {GTK_PROPERTIES}.x_offset)
						end
						if l_button_x < l_x then
							Result := Result + 1
						else
							i := l_count
						end
						i := i + 1
					end
				end
			end
		end

	call_button_event_actions (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Call pointer_button_press_actions or pointer_double_press_actions
			-- depending on event type in first position of `event_data'.
		local
			a_pointed_divider_index: INTEGER
			--a_pointer_x, a_pointer_y: INTEGER
			gdkwin: POINTER
			l_widget: POINTER
			l_last_column: POINTER
		do
			set_call_item_resize_start_actions (False)
			a_pointed_divider_index := pointed_divider_index
			if a_pointed_divider_index > 0 then
				set_call_item_resize_start_actions (True)
			end
			Precursor {EV_PRIMITIVE_IMP} (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)

				-- If we are clicking on the Void area then we the item events passing Void items.
			if a_type = {GDK}.gdk_button_press_enum or a_type = {GDK}.gdk_2button_press_enum then

				-- TODO double check	
				-- With GTK3 the call to the feature `{GDK_HELPERS}.window_at ($a_pointer_x, $a_pointer_y)`
				-- Returns default_pointer, -1, -1
				-- gdkwin := {GDK_HELPERS}.window_at ($a_pointer_x, $a_pointer_y)

				gdkwin := {GTK}.gtk_widget_get_window (c_object)
				if gdkwin /= default_pointer then
					{GDK}.gdk_window_get_user_data (gdkwin, $l_widget)
					l_last_column := {GTK2}.gtk_tree_view_get_column (c_object, count)
					if l_widget = {GTK2}.gtk_tree_view_column_get_button (l_last_column) then
							-- Fire item press actions with a Void item.
						if a_type = {GDK}.gdk_button_press_enum and then item_pointer_button_press_actions_internal /= Void then
							item_pointer_button_press_actions_internal.call ([Void, a_x, a_y, a_button])
						elseif a_type = {GDK}.gdk_2button_press_enum and then item_pointer_double_press_actions_internal /= Void then
							item_pointer_double_press_actions_internal.call ([Void, a_x, a_y, a_button])
						end
					end
				end
			end
		end

	call_item_resize_actions
			-- Call the item resize end actions.
		do
			item_has_resized
			item_resize_tuple := Void
		end

	model_count: INTEGER
		-- Number of cells available in model

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
		end

feature -- Access size

	minimum_width: INTEGER_32
			-- Minimum horizontal size in pixels.
		do
			Result := Precursor
			if Result <= 0 then
				Result := real_minimum_width
			end
		end



feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_HEADER note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
