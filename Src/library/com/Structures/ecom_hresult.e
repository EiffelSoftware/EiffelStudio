indexing
	description: "ECOM_HRESULT"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_HRESULT

inherit
	HRESULT_FORMATTER

creation
	make,
	make_from_integer

feature -- Initialization

	make is
			-- Set 'severity_bit' to 1.
		do
			item := 0
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

	severity_bit: INTEGER is
			-- Severity bit
		do
			Result := cwin_hresult_severity_bit (item)
		end

	message: STRING is
			-- Human-readable string.
		local
			error_messages: WEL_WINDOWS_ERROR_MESSAGES
		do
			Result := ccom_format_message (formatter, item)
			Result.tail (Result.count - 10)
			Result.left_adjust
			Result.right_adjust
			
			if Result.is_empty then
				create error_messages
				Result := error_messages.error_messages.item (error_code)
			end
			if Result = Void then
				create Result.make (0)
			end
		ensure
			non_void_message: Result /= Void
		end
		
feature -- Element change

	set_item (an_item: like item) is
			-- Set value of item to 'an_item'
		do
			item := an_item;
		ensure
			item_set: item = an_item
		end
	
	set_succeeded is
			-- Set severity bit to indicate succeeded 
		do
			item := (cwin_hresult_make_hresult (0, facility_code, error_code))
		end

	set_failed is
			-- Set severity bit to indicate failure
		do
			item := cwin_hresult_make_hresult (1, facility_code, error_code)
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
			
feature {NONE} -- Externals

	cwin_hresult_make_hresult (tmp_sev, a_facility_code, an_error_code: INTEGER): INTEGER is
		external
			"C [macro <winerror.h>](EIF_INTEGER, EIF_INTEGER, EIF_INTEGER):EIF_INTEGER"
		alias
			"MAKE_HRESULT"
		end

	cwin_hresult_severity_bit (an_item: INTEGER): INTEGER is
		external
			"C [macro <winerror.h>](EIF_INTEGER):EIF_INTEGER"
		alias
			"HRESULT_SEVERITY"
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
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
