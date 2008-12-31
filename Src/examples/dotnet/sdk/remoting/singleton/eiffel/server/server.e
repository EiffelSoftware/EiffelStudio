note
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	SERVER

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main
			-- Program entry point
		local
			chan1: TCP_CHANNEL
			chan2: HTTP_CHANNEL
		do
			create chan1.make ({REMOTE_CONSTANTS}.tcp_port)
			create chan2.make ({REMOTE_CONSTANTS}.http_port)

			{CHANNEL_SERVICES}.register_channel (chan1, True) -- ensure_security
			{CHANNEL_SERVICES}.register_channel (chan2, False) -- ensure_security
			{REMOTING_CONFIGURATION}.register_well_known_service_type ({HELLO_SERVER}, {REMOTE_CONSTANTS}.name, {WELL_KNOWN_OBJECT_MODE}.singleton)

			{SYSTEM_CONSOLE}.write_line ("Hit <enter> to exit...")
			{SYSTEM_CONSOLE}.read_line.do_nothing
		end

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software/Microsoft Corporation. All rights reserved."
	license: "[
			This file is part of the Microsoft .NET Framework SDK Code Samples.

			This source code is intended only as a supplement to Microsoft
			Development Tools and/or on-line documentation.  See these other
			materials for detailed information regarding Microsoft code samples.

			THIS CODE AND INFORMATION ARE PROVIDED AS IS WITHOUT WARRANTY OF ANY
			KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
			IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
			PARTICULAR PURPOSE.
		]"


end
