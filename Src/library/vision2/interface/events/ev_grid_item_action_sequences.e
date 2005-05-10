indexing
	description:
		"Action sequences for EV_GRID_ITEM."
	keywords: "event, action, sequence"
	date: "$date"
	revision: "$revision"

deferred class
	 EV_GRID_ITEM_ACTION_SEQUENCES

inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_GRID_ITEM_ACTION_SEQUENCES_I

feature -- Event handling


	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer moves.
		do
			Result := implementation.pointer_motion_actions
		ensure
			not_void: Result /= Void
		end


	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer button is pressed.
		do
			Result := implementation.pointer_button_press_actions
		ensure
			not_void: Result /= Void
		end


	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer is double clicked.
		do
			Result := implementation.pointer_double_press_actions
		ensure
			not_void: Result /= Void
		end

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer button is released.
		do
			Result := implementation.pointer_button_release_actions
		ensure
			not_void: Result /= Void
		end

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer enters widget.
		do
			Result := implementation.pointer_enter_actions
		ensure
			not_void: Result /= Void
		end

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer leaves widget.
		do
			Result := implementation.pointer_leave_actions
		ensure
			not_void: Result /= Void
		end

	select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `Current' is selected.
		do
			Result := implementation.select_actions
		ensure
			result_not_void: Result /= Void
		end
		
	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `Current' is deselected.
		do
			Result := implementation.deselect_actions
		ensure
			result_not_void: Result /= Void
		end
		
end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------