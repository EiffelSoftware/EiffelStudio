indexing

	description:
		"A datagram packet for use with datagram sockets.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DATAGRAM_PACKET 

inherit

	PACKET
		rename
			make as old_make
		redefine
			valid_position, put_element, element
		end

	PACKET
		redefine
			make, valid_position, put_element, element
		select
			make
		end

creation

	make

feature -- Initialization

	make (size: INTEGER) is
		do
			old_make (size + int_size)
		end

feature -- Measurement

	data_area_size: INTEGER is
		do
			Result := count - int_size
		end

feature -- Status_report

	data_info: PACKET is
			-- return received data packet
		local
			ext: ANY
		do
			!!Result.make (data_area_size)
			ext := Result.data
			c_get_data ($ext, $data, Result.count)
		end

	packet_number: INTEGER is
			-- packet number of this packet
		require
			data_not_void: data /= Void
		do
			Result := c_get_number ($data)
		end

	valid_position (pos: INTEGER): BOOLEAN is
			-- Is the position 'pos' a valid data position
		do
			Result := (pos >= 0 and pos < (count - int_size))
		end

	element (pos: INTEGER): CHARACTER is
			-- Element located at data position 'pos'
		do
			Result := data.item (pos + int_size)
		end

feature -- Status_setting

	set_data (p: PACKET) is
			-- set the data area of 'p' into the current data area
		require
			large_enough: p /= Void and then p.count <= data_area_size
		local
			ext: ANY
		do
			ext := p.data
			c_set_data ($data, $ext, p.count)
		end

	set_packet_number (n: INTEGER) is
			-- set the packet number for this packet
		do
			c_set_number ($data, n)
		ensure
			number_set: packet_number = n
		end

	put_element (a_item: CHARACTER; pos: INTEGER) is
			-- put 'a_item' at data position 'pos'
		do
			data.put (a_item, (pos + int_size))
		ensure then
			element_put: element (pos) = a_item
		end

feature {NONE} -- Externals

	int_size: INTEGER is
			-- size to allow for packet number
		external
			"C"
		end

	c_get_number (pd: POINTER): INTEGER is
			-- get the packet number from the data area
		external
			"C"
		end

	c_set_number (pd: POINTER; num: INTEGER) is
			-- set the packet number in the data area
		external
			"C"
		end

	c_set_data (pd, sd: POINTER; sd_count: INTEGER) is
			-- set the data into the data area
		external
			"C"
		end

	c_get_data (rd, pd: POINTER; pd_count: INTEGER) is
			-- get the data from the data area
		external
			"C"
		end

end -- class DATAGRAM_PACKET

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

