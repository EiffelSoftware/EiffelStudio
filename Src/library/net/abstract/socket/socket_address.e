indexing

	description:
		"A socket address.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SOCKET_ADDRESS

inherit
	ANY
		redefine
			copy, is_equal
		end

create

	make

feature -- Initalization

	make is
			-- Make space available for address size.
		do
			create socket_address.make (address_size)
		end

feature -- Access

	socket_address: MANAGED_POINTER
			-- Hold data.

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
			Result := get_sock_family (socket_address.item)
		end

feature -- Status setting

	set_family (f: INTEGER) is
			-- Set socket address family to `f'.
		do
			set_sock_family (socket_address.item, f)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying characters of `other'.
			-- (This is also used by `clone'.)
		do
			standard_copy (other)
			socket_address.resize (other.count)
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
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

