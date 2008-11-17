class
	TFTP_EVENT

create
	make

feature -- Event types

	request_received: INTEGER = 1
	request_processing: INTEGER = 2
	request_complete: INTEGER = 3
	request_incomplete: INTEGER = 4
	request_retransmit: INTEGER = 5
	request_outoforder: INTEGER = 6

feature

	peer_address: INET_ADDRESS
			-- Peer Address
	peer_port: INTEGER
			-- Peeer Port	
	id: INTEGER
			-- Package ID
	type: INTEGER
			-- Event Type
	arg: STRING
			-- Optional Argument

feature -- Initialization

	make (a_peer_address: INET_ADDRESS; a_peer_port: INTEGER; an_id: INTEGER; a_type: INTEGER; an_arg: STRING) is
		do
			peer_address := a_peer_address
			peer_port := a_peer_port
			id := an_id
			type := a_type
			arg := an_arg
		end

end
