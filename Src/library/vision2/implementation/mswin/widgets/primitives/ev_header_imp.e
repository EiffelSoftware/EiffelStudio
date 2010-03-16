note
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
			make
		end

	EV_PRIMITIVE_IMP
		undefine
			escape_pnd, pnd_press, on_right_button_double_click, on_middle_button_double_click,
			on_left_button_double_click, on_left_button_up,
			on_right_button_down, on_left_button_down, on_middle_button_down
		redefine
			interface,
			make,
			destroy,
			on_mouse_move,
			on_set_cursor
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			make
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
			on_getdlgcode,
			on_wm_dropfiles
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

feature -- Initialization

	old_make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			wel_make (default_parent, 0, 0, 0, 0, 0)
			create ev_children.make (2)
			initialize_pixmaps
			Precursor {EV_ITEM_LIST_IMP}
			set_default_font
			disable_tabable_from
			disable_tabable_to
			Precursor {EV_PRIMITIVE_IMP}
		end

feature -- Status report

	ev_children: ARRAYED_LIST [EV_HEADER_ITEM_IMP]
			-- List of the children.

feature -- Status setting

	refresh_item (item_imp: EV_HEADER_ITEM_IMP)
			-- Refresh `item_imp'.
		require
			item_not_void: item_imp /= Void
		do
				-- Note that one is subtracted as the wel index is zero based.
			set_header_item (ev_children.index_of (item_imp, 1) - 1, item_imp)
		end

feature -- Element change

	insert_item (item_imp: EV_HEADER_ITEM_IMP; an_index: INTEGER)
			-- Insert `item_imp' at `an_index'.
		do
			insert_header_item (item_imp, an_index - 1)
			item_imp.set_pixmap_in_parent
		end

