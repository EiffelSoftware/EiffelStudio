indexing

	description:
		"A datagram packet for use with datagram sockets.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	DATAGRAM_PACKET 

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
			-- Create a packet of buffer size `size'.
		do
			old_make (size + c_packet_number_size)
		end

feature -- Measurement

	data_area_size: INTEGER is
			-- Size of packet buffer
		do
			Result := count - c_packet_number_size
		end

feature -- Status_report

	data_info: PACKET is
			-- Return received data packet.
		local
			ext: ANY
		do
			create Result.make (data_area_size);
			ext := Result.data;
			c_get_data ($ext, $data, Result.count)
		end;

	packet_number: INTEGER is
			-- Packet number of this packet
		require
			data_not_void: data /= Void
		do
			Result := c_get_number ($data)
		end;

	valid_position (pos: INTEGER): BOOLEAN is
			-- Is the position `pos' a valid data position?
		do
			Result := (pos >= 0 and pos < data_area_size)
		end;

	element (pos: INTEGER): CHARACTER is
			-- Element located at data position `pos'
		do
			Result := data.item (pos + c_packet_number_size)
		end

feature -- Status_setting

	set_data (p: PACKET) is
			-- Set the data area of `p' into the current data area.
		require
			large_enough: p /= Void and then p.count <= data_area_size
		local
			ext: ANY
		do
			ext := p.data;
			c_set_data ($data, $ext, p.count)
		end;

	set_packet_number (n: INTEGER) is
			-- Set packet number of current packet.
		require
			number_big_enough: n >= c_int32_min;
			number_small_enough: n <= c_int32_max
		do
			c_set_number ($data, n)
		ensure
			number_set: packet_number = n
		end;

	put_element (an_item: CHARACTER; pos: INTEGER) is
			-- Put `an_item' at data position `pos'.
		do
			data.put (an_item, (pos + c_packet_number_size))
		ensure then
			element_put: element (pos) = an_item
		end

feature {NONE} -- Externals

	c_packet_number_size: INTEGER is
			-- Offset to effectively access the data in the packet
		external
			"C"
		end;

	c_get_number (pd: POINTER): INTEGER is
			-- Get packet number from the `pd' pointed data area.
		external
			"C"
		end;

	c_set_number (pd: POINTER; num: INTEGER) is
			-- Set packet number with ` num' in the `pd' pointed data area.
		external
			"C"
		end;

	c_set_data (pd, sd: POINTER; sd_count: INTEGER) is
			-- Set the data from `pd' pointed area into the `sd'
			-- pointed area with `sd_count' amount of bytes.
		external
			"C"
		end;

	c_get_data (rd, pd: POINTER; pd_count: INTEGER) is
			-- Get the data from `rd' pointed area into the `pd'
			-- pointed area with `sd_count' amount of bytes.
		external
			"C"
		end

feature -- Externals

	c_int32_min: INTEGER is
			-- Min value for a signed integer 32 bits
		external
			"C [macro %"eif_portable.h%"]"
		alias
			"INT32_MIN"
		end;

	c_int32_max: INTEGER is
			-- Max value for signed integer 32 bits
		external
			"C [macro %"eif_portable.h%"]"
		alias
			"INT32_MAX"
		end

end -- class DATAGRAM_PACKET



--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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

