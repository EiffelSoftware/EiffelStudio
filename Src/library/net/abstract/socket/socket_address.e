indexing

	description:
		"A socket address.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SOCKET_ADDRESS

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
			-- Make space available for address size.
		do
			make_socket_address (address_size)
		end

feature -- Measurement

	count: INTEGER is
			-- Size of address
		do
			Result := socket_address.count
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is current address equal to `other'?
		do
			Result := socket_address.is_equal (other.socket_address)
		end

feature -- Status report

	family: INTEGER is
			-- Get the socket family of socket address.
		do
			Result := get_sock_family ($socket_address)
		end

feature -- Status setting

	set_family (f: INTEGER) is
			-- Set socket address family to `f'.
		do
			set_sock_family ($socket_address, f)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying characters of `other'.
			-- (This is also used by `clone'.)
		do
			old_copy (other);
			if other.count > address_size then
				make_socket_address (other.count)
			else
				make
			end;
			socket_address.copy (other.socket_address)
		ensure then
			new_result_count: count = other.count or else count = address_size
		end

feature {NONE} -- External

	address_size: INTEGER is
			-- Size of socket address
		external
			"C"
		end;

	set_sock_family (address: POINTER; a_family: INTEGER) is
			-- Set family of socket address.
		external
			"C"
		end;

	get_sock_family (address: POINTER): INTEGER is
			-- Get socket family from socket address.
		external
			"C"
		end;

	set_sock_data (address: POINTER; dat: POINTER) is
			-- Set data area of socket address.
		external
			"C"
		end;

	get_sock_data (address: POINTER): POINTER is
			-- Get data portion of socket address.
		external
			"C"
		end

end -- Class SOCKET_ADDRESS



--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1086-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

