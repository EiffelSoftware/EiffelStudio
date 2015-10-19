note
	description: "[
			A fake SSL network stream socket... when SSL is disabled at compilation time.
			Its behavior is similar to NETWORK_STREAM_SOCKET.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_NETWORK_STREAM_SOCKET

inherit
	NETWORK_STREAM_SOCKET

create
	make, make_empty, make_client_by_port, make_client_by_address_and_port, make_server_by_port, make_loopback_server_by_port

create {SSL_NETWORK_STREAM_SOCKET}
	make_from_descriptor_and_address, create_from_descriptor
	

end
