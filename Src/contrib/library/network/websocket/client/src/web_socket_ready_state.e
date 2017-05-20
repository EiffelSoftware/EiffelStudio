note
	description: "Report the state of the connection: [CONNECTING, OPEN, CLOSING, CLOSED]"
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_READY_STATE

create
	make

feature -- Initialization

	make
		do
			set_state (Connecting)
		ensure
			state_connecting: state = Connecting
		end
feature -- Access

	state: INTEGER
			-- Current ready state

feature -- Status Report

	is_valid_state (a_state: INTEGER): BOOLEAN
			-- Is `a_state' a valid ready state?
		do
			Result := Connecting = a_state or else Open = a_state or else Closing = a_state or else Closed = a_state
		end

	is_connecting: BOOLEAN
			-- Is current `state' connecting?
		do
			Result := state = Connecting
		end

	is_open: BOOLEAN
			-- Is current `state' open?
		do
			Result := state = Open
		end

	is_closing: BOOLEAN
			-- Is current `state' closing?
		do
			Result := state = Closing
		end

	is_closed: BOOLEAN
			-- Is current `state' closed?
		do
			Result := state = Closed
		end

feature -- Change Element

	set_state (a_state: INTEGER)
			-- Set `state' to `a_state'
		require
			valid_state: is_valid_state (a_state)
		do
			state := a_state
		ensure
			state_set: state = a_state
		end

	mark_connecting
			--Set `state' to `connecting'
		do
			set_state (Connecting)
		ensure
		 	connecting_state: state = Connecting
		end

	mark_open
			--Set `state' to `open'
		do
			set_state (Open)
		ensure
		 	open_state: state = Open
		end

	mark_closing
			--Set `state' to `closing'
		do
			set_state (Closing)
		ensure
		 	open_state: state = Closing
		end


	mark_closed
			--Set `state' to `closed'
		do
			set_state (Closed)
		ensure
		 	open_state: state = Closed
		end


feature --State connection

	Connecting: INTEGER = 0
			-- The connection is in progress but has not been established.

	Open: INTEGER = 1
			-- The connection has been stablished. Messages can flow between client and server.

	Closing: INTEGER = 2
			-- The connection is going through the closing handshake

	Closed: INTEGER = 3
			-- The connection has been closed or could not be opened.


invariant
	is_valid_sate: is_valid_state (state)
end
