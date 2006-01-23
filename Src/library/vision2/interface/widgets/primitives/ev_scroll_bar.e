indexing
	description:
		"[
			Base class for interactive scrolling widgets.
			See EV_HORIZONTAL_SCROLL_BAR and EV_VERTICAL_SCROLL_BAR.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "scroll, bar, horizontal, vertical, gauge, leap, step, page"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCROLL_BAR

inherit
	EV_GAUGE
		redefine
			implementation
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_SCROLL_BAR_I;
			-- Responsible for interaction with native graphics toolkit.

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




end -- class EV_SCROLL_BAR

