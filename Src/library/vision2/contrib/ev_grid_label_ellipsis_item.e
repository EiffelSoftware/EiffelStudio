note
	description: "[
		The Cell is similar to EV_GRID_LABEL_ITEM, except it has ellipsis on the right
		See description of EV_GRID_LABEL_ITEM for more details
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_LABEL_ELLIPSIS_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			create_interface_objects, initialize,
			implementation, create_implementation, computed_initial_grid_label_item_layout
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	create_interface_objects
		do
			create ellipsis_actions
			Precursor
		end

	initialize
		do
			Precursor
			pointer_button_press_actions.extend (agent implementation.on_pointer_button_pressed)
		end

feature -- Actions

	ellipsis_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called if the ellipsis button is pressed.	

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_LABEL_ELLIPSIS_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_LABEL_ELLIPSIS_ITEM_I} implementation.make
		end

feature {EV_GRID_LABEL_ITEM_I} -- Implementation

	computed_initial_grid_label_item_layout (a_width, a_height: INTEGER_32): EV_GRID_LABEL_ITEM_LAYOUT
		do
			Result := Precursor (a_width, a_height)
				-- Shrink the area available for text by the total width
				-- occupied by the ellipsis.
			Result.set_available_text_width ((Result.available_text_width - implementation.ellipsis_width - spacing).max (0))
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
