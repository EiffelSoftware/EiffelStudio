indexing

	description:
		"A unix socket address.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	UNIX_SOCKET_ADDRESS

inherit

	SOCKET_RESOURCES
		undefine
			copy, is_equal
		end

	SOCKET_ADDRESS
		rename
			make as socket_address_make
		redefine
			address_size, set_sock_family, get_sock_family
		end

	SOCKET_ADDRESS
		redefine
			address_size, set_sock_family, get_sock_family,
			make
		select
			make
		end

creation

	make, make_from_path

feature -- Initialization

	make is
			-- Create an unix socket address.
		do
			socket_address_make;
			set_family (af_unix)
		end;

	make_from_path (a_path: like path) is
			-- Create an unix socket address from a path.
		do
			make;
			set_path (a_path)
		end

feature -- Status report

	path: STRING is
			-- Path of the socket address file
		do
			create Result.make(0);
			Result.from_c (get_unix_sock_path($socket_address))
		end

feature -- Status settings

	set_path (p: STRING) is 
			-- Set socket path to `p'.
		local
			ext: ANY
		do
			ext := p.to_c;
			set_unix_sock_path ($socket_address, $ext)
		end

feature {NONE} -- External

	address_size: INTEGER is
			-- Size of unix socket address
		external
			"C"
		alias
			"unix_address_size"
		end;

	set_sock_family (addr: POINTER; a_family: INTEGER) is
			-- Set family name in socket address.
		external
			"C"
		alias
			"set_unix_family"
		end;

	get_sock_family (addr: POINTER): INTEGER is
			-- Get family name from socket address.
		external
			"C"
		alias
			"get_unix_family"
		end;

	set_unix_sock_path (addr: POINTER; a_path: POINTER) is
			-- Set path in socket address.
		external
			"C"
		end;

	get_unix_sock_path (addr: POINTER): POINTER is
			-- Get path from socket address.
		external
			"C"
		end

end -- UNIX_SOCKET_ADDRESS




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

