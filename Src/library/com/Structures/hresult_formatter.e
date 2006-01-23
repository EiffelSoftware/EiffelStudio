indexing
	description: "HRESULT_FORMATTER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end -- HRESULT_FORMATTER

