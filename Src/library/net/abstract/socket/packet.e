indexing
	description: "A data packet for sending and receiving on a socket.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	PACKET

inherit
	ANY
		redefine
			copy, is_equal
		end
		
create
	make,
	make_from_memory_stream

feature -- Initialization

	make (size: INTEGER) is
			-- Create a packet.
		require
			valid_size: size >= 0
		do
			create data.make (size)
		end

	make_from_memory_stream (a_data: like data) is
			-- Create packet from `a_data' memory stream.
		require
			a_data_not_void: a_data /= Void
		do
			data := a_data
		ensure
			data_set: data = a_data
		end
		
feature -- Measurement

	count: INTEGER is
			-- Number of elements in packet
		do
			Result := data.count
		end

feature -- Access

	element, infix "@" (i: INTEGER): CHARACTER is
			-- Entry at index `i'.
		require
			valid_position: valid_position (i)			
		do
			Result := data.item (i).ascii_char
		end
		
feature -- Status report

	valid_position (i: INTEGER): BOOLEAN is
			-- Is `i' within the bounds of Current?
		do
			Result := (0 <= i) and then (i < count)
		end
		
feature -- Element change

	put_element (v: CHARACTER; i: INTEGER) is
			-- Replace `i'-th entry by `v'.
		require
			valid_position: valid_position (i)
		do
			data.put (v.code.to_integer_8, i)
		ensure
			inserted: element (i) = v
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
			make (other.count)
			data.copy (other.data)
		ensure then
			size_valid: count = other.count
		end

feature -- Storage

	data: MEMORY_STREAM
			-- Place holder
			
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
