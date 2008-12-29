note
	description:
		" EiffelVision Toolbar button, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_BUTTON_I

inherit
	EV_ITEM_I
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	EV_SENSITIVE_I
		redefine
			interface
		end

	EV_DOCKABLE_SOURCE_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES_I

feature -- Access

	gray_pixmap: EV_PIXMAP
			-- Image displayed on `Current'.
		deferred
		end

feature -- Element change

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP)
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		require
			gray_pixmap_not_void: a_gray_pixmap /= Void
		deferred
		end

	remove_gray_pixmap
			-- Make `pixmap' `Void'.
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do

			if starting then
				if not interface.drop_actions.accepts_pebble (application_implementation.pick_and_drop_source.pebble) then
					enabled_before := is_sensitive
					disable_sensitive_internal
				end
			else
				if enabled_before then
					enable_sensitive_internal
				end
			end
		end

	is_sensitive: BOOLEAN
			-- Is `Current' sensitive?
		deferred
		end

feature {NONE} -- Implementation

	enabled_before: BOOLEAN
		-- Was `Current' enabled before `update_for_pick_and_drop' modified
		-- the current state.

	enable_sensitive
			 -- Enable `Current'.
		deferred
		end

	disable_sensitive
			 -- Disable `Current'.
		deferred
		end

	enable_sensitive_internal
			 -- Enable `Current'.
			 -- This is a special version used internally by the code that updates
			 -- the pick and drop so that `enabled_before' is not updated. In
			 -- `enable_sensitive' which is called by a user, we must always updated the
			 -- state of `enabled_before' so that if it is called during a pick and drop,
			 -- this new state is respected at the end of the transport.
		deferred
		end

	disable_sensitive_internal
			 -- Disable `Current'.
			 -- This is a special version used internally by the code that updates
			 -- the pick and drop so that `enabled_before' is not updated. In
			 -- `disable_sensitive' which is called by a user, we must always updated the
			 -- state of `enabled_before' so that if it is called during a pick and drop,
			 -- this new state is respected at the end of the transport.
		deferred
		end

	parent_is_sensitive: BOOLEAN
			-- Is `parent' sensitive?
		deferred
		end

	has_parent: BOOLEAN
			-- Is `Current' parented?
		deferred
		end

	interface: EV_TOOL_BAR_BUTTON;

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




end -- class EV_TOOL_BAR_BUTTON_I

