indexing
	description: "Give some platform specific informations."
	note: "You should not use it useally. If you do, use it as a client."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PLATFORM

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Implementation

	default_create is
			-- Default creation routine.
		do
			create {EV_PLATFORM_IMP} implementation
		end

feature -- Access

	name: STRING is
			-- Name of the Current underneath library used.
			-- The result can be: "WEL" or "GTK"
		do
			Result := implementation.name
		end

feature -- Implementation

	implementation: EV_PLATFORM_I
			-- Platform specific access.

end -- class EV_PLATFORM

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
