indexing
	description: "Objects that can call `default_create'%
		%from EV_ANY."
	author: ""
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
