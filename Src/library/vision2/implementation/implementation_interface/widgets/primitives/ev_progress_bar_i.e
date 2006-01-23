indexing 
	description: "Eiffel Vision progress bar. Implementation interface."
	legal: "See notice at end of class." 
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_I

inherit
	EV_GAUGE_I

feature -- Status report

	is_segmented: BOOLEAN is
			-- Is display segmented?
		deferred
		end

feature -- Status setting

	enable_segmentation is
			-- Display bar divided into segments.
		deferred
		ensure
			is_segmented: is_segmented
		end

	disable_segmentation is
			-- Display bar without segments.
		deferred
		ensure
			not_is_segmented: not is_segmented
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




end -- class EV_PROGRESSBAR_I

