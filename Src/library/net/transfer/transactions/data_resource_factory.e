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

