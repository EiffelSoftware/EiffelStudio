indexing
	description: "Ancestor of all PND widgets which contain items."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP

inherit

	EV_PICK_AND_DROPABLE_IMP
		undefine
			set_pointer_style
		redefine
			pnd_press,
			interface
		end

feature {EV_ANY_I, EV_INTERNAL_COMBO_FIELD_IMP,
		EV_INTERNAL_COMBO_BOX_IMP} -- Implementation

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
		do
			inspect
				press_action
			when
				Ev_pnd_start_transport
			then
					start_transport (a_x, a_y, a_button, 0, 0, 0.5,
						a_screen_x, a_screen_y)
					set_parent_source_true
			when
				Ev_pnd_end_transport
			then
				end_transport (a_x, a_y, a_button)
				set_parent_source_false
			else
				if a_button = 1 then
					top_level_window_imp.move_to_foreground
				end
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			pt: WEL_POINT
		do
			internal_propagate_pointer_press (keys, x_pos, y_pos, 2)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_button_press_actions.call ([x_pos, y_pos, 3, 0.0, 0.0, 0.0, pt.x, pt.y])
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			pt: WEL_POINT
			item_is_pnd_source_at_entry: BOOLEAN
		do
			item_is_pnd_source_at_entry := item_is_pnd_source
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			internal_propagate_pointer_press (keys, x_pos, y_pos, 3)
			if item_is_pnd_source = item_is_pnd_source_at_entry then
				pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
			end
			interface.pointer_button_press_actions.call ([x_pos, y_pos, 3, 0.0, 0.0, 0.0, pt.x, pt.y])	
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			pt: WEL_POINT
			item_is_pnd_source_at_entry: BOOLEAN
		do
			item_is_pnd_source_at_entry := item_is_pnd_source
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			internal_propagate_pointer_press (keys, x_pos, y_pos, 1)
			if item_is_pnd_source = item_is_pnd_source_at_entry then
				pnd_press (x_pos, y_pos, 1, pt.x, pt.y)
			end
			interface.pointer_button_press_actions.call ([x_pos, y_pos, 1, 0.0, 0.0, 0.0, pt.x, pt.y])	
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wmlbuttonup message
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if item_is_pnd_source then
				pnd_item_source.check_drag_and_drop_release (x_pos, y_pos)
			elseif parent_is_pnd_source then
				check_drag_and_drop_release (x_pos, y_pos)
			end
			interface.pointer_button_release_actions.call ([x_pos, y_pos, 1, 0.0, 0.0, 0.0, pt.x, pt.y])
		end

	client_to_screen (x_pos, y_pos: INTEGER): WEL_POINT is
		deferred
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
		deferred
		end

	interface: EV_WIDGET

feature {EV_PICK_AND_DROPABLE_ITEM_IMP} -- Status report

	parent_is_pnd_source : BOOLEAN
			-- PND started in the widget.

	pnd_item_source: EV_PICK_AND_DROPABLE_ITEM_IMP
			-- PND source if PND started in an item.

	item_is_pnd_source: BOOLEAN
		-- PND started in an item. 

	set_item_source (source: EV_PICK_AND_DROPABLE_ITEM_IMP) is
			-- Assign `source' to `pnd_item_source'
		do
			pnd_item_source := source
		end

	set_parent_source_true is
			-- Assign `True' to `parent_is_pnd_source'.
		do
			parent_is_pnd_source := True
		end

	set_parent_source_false is
			-- Assign `False' to `parent_is_pnd_source'.
		do
			parent_is_pnd_source := False
		end

	set_item_source_true is
			-- Assign `True' to `item_is_pnd_source'.
		do
			item_is_pnd_source := True
		end

	set_item_source_false is
			-- Assign `False' to `item_is_pnd_source'.
		do
			item_is_pnd_source := False
		end

	top_level_window_imp: EV_WINDOW_IMP is
		deferred
		end

	set_pointer_style (c: EV_CURSOR) is
		deferred
		end

	set_capture is
			-- Grab user input.
			-- Works only on current windows thread.
		deferred
		end

	release_capture is
			-- Release user input.
			-- Works only on current windows thread.
		deferred
		end

	set_heavy_capture is
			-- Grab user input.
			-- Works on all windows threads.
		deferred
		end

	release_heavy_capture is
			-- Release user input
			-- Works on all windows threads.
		deferred
		end

end -- class EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
