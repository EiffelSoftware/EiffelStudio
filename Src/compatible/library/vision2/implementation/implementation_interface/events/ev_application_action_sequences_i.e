note
	description:
		"Action sequences for EV_APPLICATION_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_APPLICATION_ACTION_SEQUENCES_I


feature -- Event handling

	post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed just after application `launch'.
		do
			if post_launch_actions_internal = Void then
				post_launch_actions_internal :=
					 create_post_launch_actions
			end
			Result := post_launch_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a post_launch action sequence.
		deferred
		end

	post_launch_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `post_launch_actions'.

feature -- Event handling

	idle_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when the application is otherwise idle.
		do
			if idle_actions_internal = Void then
				idle_actions_internal :=
					 create_idle_actions
			end
			Result := idle_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_idle_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a idle action sequence.
		deferred
		end

	idle_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `idle_actions'.

feature -- Event handling

	pick_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to be performed when any "pick" occurs.
		do
			if pick_actions_internal = Void then
				pick_actions_internal :=
					 create_pick_actions
			end
			Result := pick_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pick_actions: EV_PND_ACTION_SEQUENCE
			-- Create a pick action sequence.
		deferred
		end

	pick_actions_internal: EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `pick_actions'.


feature -- Event handling

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to be performed when any "drop" occurs.
		do
			if drop_actions_internal = Void then
				drop_actions_internal :=
					 create_drop_actions
			end
			Result := drop_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_drop_actions: EV_PND_ACTION_SEQUENCE
			-- Create a drop action sequence.
		deferred
		end

	drop_actions_internal: EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `drop_actions'.


feature -- Event handling

	cancel_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to be performed when a PND is cancelled
		do
			if cancel_actions_internal = Void then
				cancel_actions_internal :=
					 create_cancel_actions
			end
			Result := cancel_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_cancel_actions: EV_PND_ACTION_SEQUENCE
			-- Create a cancel action sequence.
		deferred
		end

	cancel_actions_internal: EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `cancel_actions'.

feature -- Event handling

	pnd_motion_actions: EV_PND_MOTION_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer is moved,
			-- during a pick and drop.
		do
			if pnd_motion_actions_internal = Void then
				pnd_motion_actions_internal := create_pnd_motion_actions
			end
			Result := pnd_motion_actions_internal
		ensure
			not_void: Result /= Void
		end

	file_drop_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [widget: EV_WIDGET; file_list: LIST [STRING_32]]]
			-- Actions to be performed when an OS file drop is performed on `Current'.
			-- `widget' is the widget on which the file(s) where dropped on to.
			-- `file_list' is a list of the file paths being dropped on to `widget'.
			-- In order for `file_drop_actions' to be called an agent has to be already
			-- present in the `file_drop_actions' of `widget' otherwise a drop is disallowed.
		do
			if file_drop_actions_internal = Void then
				create file_drop_actions_internal
			end
			Result := file_drop_actions_internal
		ensure
			not_void: Result /= Void
		end

	uncaught_exception_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EXCEPTION]]
		-- Actions to be performed when an
		-- action sequence called via callback
		-- from the underlying toolkit raises an
		-- exception that is not caught
		do
			if uncaught_exception_actions_internal = Void then
				create uncaught_exception_actions_internal
			end
			Result := uncaught_exception_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pnd_motion_actions: like pnd_motion_actions
			-- Create a pnd motion action sequence.
		deferred
		end

	pnd_motion_actions_internal: like pnd_motion_actions
		-- Implementation of once per object `pnd_motion_actions'.

	file_drop_actions_internal: like file_drop_actions
		-- Implementation of once per object `file_drop_actions'.

	uncaught_exception_actions_internal: like uncaught_exception_actions
		-- Implementation of once per object `uncaught_exception_actions'.

feature

	pointer_motion_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER]]
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

	create_pointer_motion_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER]]
			-- Create a pointer_motion action sequence.
		deferred
		end

	pointer_motion_actions_internal: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER]]
			-- Implementation of once per object `pointer_motion_actions'.

feature -- Event handling

	pointer_button_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
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

	create_pointer_button_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Create a pointer_button_press action sequence.
		deferred
		end

	pointer_button_press_actions_internal: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Implementation of once per object `pointer_button_press_actions'.

feature -- Event handling

	pointer_double_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
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

	create_pointer_double_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Create a pointer_double_press action sequence.
		deferred
		end

	pointer_double_press_actions_internal: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Implementation of once per object `pointer_double_press_actions'.

