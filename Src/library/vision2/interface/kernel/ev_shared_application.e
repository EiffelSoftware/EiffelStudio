indexing
	description: "Access to the vision2 application through a once feature"
	status: "See notice at end of class"
	keywords: "EV_APPLICATION, application, once, access"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SHARED_APPLICATION

feature -- Access

	ev_application: EV_APPLICATION is
			-- Current application. This once feature must be called
			-- only if the application has been created
		once
			Result := (create {EV_ENVIRONMENT}).application
		ensure
			Result_not_void: Result /= Void
		end
		
	process_events_and_idle is
			-- Call `process_events' and `idle_actions' on `ev_application'.
		do
			ev_application.process_events
			ev_application.idle_actions.call (Void)
		end

end -- class EV_SHARED_APPLICATION

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

