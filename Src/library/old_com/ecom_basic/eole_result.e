indexing

	description: "OLE function result handling"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"
	
class
	EOLE_RESULT

inherit
	EOLE_FACILITY_CODE
	
feature -- Access

	succeeded: BOOLEAN is
			-- Was last OLE operation successful?
		do
			Result := ole2_error_succeeded
		end
	
	last_hresult: INTEGER is
			-- Last OLE return value
		do
			Result := ole2_error_last_hresult
		end
		
	last_error_code: INTEGER is
			-- Last error code
		do
			Result := ole2_error_last_error_code
		end
		
	last_facility_code: INTEGER is
			-- Origin of last error
		do
			Result := ole2_error_last_facility_code
		ensure
			valid_facility_code: is_valid_facility (Result)
		end
		
	user_hresult: INTEGER is
			-- User defined hresult defined with
			-- severity code, error code and
			-- facility code.
		do
			Result := ole2_error_user_hresult
		end
			
feature -- Element change

	set_error_code (code: INTEGER) is
			-- Set user error code to compute
			-- user hresult.
		do
			ole2_error_set_error_code (code)
		end
		
	set_error_facility (facility: INTEGER) is
			-- Set user error facility to compute
			-- user hresult.
		require
			valid_facility: is_valid_facility (facility)
		do
			ole2_error_set_error_facility (facility)
		end

	set_error_severity (success: BOOLEAN) is
			-- Set user error success to compute
			-- user hresult
		do
				ole2_error_set_error_success (success)
		end

	set_last_hresult (hresult: INTEGER) is
			-- Set last OLE result with `hresult'
		do
			ole2_error_set_last_hresult (hresult)
		end
		
feature {NONE} -- Externals

	ole2_error_succeeded: BOOLEAN is
		external
			"C"
		alias
			"eole2_error_succeeded"
		end
		
	ole2_error_last_hresult: INTEGER is
		external
			"C"
		alias
			"eole2_error_last_hresult"
		end
		
	ole2_error_last_error_code: INTEGER is
		external
			"C"
		alias
			"eole2_error_last_error_code"
		end

	ole2_error_last_facility_code: INTEGER is
		external
			"C"
		alias
			"eole2_error_last_facility_code"
		end
		
	ole2_error_user_hresult: INTEGER is
		external
			"C"
		alias
			"eole2_error_user_hresult"
		end

	ole2_error_set_error_code (code: INTEGER) is
		external
			"C"
		alias
			"eole2_error_set_error_code"
		end
		
	ole2_error_set_last_hresult (hresult: INTEGER) is
		external
			"C"
		alias
			"eole2_error_set_last_hresult"
		end
		
	ole2_error_set_error_facility (facility: INTEGER) is
		external
			"C"
		alias
			"eole2_error_set_error_facility"
		end
		
	ole2_error_set_error_success (success: BOOLEAN) is
		external
			"C"
		alias
			"eole2_error_set_result_severity"
		end

end -- class EOLE_RESULT

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
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