feature -- Removal

	remove_item (item_imp: EV_HEADER_ITEM_IMP)
			-- Remove `item' from the list
		local
			an_index: INTEGER
		do
			an_index := ev_children.index_of (item_imp, 1) - 1
			delete_header_item (an_index)
		end

feature -- Miscellaneous

	find_item_at_position (x_pos, y_pos: INTEGER): detachable EV_HEADER_ITEM_IMP
			-- `Result' is list item at pixel position `x_pos', `y_pos'.
		local
			hd_hit_test_info: WEL_HD_HIT_TEST_INFO
		do
			hd_hit_test_info := item_info_from_point (create {WEL_POINT}.make (x_pos, y_pos))
			if hd_hit_test_info /= Void and hd_hit_test_info.index /= - 1 then
				Result := ev_children @ (hd_hit_test_info.index + 1)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_HEADER note option: stable attribute end

feature {EV_HEADER_ITEM_IMP} -- Implementation

	image_list: detachable EV_IMAGE_LIST_IMP
		-- Image list associated with `Current'.
		-- `Void' if none.

	setup_image_list
			-- Create the image list and associate it
			-- to `Current' if not already associated.
		do
			image_list := get_imagelist_with_size (pixmaps_width, pixmaps_height)
			set_image_list (image_list)
		ensure then
			image_list_not_void: image_list /= Void
		end

	pixmaps_size_changed
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

	resize_item_to_content (header_item: EV_HEADER_ITEM_IMP)
			-- Resize `header_item' width to fully display both `pixmap' and `text'.
		require
			header_item_not_void: header_item /= Void
			header_item_parented_in_current: header_item.parent_imp = Current
		local
			desired_width: INTEGER
			l_text: STRING_32
			font_imp: detachable EV_FONT_IMP
			margin: INTEGER
		do
			margin := {WEL_API}.send_message_result_integer (wel_item, hdm_get_bitmap_margin, cwel_integer_to_pointer (0), cwel_integer_to_pointer (0))
			l_text := header_item.text
			if not l_text.is_empty then
				if attached private_font as l_private_font then
					font_imp ?= l_private_font.implementation
					check
						font_not_void: font_imp /= Void
					end
					desired_width := font_imp.string_width (l_text)
				elseif attached private_wel_font as l_private_wel_font then
					desired_width := l_private_wel_font.string_width (l_text)
				else
					check False end
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

	pointed_divider_index: INTEGER
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

	destroy
			-- Destroy `Current'.
		do
			attached_interface.wipe_out
			Precursor {EV_PRIMITIVE_IMP}
		end

	on_hdn_begin_track (info: WEL_HD_NOTIFY)
			-- The user has begun dragging a divider in the control
			-- (that is, the user has pressed the left mouse button while
			-- the mouse cursor is on a divider in the header control).
		local
			header_item: EV_HEADER_ITEM_IMP
		do
			header_item := ev_children @ (info.item_index + 1)
			if item_resize_start_actions_internal /= Void then
				item_resize_start_actions_internal.call ([header_item.attached_interface])
			end
			if not header_item.user_can_resize then
					-- Prevent the item from resizing if not `user_can_resize'.
				set_message_return_value (to_lresult (1))
			end
		end

	on_hdn_track (info: WEL_HD_NOTIFY)
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
				item_resize_actions_internal.call ([header_item.attached_interface])
			end
		end

	on_hdn_end_track (info: WEL_HD_NOTIFY)
			-- The user has finished dragging a divider.
		local
			header_item: EV_HEADER_ITEM_IMP
		do
			if item_resize_end_actions_internal /= Void then
				header_item := ev_children @ (info.item_index + 1)
				item_resize_end_actions_internal.call ([header_item.attached_interface])
			end
		end

	on_hdn_item_changing (info: WEL_HD_NOTIFY)
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

	on_hdn_item_changed (info: WEL_HD_NOTIFY)
			-- The attributes of a header item have changed.
			-- (from WEL_HEADER_CONTROL)
		do
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER)
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate
			-- item event. Called on a pointer button press.
		local
			pt: WEL_POINT
			l_pointed_divider_index: INTEGER
			l_item_imp: detachable EV_HEADER_ITEM_IMP
			l_item: detachable EV_HEADER_ITEM
			l_x_offset: INTEGER
		do
			pt := client_to_screen (x_pos, y_pos)
			l_pointed_divider_index := pointed_divider_index
			l_x_offset := x_pos
			l_item_imp := find_item_at_position (x_pos, y_pos)
			if transport_executing then
				if l_item_imp /= Void and then l_item_imp.is_transport_enabled and then
					not parent_is_pnd_source and then l_item_imp.parent /= Void
				then
					l_item_imp.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
					if l_item_imp.motion_action = ev_pnd_execute then
						disable_default_processing
					end
				elseif attached pnd_item_source as l_pnd_item_source then
					l_pnd_item_source.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
				end
				if item_is_pnd_source_at_entry = item_is_pnd_source then
					pnd_press (x_pos, y_pos, button, pt.x, pt.y)
				end
			else
				if l_pointed_divider_index = 0 then
						-- Clicking on the divider should not register as an item button click.
					if l_item_imp /= Void then
						l_item := l_item_imp.attached_interface
						l_x_offset := l_x_offset - item_x_offset (l_item)
						if l_item_imp.pointer_button_press_actions_internal /= Void then
							l_item_imp.pointer_button_press_actions.call (
								[l_x_offset, y_pos, button, 0.0, 0.0, 0.0, pt.x, pt.y])
						end
					end
					if item_pointer_button_press_actions_internal /= Void then
						item_pointer_button_press_actions_internal.call (
							[l_item, l_x_offset, y_pos, button]
						)
					end
				end
				if not press_actions_called and call_press_event then
					attached_interface.pointer_button_press_actions.call
						([x_pos, y_pos, button, 0.0, 0.0, 0.0, pt.x, pt.y])
				end
			end

				-- Reset `call_press_event'.
			keep_press_event
		end

	internal_propagate_pointer_double_press
		(keys, x_pos, y_pos, button: INTEGER)
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate
			-- item event. Called on a pointer button double press.
		local
			l_item_imp: detachable EV_HEADER_ITEM_IMP
			pt: WEL_POINT
			l_x_offset: INTEGER
			l_item: detachable EV_HEADER_ITEM
		do
			if pointed_divider_index = 0 then
					-- Clicking on the divider should not register as an item button click.
				l_item_imp := find_item_at_position (x_pos, y_pos)
				l_x_offset := x_pos
				if l_item_imp /= Void then
					l_item := l_item_imp.attached_interface
					l_x_offset := l_x_offset - item_x_offset (l_item)
					pt := client_to_screen (x_pos, y_pos)
					if l_item_imp.pointer_double_press_actions_internal /= Void then
						l_item_imp.pointer_double_press_actions.call
								([l_x_offset, y_pos, button, 0.0, 0.0, 0.0, pt.x, pt.y])
					end
				end

				if item_pointer_double_press_actions_internal /= Void then
					item_pointer_double_press_actions_internal.call (
						[l_item,
						l_x_offset,
						y_pos, button]
					)
				end
			end
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER)
			-- Executed when the mouse move.
		local
			it: detachable EV_HEADER_ITEM_IMP
			pt: WEL_POINT
		do
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void then
				if it.pointer_motion_actions_internal /= Void then
					it.pointer_motion_actions.call ([x_pos - item_x_offset (it.attached_interface), y_pos, 0.0, 0.0, 0.0, pt.x, pt.y])
				end
			end
			if attached pnd_item_source as l_pnd_item_source then
				l_pnd_item_source.pnd_motion (x_pos, y_pos, pt.x, pt.y)
			end
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	on_set_cursor (hit_code: INTEGER)
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

note
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
