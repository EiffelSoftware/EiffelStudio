note
	description:
		"Constants for resource errors"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_RESOURCE_ERROR_CONSTANTS

feature {NONE} -- Constants

	File_not_found: INTEGER = 1

	Write_error: INTEGER = 2

	Connection_refused: INTEGER = 3

	No_such_user: INTEGER = 4

	Access_denied: INTEGER = 5

	Wrong_command: INTEGER = 6

	Permission_denied: INTEGER = 7

	Transfer_failed: INTEGER = 8

	Transmission_error: INTEGER = 9

	Connection_timeout: INTEGER = 10

	No_socket_to_connect: INTEGER = 11

	Read_error: INTEGER = 12

feature -- Status report

	error_text (code: INTEGER): STRING
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
			when No_socket_to_connect then
				Result := "No socket available"
			when Read_error then
				Result := "Read error"
			else
				Result := {STRING} "Unknown error code " + code.out
			end
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DATA_RESOURCE_ERROR_CONSTANTS

