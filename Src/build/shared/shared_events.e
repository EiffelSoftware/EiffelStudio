indexing
	description: "Creation of all the events."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_EVENTS

feature -- Items

	select_ev: SELECT_EV is
		once
			create Result.make
		end

	unselect_ev: DESELECT_EV is
		once
			create Result.make
		end

		--| Tree item

	subtree_ev: SUBTREE_EV is
		once
			create Result.make
		end

		--| List item

	double_click_ev: DOUBLE_CLICK_EV is
		once
			create Result.make
		end

feature -- Widgets

	destroy_ev: DESTROY_EV is
		once
			create Result.make
		end

	get_focus_ev: GET_FOCUS_EV is
		once
			create Result.make
		end

	lose_focus_ev: LOSE_FOCUS_EV is
		once
			create Result.make
		end

		--| Key events

	key_press_ev: KEY_PRESS_EV is
		once
			create Result.make
		end

	key_release_ev: KEY_RELEASE_EV is
		once
			create Result.make
		end

		--| Mouse events

	enter_notify_ev: ENTER_NOTIFY_EV is
		once
			create Result.make
		end

	motion_notify_ev: MOTION_NOTIFY_EV is
		once
			create Result.make
		end

	leave_notify_ev: LEAVE_NOTIFY_EV is
		once
			create Result.make
		end

	mouse1_press_ev: MOUSE1_PRESS_EV is
		once
			create Result.make
		end

	mouse2_press_ev: MOUSE2_PRESS_EV is
		once
			create Result.make
		end

	mouse3_press_ev: MOUSE3_PRESS_EV is
		once
			create Result.make
		end

	mouse1_release_ev: MOUSE1_RELEASE_EV is
		once
			create Result.make
		end

	mouse2_release_ev: MOUSE2_RELEASE_EV is
		once
			create Result.make
		end

	mouse3_release_ev: MOUSE3_RELEASE_EV is
		once
			create Result.make
		end

	mouse1_motion_ev: MOUSE1_MOTION_EV is
		once
			create Result.make
		end

	mouse2_motion_ev: MOUSE2_MOTION_EV is
		once
			create Result.make
		end

	mouse3_motion_ev: MOUSE3_MOTION_EV is
		once
			create Result.make
		end

	mouse1_dbl_click_ev: MOUSE1_DBL_CLICK_EV is
		once
			create Result.make
		end

	mouse2_dbl_click_ev: MOUSE2_DBL_CLICK_EV is
		once
			create Result.make
		end

	mouse3_dbl_click_ev: MOUSE3_DBL_CLICK_EV is
		once
			create Result.make
		end

feature -- Buttons

	click_ev: CLICK_EV is
		once
			create Result.make
		end

		--| Toggle button

	toggle_ev: TOGGLE_EV is
		once
			create Result.make
		end

feature -- Lists

	selection_ev: SELECTION_EV is
		once
			create Result.make
		end

		--| Multi column list

	column_click_ev: COLUMN_CLICK_EV is
		once
			create Result.make
		end

feature -- Drawing area

	paint_ev: PAINT_EV is
		once
			create Result.make
		end

	resize_ev: RESIZE_EV is
		once
			create Result.make
		end

feature -- Notebook

	switch_ev: SWITCH_EV is
		once
			create Result.make
		end

feature -- Windows

	move_ev: MOVE_EV is
		once
			create Result.make
		end

	close_ev: CLOSE_EV is
		once
			create Result.make
		end

feature -- Text components

	change_ev: CHANGE_EV is
		once
			create Result.make
		end

	return_ev: RETURN_EV is
		once
			create Result.make
		end

--	insert_ev: TEXT_MODIFIED_EV is
--		once
--			create Result.make
--		end

--	delete_ev: TEXT_MOTION_EV is
--		once
--			create Result.make
--		end

end -- class SHARED_EVENTS

