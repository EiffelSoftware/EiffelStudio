indexing
	description:
		"Singleton instance of resource factory"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	DATA_RESOURCE_FACTORY

feature -- Access

	Resource_factory: DATA_RESOURCE_FACTORY_IMPL is
			-- Singleton of resource factory
		once
			create Result.make
		end

end -- class DATA_RESOURCE_FACTORY

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
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

