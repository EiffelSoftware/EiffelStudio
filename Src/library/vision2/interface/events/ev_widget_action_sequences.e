indexing
	description:
		"Action sequences for EV_WIDGET."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WIDGET_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_WIDGET_ACTION_SEQUENCES_I

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


	key_press_actions: EV_KEY_ACTION_SEQUENCE is
			-- Actions to be performed when a keyboard key is pressed.
		do
			Result := implementation.key_press_actions
		ensure
			not_void: Result /= Void
		end


	key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE is
			-- Actions to be performed when a keyboard press generates a displayable character.
		do
			Result := implementation.key_press_string_actions
		ensure
			not_void: Result /= Void
		end


	key_release_actions: EV_KEY_ACTION_SEQUENCE is
			-- Actions to be performed when a keyboard key is released.
		do
			Result := implementation.key_release_actions
		ensure
			not_void: Result /= Void
		end
		

	focus_in_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- Actions to be performed when keyboard focus is gained.
		do
			Result := implementation.focus_in_actions
		ensure
			not_void: Result /= Void
		end


	focus_out_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- Actions to be performed when keyboard focus is lost.
		do
			Result := implementation.focus_out_actions
		ensure
			not_void: Result /= Void
		end


	resize_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Actions to be performed when size changes.
		do
			Result := implementation.resize_actions
		ensure
			not_void: Result /= Void
		end

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

