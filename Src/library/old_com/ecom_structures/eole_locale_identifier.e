indexing

	description: "Locale Identifier creation and access"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_LOCALE_IDENTIFIER

creation
	make
	
feature -- Initialization

	make (lang, sublang: INTEGER) is
			-- Create locale identifier with language `lang' and
			-- sublanguage `sublang'.
		do
			value := ole2_locale_identifier_create (lang, sublang)
		end
		
feature -- access

	value: INTEGER
			-- Current locale identifier value
			
feature {NONE} -- Externals

	ole2_locale_identifier_create (lang, sublang: INTEGER) is
		external
			"C [macro <Winnt.h>] (USHORT, USHORT): ULONG"
		alias
			"MAKELANGID"
		end
		
end -- class EOLE_LOCALE_IDENTIFIER

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
