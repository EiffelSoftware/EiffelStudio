note
	description:
		"Action sequences for EV_APPLICATION."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_APPLICATION_ACTION_SEQUENCES

inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_APPLICATION_ACTION_SEQUENCES_I

feature -- Event handling

	post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed just after application `launch'.
		do
			Result := implementation.post_launch_actions
		ensure
			not_void: Result /= Void
		end

	idle_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when the application is otherwise idle.
			-- Use of `idle_actions' is not thread-safe.  For thread-safe idle
			-- actions handling use 'add_idle_action', `remove_idle_action'
			-- or `do_once_on_idle' in conjunction with EV_THREAD_APPLICATION.
		obsolete
			"Use add_idle_action, do_once_on_idle or remove_idle_action instead"
		require
			single_threaded: not {PLATFORM}.is_thread_capable
		do
			Result := implementation.idle_actions
		ensure
			not_void: Result /= Void
		end

	pick_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to be performed when any "pick" occurs.
		do
			Result := implementation.pick_actions
		ensure
			not_void: Result /= Void
		end

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to be performed when any "drop" occurs.
		do
			Result := implementation.drop_actions
		ensure
			not_void: Result /= Void
		end

	cancel_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to be performed when a PND is cancelled.
			-- A cancel may be initiated in a number of ways depending on the transport
			-- type, including attempting to drop on a target that does not accept
			-- transported pebble.
		do
			Result := implementation.cancel_actions
		ensure
			not_void: Result /= Void
		end

	pnd_motion_actions: EV_PND_MOTION_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer is moved,
			-- during a pick and drop. The "pick and drop" argument
			-- is the current EV_ABSTRACT_PICK_AND_DROPABLE below the
			-- pointer position, or Void if the `drop_actions' for this
			-- item are empty.
		do
			Result := implementation.pnd_motion_actions
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
			Result := implementation.file_drop_actions
		ensure
			not_void: Result /= Void
		end

	uncaught_exception_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [exception: EXCEPTION]]
			-- Actions to be performed when an
			-- action sequence called via callback
			-- from the underlying toolkit raises an
			-- exception that is not caught
		do
			Result := implementation.uncaught_exception_actions
		ensure
			not_void: Result /= Void
		end

	pointer_motion_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [widget: EV_WIDGET; screen_x: INTEGER; screen_y: INTEGER]]
			-- Actions to be performed when screen pointer moves.
		do
			Result := implementation.pointer_motion_actions
		ensure
			not_void: Result /= Void
		end

	pointer_button_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [widget: EV_WIDGET; button: INTEGER; screen_x: INTEGER; screen_y: INTEGER]]
			-- Actions to be performed when screen pointer button is pressed.
		do
			Result := implementation.pointer_button_press_actions
		ensure
			not_void: Result /= Void
		end

	pointer_double_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [widget: EV_WIDGET; button: INTEGER; screen_x: INTEGER; screen_y: INTEGER]]
			-- Actions to be performed when screen pointer is double clicked.
		do
			Result := implementation.pointer_double_press_actions
		ensure
			not_void: Result /= Void
		end

	pointer_button_release_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [widget: EV_WIDGET; button: INTEGER; screen_x: INTEGER; screen_y: INTEGER]]
			-- Actions to be performed when screen pointer button is released.
		do
			Result := implementation.pointer_button_release_actions
		ensure
			not_void: Result /= Void
		end

	mouse_wheel_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [widget: EV_WIDGET; delta: INTEGER]]
			-- Actions to be performed when mouse wheel is rotated.
		do
			Result := implementation.mouse_wheel_actions
		ensure
			not_void: Result /= Void
		end

	key_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [widget: EV_WIDGET; key: EV_KEY]]
			-- Actions to be performed when a keyboard key is pressed.
		do
			Result := implementation.key_press_actions
		ensure
			not_void: Result /= Void
		end

	key_press_string_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [widget: EV_WIDGET; string: STRING_GENERAL]]
			-- Actions to be performed when a keyboard press generates a displayable character.
		do
			Result := implementation.key_press_string_actions
		ensure
			not_void: Result /= Void
		end

	key_release_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [widget: EV_WIDGET; key: EV_KEY]]
			-- Actions to be performed when a keyboard key is released.
		do
			Result := implementation.key_release_actions
		ensure
			not_void: Result /= Void
		end

	focus_in_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [widget: EV_WIDGET]]
			-- Actions to be performed when getting focus.
		do
			Result := implementation.focus_in_actions
		ensure
			not_void: Result /= Void
		end

	focus_out_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [widget: EV_WIDGET]]
			-- Actions to be performed when losing focus.
		do
			Result := implementation.focus_out_actions
		ensure
			not_void: Result /= Void
		end

	theme_changed_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when operation system theme changed
		do
			Result := implementation.theme_changed_actions
		ensure
			not_void: Result /= Void
		end

	destroy_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when destroying current application.
		do
			Result := implementation.destroy_actions
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




end

