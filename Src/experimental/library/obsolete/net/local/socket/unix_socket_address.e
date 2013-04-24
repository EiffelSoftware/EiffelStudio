note

	description:
		"A Unix socket address."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
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

create

	make, make_from_path

feature -- Initialization

	make
			-- Create a Unix socket address.
		do
			socket_address_make;
			set_family (af_unix)
		end;

	make_from_path (a_path: like path)
			-- Create a Unix socket address from a path.
		do
			make;
			set_path (a_path)
		end

feature -- Status report

	path: STRING
			-- Path of the socket address file
		do
			create Result.make(0);
			Result.from_c (get_unix_sock_path (socket_address.item))
		end

feature -- Status settings

	set_path (p: STRING) 
			-- Set socket path to `p'.
		local
			ext: C_STRING
		do
			create ext.make (p)
			set_unix_sock_path (socket_address.item, ext.item)
		end

feature {NONE} -- External

	address_size: INTEGER
			-- Size of Unix socket address
		external
			"C"
		alias
			"unix_address_size"
		end;

	set_sock_family (addr: POINTER; a_family: INTEGER)
			-- Set family name in socket address.
		external
			"C"
		alias
			"set_unix_family"
		end;

	get_sock_family (addr: POINTER): INTEGER
			-- Get family name from socket address.
		external
			"C"
		alias
			"get_unix_family"
		end;

	set_unix_sock_path (addr: POINTER; a_path: POINTER)
			-- Set path in socket address.
		external
			"C"
		end;

	get_unix_sock_path (addr: POINTER): POINTER
			-- Get path from socket address.
		external
			"C"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- UNIX_SOCKET_ADDRESS

