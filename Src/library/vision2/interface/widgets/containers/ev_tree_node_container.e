indexing
	description: 
		"Abstract class for container that hold tree nodes"
	status: "See notice at end of class"
	keywords: "container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_TREE_NODE_CONTAINER

inherit
	EV_ANY

	LINEAR [EV_TREE_NODE]
		undefine
			default_create, copy
		end

end -- class EV_TREE_NODE_CONTAINER

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

