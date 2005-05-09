indexing
	description:
		"Action sequences for EV_GRID_ITEM_I."
	keywords: "event, action, sequence"
	date: "$date"
	revision: "$revision"

deferred class
	 EV_GRID_ITEM_ACTION_SEQUENCES_I


feature -- Event handling

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer moves.
		do
			if pointer_motion_actions_internal = Void then
				pointer_motion_actions_internal :=
					 create_pointer_motion_actions
			end
			Result := pointer_motion_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Create a pointer_motion action sequence.
		do
			create Result
		end

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_motion_actions'.


feature -- Event handling

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer button is pressed.
		do
			if pointer_button_press_actions_internal = Void then
				pointer_button_press_actions_internal :=
					 create_pointer_button_press_actions
			end
			Result := pointer_button_press_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Create a pointer_button_press action sequence.
		do
			create Result
		end

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_button_press_actions'.


feature -- Event handling

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer is double clicked.
		do
			if pointer_double_press_actions_internal = Void then
				pointer_double_press_actions_internal :=
					 create_pointer_double_press_actions
			end
			Result := pointer_double_press_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Create a pointer_double_press action sequence.
		do
			create Result
		end

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_double_press_actions'.


feature -- Event handling

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer button is released.
		do
			if pointer_button_release_actions_internal = Void then
				pointer_button_release_actions_internal :=
					 create_pointer_button_release_actions
			end
			Result := pointer_button_release_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Create a pointer_button_release action sequence.
		do
			create Result
		end

	pointer_button_release_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_button_release_actions'.


feature -- Event handling

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer enters widget.
		do
			if pointer_enter_actions_internal = Void then
				pointer_enter_actions_internal :=
					 create_pointer_enter_actions
			end
			Result := pointer_enter_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a pointer_enter action sequence.
		do
			create Result
		end

	pointer_enter_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_enter_actions'.

feature -- Event handling

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer leaves widget.
		do
			if pointer_leave_actions_internal = Void then
				pointer_leave_actions_internal :=
					 create_pointer_leave_actions
			end
			Result := pointer_leave_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a pointer_leave action sequence.
		do
			create Result
		end

	pointer_leave_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_leave_actions'.

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

