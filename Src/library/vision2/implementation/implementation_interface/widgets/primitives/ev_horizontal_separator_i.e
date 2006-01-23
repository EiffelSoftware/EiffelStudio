indexing 
	description:
		"Eiffel Vision horizontal separator. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_HORIZONTAL_SEPARATOR_I

inherit
	EV_SEPARATOR_I
		redefine
			interface
		end

feature {NONE} -- Initialization

	interface: EV_HORIZONTAL_SEPARATOR;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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




end -- class EV_HORIZONTAL_SEPARATOR_I

