indexing
	description:
		"Constants for resource errors"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	DATA_RESOURCE_ERROR_CONSTANTS

feature {NONE} -- Constants

	File_not_found: INTEGER is 1

	Write_error: INTEGER is 2
	
	Connection_refused: INTEGER is 3
	
	No_such_user: INTEGER is 4

	Access_denied: INTEGER is 5

	Wrong_command: INTEGER is 6

	Permission_denied: INTEGER is 7

	Transfer_failed: INTEGER is 8
	
	Transmission_error: INTEGER is 9
	
	Connection_timeout: INTEGER is 10
	
feature -- Status report

	error_text (code: INTEGER): STRING is
			-- Textual description of error
		require
			positive_code: code > 0
		do
			inspect
				code
			when File_not_found then
				Result := "File not found"
			when Write_error then
				Result := "Write error"
			when Connection_refused then
				Result := "Connection refused"
			when No_such_user then
				Result := "No such user"
			when Access_denied then
				Result := "Access denied"
			when Wrong_command then
				Result := "Wrong command"
			when Permission_denied then
				Result := "Permission denied"
			when Transfer_failed then
				Result := "Transfer failed"
			when Transmission_error then
				Result := "Transmission error"
			when Connection_timeout then
				Result := "Connection timeout"
			end
		end

end -- class DATA_RESOURCE_ERROR_CONSTANTS

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
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

