note
	description: "Implementation of a broken using ZMQ_DEALER and ZMQ_ROUTER sockets"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ZMQ_BROKER

create
	make

feature {NONE} -- Initialization

	make (a_context: ZMQ_CONTEXT; a_front_end, a_back_end: READABLE_STRING_GENERAL)
			-- Initialize `front_end' and `back_end' sockets to forward messages
			-- back and forth to clients/servers.
		do
			front_end := a_context.new_router_socket
			back_end := a_context.new_dealer_socket

				-- Bind sockets to their respective port.
			front_end.bind (a_front_end)
			back_end.bind (a_back_end)
		end

feature -- Element change

	start
		require
			is_launchable: is_launchable
		local
			l_poller: ZMQ_POLLER
		do
			create l_poller.make (2)
			l_poller.register (front_end, {ZMQ_CONSTANTS}.pollin, agent forward_message (front_end, back_end))
			l_poller.register (back_end, {ZMQ_CONSTANTS}.pollin, agent forward_message (back_end, front_end))

			l_poller.start

				-- We should never get there but we cleanup anyhow.
			front_end.close
			back_end.close
		end

feature -- Access

	front_end, back_end: ZMQ_SOCKET
			-- Sockets used for routing messages.

feature -- Status report

	is_launchable: BOOLEAN
			-- Is broker launchable?
		do
			Result := (front_end.exists and then not front_end.is_closed) and
				(back_end.exists and then not back_end.is_closed)
		end

feature {NONE} -- Implementation

	forward_message (a_source, a_dest: ZMQ_SOCKET)
			-- Forward messages received from `a_source' to `a_dest'.
		require
			a_source_exists: a_source.exists
			a_source_not_closed: not a_source.is_closed
			a_dest_exists: a_dest.exists
			a_dest_not_closed: not a_dest.is_closed
		do
			c_forward (a_source.item, a_dest.item)
		end

	c_forward (a_source, a_dest: POINTER)
			-- Forward messages received from `a_source' to `a_dest'.
		require
			a_source_not_null: a_source /= default_pointer
			a_dest_not_null: a_dest /= default_pointer
		external
			"C inline use <zmq.h>"
		alias
			"[
				zmq_msg_t message;
				while (1) {
						/* Process all parts of the message. */
					zmq_msg_init (&message);
					zmq_msg_recv (&message, $a_source, 0);
					zmq_msg_send (&message, $a_dest,
					zmq_msg_more (&message)? ZMQ_SNDMORE: 0);
					zmq_msg_close (&message);
					if (!zmq_msg_more (&message)) {
							/* This is the last message. */
						break;
					}
				}
			]"
		end
note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
