indexing

	description:
		"A data packet for sending %
		%and receiving on a socket.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	PACKET
	
inherit
	TO_SPECIAL[CHARACTER] 
		rename
			area as data,
			make_area as make_data,
			copy as old_copy
		redefine
			is_equal
		end;

	TO_SPECIAL[CHARACTER] 
		rename
			area as data,
			make_area as make_data
		redefine
			copy, is_equal
		select
			copy
		end;
creation

	make

feature 	-- Initialization

	make (size: INTEGER) is
			-- create a packet
		require
			valid_size: size >= 0;
		do
			make_data (size);
		end;

feature 	-- Access

	element (pos: INTEGER): CHARACTER is
			-- return element at position 'pos'
		require
			pos_valid: valid_position (pos);
		do
			Result := data.item (pos);
		end;

feature 	-- Measurement

	count: INTEGER is
			-- number of elements in packet
		do
			Result := data.count;
		end;

feature 	-- Comparsion

	is_equal (other: like Current): BOOLEAN is
			-- is Current equal to other
		do
			Result := data.is_equal (other.data);
		end;

feature 	-- Status report

	valid_position (pos: INTEGER): BOOLEAN is
			-- Is position 'pos' valid for this packet
		do
			Result := (pos >= 0 and pos < count);
		end;

feature 	-- Element change

	put_element (a_item: CHARACTER; pos: INTEGER) is
		require
			pos_valid: valid_position (pos);
		do
			data.put (a_item, pos)
		end;

feature 	-- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying the characters of `other'.
			-- (This is also used by `clone'.)
		do
			old_copy (other);
			make (other.count);
			data.copy (other.data);
		ensure then
			size_valid: count = other.count;
		end;

invariant
	data_not_equal_void: data /= Void;
end	-- class packet


--|----------------------------------------------------------------
--| Eiffelnet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
