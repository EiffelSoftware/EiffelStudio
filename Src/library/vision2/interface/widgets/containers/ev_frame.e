indexing
	description: 
		"Displays an optionally labeled border around a widget."
	appearance:
		"+<`text'>-----+%N%
		%|             |%N%
		%|   `item'    |%N%
		%|             |%N%
		%+-------------+"
	status: "See notice at end of class"
	keywords: "container, frame, box, border, bevel, outline, raised, lowered"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_FRAME

inherit
	EV_CELL
		undefine
			create_implementation,
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_TEXT_ALIGNABLE
		redefine
			implementation,
			is_in_default_state
		end
		
	EV_FONTABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_FRAME_CONSTANTS
		export
			{NONE} all
			{ANY} valid_frame_border
		undefine
			default_create, copy
		end

create
	default_create,
	make_with_text

feature -- Access

	style: INTEGER is
			-- Visual appearance. See: EV_FRAME_CONSTANTS.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.style
		ensure
			bridge_ok: Result = implementation.style
		end

feature -- Element change

	set_style (a_style: INTEGER) is
			-- Assign `a_style' to `style'.
		require
			not_destroyed: not is_destroyed
			a_style_valid: valid_frame_border (a_style)
		do
			implementation.set_style (a_style)
		ensure
			style_assigned: style = a_style
		end

feature {NONE} -- Contract support
	
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CELL} and Precursor {EV_TEXT_ALIGNABLE} and
				is_left_aligned and style = feature {EV_FRAME_CONSTANTS}.Ev_frame_etched_in
				and Precursor {EV_FONTABLE}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_FRAME_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of frame.
		do
			create {EV_FRAME_IMP} implementation.make (Current)
		end

invariant
	valid_style: is_usable implies valid_frame_border (style)

end -- class EV_FRAME

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

