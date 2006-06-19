indexing
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

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_TEXTABLE_IMP
		redefine
			interface,
			process_gdk_event
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface,
			process_gdk_event
		end

create
	make

feature -- Initialization

	needs_event_box: BOOLEAN is False

	make (an_interface: like interface) is
			-- Create the tree item.
		do
			base_make (an_interface)
			set_c_object  ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_new)
		end

	initialize is
			-- Initialize the header item.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_resizable (c_object, True)

				-- Allow the column to be shrank to nothing
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_min_width (c_object, 0)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_sizing (c_object, {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_fixed_enum)
			{EV_GTK_EXTERNALS}.gtk_tree_view_column_set_clickable (c_object, True)

			pixmapable_imp_initialize
			textable_imp_initialize

			box := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			{EV_GTK_EXTERNALS}.gtk_widget_show (box)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (box, pixmap_box, False, False, 0)
			{EV_GTK_EXTERNALS}.gtk_box_pack_end (box, text_label, True, True, 0)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_widget (c_object, box)

			set_minimum_width (0)
			set_maximum_width (32000)

			align_text_left
			enable_user_resize

				-- Set the default width to 80 pixels wide
			set_width (80)
			set_is_initialized (True)
		end

	handle_resize is
			-- Call the appropriate actions for the header item resize
		local
			a_width: INTEGER
		do
			a_width := tree_view_column_width
			if a_width /= width then
				width := a_width
				if parent_imp.call_item_resize_start_actions or else parent_imp.item_resize_tuple /= Void then
						-- Always make sure that the event box is the same size as the header item.
					{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (box, a_width, default_box_height)
					parent_imp.on_resize (interface)
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


	disable_user_resize is
			-- Prevent `Current' from being resized by users.
		do
			user_can_resize := False
			{EV_GTK_EXTERNALS}.gtk_tree_view_column_set_resizable (c_object, False)
		end

	enable_user_resize is
			-- Permit `Current' to be resized by users.
		do
			user_can_resize := True
			{EV_GTK_EXTERNALS}.gtk_tree_view_column_set_resizable (c_object, True)
		end

feature -- Status setting

	set_maximum_width (a_width: INTEGER) is
			-- Assign `a_maximum_width' in pixels to `maximum_width'.
			-- If `width' is greater than `a_maximum_width', resize.
		do
			maximum_width := a_width
			{EV_GTK_EXTERNALS}.gtk_tree_view_column_set_max_width (c_object, a_width)
		end

	set_minimum_width (a_width: INTEGER) is
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
		do
			minimum_width := a_width
			{EV_GTK_EXTERNALS}.gtk_tree_view_column_set_min_width (c_object, a_width)
		end

	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		do
			width := a_width
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_fixed_width (c_object, a_width.max (1))
			{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (box, a_width, default_box_height)
		end

	resize_to_content is
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		local
			a_req_struct: POINTER
			a_width, a_height: INTEGER
		do
			{EV_GTK_EXTERNALS}.gtk_widget_size_request (box, default_pointer)
			a_req_struct := {EV_GTK_EXTERNALS}.gtk_widget_struct_requisition (box)
			a_height := {EV_GTK_EXTERNALS}.gtk_requisition_struct_height (a_req_struct)
			a_width := {EV_GTK_EXTERNALS}.gtk_requisition_struct_width (a_req_struct)
			set_width (a_width)
		end

feature -- PND

	enable_transport is
			-- Enable PND transport
		do
			is_transport_enabled := True
		end

	disable_transport is
			-- Disable PND transport
		do
			is_transport_enabled := False
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

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Event handling

	process_gdk_event (n_args: INTEGER; args: POINTER) is
			-- Process gtk events using raw marshal data.
		local
			gdk_event: POINTER
			event_type: INTEGER
			a_button: POINTER
			l_x: INTEGER
			l_motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]
		do
			a_button := {EV_GTK_EXTERNALS}.gtk_tree_view_column_struct_button (c_object)
					-- We don't want the button stealing focus.
			{EV_GTK_EXTERNALS}.gtk_widget_unset_flags (a_button, {EV_GTK_EXTERNALS}.gtk_can_focus_enum)
			if n_args > 0 then
				gdk_event := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (args)
				if gdk_event /= NULL then
					event_type := {EV_GTK_EXTERNALS}.gdk_event_any_struct_type (gdk_event)
					if event_type = {EV_GTK_ENUMS}.gdk_motion_notify_enum then
						if pointer_motion_actions_internal /= Void then
							l_motion_tuple := app_implementation.motion_tuple
							l_motion_tuple.put_integer ({EV_GTK_EXTERNALS}.gdk_event_motion_struct_x (gdk_event).truncated_to_integer, 1)
							l_motion_tuple.put_integer ({EV_GTK_EXTERNALS}.gdk_event_motion_struct_y (gdk_event).truncated_to_integer, 2)
							l_motion_tuple.put_double (0.5, 3)
							l_motion_tuple.put_double (0.5, 4)
							l_motion_tuple.put_double (0.5, 5)
							l_motion_tuple.put_integer ({EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer, 6)
							l_motion_tuple.put_integer ({EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer, 7)
							pointer_motion_actions_internal.call (
								l_motion_tuple
							)
						end
					elseif
						event_type = {EV_GTK_ENUMS}.gdk_button_press_enum
					then
						if pointer_button_press_actions_internal /= Void then
							pointer_button_press_actions_internal.call ([{EV_GTK_EXTERNALS}.gdk_event_button_struct_x (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_button (gdk_event), 0.5, 0.5, 0.5, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer])
						end
						if parent_imp /= Void then
							l_x := {EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer - parent_imp.screen_x - parent_imp.item_x_offset (interface)
							if parent_imp.pointer_button_press_actions_internal /= Void then
								parent_imp.pointer_button_press_actions_internal.call ([l_x, {EV_GTK_EXTERNALS}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_button (gdk_event), 0.5, 0.5, 0.5, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer])
							end
							if parent_imp.item_pointer_button_press_actions_internal /= Void then
								parent_imp.item_pointer_button_press_actions_internal.call ([interface, l_x, {EV_GTK_EXTERNALS}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_button (gdk_event)])
							end
						end
					elseif
						event_type = {EV_GTK_ENUMS}.gdk_button_release_enum
					then
						if parent_imp /= Void and then parent_imp.pointer_button_release_actions_internal /= Void then
							l_x := {EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer - parent_imp.screen_x - parent_imp.item_x_offset (interface)
							parent_imp.pointer_button_release_actions_internal.call ([l_x, {EV_GTK_EXTERNALS}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_button (gdk_event), 0.5, 0.5, 0.5, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer])
						end
					elseif
						event_type = {EV_GTK_ENUMS}.gdk_2button_press_enum
					then
						if pointer_double_press_actions_internal /= Void then
							pointer_double_press_actions_internal.call ([{EV_GTK_EXTERNALS}.gdk_event_button_struct_x (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_button (gdk_event), 0.5, 0.5, 0.5, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer])
						end
						if parent_imp /= Void then
							l_x := {EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer - parent_imp.screen_x - parent_imp.item_x_offset (interface)
							if parent_imp.pointer_double_press_actions_internal /= Void then
								parent_imp.pointer_double_press_actions_internal.call ([l_x, {EV_GTK_EXTERNALS}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_button (gdk_event), 0.5, 0.5, 0.5, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer])
							end
							if parent_imp.item_pointer_double_press_actions_internal /= Void then
								parent_imp.item_pointer_double_press_actions_internal.call ([interface, l_x, {EV_GTK_EXTERNALS}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_button (gdk_event)])
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

	set_parent_imp (par_imp: like parent_imp) is
			-- Set `parent_imp' to `par_imp'.
		local
			a_button: POINTER
		do
			parent_imp := par_imp

			if par_imp /= Void then
					-- If this is the first time it is parented then there is no need to set the column widget.
				if {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (box) = default_pointer then
					{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_widget (c_object, box)
				end
					-- The button gets recreated everytime it is parented so the events need to be hooked up to the new button.
				a_button := {EV_GTK_EXTERNALS}.gtk_tree_view_column_struct_button (c_object)
					-- We don't want the button stealing focus.
				{EV_GTK_EXTERNALS}.gtk_widget_unset_flags (a_button, {EV_GTK_EXTERNALS}.gtk_can_focus_enum)
				real_signal_connect (a_button, once "event", agent (App_implementation.gtk_marshal).gdk_event_dispatcher (internal_id, ? , ?), Void)
				item_event_id := last_signal_connection_id
			else
				if item_event_id /= 0 then
					a_button := {EV_GTK_EXTERNALS}.gtk_tree_view_column_struct_button (c_object)
					{EV_GTK_EXTERNALS}.signal_disconnect (a_button, item_event_id)
					item_event_id := 0
				end
				{EV_GTK_EXTERNALS}.object_ref (box)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_widget (c_object, {EV_GTK_EXTERNALS}.gtk_label_new (default_pointer))
			end
		end

	item_event_id: INTEGER
		-- Item event id of `Current'

	parent_imp: EV_HEADER_IMP
		-- Parent of `Current'

feature {NONE} -- Implementation

	default_box_height: INTEGER is
			-- Default height of the box.
		once
			Result := (create {EV_LABEL}).minimum_height + 3
		end

	tree_view_column_width: INTEGER is
			-- `Result' is width of `Current' used
			-- while parented.
		do
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_get_width (c_object)
		end

	box: POINTER
		-- Box to hold column text and pixmap.

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
		do
			create Result
			interface.init_drop_actions (Result)
		end

feature {NONE} -- Redundant implementation

	real_pointed_target: EV_PICK_AND_DROPABLE is
		do
			check do_not_call: False end
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy `c_object'.
		do
			{EV_GTK_EXTERNALS}.object_unref (c_object)
			c_object := default_pointer
			set_is_destroyed (True)
		end

	interface: EV_HEADER_ITEM;
		-- Interface object of `Current'.

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
