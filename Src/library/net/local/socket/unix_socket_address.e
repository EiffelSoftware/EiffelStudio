indexing

	description:
		"A unix socket address.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class UNIX_SOCKET_ADDRESS

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

	make

feature -- Initalization

	make is
			-- Create a unix socket address
		do
			socket_address_make
			set_family (af_unix)
		end

feature -- Status report

	path: STRING is
			-- Path of the socket address
		do
			!!Result.make(0)
			Result.from_c (get_unix_sock_path($socket_address))
		end

feature -- Status settings

	set_path (p: STRING) is 
			-- Set the path to p
		local
			ext: ANY
		do
			ext := p.to_c
			set_unix_sock_path ($socket_address, $ext)
		end

feature {NONE} -- External

	address_size: INTEGER is
			-- Size of the unix socket address
		external
			"C"
		alias
			"unix_address_size"
		end

	set_sock_family (addr: ANY; a_family: INTEGER) is
			-- Set the family name in the socket address
		external
			"C"
		alias
			"set_unix_family"
		end

	get_sock_family (addr: ANY): INTEGER is
			-- Get the family name from the socket address
		external
			"C"
		alias
			"get_unix_family"
		end

	set_unix_sock_path (addr: ANY; a_path: ANY) is
			-- Set the path in the socket address
		external
			"C"
		end

	get_unix_sock_path (addr: ANY): POINTER is
			-- Get the path from the socket address
		external
			"C"
		end

end -- UNIX_SOCKET_ADDRESS

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

