note
	description: "EiffelCOM exception"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_EXCEPTION

inherit
	EXCEPTIONS

	ECOM_EXCEPTION_CODES
		export
			{NONE} all
		end

	HRESULT_FORMATTER

feature --  Access

	code: INTEGER
			-- Com error code.
			-- Error code part of the `hresult'.
		do
			Result := hresult_code
		end

	message: STRING_8
			-- Message(Tag) of current exception
		do
			if {l_com_failure: COM_FAILURE} exception_manager.last_exception then
				Result := l_com_failure.message
			else
				create Result.make_empty
			end
		end

	line_number: INTEGER
			-- Line number
		do
			if {l_com_failure: COM_FAILURE} exception_manager.last_exception then
				Result := l_com_failure.line_number
			end
		end

	original: ?EXCEPTION
			-- The original exception caused current exception
		do
			if {l_com_failure: COM_FAILURE} exception_manager.last_exception then
				Result := l_com_failure.original
			end
		end

	type_name: ?STRING_8
			-- Name of the class that includes the recipient
			-- of original form of current exception
		do
			if {l_com_failure: COM_FAILURE} exception_manager.last_exception then
				Result := l_com_failure.type_name
			end
		end

	throwing_exception: ?EXCEPTION
			-- The exception throwing current exception
		do
			if {l_com_failure: COM_FAILURE} exception_manager.last_exception then
				Result := l_com_failure.throwing_exception
			end
		end

	hresult: INTEGER is
			-- Original HRESULT.
		do
			if {l_com_failure: COM_FAILURE} exception_manager.last_exception then
				Result := l_com_failure.hresult
			end
		end

	hresult_code: INTEGER is
			-- Status code.
		do
			if {l_com_failure: COM_FAILURE} exception_manager.last_exception then
				Result := l_com_failure.hresult_code
			end
		end

	hresult_facility: INTEGER is
			-- Facility code.
		do
			if {l_com_failure: COM_FAILURE} exception_manager.last_exception then
				Result := l_com_failure.hresult_facility
			end
		end

	hresult_message: STRING is
			-- Error message.
		do
			if {l_com_failure: COM_FAILURE} exception_manager.last_exception then
				Result := l_com_failure.hresult_message
			else
				create Result.make_empty
			end
		end

feature -- Element Change

	trigger (a_code: INTEGER) is
			-- Raise exception with code `a_code'.
			-- See class ECOM_EXCEPTION_CODES for possible values.
		do
			(create {COM_FAILURE}).trigger (a_code)
		end

note
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

