indexing
	description:
		"Executable components"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	RUNNABLE

feature -- Status report

	is_enabled: BOOLEAN is
			-- Is component enabled?
	 	deferred
		end
		
	is_ready: BOOLEAN is
	 		-- Is component ready to be executed?
		deferred
		end
	
feature -- Basic operations

	execute is
			-- Execute component.
		require
			enabled: is_enabled
			ready: is_ready
		deferred
		end

end -- class RUNNABLE

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
