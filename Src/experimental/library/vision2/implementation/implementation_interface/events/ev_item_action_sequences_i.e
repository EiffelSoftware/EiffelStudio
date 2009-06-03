note
	description:
		"Action sequences for EV_ITEM_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_ITEM_ACTION_SEQUENCES_I


feature -- Event handling

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
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

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Create a pointer_motion action sequence.
		deferred
		end

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_motion_actions'.


feature -- Event handling

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
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

	create_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Create a pointer_button_press action sequence.
		deferred
		end

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_button_press_actions'.


feature -- Event handling

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
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

	create_pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Create a pointer_double_press action sequence.
		deferred
		end

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE;
			-- Implementation of once per object `pointer_double_press_actions'.

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

