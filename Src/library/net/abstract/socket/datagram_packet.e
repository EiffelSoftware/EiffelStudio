indexing
	description: "A datagram packet for use with datagram sockets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DATAGRAM_PACKET

inherit
	PACKET
		redefine
			make, valid_position, put_element, element
		end

create

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
			Result.data.item.memory_copy (data.item + c_packet_number_size, l_count)
		end

	packet_number: INTEGER is
			-- Packet number of this packet
		require
			data_not_void: data /= Void
		do
			Result := c_get_number (data.item)
		end

	valid_position (pos: INTEGER): BOOLEAN is
			-- Is the position `pos' a valid data position?
		do
			Result := (pos >= 0 and pos < data_area_size)
		end

	element alias "[]"(pos: INTEGER): CHARACTER assign put_element is
			-- Element located at data position `pos'
		do
			Result := data.read_integer_8 (pos + c_packet_number_size).to_character_8
		end

feature -- Status_setting

	set_data (p: PACKET) is
			-- Set the data area of `p' into the current data area.
		require
			large_enough: p /= Void and then p.count <= data_area_size
		do
			(data.item + c_packet_number_size).memory_copy (p.data.item, p.count)
		end

	set_packet_number (n: INTEGER) is
			-- Set packet number of current packet.
		require
			number_big_enough: n >= c_int32_min
			number_small_enough: n <= c_int32_max
		do
			c_set_number (data.item, n)
		ensure
			number_set: packet_number = n
		end

	put_element (an_item: CHARACTER; pos: INTEGER) is
			-- Put `an_item' at data position `pos'.
		do
			data.put_integer_8 (an_item.code.to_integer_8, (pos + c_packet_number_size))
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




end -- class DATAGRAM_PACKET

