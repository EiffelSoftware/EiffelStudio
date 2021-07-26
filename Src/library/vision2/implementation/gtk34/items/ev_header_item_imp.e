note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_ITEM_IMP

inherit
	EV_HEADER_ITEM_I
		redefine
			interface
		end

	EV_TEXTABLE_IMP
		redefine
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface,
			needs_event_box,
			process_gdk_event,
			process_draw_event,
			destroy
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
			-- Create the tree item.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize the header item.
		local
			l_label_ellipsize_symbol: POINTER
		do
			set_c_object  ({GTK2}.gtk_tree_view_column_new)
			{GTK2}.gtk_tree_view_column_set_resizable (c_object, True)
			{GTK2}.gtk_tree_view_column_set_sizing (c_object, {GTK2}.gtk_tree_view_column_fixed_enum)
			{GTK2}.gtk_tree_view_column_set_clickable (c_object, True)
			pixmapable_imp_initialize
			textable_imp_initialize
			l_label_ellipsize_symbol := gtk_label_set_ellipsize_symbol
			if l_label_ellipsize_symbol /= default_pointer then
				gtk_label_set_ellipsize_call (l_label_ellipsize_symbol, text_label, 3)
			else
				{GTK2}.gtk_label_set_ellipsize (text_label, 3)
			end
			box := {GTK}.gtk_box_new ({GTK_ORIENTATION}.gtk_orientation_horizontal, 0)
			box := {GDK}.g_object_ref_sink (box)
			{GTK}.gtk_widget_show (box)
			{GTK}.gtk_box_pack_start (box, pixmap_box, False, False, 0)
			{GTK}.gtk_box_pack_end (box, text_label, True, True, 0)
			{GTK2}.gtk_tree_view_column_set_widget (c_object, box)

			set_minimum_width (0)
			maximum_width := 32000
			align_text_left
			enable_user_resize

				-- Set the default width to 80 pixels wide
			set_width (80)
			set_is_initialized (True)
		end

	gtk_label_set_ellipsize_symbol: POINTER
			-- Symbol for `gtk_label_set_ellipsize'.
		once
			Result := app_implementation.symbol_from_symbol_name ("gtk_label_set_ellipsize")
		end

	gtk_label_set_ellipsize_call (a_function: POINTER; a_label: POINTER; a_ellipsize_mode: INTEGER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"(FUNCTION_CAST(void, (GtkLabel*, gint)) $a_function)((GtkLabel*) $a_label, (gint) $a_ellipsize_mode);"
		end

	handle_resize
			-- Call the appropriate actions for the header item resize
		local
			a_width: INTEGER
		do
			a_width := tree_view_column_width
			if a_width /= width then
				width := a_width
				if attached parent_imp as l_parent_imp and then (l_parent_imp.call_item_resize_start_actions or else l_parent_imp.item_resize_tuple /= Void) then
						-- Always make sure that the event box is the same size as the header item.
					{GTK2}.gtk_widget_set_minimum_size (box, a_width, -1)
					l_parent_imp.on_resize (attached_interface)
				end
			end
		end

feature -- Access

	width: INTEGER
			-- Width of `Current' in pixels.

	minimum_width: INTEGER
		-- Lower bound on `width' in pixels.

	maximum_width: INTEGER
		-- Upper bound on `width' in pixels.

	user_can_resize: BOOLEAN
		-- Can a user resize `Current'?


	disable_user_resize
			-- Prevent `Current' from being resized by users.
		do
			user_can_resize := False
			{GTK2}.gtk_tree_view_column_set_resizable (c_object, False)
		end

	enable_user_resize
			-- Permit `Current' to be resized by users.
		do
			user_can_resize := True
			{GTK2}.gtk_tree_view_column_set_resizable (c_object, True)
		end

feature -- Status setting

	set_maximum_width (a_width: INTEGER)
			-- Assign `a_maximum_width' in pixels to `maximum_width'.
			-- If `width' is greater than `a_maximum_width', resize.
		do
			maximum_width := a_width
			{GTK2}.gtk_tree_view_column_set_max_width (c_object, a_width)
		end

	set_minimum_width (a_width: INTEGER)
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
		do
			minimum_width := a_width
			{GTK2}.gtk_tree_view_column_set_min_width (c_object, a_width)
		end

	set_width (a_width: INTEGER)
			-- Assign `a_width' to `width'.
		do
			width := a_width
			{GTK2}.gtk_tree_view_column_set_fixed_width (c_object, a_width.max (1))
			{GTK2}.gtk_widget_set_minimum_size (box, a_width, -1)
		end

	resize_to_content
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		local
			a_req_struct: POINTER
			a_width, a_height: INTEGER
		do
			a_req_struct := a_req_struct.memory_alloc ({GTK}.c_gtk_requisition_struct_size)
			{GTK}.gtk_widget_get_preferred_size (box, a_req_struct, default_pointer)
			a_height := {GTK}.gtk_requisition_struct_height (a_req_struct)
			a_width := {GTK}.gtk_requisition_struct_width (a_req_struct)
			set_width (a_width)
			a_req_struct.memory_free
		end

