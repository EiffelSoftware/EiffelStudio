note
	description: "GpStatus enumeration for Gdi+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_STATUS

feature -- Enumeration

	Ok: INTEGER = 0
			-- Ok

    GenericError: INTEGER = 1
			-- GenericError

    InvalidParameter: INTEGER = 2
			-- InvalidParameter

    OutOfMemory: INTEGER = 3
			-- OutOfMemory

    ObjectBusy: INTEGER = 4
			-- ObjectBusy

    InsufficientBuffer: INTEGER = 5
			-- InsufficientBuffer

    NotImplemented: INTEGER = 6
			-- NotImplemented

    Win32Error: INTEGER = 7
			-- Win32Error

    WrongState: INTEGER = 8
			-- WrongState

    Aborted: INTEGER = 9
			-- Aborted

    FileNotFound: INTEGER = 10
			-- FileNotFound

    ValueOverflow: INTEGER = 11
			-- ValueOverflow

    AccessDenied: INTEGER = 12
			-- AccessDenied

    UnknownImageFormat: INTEGER = 13
			-- UnknownImageFormat

    FontFamilyNotFound: INTEGER = 14
			-- FontFamilyNotFound

    FontStyleNotFound: INTEGER = 15
			-- FontStyleNotFound

    NotTrueTypeFont: INTEGER = 16
			-- NotTrueTypeFont

    UnsupportedGdiplusVersion: INTEGER = 17
			-- UnsupportedGdiplusVersion

    GdiplusNotInitialized: INTEGER = 18
			-- GdiplusNotInitialized

    PropertyNotFound: INTEGER = 19
			-- PropertyNotFound

    PropertyNotSupported: INTEGER = 20;
			-- PropertyNotSupported

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
