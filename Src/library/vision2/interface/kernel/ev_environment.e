indexing
	description:
		"Facilities for inspecting global environment information."
	status: "See notice at end of class"
	keywords: "environment, application, global, system"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ENVIRONMENT

inherit
	EV_ANY
		redefine
			implementation,
			application_exists
		end

create
	default_create

feature -- Access

	application: EV_APPLICATION is
			-- Single application object for system.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.application
		ensure
			bridge_ok: Result = implementation.application
		end
		
feature {NONE} -- Contract support

	application_exists: BOOLEAN is
			-- Does the application exist? This is used to stop
			-- manipulation of widgets before an application is created.
			-- As we are now in the process of creating the application,
			-- we return True.
		do
			Result := True
		end
		
feature {EV_ANY_I} -- Implementation

	implementation: EV_ENVIRONMENT_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_ENVIRONMENT_IMP} implementation.make (Current)
		end

end -- class EV_ENVIRONMENT

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
