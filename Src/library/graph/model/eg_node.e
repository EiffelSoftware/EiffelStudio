indexing
	description: "A model for a graph node"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_NODE

inherit
	EG_LINKABLE
		redefine
			default_create
		end
	
create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Create a EG_NODE
		do
			Precursor {EG_LINKABLE}
		end

end -- class EG_NODE

--|----------------------------------------------------------------
--| EiffelGraph: library of graph components for ISE Eiffel.
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

