indexing
	description:
		"Singleton instance of the comparator builder"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	COMPARATOR_BUILDER

feature -- Access

	Comparator_builder: COMPARATOR_BUILDER_IMPL is
			-- Comparator builder singleton
		once
			create Result.make
		end

end -- class COMPARATOR_BUILDER


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

