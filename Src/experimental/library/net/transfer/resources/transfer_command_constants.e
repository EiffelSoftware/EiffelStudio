note
	description:
		"Constants for server commands"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TRANSFER_COMMAND_CONSTANTS

feature {NONE} -- Constants for FTP

	Ftp_user_command: STRING = "USER"

	Ftp_password_command: STRING = "PASS"

	Ftp_text_mode_command: STRING = "TYPE A"

	Ftp_binary_mode_command: STRING = "TYPE I"

	Ftp_port_command: STRING = "PORT"

	Ftp_passive_mode_command: STRING = "PASV"

	Ftp_retrieve_command: STRING = "RETR"

	Ftp_store_command: STRING = "STOR"

feature {NONE} -- Constants for HTTP

	Http_get_command: STRING = "GET"

	Http_version: STRING = "HTTP/1.0"

	Http_host_header: STRING = "Host"

	Http_Authorization_header: STRING = "Authorization"

	Http_end_of_header_line: STRING = "%R%N"

	Http_end_of_command: STRING = "%R%N%R%N";

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




end -- class TRANSFER_COMMAND_CONSTANTS

