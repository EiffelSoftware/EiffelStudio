indexing

	description:
		"A host address object.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class HOST_ADDRESS

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

	make

feature -- Initialization

	make is
			-- Create a host address object 
		do
			make_area (in_addr_size)
		end

feature -- Measurement

	count: INTEGER is
			-- object address size
		do
			Result := address_host.count
		end

feature -- Comparison

	is_equal (other: like current): BOOLEAN is
			-- Are the two host address areas equal
		do
			Result := address_host.is_equal (other.address_host)
		end

feature -- Status_report

	host_number: INTEGER is
		do
			Result := get_host_addr ($address_host)
		end

feature -- Status_setting

	set_address_from_name (a_name: STRING) is
			-- set the host address using the name provided in 'a_name'
		require
			name_valid: a_name /= Void and then not a_name.empty
		local
			ext: ANY
		do
			ext := a_name.to_c
			host_address_from_name ($address_host, $ext)
		end

	set_host_address (host_id: STRING) is
			-- set host address from dotted string
		require
			dotted_address_not_void: host_id /= Void
		local
			ext: ANY
			host_num: INTEGER
		do
			ext := host_id.to_c
			host_num := net_host_addr ($ext)
			set_host_addr ($address_host, host_num)
		end

	set_in_address_any is
			-- Set host address to in address any
			-- This is a special address selected by the host machine.
		do
			set_host_addr ($address_host, inet_inaddr_any)
		end

feature -- Conversion

	from_c (ptr: POINTER) is
			-- converts a c host address structure (address_in)
			-- to an eiffel address object
		do
			set_from_c ($address_host, ptr)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying the characters of `other'.
			-- (This is also used by `clone'.)
		do
			old_copy (other)
			make_area (other.count)
			address_host.copy (other.address_host)
		ensure then
			new_result_count: count = other.count or else count = in_addr_size
		end

feature {NONE} -- External

	in_addr_size: INTEGER is
			-- the size of the c address structure
		external
			"C"
		end

	inet_inaddr_any: INTEGER is
			-- a c constant
		external
			"C"
		end

	set_host_addr (addr: POINTER; value: INTEGER) is
		external
			"C"
		alias
			"set_sin_addr"
		end

	get_host_addr (addr: POINTER): INTEGER is
			-- get the host number from 'addr'
		external
			"C"
		alias
			"get_sin_addr"
		end

	net_host_addr(host_addr: POINTER): INTEGER is
			--  Convert the dotted string address to a host number
		external
			"C"
		end

	net_host (addr: POINTER): STRING is
		external
			"C"
		end

	host_address_from_name (addr, name: POINTER) is
			-- sets the host address in 'addr' using the
			-- name to identify the host.
		external
			"C"
		end

	set_from_c (addr: POINTER ptr: POINTER) is
			--  copies the address infor in 'ptr'
			-- to the addr object.
		external
			"C"
		end

end

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