feature -- PND

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
		end

	enable_transport
			-- Enable PND transport
		do
			is_transport_enabled := True
		end

	disable_transport
			-- Disable PND transport
		do
			is_transport_enabled := False
		end

	draw_rubber_band
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band
		do
			check
				do_not_call: False
			end
		end

	enable_capture
		do
			check
				do_not_call: False
			end
		end

	disable_capture
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER; a_press: BOOLEAN;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER; a_menu_only: BOOLEAN)
        	-- Start PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER)
			-- End PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (c: EV_POINTER_STYLE)
			-- Set 'pointer_style' to 'c' (not needed)
		do
			check
				do_not_call: False
			end
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
		end

	height: INTEGER
			-- Height in pixels.
		do
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Event handling

	process_draw_event (a_cairo_context: POINTER): BOOLEAN
			-- <Precursor>
		do
			handle_resize
			Result := False --execute remaining processing (including default)
		end

	process_gdk_event (n_args: INTEGER; args: POINTER)
			-- Process gtk events using raw marshal data.
		local
			gdk_event: POINTER
			event_type: INTEGER
			a_button: POINTER
			l_x: INTEGER
			l_screen_virtual_x, l_screen_virtual_y: INTEGER
			l_motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]
			l_parent_imp: like parent_imp
		do
			a_button := {GTK2}.gtk_tree_view_column_get_button (c_object)

			l_parent_imp := parent_imp
					-- We don't want the button stealing focus.
			{GTK}.gtk_widget_set_can_focus (a_button, False)
			if n_args > 0 then
					-- Store screen virtual coordinates used for normalize gdk event screen coordinates to vision2 screen coordinates.
				l_screen_virtual_x := app_implementation.screen_virtual_x
				l_screen_virtual_y := app_implementation.screen_virtual_y
				gdk_event := {GTK2}.gtk_value_pointer (args)
				if gdk_event /= default_pointer then
					event_type := {GTK}.gdk_event_any_struct_type (gdk_event)
					if event_type = {EV_GTK_ENUMS}.gdk_motion_notify_enum then
						if pointer_motion_actions_internal /= Void then
							l_motion_tuple := app_implementation.motion_tuple
							l_motion_tuple.put_integer ({GTK}.gdk_event_motion_struct_x (gdk_event).truncated_to_integer, 1)
							l_motion_tuple.put_integer ({GTK}.gdk_event_motion_struct_y (gdk_event).truncated_to_integer, 2)
							l_motion_tuple.put_double (0.5, 3)
							l_motion_tuple.put_double (0.5, 4)
							l_motion_tuple.put_double (0.5, 5)
							l_motion_tuple.put_integer ({GTK}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer + l_screen_virtual_x, 6)
							l_motion_tuple.put_integer ({GTK}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer + l_screen_virtual_y, 7)
							pointer_motion_actions_internal.call (
								l_motion_tuple
							)
						end
					elseif
						event_type = {EV_GTK_ENUMS}.gdk_button_press_enum
					then
						if pointer_button_press_actions_internal /= Void then
							pointer_button_press_actions_internal.call ([{GTK}.gdk_event_button_struct_x (gdk_event).truncated_to_integer, {GTK}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {GTK}.gdk_event_button_struct_button (gdk_event), 0.5, 0.5, 0.5, {GTK}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer + l_screen_virtual_x, {GTK}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer + l_screen_virtual_y])
						end
						if l_parent_imp /= Void then
							l_x := {GTK}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer + l_screen_virtual_x - l_parent_imp.screen_x - l_parent_imp.item_x_offset (attached_interface)
							if l_parent_imp.pointer_button_press_actions_internal /= Void then
								l_parent_imp.pointer_button_press_actions.call ([l_x, {GTK}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {GTK}.gdk_event_button_struct_button (gdk_event), 0.5, 0.5, 0.5, {GTK}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer + l_screen_virtual_x, {GTK}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer + l_screen_virtual_y])
							end
							if l_parent_imp.item_pointer_button_press_actions_internal /= Void then
								l_parent_imp.item_pointer_button_press_actions.call ([interface, l_x, {GTK}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {GTK}.gdk_event_button_struct_button (gdk_event)])
							end
						end
					elseif
						event_type = {EV_GTK_ENUMS}.gdk_button_release_enum
					then
						if l_parent_imp /= Void and then l_parent_imp.pointer_button_release_actions_internal /= Void then
							l_x := {GTK}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer + l_screen_virtual_x - l_parent_imp.screen_x - l_parent_imp.item_x_offset (attached_interface)
							l_parent_imp.pointer_button_release_actions.call ([l_x, {GTK}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {GTK}.gdk_event_button_struct_button (gdk_event), 0.5, 0.5, 0.5, {GTK}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer + l_screen_virtual_x, {GTK}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer + l_screen_virtual_y])
						end
					elseif
						event_type = {EV_GTK_ENUMS}.gdk_2button_press_enum
					then
						if pointer_double_press_actions_internal /= Void then
							pointer_double_press_actions_internal.call ([{GTK}.gdk_event_button_struct_x (gdk_event).truncated_to_integer, {GTK}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {GTK}.gdk_event_button_struct_button (gdk_event), 0.5, 0.5, 0.5, {GTK}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer + l_screen_virtual_x, {GTK}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer + l_screen_virtual_y])
						end
						if l_parent_imp /= Void then
							l_x := {GTK}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer + l_screen_virtual_x - l_parent_imp.screen_x - l_parent_imp.item_x_offset (attached_interface)
							if l_parent_imp.pointer_double_press_actions_internal /= Void then
								l_parent_imp.pointer_double_press_actions.call ([l_x, {GTK}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {GTK}.gdk_event_button_struct_button (gdk_event), 0.5, 0.5, 0.5, {GTK}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer + l_screen_virtual_x, {GTK}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer + l_screen_virtual_y])
							end
							if l_parent_imp.item_pointer_double_press_actions_internal /= Void then
								l_parent_imp.item_pointer_double_press_actions.call ([attached_interface, l_x, {GTK}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {GTK}.gdk_event_button_struct_button (gdk_event)])
							end
						end
					elseif
						event_type = {EV_GTK_ENUMS}.gdk_expose_enum
					 then
								-- Handle any potential resize.
						handle_resize
					end
				end
			end
		end

