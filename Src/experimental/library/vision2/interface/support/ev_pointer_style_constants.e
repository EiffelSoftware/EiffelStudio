note
	description: "Pointer sytle constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords	: "pixmap, cursor, default, pointer style"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_POINTER_STYLE_CONSTANTS

feature -- Enumeration

	Busy_cursor: INTEGER = 1
			-- Standard arrow and small hourglass

	Standard_cursor: INTEGER = 2
			-- Standard arrow

	Crosshair_cursor: INTEGER = 3
			-- Crosshair

	Help_cursor: INTEGER = 4
			-- Arrow and question mark

	Ibeam_cursor: INTEGER = 5
			-- I-beam displayed in editable widgets.

	No_cursor: INTEGER = 6
			-- Slashed_circle

	Sizeall_cursor: INTEGER = 7
			-- Four-pointed arrow pointing north, south, east and west

	Sizens_cursor: INTEGER = 8
			-- Double-pointed arrow pointing north and south

	Sizenwse_cursor: INTEGER = 9
			-- Double-pointed arrow pointing north-west and south-east

	Sizenesw_cursor: INTEGER = 10
			-- Double-pointed arrow pointing north-east and south-west

	Sizewe_cursor: INTEGER = 11
			-- Double-pointed arrow pointing west and east

	Uparrow_cursor: INTEGER = 12
			-- Vertical arrow

	Wait_cursor: INTEGER = 13
			-- Hourglass

	Header_sizewe_cursor: INTEGER = 14
			-- Double-pointed arrow pointing west and east used for header column resizing.

	Hyperlink_cursor: INTEGER = 15
			-- Used for hyperlinks

feature -- Query

	is_valid (a_integer: INTEGER): BOOLEAN
			-- If `a_integer' is valid?
		do
			Result := (Busy_cursor |..| Hyperlink_cursor).valid_index (a_integer)
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




end
