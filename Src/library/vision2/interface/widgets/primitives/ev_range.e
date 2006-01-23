indexing 
	description:
		"[
			Interactive range widget. A sliding thumb displays the current `value'
			and allows it to be adjusted.
			See EV_HORIZONTAL_RANGE and EV_VERTICAL_RANGE.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "range, slide, adjust"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RANGE

inherit
	EV_GAUGE
		redefine
			implementation
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_RANGE_I;
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




end -- class EV_RANGE

