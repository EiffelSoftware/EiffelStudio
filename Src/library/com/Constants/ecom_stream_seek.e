indexing

	description: "IStorage and IStream Seek flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_STREAM_SEEK

feature -- Access

	Stream_seek_set: INTEGER is
			-- Sets seek position relative to
			-- beginning of stream
		external
			"C [macro <objidl.h>]"
		alias
			"STREAM_SEEK_SET"
		end
		
	Stream_seek_cur: INTEGER is
			-- Sets seek position relative to
			-- current position of stream
		external
			"C [macro <objidl.h>]"
		alias
			"STREAM_SEEK_CUR"
		end
		
	Stream_seek_end: INTEGER is
			-- Sets seek position relative to
			-- current end of stream
		external
			"C [macro <objidl.h>]"
		alias
			"STREAM_SEEK_END"
		end

	is_valid_seek (seek: INTEGER): BOOLEAN is
			-- Is `seek' a valid IStorage and IStream seek flag?
		do
			Result := seek = Stream_seek_set or
						seek = Stream_seek_cur or
						seek = Stream_seek_end
		end
		
end -- class EOLE_STREAM_SEEK

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
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

