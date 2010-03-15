note
	description:
		"[
			Base class for bar graph gauges that display progress of a process.
			See EV_HORIZONTAL_PROGRESS_BAR and EV_VERTICAL_PROGRESS_BAR
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "status, progress, bar"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR

inherit
	EV_GAUGE
		redefine
			implementation,
			is_in_default_state,
			is_in_default_state_for_tabs
		end

feature -- Status report

	is_segmented: BOOLEAN
			-- Is display segmented?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_segmented
		ensure
			bridge_ok: Result = implementation.is_segmented
		end

feature -- Status setting

	enable_segmentation
			-- Divide display of bar into segments.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_segmentation
		ensure
			is_segmented: is_segmented
		end

	disable_segmentation
			-- Display continuous bar.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_segmentation
		ensure
			not_is_segmented: not is_segmented
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_GAUGE} and is_segmented
		end

	is_in_default_state_for_tabs: BOOLEAN
		do
			Result := not is_tabable_from and not is_tabable_to
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_PROGRESS_BAR_I;
			-- Responsible for interaction with native graphics toolkit.

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




end -- class EV_PROGRESS_BAR

