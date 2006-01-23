indexing
	description: "Objects that allow insertion of a Vision2 control%
		%within a WEL system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_EV_CONTAINER_I
	
inherit
	EV_CELL_I
		redefine
			interface
		end

feature {WEL_EV_CONTAINER} -- Initialization

	set_real_parent (a_parent: WEL_WINDOW; x_pos, y_pos, a_width, a_height: INTEGER) is
			-- Actually target `Current' to `a_parent' and set x_position to `x_pos',
			-- y_position to `y_pos', width to `a_width' and height to `a_height'.
		deferred
		end
		

feature -- Access

	implementation_window: WEL_WINDOW is
			-- Window containing `item'.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: WEL_EV_CONTAINER;

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




end -- class WEL_EV_CONTAINER_I

