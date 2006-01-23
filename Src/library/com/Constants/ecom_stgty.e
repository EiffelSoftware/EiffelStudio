indexing

	description: "SToraGe TYpe flags"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_STGTY

feature -- Access

	Stgty_storage: INTEGER is
			-- Storage object
		external
			"C [macro <objidl.h>]"
		alias
			"STGTY_STORAGE"
		end
		
	Stgty_stream: INTEGER is
			-- Stream object
		external
			"C [macro <objidl.h>]"
		alias
			"STGTY_STREAM"
		end
		
	Stgty_lockbytes: INTEGER is
			-- Byte array object
		external
			"C [macro <objidl.h>]"
		alias
			"STGTY_LOCKBYTES"
		end

	is_valid_stgty (stgty: INTEGER): BOOLEAN is
			-- Is `stgty' a valid storage type flag?
		do
			Result := stgty = Stgty_storage or
						stgty = Stgty_stream or
						stgty = Stgty_lockbytes
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




end -- class EOLE_STGTY

