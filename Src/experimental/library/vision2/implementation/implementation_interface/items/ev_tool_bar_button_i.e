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

	gray_pixmap: detachable EV_PIXMAP
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
				if
					is_sensitive and then
					attached application_implementation.pick_and_drop_source as l_pnd_source and then
					attached l_pnd_source.pebble as l_pebble and then
					not attached_interface.drop_actions.accepts_pebble (l_pebble)
				then
					enabled_before := True
					disable_sensitive
				end
			else
				if enabled_before then
					enabled_before := False
					enable_sensitive
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

	parent_is_sensitive: BOOLEAN
			-- Is `parent' sensitive?
		deferred
		end

	has_parent: BOOLEAN
			-- Is `Current' parented?
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_BUTTON note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_TOOL_BAR_BUTTON_I










