indexing
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

	post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed just after application `launch'.
		do
			Result := implementation.post_launch_actions
		ensure
			not_void: Result /= Void
		end

	idle_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when the application is otherwise idle.
		do
			Result := implementation.idle_actions
		ensure
			not_void: Result /= Void
		end

	pick_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when any "pick" occurs.
		do
			Result := implementation.pick_actions
		ensure
			not_void: Result /= Void
		end

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when any "drop" occurs.
		do
			Result := implementation.drop_actions
		ensure
			not_void: Result /= Void
		end

	cancel_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when a PND is cancelled.
			-- A cancel may be initiated in a number of ways depending on the transport
			-- type, including attempting to drop on a target that does not accept
			-- transported pebble.
		do
			Result := implementation.cancel_actions
		ensure
			not_void: Result /= Void
		end

	pnd_motion_actions: EV_PND_MOTION_ACTION_SEQUENCE is
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

	uncaught_exception_actions: ACTION_SEQUENCE [TUPLE [EXCEPTION]] is
			-- Actions to be performed when an
			-- action sequence called via callback
			-- from the underlying toolkit raises an
			-- exception that is not caught
		do
			Result := implementation.uncaught_exception_actions
		ensure
			not_void: Result /= Void
		end

	pointer_motion_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER]] is
			-- Actions to be performed when screen pointer moves with open arguments
			-- widget: EV_WIDGET; screen_x, screen_y: INTEGER
		do
			Result := implementation.pointer_motion_actions
		ensure
			not_void: Result /= Void
		end

	pointer_button_press_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]] is
			-- Actions to be performed when screen pointer button is pressed with open arguments
			-- widget: EV_WIDGET; button, screen_x, screen_y: INTEGER
		do
			Result := implementation.pointer_button_press_actions
		ensure
			not_void: Result /= Void
		end

	pointer_double_press_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]] is
			-- Actions to be performed when screen pointer is double clicked with open arguments
			-- widget: EV_WIDGET; button, screen_x, screen_y: INTEGER
		do
			Result := implementation.pointer_double_press_actions
		ensure
			not_void: Result /= Void
		end

	pointer_button_release_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER]] is
			-- Actions to be performed when screen pointer button is released with open arguments
			-- widget: EV_WIDGET; button, screen_x, screen_y: INTEGER
		do
			Result := implementation.pointer_button_release_actions
		ensure
			not_void: Result /= Void
		end

	mouse_wheel_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, INTEGER]] is
			-- Actions to be performed when mouse wheel is rotated with open arguments
			-- widget: EV_WIDGET; delta: INTEGER
		do
			Result := implementation.mouse_wheel_actions
		ensure
			not_void: Result /= Void
		end

	key_press_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]] is
			-- Actions to be performed when a keyboard key is pressed with open arguments
			-- widget: EV_WIDGET; key: EV_KEY
		do
			Result := implementation.key_press_actions
		ensure
			not_void: Result /= Void
		end

	key_press_string_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, STRING]] is
			-- Actions to be performed when a keyboard press generates a displayable character with
			-- open arguments widget: EV_WIDGET; string: STRING
		do
			Result := implementation.key_press_string_actions
		ensure
			not_void: Result /= Void
		end

	key_release_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET, EV_KEY]] is
			-- Actions to be performed when a keyboard key is released with open arguments
			-- widget: EV_WIDGET; key: EV_KEY
		do
			Result := implementation.key_release_actions
		ensure
			not_void: Result /= Void
		end

	focus_in_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET]] is
			-- Actions to be performed when getting focus with open arguments
			-- widget: EV_WIDGET
		do
			Result := implementation.focus_in_actions
		ensure
			not_void: Result /= Void
		end

	focus_out_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET]] is
			-- Actions to be performed when losing focus with open arguments
			-- widget: EV_WIDGET
		do
			Result := implementation.focus_out_actions
		ensure
			not_void: Result /= Void
		end

indexing
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

