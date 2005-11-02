indexing
	description:
		"Action sequences for EV_APPLICATION_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_APPLICATION_ACTION_SEQUENCES_IMP

inherit
	EV_APPLICATION_ACTION_SEQUENCES_I


feature -- Event handling

	create_post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a post_launch action sequence.
		do
			create Result
		end

	create_idle_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a idle action sequence.
		do
			create Result
		end

	create_pick_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a pick action sequence.
		do
			create Result
		end

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a drop action sequence.
		do
			create Result
		end

	create_pnd_motion_actions: EV_PND_MOTION_ACTION_SEQUENCE is
			-- Create a pnd motion action sequence.
		do
			create Result
		end

	create_cancel_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a cancel action sequence.
		do
			create Result
		end

	create_pointer_motion_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER]] is
			-- Create a pointer_motion action sequence.
		do
			create Result
		end

	create_pointer_button_press_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]] is
			-- Create a pointer_button_press action sequence.
		do
			create Result
		end

	create_pointer_double_press_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]] is
			-- Create a pointer_double_press action sequence.
		do
			create Result
		end

	create_pointer_button_release_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]] is
			-- Create a pointer_button_release action sequence.
		do
			create Result
		end

	create_mouse_wheel_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER]] is
			-- Create a mouse_wheel action sequence.
		do
			create Result
		end

	create_key_press_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]] is
			-- Create a key_press action sequence.
		do
			create Result
		end

	create_key_press_string_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, STRING]] is
			-- Create a key_press_string action sequence.
		do
			create Result
		end

	create_key_release_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]] is
			-- Create a key_release action sequence.
		do
			create Result
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

