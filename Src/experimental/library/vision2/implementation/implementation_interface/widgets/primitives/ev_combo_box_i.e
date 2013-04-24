note
	description: "EiffelVision Combo-box. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COMBO_BOX_I

inherit
	EV_TEXT_FIELD_I
		redefine
			interface
		end

	EV_LIST_ITEM_LIST_I
		redefine
			interface
		end

	EV_COMBO_BOX_ACTION_SEQUENCES_I

feature -- Status report

	is_list_shown: BOOLEAN
			-- Is drop down list currently shown?
		deferred
		end

feature -- Access

	list_height_hint: INTEGER
			-- Suggested height of list in pixels which may or may not be used by the underlying platform.
			-- By default it is -1 and the actual height is dependent on the underlying platform.

	list_width_hint: INTEGER
			-- Suggested width of list in pixels which may or may not be used by the underlying platform.
			-- By default it is -1 and the actual width is dependent on the underlying platform.

feature -- Settings

	set_list_height_hint (v: like list_height_hint)
			-- Set `list_height_hint' with `v'.
		require
			not_destroyed: not is_destroyed
		do
			list_height_hint := v
		ensure
			list_height_hint_set: list_height_hint = v
		end

	set_list_width_hint (v: like list_width_hint)
			-- Set `list_width_hint' with `v'.
		require
			not_destroyed: not is_destroyed
		do
			list_width_hint := v
		ensure
			list_width_hint_set: list_width_hint = v
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_COMBO_BOX note option: stable attribute end;

feature {NONE} -- Initialization

	initialize_hints
			-- Set default values for various hints.
		do
			list_height_hint := -1
			list_width_hint := -1
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
