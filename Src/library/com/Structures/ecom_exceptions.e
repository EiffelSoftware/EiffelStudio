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

feature -- Element Change

	trigger (code: INTEGER) is
			-- Raise exception with code `code'.
			-- See class ECOM_EXCEPTION_CODES for possible values.
		local
			exception_text: WEL_STRING
		do
			!! exception_text.make (ccom_format_message (formatter, code))
			ccom_raise (exception_text.item, code)
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

end -- class ECOM_EXCEPTION

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

