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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