feature {EV_HEADER_IMP} -- Implementation

	set_parent_imp (par_imp: like parent_imp)
			-- Set `parent_imp' to `par_imp'.
		local
			a_button: POINTER
			l_app_imp: EV_APPLICATION_IMP
		do
			parent_imp := par_imp

			if par_imp /= Void then
					-- If this is the first time it is parented then there is no need to set the column widget.
				if {GTK}.gtk_widget_get_parent (box) = default_pointer then
					{GTK2}.gtk_tree_view_column_set_widget (c_object, box)
				end
					-- The button gets recreated everytime it is parented so the events need to be hooked up to the new button.
				a_button := {GTK2}.gtk_tree_view_column_get_button (c_object)
					-- We don't want the button stealing focus.
				{GTK}.gtk_widget_set_can_focus (a_button, False)

				l_app_imp := app_implementation

				real_signal_connect (
						a_button,
						once "event",
						agent (l_app_imp.gtk_marshal).gdk_event_dispatcher (internal_id, ? , ?),
						Void
					)
				item_event_connection := last_signal_connection

					-- Hook up to "draw" signal so that we can check if we need to resize `Current'.
				real_signal_connect (
						a_button,
						{EV_GTK_EVENT_STRINGS}.draw_event_name,
						agent (l_app_imp.gtk_marshal).draw_actions_intermediary (c_object, ?),
						l_app_imp.gtk_marshal.draw_translate_agent
					)
				item_draw_event_connection := last_signal_connection
			else
				if attached item_event_connection as conn then
					a_button := {GTK2}.gtk_tree_view_column_get_button (c_object)

					conn.close
					item_event_connection := Void
				end
				if attached item_draw_event_connection as conn then
						-- Disconnect draw signal .
					conn.close
					item_draw_event_connection := Void
				end
				{GTK2}.gtk_tree_view_column_set_widget (c_object, {GTK}.gtk_label_new (default_pointer))
			end
		end

	item_event_connection: detachable GTK_SIGNAL_MARSHAL_CONNECTION
			-- Item event id of `Current`

	item_draw_event_connection: detachable GTK_SIGNAL_MARSHAL_CONNECTION
			-- Draw event signal connection if `Current`

	parent_imp: detachable EV_HEADER_IMP
		-- Parent of `Current'

feature {NONE} -- Implementation

	tree_view_column_width: INTEGER
			-- `Result' is width of `Current' used
			-- while parented.
		do
			Result := {GTK2}.gtk_tree_view_column_get_width (c_object)
		end

	box: POINTER
		-- Box to hold column text and pixmap.

feature {NONE} -- Redundant implementation

	real_pointed_target: detachable EV_PICK_AND_DROPABLE
		do
			check do_not_call: False end
		end

feature {NONE} -- Implementation

	destroy
			-- Destroy `c_object'.
		do
			if not box.is_default_pointer then
				{GDK}.g_object_unref (box)
				box := default_pointer
			end
			if not c_object.is_default_pointer then
				{GTK2}.g_object_unref (c_object)
				c_object := default_pointer
			end
			set_is_destroyed (True)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_HEADER_ITEM note option: stable attribute end;
		-- Interface object of `Current'.

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
