indexing

	description: "Facility codes"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"
	
class
	EOLE_FACILITY_CODE
	
feature -- Access

	Facility_null: INTEGER is
			-- General result
		external
			"C [macro <winerror.h>]"
		alias
			"FACILITY_NULL"
		end
		
	Facility_rpc: INTEGER is
			-- Remote-procedure call result
		external
			"C [macro <winerror.h>]"
		alias
			"FACILITY_RPC"
		end
		
	Facility_dispatch: INTEGER is
			-- Dispatch result
		external
			"C [macro <winerror.h>]"
		alias
			"FACILITY_DISPATCH"
		end
		
	Facility_itf: INTEGER is
			-- Interface/API specific result
		external
			"C [macro <winerror.h>]"
		alias
			"FACILITY_ITF"
		end

	Facility_win32: INTEGER is
			-- Win32 GetLastError result
		external
			"C [macro <winerror.h>]"
		alias
			"FACILITY_WIN32"
		end
		
	Facility_control: INTEGER is
			-- OLE control result
		external
			"C [macro <winerror.h>]"
		alias
			"FACILITY_CONTROL"
		end
		
	Facility_windows: INTEGER is
			-- Microsoft defined interface result
		external
			"C [macro <winerror.h>]"
		alias
			"FACILITY_WINDOWS"
		end

	is_valid_facility (facility: INTEGER): BOOLEAN is
			-- Is `facility' a valid facility code?
		do
			Result := facility = Facility_null or
					facility = Facility_rpc or
					facility = Facility_dispatch or
					facility = Facility_itf or
					facility = Facility_dispatch or
					facility = Facility_win32 or
					facility = Facility_control or
					facility = Facility_windows
		end
end
	
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
