indexing
	description: "Objects that allow insertion of a Vision2 control%
		%within a WEL system."
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

	interface: WEL_EV_CONTAINER

end -- class WEL_EV_CONTAINER_I
