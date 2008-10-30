indexing
	description: "A host address."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	HOST_ADDRESS

obsolete
	"Use the INET_ADDRESS_FACTORY instead to create addresses."

inherit
	ANY
		redefine
			is_equal, copy
		end

create
	make, make_local, make_from_name, make_from_ip_number

feature -- Initialization

	make is
			-- Create a host address object.
		do
			create address_host.make (in_addr_size)
		end;

	make_local is
			-- Create a local host address object.
		do
			make;
			set_in_address_any
		end;

	make_from_name (a_name: STRING) is
			-- Create host address from host name `a_name'.
		do
			make;
			set_address_from_name (a_name)
		end;

	make_from_ip_number (an_ip_address: STRING) is
			-- Create host address from IP number in dotted format.
		do
			make;
			set_host_address (an_ip_address)
		end

feature -- Access

	address_host: MANAGED_POINTER
			-- Special data zone.

feature -- Measurement

	count: INTEGER is
			-- Object address size
		do
			Result := address_host.count
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Are the two host address areas equal ?
		do
			Result := address_host.is_equal (other.address_host)
		end

feature -- Status_report

	host_number: INTEGER is
			-- IP number in long integer form of current address
		do
			Result := get_host_addr (address_host.item)
		end;

	host_address: STRING is
			-- IP number (dotted format) of current address
		do
			create Result.make_from_c (net_host (address_host.item))
		end;

	local_host_name: STRING is
			-- Host name of the local machine
		local
			l_c_str: C_STRING
		do
			create l_c_str.make_empty (1024)
			c_get_hostname (l_c_str.item, 1024)
			Result := l_c_str.string
		end

feature -- Status_setting

	set_address_from_name (a_name: STRING) is
			-- Set the host address using the name provided in 'a_name'.
		require
			name_valid: a_name /= Void and then not a_name.is_empty
		local
			ext: C_STRING
		do
			create ext.make (a_name)
			host_address_from_name (address_host.item, ext.item)
		end;

	set_host_address (host_id: STRING) is
			-- Set host address from dotted format string.
		require
			dotted_address_not_void: host_id /= Void
		local
			ext: C_STRING
			host_num: INTEGER
		do
			create ext.make (host_id)
			host_num := net_host_addr (ext.item);
			set_host_addr (address_host.item, host_num)
		end;

	set_in_address_any is
			-- Set host address to "in address any".
			-- This is a special address selected by the host machine.
		do
			set_host_addr (address_host.item, inet_inaddr_any)
		end

feature -- Conversion

	from_c (ptr: POINTER) is
			-- Converts a c host address structure (address_in)
			-- to an eiffel address object.
		do
			set_from_c (address_host.item, ptr)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying the characters of `other'.
			-- (This is also used by `clone')
		do
			standard_copy (other)
			address_host.resize (other.count)
			address_host.copy (other.address_host)
		ensure then
			new_result_count: count = other.count or else count = in_addr_size
		end

feature {NONE} -- External

	c_get_hostname (buf: POINTER; nb: INTEGER) is
			-- Get local hostname.
		external
			"C signature (char *, size_t)"
		end;

	in_addr_size: INTEGER is
			-- Size of the c address structure
		external
			"C"
		end;

	inet_inaddr_any: INTEGER is
			-- C constant for "wildcard" address
		external
			"C"
		end;

	set_host_addr (addr: POINTER; value: INTEGER) is
		external
			"C"
		alias
			"set_sin_addr"
		end;

	get_host_addr (addr: POINTER): INTEGER is
			-- get the host number from 'addr'
		external
			"C"
		alias
			"get_sin_addr"
		end;

	net_host_addr(host_addr: POINTER): INTEGER is
			--	Convert the dotted string address to a host number
		external
			"C"
		end;

	net_host (addr: POINTER): POINTER is
		external
			"C"
		end;

	host_address_from_name (addr, name: POINTER) is
			-- sets the host address in 'addr' using the
			-- name to identify the host.
		external
			"C"
		end;

	set_from_c (addr: POINTER ptr: POINTER) is
			-- copies the address infor in 'ptr'
			-- to the addr object.
		external
			"C"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HOST_ADDRESS

