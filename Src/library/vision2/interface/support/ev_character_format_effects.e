indexing
	description: "[
		Objects that represent effects applicable to EiffelVision2 character formats.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_EFFECTS

inherit
	ANY
		redefine
			is_equal
		end

feature -- Status report

	is_striked_out: BOOLEAN
			-- Is the character striken out?
		
	is_underlined: BOOLEAN
			-- Is the character underlined?
			
	vertical_offset: INTEGER
			-- Vertical offset of character from base line in pixels.
			-- A positive value indicates a superscript, negative indicating a subscript.

feature -- Status setting

	enable_striked_out is
			-- Ensure characters are displayed as striken out, and set `is_striked_out' to True.
		do
			is_striked_out := True
		ensure
			is_striked_out: is_striked_out
		end
		
	disable_striked_out is
			-- Ensure characters are not displayed as striken out, and set `is_striked_out' to False.
		do
			is_striked_out := False
		ensure
			not_striked_out: not is_striked_out
		end
		
	enable_underlined is
			-- Ensure characters are displayed as underlined, and set `is_underlined' to True.
		do
			is_underlined := True
		ensure
			is_underlined: is_underlined
		end

	disable_underlined is
			-- Ensure characters are not displayed as underlined, and set `is_underlined' to False.
		do
			is_underlined := False
		ensure
			not_underlined: not is_underlined
		end
		
	set_vertical_offset (an_offset: INTEGER) is
			-- Assign `an_offset' to `vertical_offset'.
		do
			vertical_offset := an_offset
		ensure
			vertical_offset_set: vertical_offset = an_offset
		end
		
	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := (is_striked_out = other.is_striked_out) and then
				(is_underlined = other.is_underlined)
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




end -- class EV_CHARACTER_FORMAT_EFFECTS

