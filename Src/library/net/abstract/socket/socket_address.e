indexing

	description:
		"A socket address.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SOCKET_ADDRESS

inherit

	TO_SPECIAL [CHARACTER]
		rename
			area as socket_address,
			make_area as make_socket_address,
			copy as old_copy
		redefine
			is_equal
		end

	TO_SPECIAL [CHARACTER]
		rename
			area as socket_address,
			make_area as make_socket_address
		redefine
			copy, is_equal
		select
			copy
		end

creation

	make

feature -- Initalization

	make is
			--create the memory for address size
		do
			make_socket_address (address_size)
		end

feature -- Measurement

	count: INTEGER is
			-- size of address
		do
			Result := socket_address.count
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := socket_address.is_equal (other.socket_address)
		end

feature -- Status report

	family: INTEGER is
			-- get the socket family from socket address
		do
			Result := get_sock_family ($socket_address)
		end

feature -- Status setting

	set_family (f: INTEGER) is
			-- set socket address family to f
		do
			set_sock_family ($socket_address, f)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying the characters of `other'.
			-- (This is also used by `clone'.)
		do
			old_copy (other)
			if other.count > address_size then
				make_socket_address (other.count)
			else
				make
			end
			socket_address.copy (other.socket_address)
		ensure then
			new_result_count: count = other.count or else count = address_size
		end

feature {NONE} -- External

	address_size: INTEGER is
			-- returns the size of the socket address
		external
			"C"
		end

	set_sock_family (address: ANY; a_family: INTEGER) is
			-- sets the family in the socket address
		external
			"C"
		end

	get_sock_family (address: ANY): INTEGER is
			-- gets the socket family from the socket address
		external
			"C"
		end

	set_sock_data (address: ANY; dat: ANY) is
			-- sets the data area of the socket address 
		external
			"C"
		end

	get_sock_data (address: ANY): ANY is
			-- gets the data portion of the socket address
		external
			"C"
		end

end -- Class SOCKET_ADDRESS

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel 3.
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

