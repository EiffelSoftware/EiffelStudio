indexing
	description: "Objects that may call `default_create'%
		%from EV_ANY."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ANY_HANDLER
	
	-- `default_create' from EV_ANY is exported to this class.
	-- This is used to stop people calling `default_create' unless
	-- they are a direct descendent of EV_ANY or inherit `Current'.
	-- An example of where this is necessary is:
	-- If you wish to use `new_instance_of' from INTERNAL, with Vision2,
	-- you need to be able to call `default_create' on the object
	-- afterwards. In this case, you just inherit from `Current'.

end -- class EV_ANY_HANDLER

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

