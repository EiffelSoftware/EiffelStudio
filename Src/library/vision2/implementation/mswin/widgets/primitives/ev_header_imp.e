indexing
	description: "Objects that represent an EiffelVision header control. Mswin Implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_IMP

inherit
	EV_HEADER_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_HEADER_ITEM, EV_HEADER_ITEM_IMP]
		redefine
			interface,
			initialize
		end

	EV_PRIMITIVE_IMP
		undefine
			escape_pnd, pnd_press, on_right_button_double_click, on_middle_button_double_click,
			on_left_button_double_click, on_left_button_up,
			on_right_button_down, on_left_button_down, on_middle_button_down
		redefine
			interface,
			initialize,
			destroy,
			on_mouse_move,
			on_set_cursor
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			initialize
		end

	WEL_HEADER_CONTROL
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			set_text as wel_set_text,
			font as wel_font,
			set_font as wel_set_font,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_mouse_wheel,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			on_size,
			show,
			hide,
			x_position,
			y_position,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message,
			on_getdlgcode
		redefine
			on_hdn_begin_track,
			on_hdn_track,
			on_hdn_end_track,
			on_hdn_item_changed,
			on_hdn_item_changing
		end

	EV_HEADER_ACTION_SEQUENCES_IMP
		export
			{NONE} all
		end

	EV_SHARED_IMAGE_LIST_IMP
		export
			{NONE} all
		end

	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
		export
			{NONE} all
		redefine
			interface
		end

	WEL_HHT_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, 0, 0, 0, 0, 0)
			create ev_children.make (2)
			initialize_pixmaps
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_ITEM_LIST_IMP}
			set_default_font
		end

feature -- Status report

	ev_children: ARRAYED_LIST [EV_HEADER_ITEM_IMP]
			-- List of the children.

feature -- Status setting

	refresh_item (item_imp: EV_HEADER_ITEM_IMP) is
			-- Refresh `item_imp'.
		require
			item_not_void: item_imp /= Void
		do
				-- Note that one is subtracted as the wel index is zero based.
			set_header_item (ev_children.index_of (item_imp, 1) - 1, item_imp)
		end

feature -- Element change

	insert_item (item_imp: EV_HEADER_ITEM_IMP; an_index: INTEGER) is
			-- Insert `item_imp' at `an_index'.
		do
			insert_header_item (item_imp, an_index - 1)
			item_imp.set_pixmap_in_parent
		end

