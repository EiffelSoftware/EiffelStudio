indexing
	description: "EiffelCOM exception"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_EXCEPTION
	
inherit
	EXCEPTIONS
		rename
			eraise as ccom_raise
		redefine
			ccom_raise
		end
	
	ECOM_EXCEPTION_CODES
		export
			{NONE} all
		end
		
	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end


feature --  Access

	hresult: INTEGER is
			-- Original HRESULT.
		require
			applicable: is_developer_exception
		local
			wel_string: WEL_STRING
		do
			create wel_string.make (tag_name)
			Result := ccom_hresult (formatter, wel_string.item)
		end

	hresult_code: INTEGER is
			-- Status code.
		require
			applicable: is_developer_exception
		do
			Result := ccom_hresult_code (hresult)
		end

	hresult_facility: INTEGER is
			-- Facility code.
		require
			applicable: is_developer_exception
		do
			Result := ccom_hresult_facility (hresult)
		end
	
	hresult_message: STRING is
			-- Error message.
		require
			applicable: is_developer_exception
		local
			error_messages: WEL_WINDOWS_ERROR_MESSAGES
		do
			Result := clone (tag_name)
			Result.tail (Result.count - 10)
			Result.left_adjust
			Result.right_adjust
			
			if Result.empty then
				create error_messages
				Result := error_messages.error_messages.item (hresult_code)
			end
			if Result = Void then
				create Result.make (0)
			end
		ensure
			non_void_message: Result /= Void
		end
		
feature -- Element Change

	trigger (code: INTEGER) is
			-- Raise exception with code `code'.
			-- See class ECOM_EXCEPTION_CODES for possible values.
		do
			raise (ccom_hresult_to_string (formatter, code))
		end

feature {NONE} -- Implementation

	formatter: POINTER is
			-- Error messages formatter.
		do
			if impl_formatter = default_pointer then
				impl_formatter := ccom_initialize_formatter
			end
			Result := impl_formatter
		ensure
			valid_formatter: Result /= default_pointer
		end

	impl_formatter: POINTER
			-- Pointer holder.

	dispose is
			-- Free formatter first.
		do
			if impl_formatter /= default_pointer then
				ccom_delete_formatter (impl_formatter)
			end
		end
			
feature {NONE} -- External

	ccom_format_message (a_pointer: POINTER; code: INTEGER): STRING is
		external
			"C++ [Formatter %"ecom_exception.h%"] (EIF_INTEGER): EIF_REFERENCE"
		end

	ccom_hresult_to_string (a_pointer: POINTER; code: INTEGER): STRING is
		external
			"C++ [Formatter %"ecom_exception.h%"] (EIF_INTEGER): EIF_REFERENCE"
		end

	ccom_hresult (a_pointer: POINTER; an_exception_code: POINTER ): INTEGER is
		external
			"C++ [Formatter %"ecom_exception.h%"] (char *): EIF_INTEGER"
		end
		
	ccom_initialize_formatter: POINTER is
		external
			"C++ [new Formatter %"ecom_exception.h%"] ()"
		end

	ccom_delete_formatter (a_pointer: POINTER) is
		external
			"C++ [delete Formatter %"ecom_exception.h%"]()"
		end

	ccom_raise (a_pointer: POINTER; code: INTEGER) is
		external
			"C | %"eif_except.h%""
		alias
			"com_eraise"
		end;

	ccom_hresult_code (an_hresult: INTEGER): INTEGER is
		external
			"C [macro <winerror.h>] (HRESULT): EIF_INTEGER"
		alias
			"HRESULT_CODE"
		end
	
	ccom_hresult_facility (an_hresult: INTEGER): INTEGER is
		external
			"C [macro <winerror.h>] (HRESULT): EIF_INTEGER"
		alias
			"HRESULT_FACILITY"
		end

end -- class ECOM_EXCEPTION

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

