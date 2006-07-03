indexing
	description: "Property with several values to choose from."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CHOICE_PROPERTY [G]

inherit
	ELLIPSIS_PROPERTY [G]
		redefine
			ellipsis,
			initialize,
			initialize_actions,
			deactivate,
			has_focus
		end

feature {NONE} -- Initialization

	make_with_choices (a_name: like name; a_choices: ARRAY [G]) is
			-- Initialize with some choices.
		require
			a_choices_ok: a_choices /= Void and not a_choices.is_empty
		do
			make (a_name)
			item_strings := create {ARRAYED_LIST [G]}.make_from_array (a_choices)
		end

	initialize is
			-- Initialize.
		do
			Precursor

			ellipsis_actions.extend (agent show_ellipsis)
		end

feature -- Status

	has_focus: BOOLEAN is
			-- Does this property have the focus?
		do
			Result := Precursor {ELLIPSIS_PROPERTY} or has_combo_focus
		end

	has_combo_focus: BOOLEAN is
			-- Does the combo popup have the focus?
		do
			Result := (combo_grid /= Void and then combo_grid.has_focus) or (combo_popup /= Void and then combo_popup.has_focus)
		end

feature -- Access

	item_strings: LIST [like value]
			-- Possible choices.

feature {NONE} -- Agents

	switch is
			-- Switch value.
		local
			l_parent: PROPERTY_GRID
			l_done: BOOLEAN
			l_item: like value
		do
			l_parent ?= parent
			if l_parent /= Void and then not l_parent.is_resize_mode then
				from
					item_strings.start
				until
					l_done or item_strings.after
				loop
					if text_field.text.is_equal (item_strings.item.out) then
						if item_strings.islast then
							l_item := item_strings.first
						else
							item_strings.forth
							l_item := item_strings.item
						end
						text_field.set_text (l_item.out)
						if is_valid_value (l_item) then
							set_value (l_item)
						end
						l_done := True
					end
					item_strings.forth
				end
			end
		end

	initialize_actions is
			-- Setup the actions sequences when the item is shown.
		do
			Precursor
			text_field.disable_edit
			text_field.pointer_button_press_actions.force_extend (agent switch)
			text_field.key_press_actions.extend (agent on_text_field_key)
		end

	show_ellipsis is
			-- Called when ellipsis is pressed.
		require
			is_activated: is_activated
		local
			l_item: GENERIC_GRID_ITEM [G]
			l_frame: EV_FRAME
		do
			create combo_popup
			combo_popup.set_position (popup_window.x_position, popup_window.y_position + text_field.height)
			combo_popup.set_width (width)

			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_etched_out)

			create combo_grid
			combo_grid.hide_header
			combo_grid.pointer_button_press_item_actions.extend (agent combo_click)
			combo_grid.key_press_actions.extend (agent on_combo_key)
			l_frame.extend (combo_grid)
			from
				item_strings.start
			until
				item_strings.after
			loop
				create l_item.make_with_text (item_strings.item.out)
				l_item.set_value (item_strings.item)
				combo_grid.set_item (1, item_strings.index, l_item)
				l_item.pointer_enter_actions.force_extend (agent combo_select (l_item))
				if l_item.text.is_equal (text_field.text) then
					l_item.enable_select
				end
				item_strings.forth
			end
			if item_strings.count < 10 then
				combo_popup.set_height ((item_strings.count) * (combo_grid.row_height) + 4)
				combo_grid.column (1).set_width (width-4)
			else
				combo_popup.set_height (10 * (combo_grid.row_height) + 4)
				combo_grid.column (1).set_width (width-21)
			end
			combo_grid.set_minimum_height (0)
			combo_grid.set_minimum_width (0)

			combo_popup.focus_out_actions.force (agent combo_focus_lost)
			combo_grid.focus_out_actions.force (agent combo_focus_lost)

			combo_popup.extend (l_frame)
			combo_popup.show
			combo_grid.set_focus
		end

	deactivate is
			-- Called on deactivate.
		do
			Precursor {ELLIPSIS_PROPERTY}
			destroy_combo_popup
		end

	combo_focus_lost is
			-- Called if focus of the combo popup is lost.
		do
			if not has_combo_focus then
				destroy_combo_popup
				focus_lost
			end
		end

	combo_select (an_item: EV_GRID_ITEM) is
			-- Change the selected item in the combo.
		do
			if combo_grid /= Void then
				combo_grid.remove_selection
				an_item.enable_select
			end
		end

	combo_click (x_pos, y_pos, a_button: INTEGER; an_item: EV_GRID_ITEM) is
			-- Choose a different value.
		require
			is_activated: is_activated
		local
			l_item: GENERIC_GRID_ITEM [G]
		do
			l_item ?= an_item
			if l_item /= Void then
				if is_valid_value (l_item.value) then
					set_value (l_item.value)
				end
				update_text_on_deactivation
				destroy_combo_popup
			end
		end

	on_combo_key (a_key: EV_KEY) is
			-- A key was pressed in `combo_grid'.
		require
			a_key_not_void: a_key /= Void
		local
			l_item: GENERIC_GRID_ITEM [G]
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				if combo_grid.selected_items /= Void and then combo_grid.selected_items.count = 1 then
					l_item ?= combo_grid.selected_items.first
					if l_item /= Void and then is_valid_value (l_item.value) then
						set_value (l_item.value)
					end
					deactivate
				end
			end
		end

	on_text_field_key (a_key: EV_KEY) is
			-- A key was pressed in `text_field'.
		require
			a_key_not_void: a_key /= Void
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter or a_key.code = {EV_KEY_CONSTANTS}.key_down then
				ellipsis_actions.call ([])
			end
		end

feature {NONE} -- Implementation

	ellipsis: EV_PIXMAP is
			-- Icon for combo box button.
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
		end

	combo_popup: EV_POPUP_WINDOW
			-- Popup window for showing the combo list.

	combo_grid: EV_GRID
			-- Grid that shows the available choices.

	destroy_combo_popup is
			-- Destroy combo popup.
		do
			if combo_grid /= Void then
				combo_grid.focus_out_actions.wipe_out
				combo_grid.destroy
				combo_grid := Void
			end
			if combo_popup /= Void then
				combo_popup.focus_out_actions.wipe_out
				combo_popup.destroy
				combo_popup := Void
			end
		end

end
