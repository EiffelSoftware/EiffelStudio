note
	description: "Containers listing all ZMQ sockets being polled on."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	EIS: "name=API", "src=http://api.zeromq.org/3-3:zmq-poll", "protocol=uri"
	date: "$Date$"
	revision: "$Revision$"

class
	ZMQ_POLLER

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Create `n' entries to listen to.
		require
			n_positive: n > 0
		do
			count := 0
			capacity := n
			create managed_pointer.make (n * element_size)
			create actions.make (n)
		ensure
			capacity_set: n = capacity
		end

feature -- Access

	capacity: INTEGER
			-- Maximum number of entries to listen to.

	count: INTEGER
			-- Current number of entries to listen to.

	is_terminated: BOOLEAN
			-- Is polling terminated due to one of the entries being closed?

feature -- Element change

	register (a_socket: ZMQ_SOCKET; a_flag: INTEGER; a_action: PROCEDURE)
			-- Register `a_socket' to be polled for `a_flag'.
		require
			a_socket_exists: a_socket.exists
			a_socket_not_closed: not a_socket.is_closed
			valid_flag: a_flag = {ZMQ_CONSTANTS}.pollin
		do
			if count = capacity then
					-- Resizing necessary
				capacity := capacity + capacity // 2
				managed_pointer.resize (capacity * element_size)
			end
			c_set_poll_entry (managed_pointer.item, count, a_socket.item, a_flag)
			actions.extend (a_action)
			count := count + 1
		end

	start
			-- Start poller's event loop.
		local
			i, l_err: INTEGER
			l_exit: BOOLEAN
		do
			from
			until
				l_exit
			loop
				l_err := {ZMQ}.poll (managed_pointer.item, count, -1)
				if l_err = 0 then
						-- Nothing was signaled, nothing to do.
				elseif l_err > 0 then
						-- Process all signaled entries.
					from
						i := 0
					until
						l_err = 0
					loop
						if c_is_entry_signaled (managed_pointer.item, i, {ZMQ_CONSTANTS}.pollin) then
							actions.i_th (i + 1).call (Void)
							l_err := l_err - 1
						end
					end
				else
						-- An error occurred
					l_err := {ZMQ}.errno
					if l_err = {ZMQ_ERROR_CODES}.eterm or l_err = {ZMQ_ERROR_CODES}.efault then
							-- An error occurred.
						l_exit := True
					else
						check l_err = {ZMQ_ERROR_CODES}.eintr end
					end
				end
			end
		end

feature {NONE} -- Implementation

	managed_pointer: MANAGED_POINTER
			-- Storage for the poll entries.

	actions: ARRAYED_LIST [PROCEDURE]
			-- Storage for actions associated to poll entries.

	element_size: INTEGER
			-- Size of the `zmq_pollitem_t' structure.
		external
			"C inline use <zmq.h>"
		alias
			"return sizeof(zmq_pollitem_t);"
		end

	c_set_poll_entry (entries: POINTER; i: INTEGER; a_socket: POINTER; a_flag: INTEGER)
		external
			"C inline use <zmq.h>"
		alias
			"[
				((zmq_pollitem_t *) $entries) [$i].socket = $a_socket;
				((zmq_pollitem_t *) $entries) [$i].events = $a_flag;
			]"
		end

	c_is_entry_signaled (entries: POINTER; i: INTEGER; a_flag: INTEGER): BOOLEAN
		external
			"C inline use <zmq.h>"
		alias
			"return EIF_TEST(((zmq_pollitem_t *) $entries) [$i].revents & $a_flag);"
		end

invariant
	capacity_positive: capacity > 0

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