feature -- Removal

	remove_item (item_imp: EV_HEADER_ITEM_IMP) is
			-- Remove `item' from the list
		local
			an_index: INTEGER
		do
			an_index := ev_children.index_of (item_imp, 1) - 1
			delete_header_item (an_index)
		end

feature -- Miscellaneous

	find_item_at_position (x_pos, y_pos: INTEGER): EV_HEADER_ITEM_IMP is
			-- `Result' is list item at pixel position `x_pos', `y_pos'.
		local
			hd_hit_test_info: WEL_HD_HIT_TEST_INFO
		do
			hd_hit_test_info := item_info_from_point (create {WEL_POINT}.make (x_pos, y_pos))
			if hd_hit_test_info /= Void and hd_hit_test_info.index /= - 1 then
				Result := ev_children @ (hd_hit_test_info.index + 1)
			end
		end

feature {EV_ANY_I}

	interface: EV_HEADER

feature {EV_HEADER_ITEM_IMP} -- Implementation

	image_list: EV_IMAGE_LIST_IMP
		-- Image list associated with `Current'.
		-- `Void' if none.

	setup_image_list is
			-- Create the image list and associate it
			-- to `Current' if not already associated.
		do
			image_list := get_imagelist_with_size (pixmaps_width, pixmaps_height)
			set_image_list (image_list)
		ensure then
			image_list_not_void: image_list /= Void
		end

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		local
			l_cursor: CURSOR
			l_item: EV_HEADER_ITEM_IMP
		do
			if image_list /= Void then
				set_image_list (Void)
				image_list := Void
			end
			l_cursor := ev_children.cursor
			from
				ev_children.start
			until
				ev_children.off
			loop
				l_item := ev_children.item
				l_item.set_pixmap_in_parent
				ev_children.forth
			end
			ev_children.go_to (l_cursor)
		end

	resize_item_to_content (header_item: EV_HEADER_ITEM_IMP) is
			-- Resize `header_item' width to fully display both `pixmap' and `text'.
		require
			header_item_not_void: header_item /= Void
			header_item_parented_in_current: header_item.parent_imp = Current
		local
			desired_width: INTEGER
			l_text: STRING_32
			font_imp: EV_FONT_IMP
			margin: INTEGER
		do
			margin := cwin_send_message_result_integer (wel_item, hdm_get_bitmap_margin, cwel_integer_to_pointer (0), cwel_integer_to_pointer (0))
			l_text := header_item.text
			if not l_text.is_empty then
				if private_font /= Void then
					font_imp ?= private_font.implementation
					check
						font_not_void: font_imp /= Void
					end
					desired_width := font_imp.string_width (l_text)
				else
					desired_width := private_wel_font.string_width (l_text)
				end
			end

			if header_item.pixmap_imp /= Void then
				if l_text.is_empty then
					desired_width := desired_width + pixmaps_width
				else
					desired_width := desired_width + pixmaps_width + margin * 2
				end
			end
			desired_width := desired_width + 18
				-- Restrict `desired_width' to dimensions permitted by `resize_item_to_content'.
			desired_width := desired_width.min (header_item.maximum_width)
			desired_width := desired_width.max (header_item.minimum_width)

			header_item.set_width (desired_width)
		end

	pointed_divider_index: INTEGER is
			-- Index of divider currently beneath the mouse pointer, or
			-- 0 if none.
		local
			hit_test_info: WEL_HD_HIT_TEST_INFO
			wel_point: WEL_POINT
		do
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			wel_point.set_x (wel_point.x - absolute_x - 1)
			wel_point.set_y (wel_point.y - absolute_y - 1)
			hit_test_info := item_info_from_point (wel_point)
			if flag_set (hit_test_info.flags, Hht_on_divider) or flag_set (hit_test_info.flags, hht_on_div_open) then
				Result := hit_test_info.index + 1
			else
				Result := 0
			end
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy `Current'.
		do
			interface.wipe_out
			Precursor {EV_PRIMITIVE_IMP}
		end

	on_hdn_begin_track (info: WEL_HD_NOTIFY) is
			-- The user has begun dragging a divider in the control
			-- (that is, the user has pressed the left mouse button while
			-- the mouse cursor is on a divider in the header control).
		local
			header_item: EV_HEADER_ITEM_IMP
		do
			header_item := ev_children @ (info.item_index + 1)
			if item_resize_start_actions_internal /= Void then
				item_resize_start_actions_internal.call ([header_item.interface])
			end
			if not header_item.user_can_resize then
					-- Prevent the item from resizing if not `user_can_resize'.
				set_message_return_value (to_lresult (1))
			end
		end

	on_hdn_track (info: WEL_HD_NOTIFY) is
			-- The user is dragging a divider in the header control.
		local
			header_item: EV_HEADER_ITEM_IMP
			desired_width: INTEGER
		do
			header_item := ev_children.i_th (info.item_index + 1)
			if flag_set (hdi_width, info.header_item.mask) then
				desired_width := info.header_item.width
				desired_width := desired_width.min (header_item.maximum_width).max (header_item.minimum_width)
				if header_item.width /= desired_width then
					header_item.set_width (desired_width)
				end
			end
			if item_resize_actions_internal /= Void then
				header_item := ev_children @ (info.item_index + 1)
				item_resize_actions_internal.call ([header_item.interface])
			end
		end

	on_hdn_end_track (info: WEL_HD_NOTIFY) is
			-- The user has finished dragging a divider.
		local
			header_item: EV_HEADER_ITEM_IMP
		do
			if item_resize_end_actions_internal /= Void then
				header_item := ev_children @ (info.item_index + 1)
				item_resize_end_actions_internal.call ([header_item.interface])
			end
		end

	on_hdn_item_changing (info: WEL_HD_NOTIFY) is
			-- The attributes of a header are changing.
			-- (from WEL_HEADER_CONTROL)
		local
			header_item: EV_HEADER_ITEM_IMP
			desired_width: INTEGER
		do
			header_item := ev_children @ (info.item_index + 1)
			desired_width := info.header_item.width
			if desired_width < header_item.minimum_width or desired_width > header_item.maximum_width then
				set_message_return_value (to_lresult (1))
			end
		end

	on_hdn_item_changed (info: WEL_HD_NOTIFY) is
			-- The attributes of a header item have changed.
			-- (from WEL_HEADER_CONTROL)
		do
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate
			-- item event. Called on a pointer button press.
		local
			pre_drop_it, post_drop_it: EV_HEADER_ITEM_IMP
			item_press_actions_called: BOOLEAN
			pt: WEL_POINT
		do
			if pointed_divider_index = 0 then
					-- Clicking on the divider should not register as an item button click.
				pre_drop_it := find_item_at_position (x_pos, y_pos)
			end
			pt := client_to_screen (x_pos, y_pos)
			if pre_drop_it /= Void and not transport_executing
				and not item_is_in_pnd then
				if pre_drop_it.pointer_button_press_actions_internal
					/= Void then
					pre_drop_it.pointer_button_press_actions_internal.call (
						[x_pos - item_x_offset (pre_drop_it.interface) , y_pos, button, 0.0,
						0.0, 0.0, pt.x, pt.y])
				end
				if item_pointer_button_press_actions_internal /= Void then
					item_pointer_button_press_actions_internal.call (
						[pre_drop_it.interface,
						x_pos - item_x_offset (pre_drop_it.interface),
						y_pos, button]
					)
				end

					-- We record that the press actions have been called.
				item_press_actions_called := True
			end
				--| The pre_drop_it.parent /= Void is to check that the item that
				--| was originally clicked on, has not been removed during the press actions.
				--| If the parent is now void then it has, and there is no need to continue
				--| with `pnd_press'.
			if pre_drop_it /= Void and pre_drop_it.is_transport_enabled and
				not parent_is_pnd_source and pre_drop_it.parent /= Void then
				pre_drop_it.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
			elseif pnd_item_source /= Void then
				pnd_item_source.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
			end

			if item_is_pnd_source_at_entry = item_is_pnd_source then
				pnd_press (x_pos, y_pos, button, pt.x, pt.y)
			end

			if not press_actions_called and call_press_event then
				interface.pointer_button_press_actions.call
					([x_pos, y_pos, button, 0.0, 0.0, 0.0, pt.x, pt.y])
			end

			post_drop_it := find_item_at_position (x_pos, y_pos)

				-- If the press actions have not already been called then
				-- call them. If `press_actions_called' = False then it means
				-- we were in a pick and drop when entering this procedure, so
				-- we now call them after the PND has completed.
			if not item_press_actions_called then

					-- If there is an item where the button press was recieved,
					-- and it has not changed from the start of this procedure
					-- then call `pointer_button_press_actions'.
					--| Internal_propagate_pointer_press in
					--| EV_MULTI_COLUMN_LIST_IMP has a complete explanation.
				if post_drop_it /= Void and pre_drop_it = post_drop_it and call_press_event then
					if post_drop_it.pointer_button_press_actions_internal
						/= Void then
						post_drop_it.pointer_button_press_actions_internal.call(
							[x_pos - item_x_offset (post_drop_it.interface), y_pos, button, 0.0,
							0.0, 0.0, pt.x, pt.y])
					end
					if item_pointer_button_press_actions_internal /= Void then
						item_pointer_button_press_actions_internal.call (
							[pre_drop_it.interface,
							x_pos - item_x_offset (pre_drop_it.interface),
							y_pos, button]
						)
					end
				end
			end
				-- Reset `call_press_event'.
			keep_press_event
		end

	internal_propagate_pointer_double_press
		(keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate
			-- item event. Called on a pointer button double press.
		local
			it: EV_HEADER_ITEM_IMP
			pt: WEL_POINT
		do
			if pointed_divider_index = 0 then
					-- Clicking on the divider should not register as an item button click.
				it := find_item_at_position (x_pos, y_pos)
			end
			if it /= Void then
				pt := client_to_screen (x_pos, y_pos)
				if it.pointer_double_press_actions_internal /= Void then
					it.pointer_double_press_actions_internal.call
						([x_pos- item_x_offset (it.interface), y_pos, button, 0.0, 0.0, 0.0, pt.x, pt.y])
				end
				if item_pointer_double_press_actions_internal /= Void then
					item_pointer_double_press_actions_internal.call (
						[it.interface,
						x_pos - item_x_offset (it.interface),
						y_pos, button]
					)
				end
			end
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
		local
			it: EV_HEADER_ITEM_IMP
			pt: WEL_POINT
		do
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void then
				if it.pointer_motion_actions_internal /= Void then
					it.pointer_motion_actions_internal.call ([x_pos - item_x_offset (it.interface), y_pos, 0.0, 0.0, 0.0, pt.x, pt.y])
				end
			end
			if pnd_item_source /= Void then
				pnd_item_source.pnd_motion (x_pos, y_pos, pt.x, pt.y)
			end
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	on_set_cursor (hit_code: INTEGER) is
			-- Called when a `Wm_setcursor' message is received.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		local
			l_pointed_divider_index: INTEGER
		do
			l_pointed_divider_index := pointed_divider_index
			if l_pointed_divider_index > 1 and then not (ev_children @ l_pointed_divider_index).user_can_resize then
				disable_default_processing
			end
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




end -- class EV_HEADER_IMP

