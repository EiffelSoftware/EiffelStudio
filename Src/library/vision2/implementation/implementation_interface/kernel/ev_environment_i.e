indexing
	description:
		"Eiffel Vision Environment. Implementation interface.%N%
		%See ev_environment.e"
	status: "See notice at end of class"
	keywords: "environment, global, system"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ENVIRONMENT_I

inherit
	EV_ANY_I
		redefine
			interface
		end
		
feature {EV_APPLICATION_I, EV_ENVIRONMENT} -- Status report
		
	application: EV_APPLICATION is
			-- Single application object for system.
		require
			not_destroyed: not is_destroyed
		do
			Result := application_cell.item
		ensure
			Result = application_cell.item
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ENVIRONMENT
            -- Provides a common user interface to platform dependent
            -- functionality implemented by `Current'
            
feature {EV_APPLICATION_I, EV_ENVIRONMENT} -- Access

	set_application (an_application: EV_APPLICATION) is
			-- Specify `an_application' as the single application object for the
			-- system. Must be called exactly once from EV_APPLICATION's
			-- creation procedure.
		require
			not_destroyed: not is_destroyed
			application_not_already_set: application = Void
		do
			application_cell.put (an_application)
		ensure
			application_assigned: application = an_application
		end

feature {NONE} -- Implementation

	Application_cell: CELL [EV_APPLICATION] is
			-- A global cell where `item' is the single application object for
			-- the system.
		require
			not_destroyed: not is_destroyed
		once
			create Result.put (Void)
		end

feature -- Command

	destroy is
			-- Render current unusable.
		do
			is_destroyed := True
		end

end -- class EV_ENVIRONMENT_I

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

