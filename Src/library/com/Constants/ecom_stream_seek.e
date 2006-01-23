indexing

	description: "IStorage and IStream Seek flags"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EOLE_STREAM_SEEK

