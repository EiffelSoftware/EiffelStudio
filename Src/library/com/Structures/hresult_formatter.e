indexing
	description: "HRESULT_FORMATTER"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	HRESULT_FORMATTER

inherit
	DISPOSABLE

create


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
			
feature {NONE} -- Externals

	ccom_format_message (a_pointer: POINTER; code: INTEGER): STRING is
		external
			"C++ [Formatter %"ecom_exception.h%"] (EIF_INTEGER): EIF_REFERENCE"
		end

	ccom_initialize_formatter: POINTER is
		external
			"C++ [new Formatter %"ecom_exception.h%"] ()"
		end

	ccom_delete_formatter (a_pointer: POINTER) is
		external
			"C++ [delete Formatter %"ecom_exception.h%"]()"
		end

end -- HRESULT_FORMATTER

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

