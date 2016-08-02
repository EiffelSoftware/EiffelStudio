note
	description: "Summary description for {ZMQ_SOCKET}."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ZMQ_SOCKET

inherit
	WRAPPER_BASE
		rename
			make as base_make
		export
			{ZMQ_CONTEXT, ZMQ_POLLER, ZMQ_BROKER} item
		end

	STRING_HANDLER

	HASHABLE

create {ZMQ_CONTEXT}
	make

feature {NONE} -- Initialization

	make (a_item: POINTER; a_socket_type: INTEGER)
			-- Initialize Current with initialized socket `a_item' of type `a_socket_type'.
		require
			a_item_not_null: a_item /= default_pointer
		do
			base_make (a_item)
			hash_code := a_item.hash_code
			create last_string.make (256)
			is_closed := True
			socket_type := a_socket_type
		ensure
			item_set: item = a_item
			socket_type_set: socket_type = a_socket_type
		end

feature -- Access

	last_string: STRING
			-- Last received string via `read_string'.

	hash_code: INTEGER
			-- Hash code associated with current socket.

	socket_type: INTEGER
			-- Type of current socket (See ZMQ_CONSTANTS for list.)

feature -- Status report

	exists: BOOLEAN
			-- Is current socket valid?
		do
			Result := item /= default_pointer
		end

	is_closed: BOOLEAN
			-- Is socket closed?

feature -- Binding

	bind (an_address: READABLE_STRING_GENERAL)
			-- Bind Current socket to a particular transport.
		require
			an_address /= Void
			an_address_ascii: an_address.is_valid_as_string_8
		local
			res: INTEGER_32
			c_str: C_STRING
		do
			create c_str.make (an_address)
			res := {ZMQ}.bind (item, c_str.item)
			if res /= 0 then
					--exceptions.raise(create {STRING}.make_from_c(zmq_strerror(errno)))
			else
				is_closed := False
			end
		end

	connect (an_address: READABLE_STRING_GENERAL)
			-- Connect Current socket to the peer identified by `an_address'.
			-- Actual semantics of the  command depend on the underlying transport mechanism,
			-- however, in cases where peers connect in an asymetric manner, zmq_bind should
			-- be called first, zmq_connect afterwards.
			-- Formats of the addr  parameter are defined by individual transports.
			-- For a list of supported transports have a look at zmq(7) manual page.
			-- Note that single socket can be connected (and bound) to arbitrary number of peers using different transport mechanisms.
		require
			an_address /= Void
			an_address_ascii: an_address.is_valid_as_string_8
		local
			rc: INTEGER_32
			c_str: C_STRING
		do
			create c_str.make (an_address)
			rc := {ZMQ}.connect (item, c_str.item)
			check
					-- TODO: proper error handling
				rc = 0
			end
			is_closed := False
		end

feature -- Receiving messages

	read_string
			 -- Receive a message from Current socket. Program is blocked until
			 -- a message is received.
		require
			exists: exists
			not_closed: not is_closed
		local
			l_buffer: C_STRING
			l_bytes: INTEGER
			l_err: INTEGER
		do
			create l_buffer.make_empty (256)
			l_bytes := {ZMQ}.recv (item, l_buffer.item, 256, 0)
			if l_bytes < 0 then
				l_err := {ZMQ}.errno
				inspect l_err
				else
					io.put_integer (l_err)
				end
				exceptions.raise ("ZMQ_SOCKET.read_string error not handled")
			else
				last_string.set_count (l_bytes)
				l_buffer.read_substring_into (last_string, 1, l_bytes)
			end
		end

	receive_message (a_message: ZMQ_MESSAGE)
			-- Receive `a_message' from Current socket; any previous content of
			-- `a_message' will be properly deallocated. Program is blocked until a
			-- message is received; see also `receive_now'.
		require
			exists: exists
			not_closed: not is_closed
		local
			rc: INTEGER_32
		do
			rc := {ZMQ}.msg_recv (a_message.item, item, 0)
			if rc = -1 then
				exceptions.raise ("ZMQ_SOCKET.message_receive error not handled")
			end
		end

	receive_now (a_message: ZMQ_MESSAGE)
			-- Receive `a_message' from Current socket; any previous content of
			-- `a_message' will be properly deallocated. If it cannot be processed immediately, errno is set to EAGAIN.

			-- TODO: perhaps non_blocking_receive is a better name?
		require
			exists: exists
			not_closed: not is_closed
		local
			rc: INTEGER_32
		do
			rc := {ZMQ}.msg_recv (a_message.item, item, {ZMQ_CONSTANTS}.noblock)
			if rc = -1 then
				exceptions.raise ("ZMQ_SOCKET.now_receive error not handled")
			end
		end


feature {ANY} -- Sending

	put_string (a_message: STRING)
			-- Send `a_message'. Blocking call
		require
			exists: exists
			not_closed: not is_closed
		local
			rc: INTEGER_32
			l_buf: C_STRING
		do
			create l_buf.make (a_message)
			rc := {ZMQ}.send (item, l_buf.item, l_buf.bytes_count, 0)
			check
				valid_result: rc >= 0
			end
		end

	send_message (a_message: ZMQ_MESSAGE)
			-- Send `a_message'. Blocking call
		require
			exists: exists
			not_closed: not is_closed
		local
			rc: INTEGER_32
		do
			rc := {ZMQ}.sendmsg (item, a_message.item, 0)
			check
				valid_result: rc >= 0
			end
		end

feature -- Closing

	close
			-- Close current socket.
		require
			exists: exists
		do
			if {ZMQ}.close (item) /= 0 then
				check {ZMQ}.errno = {ZMQ_ERROR_CODES}.enotsock end
			end
			item := default_pointer
			is_closed := True
		ensure
			is_closed: is_closed
		end

feature {NONE} -- Disposing

	dispose
			-- Precursor
		do
			if item /= default_pointer then
				close
			end
		end

feature {NONE} -- Exceptions

	exceptions: EXCEPTIONS
		once
			create Result
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class ZMQ_SOCKET
