note
	description: "[
					Object that to export update_for_pick_and_drop feature
					which is in implementation.
																			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_DRAWING_AREA

inherit
	EV_DRAWING_AREA
		redefine
			create_implementation,
			enable_capture,
			disable_capture
		end

feature -- Command

	enable_capture
			-- <Precursor>
		do
			internal_shared.setter.before_enable_capture
			Precursor {EV_DRAWING_AREA}
		end

	disable_capture
			-- <Precursor>
		do
			Precursor {EV_DRAWING_AREA}
			internal_shared.setter.after_disable_capture
		end

feature {EV_ANY_I} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {SD_DRAWING_AREA_IMP} implementation.make
		end

	update_for_pick_and_drop (a_starting: BOOLEAN; a_pebble: ANY)
			-- Update for pick and drop.
		require
			not_void: a_starting implies a_pebble /= Void
		do
		end

feature {NONE} -- Implementation

	internal_shared: SD_SHARED
			-- Shared singletons

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
