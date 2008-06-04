indexing
	description	: "Listener to the daemon to execute corresponding request"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class ISED_X_SLAVE

inherit
	SHARED_STATUS

	SHARED_PLATFORM_CONSTANTS

feature -- Initialization

	init_connection (old_style: BOOLEAN) is
			-- Connect with ised and watch for inputs from ised.
		local
			err: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				c_init_connect ($err)
				if err /= 0 then
					connection_failed := True
				else
						-- Initialize the connection
						-- with the ised daemon.
					if old_style then
						create_handler
					else
						create io_watcher.make_with_action (agent execute (Void))
					end

					pass_adresses
						-- Pass adresses of RQST_HANDLER objects to
						-- C, so they can be called when the
						-- the workbench is in server mode.

					enable_server_mode
						-- Enable the server mode
					connection_failed := False
				end
			else
				connection_failed := True
			end
		rescue
			retried := True
			retry
		end

	clean_connection is
		do
			disable_server_mode
			if io_watcher /= Void then
				io_watcher.destroy
				io_watcher := Void
			end
			reset_adresses
			c_clean_connect
		end

	connection_failed: BOOLEAN
			-- Did last `init_connection' failed ?

	create_handler is
			-- Create an IO handler to listen to ebench
		deferred
		end

feature {NONE} -- Implementation

	execute (argument: ANY) is
			-- Serve request from ised.
		local
			rqst_hdlr: RQST_HANDLER
		do
			rqst_hdlr := request_handler
			if rqst_hdlr /= Void then
				rqst_hdlr.execute
			end
		end

	io_watcher: EB_IO_WATCHER
			-- Class to watch for request from the daemon.

	failure_handler: FAILURE_HDLR
			-- Handler for failure error event.

	dead_handler: DEAD_HDLR
			-- Handler for dead application event.

	notified_handler: NOTIFIED_HDLR
			-- Handler for notification event.

	stopped_handler: STOPPED_HDLR
			-- Handler for stopped application event.
			-- (Called when the application hit a breakpoint or when
			-- the user change the status of a breakpoint while the
			-- debugged application is running)

	pass_adresses is
			-- Create all possible kinds of RQST_HANDLER that the outside could
			-- send on the pipe `Listen_to_const', and pass the corresponding
			-- addresses to C so that C can set the proper object.
		do
			create failure_handler.make
			create dead_handler.make
			create notified_handler.make
			create stopped_handler.make
		end

	reset_adresses is
		do
			if stopped_handler /= Void then
				stopped_handler.reset_addresses
				stopped_handler := Void
			end
			if notified_handler /= Void then
				notified_handler.reset_addresses
				notified_handler := Void
			end
			if dead_handler /= Void then
				dead_handler.reset_addresses
				dead_handler := Void
			end
			if failure_handler /= Void then
				failure_handler.reset_addresses
				failure_handler := Void
			end
		end

feature {NONE} -- Externals

	c_init_connect (perror: TYPED_POINTER[INTEGER]) is
			-- Initialize the connection
		external
			"C signature (int*)"
		alias
			"init_connection"
		end

	c_clean_connect is
			-- Initialize the connection
		external
			"C signature ()"
		alias
			"clean_connection"
		end

	request_handler: RQST_HANDLER is
			-- Return the correct RequestHandler at run-time.
		external
			"C"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
