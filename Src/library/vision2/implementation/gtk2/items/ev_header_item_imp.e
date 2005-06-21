indexing
	description: "Objects that ..."
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
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
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
			real_signal_connect (c_object, once "notify::width", agent handle_resize, Void)
			
			pixmapable_imp_initialize
			textable_imp_initialize

			box := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			{EV_GTK_EXTERNALS}.gtk_widget_show (box)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (box, pixmap_box, False, False, 0)
			{EV_GTK_EXTERNALS}.gtk_box_pack_end (box, text_label, True, True, 0)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_widget (c_object, box)

				-- Set the default width to 80 pixels wide
			set_width (80)
			align_text_left
			set_is_initialized (True)
		end

	handle_resize is
			-- Call the appropriate actions for the header item resize
		local
			a_width: INTEGER
		do
			a_width := width_internal
					-- Always make sure that the event box is the same size as the header item.
			{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (box, a_width, -1)
			if a_width /= width then
				width := a_width
				if parent_imp /= Void then
					parent_imp.on_resize (interface)
				end
			end
		end

feature -- Access

	width: INTEGER
		-- Width of `Current' in pixels.

feature -- Status setting

	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		do
			width := a_width
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_fixed_width (c_object, a_width.max (1))
			{EV_GTK_EXTERNALS}.gtk_widget_set_minimum_size (box, a_width, 16)
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

	process_event (n_args: INTEGER; args: POINTER) is
			-- Process gtk events using raw marshal data.
		local
			gdk_event: POINTER
			event_type: INTEGER
			a_button: POINTER
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
							pointer_motion_actions_internal.call (
								app_implementation.gtk_marshal.motion_tuple (
									{EV_GTK_EXTERNALS}.gdk_event_motion_struct_x (gdk_event).truncated_to_integer,
									{EV_GTK_EXTERNALS}.gdk_event_motion_struct_y (gdk_event).truncated_to_integer,
									0.5,
									0.5,
									0.5,
									{EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer,
									{EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer
									)
							)
						end	
					elseif
						event_type = {EV_GTK_ENUMS}.gdk_button_press_enum
					then
						if pointer_button_press_actions_internal /= Void then
							pointer_button_press_actions_internal.call ([{EV_GTK_EXTERNALS}.gdk_event_button_struct_x (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_button (gdk_event), 0.5, 0.5, 0.5, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer])	
						end
					elseif
						event_type = {EV_GTK_ENUMS}.gdk_2button_press_enum
					then
						if pointer_double_press_actions_internal /= Void then
							pointer_double_press_actions_internal.call ([{EV_GTK_EXTERNALS}.gdk_event_button_struct_x (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_y (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_button_struct_button (gdk_event), 0.5, 0.5, 0.5, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_x_root (gdk_event).truncated_to_integer, {EV_GTK_EXTERNALS}.gdk_event_motion_struct_y_root (gdk_event).truncated_to_integer])	
						end
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
				real_signal_connect (a_button, once "event", agent (App_implementation.gtk_marshal).header_item_event_dispatcher (internal_id, ? , ?), Void)
			else
				{EV_GTK_EXTERNALS}.object_ref (box)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_widget (c_object, {EV_GTK_EXTERNALS}.gtk_label_new (default_pointer))
			end
		end

	parent_imp: EV_HEADER_IMP
		-- Parent of `Current'

feature {NONE} -- Implementation

	width_internal: INTEGER is
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

	interface: EV_HEADER_ITEM


end
