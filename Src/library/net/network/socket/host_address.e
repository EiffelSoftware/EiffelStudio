indexing

	description:
		"A host address.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	HOST_ADDRESS

inherit

	TO_SPECIAL[CHARACTER]
		rename
			area as address_host,
			copy as old_copy
		redefine
			is_equal
		end

	TO_SPECIAL[CHARACTER]
		rename
			area as address_host
		redefine
			copy, is_equal
		select
			copy
		end

creation

	make, make_local, make_from_name, make_from_ip_number

feature -- Initialization

	make is
			-- Create a host address object.
		do
			make_area (in_addr_size)
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

feature -- Measurement

	count: INTEGER is
			-- Object address size
		do
			Result := address_host.count
		end

feature -- Comparison

	is_equal (other: like current): BOOLEAN is
			-- Are the two host address areas equal ?
		do
			Result := address_host.is_equal (other.address_host)
		end

feature -- Status_report

	host_number: INTEGER is
			-- IP number in long integer form of current address
		do
			Result := get_host_addr ($address_host)
		end;

	host_address: STRING is
			-- IP number (dotted format) of current address
		do
			Result := net_host ($address_host)
		end;

	local_host_name: STRING is
			-- Host name of the local machine
		do
			Result := c_get_hostname
		end

feature -- Status_setting

	set_address_from_name (a_name: STRING) is
			-- Set the host address using the name provided in 'a_name'.
		require
			name_valid: a_name /= Void and then not a_name.empty
		local
			ext: ANY
		do
			ext := a_name.to_c;
			host_address_from_name ($address_host, $ext)
		end;

	set_host_address (host_id: STRING) is
			-- Set host address from dotted format string.
		require
			dotted_address_not_void: host_id /= Void
		local
			ext: ANY;
			host_num: INTEGER
		do
			ext := host_id.to_c;
			host_num := net_host_addr ($ext);
			set_host_addr ($address_host, host_num)
		end;

	set_in_address_any is
			-- Set host address to "in address any".
			-- This is a special address selected by the host machine.
		do
			set_host_addr ($address_host, inet_inaddr_any)
		end

feature -- Conversion

	from_c (ptr: POINTER) is
			-- Converts a c host address structure (address_in)
			-- to an eiffel address object.
		do
			set_from_c ($address_host, ptr)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying the characters of `other'.
			-- (This is also used by `clone')
		do
			old_copy (other)
			make_area (other.count)
			address_host.copy (other.address_host)
		ensure then
			new_result_count: count = other.count or else count = in_addr_size
		end

feature {NONE} -- External

	c_get_hostname: STRING is
			-- Get local hostname.
		external
			"C"
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

	net_host (addr: POINTER): STRING is
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

end -- class HOST_ADDRESS



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