feature -- Event handling

	pointer_button_release_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
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

	create_pointer_button_release_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Create a pointer_button_release action sequence.
		deferred
		end

	pointer_button_release_actions_internal: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]]
			-- Implementation of once per object `pointer_button_release_actions'.

feature -- Event handling

	mouse_wheel_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER]]
			-- Actions to be performed when mouse wheel is rotated.
		do
			if mouse_wheel_actions_internal = Void then
				mouse_wheel_actions_internal := create_mouse_wheel_actions
			end
			Result := mouse_wheel_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_mouse_wheel_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER]]
			-- Create a mouse_wheel action sequence.
		deferred
		end

	mouse_wheel_actions_internal: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER]]
			-- Implementation of once per object `mouse_wheel_actions'.

feature -- Event handling

	key_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
			-- Actions to be performed when a keyboard key is pressed.
		do
			if key_press_actions_internal = Void then
				key_press_actions_internal :=
					 create_key_press_actions
			end
			Result := key_press_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_key_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
			-- Create a key_press action sequence.
		deferred
		end

	key_press_actions_internal: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
			-- Implementation of once per object `key_press_actions'.

feature -- Event handling

	key_press_string_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, STRING_32]]
			-- Actions to be performed when a keyboard press generates a displayable character.
		do
			if key_press_string_actions_internal = Void then
				key_press_string_actions_internal := create_key_press_string_actions
			end
			Result := key_press_string_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_key_press_string_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, STRING_32]]
			-- Create a key_press_string action sequence.
		deferred
		end

	key_press_string_actions_internal: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, STRING_32]]
			-- Implementation of once per object `key_press_string_actions'.

feature -- Event handling

	key_release_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
			-- Actions to be performed when a keyboard key is released.
		do
			if key_release_actions_internal = Void then
				key_release_actions_internal :=
					 create_key_release_actions
			end
			Result := key_release_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_key_release_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
			-- Create a key_release action sequence.
		deferred
		end

	key_release_actions_internal: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]]
			-- Implementation of once per object `key_release_actions'.

feature -- Event handling

	focus_in_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Actions to be performed when getting focus.
		do
			if focus_in_actions_internal = Void then
				focus_in_actions_internal :=
					 create_focus_in_actions
			end
			Result := focus_in_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_focus_in_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Create a focus_in action sequence.
		deferred
		end

	focus_in_actions_internal: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Implementation of once per object `focus_in_actions'.

feature -- Event handling

	focus_out_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Actions to be performed when losing focus.
		do
			if focus_out_actions_internal = Void then
				focus_out_actions_internal :=
					 create_focus_out_actions
			end
			Result := focus_out_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_focus_out_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Create a focus_out action sequence.
		deferred
		end

	focus_out_actions_internal: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]];
			-- Implementation of once per object `focus_out_actions'.

feature -- Event handling

	theme_changed_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when operating system theme changed.
		do
			if theme_changed_actions_internal = Void then
				theme_changed_actions_internal :=
					create_theme_changed_actions
			end
			Result := theme_changed_actions_internal
		end

feature {EV_ANY_I} -- Implementation

	create_theme_changed_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a theme_changed action sequence.
		deferred
		end

	theme_changed_actions_internal: EV_NOTIFY_ACTION_SEQUENCE;
			-- Implementation of once per object `theme_changed_actions'.

feature -- Event handling

	system_color_change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when screen color depth changed.
		do
			if system_color_change_actions_internal = Void then
				system_color_change_actions_internal :=
					 create_system_color_change_actions
			end
			Result := system_color_change_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_system_color_change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a system_color_change_actions.
		deferred
		end

	system_color_change_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `system_color_change_actions'.

feature -- Event handling

	destroy_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when current application is destroying.
		do
			if destroy_actions_internal = Void then
				destroy_actions_internal :=
					create_destroy_actions
			end
			Result := destroy_actions_internal
		end

feature {EV_ANY_I}	-- Implementation

	create_destroy_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a destroy_action sequence.
		deferred
		end

	destroy_actions_internal: EV_NOTIFY_ACTION_SEQUENCE;
			-- Impplementation of once per object `destroy_actions'

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

