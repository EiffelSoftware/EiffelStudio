indexing

	description: "BINDFLAGS flags"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EOLE_BIND_OPTIONS_FLAGS

feature -- Access

	Bindflags_maybotheruser: INTEGER is
			-- If present, this sort of interaction is permitted.
			-- If not present, the operation to which the bind context
			-- containing this parameter is applied should not interact
			-- with the user in any way, such as by asking for a 
			-- password for a network volume that needs mounting.
		external
			"C [macro <objidl.h>]"
		alias
			"BINDFLAGS_MAYBOTHERUSER"
		end
		
	Bind_justtestexistence: INTEGER is
			-- If present, this value indicates that the caller of
			-- the moniker operation to which this flag is being
			-- applied is not actually interested in having the
			-- operation carried out, but only in learning whether the
			-- operation could have been carried out had this flag not
			-- been specified.
		external
			"C [macro <objidl.h>]"
		alias
			"BIND_JUSTTESTEXISTENCE"
		end

	is_valid_bind_options_flag (flag: INTEGER): BOOLEAN is
			-- Is `flag' a valid BINDFLAGS flag?
		do
			Result := c_and (Bindflags_maybotheruser + Bind_justtestexistence
							, flag)
						= Bindflags_maybotheruser + Bind_justtestexistence
		end
		
end -- class EOLE_BIND_OPTIONS_FLAGS

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

