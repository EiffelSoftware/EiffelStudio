note
	description: "Summary description for {PE_METHOD_FLAGS}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_CONSTANTS

feature -- Flags

	TinyFormat: INTEGER = 2
			-- no local variables MAXstack <=8 size < 64;
	FatFormat: INTEGER = 3

		-- more flags only availble for FAT format
	MoreSects: INTEGER = 8
	InitLocals: INTEGER = 0x10

	CIL: INTEGER = 0x4000
			-- not a real flag either
	EntryPoint: INTEGER = 0x8000
			-- not a real flag that goes in the PE file

feature -- Table

	EHTable: INTEGER = 1
	OptILTable: INTEGER = 2
	EHFatFormat: INTEGER = 0x40
	EHMoreSects: INTEGER = 0x80

end
