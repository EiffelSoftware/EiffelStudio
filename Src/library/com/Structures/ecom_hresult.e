indexing
	description: "ECOM_HRESULT"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_HRESULT

creation
	make,
	make_from_integer

feature -- Initialization

	make is
			-- Set 'severity_bit' to 1.
		do
			severity_bit := 1
		end

	make_from_integer (an_integer: INTEGER) is
			-- Initialize hresult according to 'an_integer'.
		do
			set_item (an_integer)
		end

feature -- Access
	
	item: INTEGER
			-- HRESULT

	facility_code: INTEGER is
			-- Facility code
		do
			Result := cwin_hresult_facility_code (item)
		end

	error_code: INTEGER is
			-- Error code
		do
			Result := cwin_hresult_error_code (item)
		end

feature -- Element change

	set_item (an_item: like item) is
			-- Set value of item to 'an_item'
		do
			item := an_item;
			if an_item >= 0 then
				severity_bit := 0
			else
				severity_bit := 1
			end
		ensure
			item_set: item = an_item
		end
	
	set_succeeded is
			-- Set severity bit to indicate succeeded 
		do
			severity_bit := 0;
			item := (cwin_hresult_make_hresult (severity_bit, facility_code, error_code))
		ensure
			severity_bit_set: severity_bit = 0
		end

	set_failed is
			-- Set severity bit to indicate failure
		do
			severity_bit := 1;
			item := cwin_hresult_make_hresult (severity_bit, facility_code, error_code)
		ensure
			severity_bit_set: severity_bit = 1
		end

	set_facility_code (a_code: like facility_code) is
			-- Set facility code
		require
			valid_facility_code: a_code >= 0
		do
			item := cwin_hresult_make_hresult (severity_bit, a_code, error_code)
		ensure
			facility_code_set: facility_code = a_code
		end

	set_error_code (a_code: like error_code) is
			-- Set error code
		require
			valid_error_code: a_code >= 0
		do
			item := cwin_hresult_make_hresult (severity_bit, facility_code, a_code)
		ensure
			facility_code_set: error_code = a_code
		end


feature -- Status report

	succeeded: BOOLEAN is
			-- Does hresult correspond to success?
		do
			Result := (severity_bit = 0)
		end

	severity_bit: INTEGER

feature {NONE} -- Implementation

	cwin_hresult_make_hresult (tmp_sev, a_facility_code, an_error_code: INTEGER): INTEGER is
		external
			"C [macro <winerror.h>](EIF_INTEGER, EIF_INTEGER, EIF_INTEGER):EIF_INTEGER"
		alias
			"MAKE_HRESULT"
		end

	cwin_hresult_error_code (an_item: INTEGER): INTEGER is
		external
			"C [macro <winerror.h>](EIF_INTEGER):EIF_INTEGER"
		alias
			"HRESULT_CODE"
		end

	cwin_hresult_facility_code (an_item: INTEGER) : INTEGER is
		external
			"C [macro <winerror.h>](EIF_INTEGER):EIF_INTEGER"
		alias
			"HRESULT_FACILITY"
		end

	cwin_hresult_succeeded (an_item : POINTER):BOOLEAN is
		external
			"C [macro <winerror.h>](EIF_POINTER):EIF_BOOLEAN"
		alias
			"SUCCEEDED"
		end
	
invariant
	valid_severity_value: severity_bit = 0 or severity_bit = 1		

end

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
