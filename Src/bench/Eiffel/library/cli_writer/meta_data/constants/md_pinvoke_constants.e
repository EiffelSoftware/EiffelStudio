indexing
	description: "Flags to define a Pinvoke routine in call to `MD_EMIT.define_pinvoke_map'"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_PINVOKE_CONSTANTS

feature -- Access

  	no_mangle: INTEGER_16 is 0x0001
			-- Pinvoke is to use the member name as specified.

feature -- Access: CharSet information

	charset_mask: INTEGER_16 is 0x0006
			-- Use this mask to retrieve the CharSet information.

	charset_not_specified: INTEGER_16 is 0x0000
	charset_ansi: INTEGER_16 is 0x0002
	charset_unicode: INTEGER_16 is 0x0004
	charset_auto: INTEGER_16 is 0x0006

	supports_last_error: INTEGER_16 is 0x0040
			-- Information about target function. Not relevant for fields.

feature -- Access: calling convention

	calling_convention_mask: INTEGER_16 is 0x0700

	winapi: INTEGER_16 is 0x0100
			-- Pinvoke will use native callconv appropriate to target windows platform.

	cdecl: INTEGER_16 is 0x0200
	stdcall: INTEGER_16 is 0x0300

	thiscall: INTEGER_16 is 0x0400
			-- In M9, pinvoke will raise exception.

	fastcall: INTEGER_16 is 0x0500

end -- class MD_PINVOKE_CONSTANTS
