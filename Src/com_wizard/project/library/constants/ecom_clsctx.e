indexing

	description: "COM component instantiation context constants"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	ECOM_CLSCTX

feature -- Access

	Clsctx_inproc_server: INTEGER is
			-- The code that creates and manages objects of 
			-- descendant class runs in the same process as the 
			-- caller of the function specifying the class context. 
		external
			"C [macro <wtypes.h>]"
		alias
			"CLSCTX_INPROC_SERVER"
		end
		
	Clsctx_inproc_handler: INTEGER is
			-- The code that manages objects of descendant class
			-- is an in-process handler. This is a DLL that runs 
			-- in the client process and implements client-side 
			-- structures of this class when instances of the 
			-- class are accessed remotely. 
		external
			"C [macro <wtypes.h>]"
		alias
			"CLSCTX_INPROC_SERVER"
		end			
		
	Clsctx_local_server: INTEGER is
			-- The EXE code that creates and manages objects of
			-- descendant class is loaded in a separate process space
			-- (runs on same machine but in a different process).
		external
			"C [macro <wtypes.h>]"
		alias
			"CLSCTX_LOCAL_SERVER"
		end
		
	Clsctx_server: INTEGER is
			-- Indicates server code, whether in-process or local.
		external
			"C [macro <objbase.h>]"
		alias
			"CLSCTX_SERVER"
		end
		
	Clsctx_all: INTEGER is
			-- Indicates all class contexts.
		external
			"C [macro <objbase.h>]"
		alias
			"CLSCTX_ALL"
		end
		
	is_valid_clsctx (context: INTEGER): BOOLEAN is
			-- Is `context' a valid class context?
		do
			Result := context = Clsctx_inproc_server or
						context = Clsctx_inproc_handler or
						context = Clsctx_local_server or
						context = Clsctx_server or
						context = Clsctx_all
		end

end -- class EOLE_CLSCTX

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1998-1999 Interactive Software Engineering Inc.
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

