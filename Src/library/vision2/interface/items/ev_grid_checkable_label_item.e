indexing
	description: "[
		The Cell is similar to EV_GRID_LABEL_ITEM, except it has a checkbox [x]
		See description of EV_GRID_LABEL_ITEM for more details
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_CHECKABLE_LABEL_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			implementation, create_implementation
		end

create
	default_create,
	make_with_text

feature -- Access

	is_checked: BOOLEAN is
			-- Is checkbox checked ?
		do
			Result := implementation.is_checked
		end

feature -- Change

	toggle_is_checked is
			-- Toggel checkbox status
		do
			implementation.toggle_is_checked
		end

	set_is_checked (b: BOOLEAN) is
			-- Set checkbox status
		do
			if is_checked /= b then
				implementation.set_is_checked (b)
			end
		end

feature -- Status

	is_sensitive: BOOLEAN is
			-- Is current sensitive ?
		do
			Result := implementation.is_sensitive
		end

feature -- Status setting

	enable_sensitive is
			-- Make object sensitive to user input
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_sensitive
		ensure
			is_sensitive: (parent = Void or parent.is_sensitive) implies is_sensitive
		end

	disable_sensitive is
			-- Make object non-sensitive to user input
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_sensitive
		ensure
			is_unsensitive: not is_sensitive
		end

feature -- Actions

	checked_changed_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [like Current]] is
			-- Actions called when checkbox value changed.
		do
			Result := implementation.checked_changed_actions
		end

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_CHECKABLE_LABEL_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_CHECKABLE_LABEL_ITEM_I} implementation.make (Current)
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
