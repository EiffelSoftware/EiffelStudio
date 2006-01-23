indexing
	description: 
		"Eiffel Vision deselectable. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "deselect, deselectable, selectable, select"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DESELECTABLE_I

inherit
	EV_SELECTABLE_I
		redefine
			interface
		end
	
feature -- Status setting

	disable_select is
			-- Deselect the object.
		require
			is_selectable: is_selectable
		deferred
		ensure
			deselected: not is_selected
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_DESELECTABLE;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

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




end -- class EV_DESELECTABLE_I

