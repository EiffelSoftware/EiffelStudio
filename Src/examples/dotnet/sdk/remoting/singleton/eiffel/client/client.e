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
		do
			create thread_1.make (create {THREAD_START}.make (Current, $run_me))
			create thread_2.make (create {THREAD_START}.make (Current, $run_me))
			thread_1.start
			thread_2.start
		end

feature -- Access

	thread_1: SYSTEM_THREAD
	thread_2: SYSTEM_THREAD

feature -- Basic operations

	run_me
		require
			thread_1_attached: thread_1 /= Void
			thread_2_attached: thread_2 /= Void
		local
			http_chan: HTTP_CHANNEL
			tcp_chan: TCP_CHANNEL
			obj: HELLO_SERVER
			i: INTEGER
		do
			if {SYSTEM_THREAD}.current_thread = thread_1 then
				create http_chan.make

				{CHANNEL_SERVICES}.register_channel (http_chan, False) -- ensure_security
				{SYSTEM_CONSOLE}.write_line ("I am thread one")

				obj ?= {ACTIVATOR}.get_object ({HELLO_SERVER}, {SYSTEM_STRING}.format ("http://localhost:{0}/{1}", {REMOTE_CONSTANTS}.http_port, {REMOTE_CONSTANTS}.name))
				check obj_attached: obj /= Void end

				from i := 0 until i = 1000 loop
					{SYSTEM_CONSOLE}.write_line (obj.count_me.out + " - from thread 1 ")
					{SYSTEM_THREAD}.sleep (0)
					i := i + 1
				end
			elseif {SYSTEM_THREAD}.current_thread = thread_2 then
				create tcp_chan.make

				{CHANNEL_SERVICES}.register_channel (tcp_chan, True) -- ensure_security
				{SYSTEM_CONSOLE}.write_line ("I am thread two")

				obj ?= {ACTIVATOR}.get_object ({HELLO_SERVER}, {SYSTEM_STRING}.format ("tcp://localhost:{0}/{1}", {REMOTE_CONSTANTS}.tcp_port, {REMOTE_CONSTANTS}.name))
				check obj_attached: obj /= Void end

				from i := 0 until i = 1000 loop
					{SYSTEM_CONSOLE}.write_line (obj.count_me.out + " - from thread 2 ")
					{SYSTEM_THREAD}.sleep (0)
					i := i + 1
				end
			end
		end

invariant
	thread_1_attached: thread_1 /= Void
	thread_2_attached: thread_2 /= Void

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
