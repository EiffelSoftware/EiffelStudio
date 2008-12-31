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
			provider: BINARY_SERVER_FORMATTER_SINK_PROVIDER
			props: IDICTIONARY
			chan: TCP_CHANNEL
		do
				-- Creating a custom formatter for your {TCP_CHANNEL} sink chain
			create provider.make

			provider.type_filter_level := {TYPE_FILTER_LEVEL}.full

				-- Creating the dictionary to set the port on the channel instance
			create {HASHTABLE} props.make

			props.set_item (({SYSTEM_STRING})["port"], {REMOTE_CONSTANTS}.tcp_port)

				-- Pass the props for the port setting and the server provider in the server chain argument. (Client remains Void here.)
			create chan.make (props, Void, provider)

			{CHANNEL_SERVICES}.register_channel (chan, True) -- ensure_security
			{REMOTING_CONFIGURATION}.register_well_known_service_type ({HELLO_SERVER}, {REMOTE_CONSTANTS}.name, {WELL_KNOWN_OBJECT_MODE}.single_call)

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
