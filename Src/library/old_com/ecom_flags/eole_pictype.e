indexing

	description: "Pictype flags"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EOLE_PICTYPE

feature -- Access

	Pictype_uninitialized: INTEGER is
			-- Picture object is currently uninitialized.
			-- This value is valid only as a return value
			-- from get_type of EOLE_PICTURE.
		external
			"C [macro <olectl.h>]"
		alias
			"PICTYPE_UNINITIALIZED"
		end
	
	Pictype_none: INTEGER is
			-- New picture object is to be created
			-- without an initialized state.
			-- This value is valid only in the PICTDESC structure.
		external
			"C [macro <olectl.h>]"
		alias
			"PICTYPE_NONE"
		end
			
	Pictype_bitmap: INTEGER is
			-- Bitmap
		external
			"C [macro <olectl.h>]"
		alias
			"PICTYPE_BITMAP"
		end
			
	Pictype_metafile: INTEGER is
			-- Metafile
		external
			"C [macro <olectl.h>]"
		alias
			"PICTYPE_METAFILE"
		end
		
	Pictype_icon: INTEGER is
			-- Icon
		external
			"C [macro <olectl.h>]"
		alias
			"PICTYPE_ICON"
		end
		
	Pictype_enhmetafile: INTEGER is
			-- Win32-enhanced metafile
		external
			"C [macro <olectl.h>]"
		alias
			"PICTYPE_ENHMETAFILE"
		end

	is_valid_pictype (type: INTEGER): BOOLEAN is
			-- Is `type' a valid pictype?
		do
			Result := type = Pictype_uninitialized or
						type = Pictype_none or
						type = Pictype_bitmap or
						type = Pictype_metafile or
						type = Pictype_icon or
						type = Pictype_enhmetafile
		end
		
end -- class EOLE_PICTYPE

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
