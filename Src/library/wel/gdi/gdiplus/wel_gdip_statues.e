indexing
	description: "GpStatus enumeration for Gdi+."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_STATUS

feature -- Enumeration

	Ok: INTEGER is 0
			-- Ok

    GenericError: INTEGER is 1
			-- GenericError

    InvalidParameter: INTEGER is 2
			-- InvalidParameter

    OutOfMemory: INTEGER is 3
			-- OutOfMemory

    ObjectBusy: INTEGER is 4
			-- ObjectBusy

    InsufficientBuffer: INTEGER is 5
			-- InsufficientBuffer

    NotImplemented: INTEGER is 6
			-- NotImplemented

    Win32Error: INTEGER is 7
			-- Win32Error

    WrongState: INTEGER is 8
			-- WrongState

    Aborted: INTEGER is 9
			-- Aborted

    FileNotFound: INTEGER is 10
			-- FileNotFound

    ValueOverflow: INTEGER is 11
			-- ValueOverflow

    AccessDenied: INTEGER is 12
			-- AccessDenied

    UnknownImageFormat: INTEGER is 13
			-- UnknownImageFormat

    FontFamilyNotFound: INTEGER is 14
			-- FontFamilyNotFound

    FontStyleNotFound: INTEGER is 15
			-- FontStyleNotFound

    NotTrueTypeFont: INTEGER is 16
			-- NotTrueTypeFont

    UnsupportedGdiplusVersion: INTEGER is 17
			-- UnsupportedGdiplusVersion

    GdiplusNotInitialized: INTEGER is 18
			-- GdiplusNotInitialized

    PropertyNotFound: INTEGER is 19
			-- PropertyNotFound

    PropertyNotSupported: INTEGER is 20
			-- PropertyNotSupported

end
