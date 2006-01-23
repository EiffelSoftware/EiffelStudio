indexing
	description:
		"Action sequences for EV_GRID_ITEM."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble is dropped here.
		do
			Result := implementation.drop_actions
		ensure
			not_void: Result /= Void
		end

	activate_actions: ACTION_SEQUENCE [TUPLE [EV_POPUP_WINDOW]] is
			-- Actions to be performed to override the default `activate' setup of `Current', see {EV_GRID_EDITABLE_ITEM}.activate_action.
			-- Useful for repositioning `popup_window', which will then be shown automatically by the grid.
			-- Arguments of TUPLE (with name for clarity):
			--
			-- popup_window: EV_POPUP_WINDOW -- The popup window used to interactively edit `activate_item', window has already been sized and positioned.
		do
			Result := implementation.activate_actions
		ensure
			result_not_void: Result /= Void
		end

	deactivate_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `Current' has been deactivated.
		do
			Result := implementation.deactivate_actions
		ensure
			result_not_void: Result /= Void
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

