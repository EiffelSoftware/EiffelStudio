indexing
	description: "Objects that may call `default_create'%
		%from EV_ANY."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end -- class EV_ANY_HANDLER

