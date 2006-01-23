indexing
	description:
		"Action sequences for EV_GRID_ITEM_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
				create pointer_motion_actions_internal
			end
			Result := pointer_motion_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_motion_actions'.


feature -- Event handling

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer button is pressed.
		do
			if pointer_button_press_actions_internal = Void then
				create pointer_button_press_actions_internal
			end
			Result := pointer_button_press_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_button_press_actions'.


feature -- Event handling

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer is double clicked.
		do
			if pointer_double_press_actions_internal = Void then
				create pointer_double_press_actions_internal
			end
			Result := pointer_double_press_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_double_press_actions'.


feature -- Event handling

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer button is released.
		do
			if pointer_button_release_actions_internal = Void then
				create pointer_button_release_actions_internal
			end
			Result := pointer_button_release_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pointer_button_release_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_button_release_actions'.


feature -- Event handling

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer enters widget.
		do
			if pointer_enter_actions_internal = Void then
				create pointer_enter_actions_internal
			end
			Result := pointer_enter_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pointer_enter_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_enter_actions'.

feature -- Event handling

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer leaves widget.
		do
			if pointer_leave_actions_internal = Void then
				create pointer_leave_actions_internal
			end
			Result := pointer_leave_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	pointer_leave_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_leave_actions'.

feature -- Event handling

	select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when an item is selected.
		do
			if select_actions_internal = Void then
				create select_actions_internal
			end
			Result := select_actions_internal
		ensure
			result_not_void: Result /= Void
		end
		
	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when an item is deselected.
		do
			if deselect_actions_internal = Void then
				create deselect_actions_internal
			end
			Result := deselect_actions_internal
		ensure
			result_not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	select_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `select_actions'.

	deselect_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `deselect_actions'.

feature -- Event handling

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble is dropped here.
		do
			if drop_actions_internal = Void then
				create drop_actions_internal
			end
			Result := drop_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	drop_actions_internal: EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `drop_actions'.

feature -- Event handling

	activate_actions: ACTION_SEQUENCE [TUPLE [EV_POPUP_WINDOW]] is
			-- Actions to be performed to setup `Current' for activation.
			-- Overrides default setup of activatable items.
			-- Arguments of TUPLE (with names for clarity):
			--
			-- popup_window: EV_WINDOW -- The popup window used to interactively edit `activate_item', window has already been sized and positioned.
		do
			if activate_actions_internal = Void then
				create activate_actions_internal
			end
			Result := activate_actions_internal
		end

feature {EV_ANY_I} -- Implementation

	activate_actions_internal: ACTION_SEQUENCE [TUPLE [EV_POPUP_WINDOW]]
			-- Implementation of once per object `activate_actions'.

feature -- Event handling

	deactivate_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `Current' is deactivated.
		do
			if deactivate_actions_internal = Void then
				create deactivate_actions_internal
			end
			Result := deactivate_actions_internal
		ensure
			result_not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	deactivate_actions_internal: EV_NOTIFY_ACTION_SEQUENCE;
			-- Implementation of once per object `deactivate_actions'.

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

