note
	description:
		"[
			EV_GRID Text label whose content may be interactively chosen by the user via a list.

			`set_item_strings' may be used to set the list items used in the choice list before the item is activated.

			By default a list containing the strings set from `set_item_strings' is displayed, allowing
			the user to change the text of `Current' by selecting an item within that list.
				
			The default behavior of the activation may be overriden using `activate_actions' or `item_activate_actions' (from
			EV_GRID).
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_CHOICE_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			activate_action,
			deactivate,
			initialize,
			required_width
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialize

	initialize
			-- Initialize current.
		do
			Precursor {EV_GRID_LABEL_ITEM}
			set_layout_procedure (agent update_layout)
		end

feature -- Element change

	set_item_strings (a_string_array: attached like item_strings)
			-- Set each item in `Current' to the strings referenced in `a_string_array'.
		require
			a_string_array_not_void: a_string_array /= Void
		do
			item_strings := a_string_array
			if attached choice_list as l_choice_list and then not l_choice_list.is_destroyed then
				set_strings
			end
			if a_string_array.index_set.count > 1 then
				set_pixmap (drop_down_pixmap)
			else
				remove_pixmap
			end
		ensure
			item_strings_set: item_strings = a_string_array
		end

feature -- Access

	item_strings: detachable INDEXABLE [READABLE_STRING_GENERAL, INTEGER]
		-- Item strings used to make up combo box list.

	required_width: INTEGER
			-- Width in pixels required to fully display contents, based
			-- on current settings.
		do
				-- If there is a pixmap set, we use that pixmap, otherwise we
				-- take into account the size of `drop_down_pixmap' even if it is not shown.
			if pixmap = Void then
				pixmap := drop_down_pixmap
				Result := implementation.required_width
				pixmap := Void
			else
				Result := implementation.required_width
			end
		end

feature {NONE} -- Implementation

	choice_list: detachable EV_GRID
		-- Text field used to edit `Current' on `activate'
		-- Void when `Current' isn't being activated.

	update_layout (a_item: EV_GRID_LABEL_ITEM; a_layout: EV_GRID_LABEL_ITEM_LAYOUT)
			-- Update layout for displaying current.
		do
			if a_item /= Void and a_layout /= Void and attached pixmap as l_pixmap then
					-- We have the pixmap enabled, let's compute the position
					-- of the `text' and `pixmap' so that the pixmap appears
					-- on the right edge of `a_item'.
				a_layout.set_text_x (left_border)
				a_layout.set_pixmap_x (a_item.width - l_pixmap.width - 2)
				a_layout.set_has_text_pixmap_overlapping (False)
			end
		end

	set_strings
			-- Update `choice_list' with `item_strings'.
		require
			choice_list_not_destroyed: attached choice_list as l_c_list and then not l_c_list.is_destroyed
		local
			l_item: EV_GRID_LABEL_ITEM
			i, j, nb: INTEGER
			l_interval: INTEGER_INTERVAL
			l_text, l_selected_text: READABLE_STRING_GENERAL
			l_font: EV_FONT
			l_choice_list: like choice_list
		do
			l_choice_list := choice_list
			check l_choice_list /= Void end
			l_choice_list.wipe_out
			if attached item_strings as l_item_strings then
				from
					l_interval := l_item_strings.index_set
					j := 1
					i := l_interval.lower
					nb := l_interval.upper
					l_selected_text := text
				until
					i > nb
				loop
					l_text := l_item_strings.item (i)
					create l_item.make_with_text (l_text)
					i := i + 1
					l_choice_list.set_item (1, j, l_item)
					j := j + 1
					if l_text.same_string (l_selected_text) then
						create l_font
						l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
						l_item.set_font (l_font)
						l_item.enable_select
					end
				end
			end
		end

	has_user_selected_item: BOOLEAN
		-- Did the user select an entry in the list?

	activate_action (popup_window: EV_POPUP_WINDOW)
			-- `Current' has been requested to be updated via `popup_window'.
		local
			l_vbox: EV_VERTICAL_BOX
			l_maximum_height, l_maximum_width: INTEGER
			l_screen: detachable EV_SCREEN_IMP
			l_choice_list: EV_GRID
			l_popup_window: detachable EV_POPUP_WINDOW
		do
			l_screen ?= (create {EV_SCREEN}).implementation
			check l_screen_not_void: l_screen /= Void end
			create l_choice_list
			choice_list := l_choice_list
			l_choice_list.hide_header
			l_choice_list.enable_single_row_selection
			l_choice_list.enable_selection_key_handling
			l_choice_list.enable_row_height_fixed
			l_choice_list.set_minimum_height (l_choice_list.row_height)

			create l_vbox
			l_vbox.set_border_width (1)
			l_vbox.set_background_color ((create {EV_STOCK_COLORS}).black)
			l_vbox.extend (l_choice_list)

			l_popup_window := popup_window
			check l_popup_window /= Void end

			l_popup_window.extend (l_vbox)

			set_strings

				-- Compute location and size of `popup_window' and `choice_list' so that we can see most
				-- of the items at once.
			l_maximum_height := (l_screen.virtual_height - l_popup_window.y_position).max (0)
			l_maximum_width := (l_screen.virtual_width - l_popup_window.x_position).max (0)
			l_choice_list.column (1).set_width (left_border + l_maximum_width.min (
				(popup_window.width - 2).max (l_choice_list.column (1).required_width_of_item_span (1, l_choice_list.row_count))))
				-- +2 to take into account 2 pixels border of the vertical box.
			l_popup_window.set_height (2 + l_maximum_height.min (l_choice_list.row_count * l_choice_list.row_height))
			l_popup_window.set_width (l_popup_window.width.max (2 + l_choice_list.column (1).width))

			l_choice_list.set_background_color (implementation.displayed_background_color)
			l_popup_window.set_background_color (implementation.displayed_background_color)
			l_choice_list.set_foreground_color (implementation.displayed_foreground_color)

				-- Initialize action sequences when `Current' is shown.
			l_popup_window.show_actions.extend (agent initialize_actions)
		end

	initialize_actions
			-- Setup the action sequences when the item is shown.
		do
				-- No selection yet.
			has_user_selected_item := False

			if attached choice_list as l_choice_list and then not l_choice_list.is_destroyed then
					-- Initialize actions.
				l_choice_list.set_focus
				l_choice_list.focus_out_actions.extend (agent deactivate)
				l_choice_list.pointer_button_press_item_actions.extend (agent on_mouse_click)
				l_choice_list.pointer_double_press_item_actions.extend (agent on_mouse_click)
				l_choice_list.pointer_motion_actions.force_extend (agent on_mouse_move)
				l_choice_list.key_press_actions.extend (agent on_key)
				l_choice_list.hide_horizontal_scroll_bar
			else
					-- Something wrong happend here, we should deactivate if possible.
				if not is_destroyed and is_parented then
					deactivate
				end
			end
		end

	on_mouse_move (a_x, a_y: INTEGER)
			-- Handle mouse moving actions.
		local
			l_item: detachable EV_GRID_ITEM
			l_list: LIST [EV_GRID_ITEM]
		do
			if attached choice_list as l_choice_list then
				l_item := l_choice_list.item_at_virtual_position (l_choice_list.virtual_x_position + a_x,
					l_choice_list.virtual_y_position + a_y)
				if l_item /= Void then
					l_list := l_choice_list.selected_items
					if not l_list.is_empty and then l_list.first /= l_item then
						l_choice_list.remove_selection
						l_item.enable_select
					end
				end
			else
				check choice_list /= Void end
			end
		end

	on_mouse_click (a_x, a_y, a_button: INTEGER; a_item: detachable EV_GRID_ITEM)
			-- Handle mouse actions.
		local
			l_item: detachable EV_GRID_ITEM
			l_list: LIST [EV_GRID_ITEM]
		do
			if a_button = 1 then
				if attached choice_list as l_choice_list then
					l_item := l_choice_list.item_at_virtual_position (l_choice_list.virtual_x_position + a_x,
						l_choice_list.virtual_y_position + a_y)
					if l_item /= Void then
						l_list := l_choice_list.selected_items
						if not l_list.is_empty and then l_list.first /= l_item then
							l_choice_list.remove_selection
							l_item.enable_select
						end
						has_user_selected_item := True
						deactivate
					end
				else
					check choice_list /= Void end
				end
			end
		end

	on_key (a_key: EV_KEY)
			-- Handle key action on `choice_list'
		do
			if a_key /= Void then
				if a_key.code = {EV_KEY_CONSTANTS}.key_escape then
					deactivate
				elseif a_key.code = {EV_KEY_CONSTANTS}.key_enter then
					has_user_selected_item := True
					deactivate
				end
			end
		end

	deactivate
			-- Cleanup from previous call to activate.
		local
			l_item: detachable EV_GRID_LABEL_ITEM
		do
			if attached choice_list as l_choice_list and then not l_choice_list.is_destroyed then
				l_choice_list.focus_out_actions.wipe_out
				if has_user_selected_item and then not l_choice_list.selected_rows.is_empty then
					l_item ?= l_choice_list.selected_rows.first.item (1)
					if l_item /= Void then
						set_text (l_item.text)
					end
				end
				choice_list := Void
			end
			Precursor {EV_GRID_LABEL_ITEM}
		end

	drop_down_pixmap: EV_PIXMAP
			-- Drop drawn pixmap
		local
			l_mask: EV_BITMAP
		once
				-- Draw a drop down triangle.
			create Result.make_with_size (9, 6)
			Result.draw_segment (1, 1, 7, 1)
			Result.draw_segment (2, 2, 6, 2)
			Result.draw_segment (3, 3, 5, 3)
			Result.draw_segment (4, 4, 4, 4)

			create l_mask.make_with_size (9, 6)
			l_mask.draw_segment (0, 0, 8, 0)
			l_mask.draw_segment (0, 1, 8, 1)
			l_mask.draw_segment (1, 2, 7, 2)
			l_mask.draw_segment (2, 3, 6, 3)
			l_mask.draw_segment (3, 4, 5, 4)
			l_mask.draw_segment (4, 5, 4, 5)

			Result.set_mask (l_mask)
		ensure
			drop_down_pixmap_not_void: Result /= Void
		end

invariant
	choice_list_parented_during_activation: attached choice_list as l_choice_list implies l_choice_list.parent /= Void

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
end
