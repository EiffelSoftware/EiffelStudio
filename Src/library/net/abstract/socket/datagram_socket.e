indexing

	description:
		"A socket datagram";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"


deferred class 
	SOCKET_DGRAM

inherit

	SOCKET_R

feature 	-- Status report

	bound: BOOLEAN is
			-- has socket been bound
		deferred
		end;

	descriptor: INTEGER is
			-- Socket descriptor
		deferred
		end;

	exists: BOOLEAN is
			-- does the socket descriptor exist
		deferred
		end;

	address: SOCKET_ADDRESS is
			-- Local socket address
		deferred
		end;

	peer_address: like address is
			-- sockets peer address
		deferred
		end;

feature 	-- Input

	receive_from (size: INTEGER; flags: INTEGER): DGRAM_PACKET is
			-- receive a packet. Who from is put into the 'peer_address'
		require 
			socket_exists: exists;
			opened_for_read: bound;
		local
			return_val: INTEGER;
			ext_data: ANY;
			ext_addr: ANY;
			peer_addr_size: INTEGER_REF;
		do
			if peer_address = Void then
				make_peer_address
			end;
			ext_addr := peer_address.socket_address;
			!!peer_addr_size;
			peer_addr_size.set_item (peer_address.count);
			!!Result.make (size);
			ext_data := Result.data;
			return_val := c_rcv_from (descriptor, $ext_data, 
						Result.count, flags, $ext_addr, 
						$peer_addr_size);
			debug ("network_dgram") 
				io.putstring ("read : ");
				io.putint (return_val);
				io.new_line;
				io.putstring ("peer address size (eiffel : c) , ");
				io.putint (peer_address.count);
				io.putstring (" : ");
				io.putint (peer_addr_size.item);
				io.new_line;
			end;
		ensure
			known_address: peer_address /= Void;
		end;

feature 	-- Output

	send_to (a_packet: DGRAM_PACKET; to_address: SOCKET_ADDRESS; flags: INTEGER) is
			-- send 'a_packet to address 'to_address' or peer_address'
		require 
			socket_exists: exists;
			opened_for_write: bound;
			valid_peer: to_address /= Void or else peer_address /= Void;
			valid_packet: a_packet /= Void;
		local
			ext_data: ANY;
			ext_addr: ANY;
			return_val: INTEGER;
		do
			ext_data := a_packet.data;
			if to_address = Void then
				ext_addr := peer_address.socket_address;
			else
				ext_addr := to_address.socket_address;
			end;
			return_val := c_send_to (descriptor, $ext_data, 
						a_packet.count, flags, 
						$ext_addr, peer_address.count);
			debug ("network_dgram") 
				io.putstring ("write : ");
				io.putint (return_val);
				io.new_line;
			end;
		end;


feature  {NONE}	--  Implementation

	make_peer_address is 
			-- create a peer address
		deferred
		ensure
			peer_created: peer_address /= Void;
		end;


feature 	-- Externals

	c_rcv_from (fd: INTEGER; buf: ANY; len:INTEGER; flags: INTEGER; 
			addr: ANY; l: INTEGER_REF): INTEGER is
					-- external routine to read 'l' length of data
					-- from the socket identified by fd connected
					-- to a peer address of 'addr'
		external
			"C"
		end


	c_send_to (fd: INTEGER; buf: ANY; len: INTEGER; flags: INTEGER; 
			addr: ANY; l: INTEGER): INTEGER is
					-- external routine to write 'l' length of data
					-- from the socket identified by fd connected
					-- to a peer address of 'addr'
		external
			"C"
		end;

end 	-- class SOCKET_DGRAM

--|----------------------------------------------------------------
--| Eiffelnet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
