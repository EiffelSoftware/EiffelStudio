note
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	CLIENT

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main
			-- Program entry point
		local
			chan: TCP_CHANNEL
			obj: HELLO_SERVER
			param, after: FORWARD_ME
		do
			create chan.make
			{CHANNEL_SERVICES}.register_channel (chan, True) -- ensure_security

			create param.make
			obj ?= {ACTIVATOR}.get_object ({HELLO_SERVER}, {SYSTEM_STRING}.format ("tcp://localhost:{0}/{1}", {REMOTE_CONSTANTS}.tcp_port, {REMOTE_CONSTANTS}.name))
			if obj = Void then
				{SYSTEM_CONSOLE}.write_line ("Could not locate server")
			else
				{SYSTEM_CONSOLE}.write_line ("The value is {0}", param.get_value)

				after := obj.hello_method (param)

				{SYSTEM_CONSOLE}.write_line ("The value is {0}", after.get_value)
			end
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
