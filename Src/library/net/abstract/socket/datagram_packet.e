indexing
	description: "A datagram packet for use with datagram sockets."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	DATAGRAM_PACKET 

inherit
	PACKET
		redefine
			make, valid_position, put_element, element
		end

creation

	make

feature -- Initialization

	make (size: INTEGER) is
			-- Create a packet of buffer size `size'.
		do
			Precursor {PACKET} (size + c_packet_number_size)
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
			l_count: INTEGER
		do
			l_count:= data_area_size
			create Result.make (l_count)
			Result.data.area.memory_copy (data.area + c_packet_number_size, l_count)
		end

	packet_number: INTEGER is
			-- Packet number of this packet
		require
			data_not_void: data /= Void
		do
			Result := c_get_number (data.area)
		end

	valid_position (pos: INTEGER): BOOLEAN is
			-- Is the position `pos' a valid data position?
		do
			Result := (pos >= 0 and pos < data_area_size)
		end

	element (pos: INTEGER): CHARACTER is
			-- Element located at data position `pos'
		do
			Result := data.item (pos + c_packet_number_size).ascii_char
		end

feature -- Status_setting

	set_data (p: PACKET) is
			-- Set the data area of `p' into the current data area.
		require
			large_enough: p /= Void and then p.count <= data_area_size
		do
			(data.area + c_packet_number_size).memory_copy (p.data.area, p.count)
		end

	set_packet_number (n: INTEGER) is
			-- Set packet number of current packet.
		require
			number_big_enough: n >= c_int32_min
			number_small_enough: n <= c_int32_max
		do
			c_set_number (data.area, n)
		ensure
			number_set: packet_number = n
		end

	put_element (an_item: CHARACTER; pos: INTEGER) is
			-- Put `an_item' at data position `pos'.
		do
			data.put (an_item.code.to_integer_8, (pos + c_packet_number_size))
		ensure then
			element_put: element (pos) = an_item
		end

feature {NONE} -- Externals

	c_packet_number_size: INTEGER is
			-- Offset to effectively access the data in the packet
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"sizeof(uint32)"
		end

	c_get_number (pd: POINTER): INTEGER is
			-- Get packet number from the `pd' pointed data area.
		external
			"C"
		end

	c_set_number (pd: POINTER; num: INTEGER) is
			-- Set packet number with ` num' in the `pd' pointed data area.
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
		end

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

