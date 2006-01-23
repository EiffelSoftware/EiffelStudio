indexing
	description: "EiffelCOM exception"
	legal: "See notice at end of class."
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
		
	HRESULT_FORMATTER

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
			Result := tag_name.twin
			Result.remove_head (10)
			Result.left_adjust
			Result.right_adjust
			
			if Result.is_empty then
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

			
feature {NONE} -- External

	ccom_hresult_to_string (a_pointer: POINTER; code: INTEGER): STRING is
		external
			"C++ [Formatter %"ecom_exception.h%"] (EIF_INTEGER): EIF_REFERENCE"
		end

	ccom_hresult (a_pointer: POINTER; an_exception_code: POINTER ): INTEGER is
		external
			"C++ [Formatter %"ecom_exception.h%"] (char *): EIF_INTEGER"
		end

	ccom_raise (a_pointer: POINTER; code: INTEGER) is
		external
			"C signature (char *, long) use %"eif_except.h%""
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




end -- class ECOM_EXCEPTION

