indexing

	description:
		"A data packet for sending and receiving on a socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	PACKET

inherit
	TO_SPECIAL [CHARACTER] 
		rename
			area as data,
			make_area as make_data,
			valid_index as valid_position,
			item as element,
			put as put_element
		redefine
			copy, is_equal
		end

creation

	make

feature -- Initialization

	make (size: INTEGER) is
			-- Create a packet.
		require
			valid_size: size >= 0
		do
			make_data (size)
		end

feature -- Measurement

	count: INTEGER is
			-- Number of elements in packet
		do
			Result := data.count
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is current packet equal to `other'?
		do
			Result := data.is_equal (other.data)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying characters of `other'.
			-- (This is also used by `clone')
		do
			Precursor {TO_SPECIAL} (other)
			make (other.count)
			data.copy (other.data)
		ensure then
			size_valid: count = other.count
		end

invariant

	data_not_equal_void: data /= Void

end -- class PACKET

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
