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

end -- class EV_SHARED_APPLICATION

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
