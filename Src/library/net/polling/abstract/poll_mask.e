note

	description:
		"A mask for use with a medium poller."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	POLL_MASK

inherit
	ANY
		redefine
			is_equal, copy
		end

create
	make

feature -- Initialization

	make
			-- Create mask.
		do
			create mask.make (mask_size)
			clear
		end

feature -- Access

	mask: MANAGED_POINTER
			-- Hold data.

feature -- Measurement

	count: INTEGER
			-- Size of mask in bytes
		do
			Result := mask.count
		end

feature -- Comparison

	is_equal (other: like Current ): BOOLEAN
			-- Is current mask equal to `other' ?
		do
			Result := mask.is_equal (other.mask)
		end

feature -- Status report

	is_medium_ready (s: IO_MEDIUM): BOOLEAN
			-- Is the bit identified by the medium `s' handle set ?
		require
			valid_medium: s /= Void and then not s.is_closed
		do
			Result := c_is_bit_set (mask.item, s.handle)
		end;

	is_bit_set (b: INTEGER): BOOLEAN
			-- Is the bit identified by `b' set ?
		do
			Result := c_is_bit_set (mask.item, b)
		end

feature -- Status setting

	clear
			-- Blank out all bits in mask.
		do
			c_zero_mask (mask.item)
		end;

	clear_bit (b: INTEGER)
			-- Clear bit at position `b' in mask.
		do
			c_mask_clear (mask.item, b)
		ensure
			has_cleared: not is_bit_set (b)
		end;

	clear_medium (s: IO_MEDIUM)
			-- Clear bit at medium `s' handle position, in mask.
		require
			valid_medium: s /= Void and then not s.is_closed
		do
			c_mask_clear (mask.item, s.handle)
		ensure
			has_cleared: not is_bit_set (s.handle)
		end;

	set_medium (s: IO_MEDIUM)
			-- Set bit at medium `s' handle position, in mask.
		require
			valid_medium: s /= Void and then not s.is_closed
		do
			c_set_bit (mask.item, s.handle)
		ensure
			has_set: is_bit_set (s.handle)
		end;

	set_bit (b: INTEGER)
			-- Set bit at position `b' in mask.
		do
			c_set_bit (mask.item, b)
		ensure
			has_set: is_bit_set (b)
		end

feature -- Duplication

	copy (other: like Current)
			-- Reinitialize by copying the characters of `other'.
			-- (This is also used by `clone'.)
		do
			standard_copy (other)
			create mask.make (other.count)
			mask.copy (other.mask)
		ensure then
			size_valid: count = other.count or else count = mask_size
		end

feature {NONE} -- External

	mask_size: INTEGER
			-- Get size of poll mask in number of characters.
		external
			"C"
		end;

	c_mask_clear (a_mask: POINTER; pos: INTEGER)
			-- Clear bit number `pos' in mask pointed by `a_mask'.
		external
			"C"
		end;

	c_set_bit (a_mask: POINTER; pos: INTEGER)
			-- Set bit number `pos' in mask pointed by `a_mask'.
		external
			"C"
		end;

	c_is_bit_set (a_mask: POINTER; pos: INTEGER): BOOLEAN
			-- Is bit number `pos' set in mask pointed by `a_mask' ?
		external
			"C"
		end;

	c_zero_mask (a_mask: POINTER)
			-- Clear all bits in mask `a_mask'.
		external
			"C"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class POLL_MASK

