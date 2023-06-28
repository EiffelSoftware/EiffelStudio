note
	description: "[
			see II.23.1.8 Flags for ImplMap [PInvokeAttributes]
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_PINVOKE_ATTRIBUTES_ITEM

inherit
	PE_INTEGER_16_ITEM
		redefine
			make_from_item
		end

	PE_ATTRIBUTES_ITEM
		rename
			has_flag_16 as has_flag
		end

create
	make,
	make_from_item

convert
	value: {INTEGER_16}

feature {NONE} -- Initialization

	make_from_item (a_item: PE_ITEM)
		do
			Precursor (a_item)
			value := pointer.read_integer_16_le (0)
		end

feature -- Status report

	to_flags_string: STRING_8
		local
			v: NATURAL_16
		do
			create Result.make (0)
			v := value.to_natural_16

			--if has_flag (0x0, NoMangle,	v) then add_flag_to ("NoMangle", Result) end
			if has_flag (CharSetMask, CharSetNotSpec,v) then add_flag_to ("CharSetNotSpec", Result) end
			if has_flag (CharSetMask, CharSetAnsi,v) then add_flag_to ("ansi", Result) end
			if has_flag (CharSetMask, CharSetUnicode,v) then add_flag_to ("unicode", Result) end
			if has_flag (CharSetMask, CharSetAuto,v) then add_flag_to ("auto", Result) end
			if has_flag (CharSetMask, SupportsLastError,v) then add_flag_to ("SupportsLastError", Result) end

			if has_flag (CallConvMask, CallConvPlatformapi,v) then add_flag_to ("PlaformAPI", Result) end
			if has_flag (CallConvMask, CallConvCdecl,v) then add_flag_to ("Cdecl", Result) end
			if has_flag (CallConvMask, CallConvStdcall,v) then add_flag_to ("Stdcall", Result) end
			if has_flag (CallConvMask, CallConvThiscall,v) then add_flag_to ("thiscall", Result) end
			if has_flag (CallConvMask, CallConvFastcall,v) then add_flag_to ("Fastcall", Result) end

		end

--	to_string: STRING_32
--		do
--			Result := to_flags_string + Precursor
--		end

feature -- Flags

	NoMangle: NATURAL_16 = 0x0001 -- PInvoke is to use the member name as specified

feature -- Character set
	CharSetMask: NATURAL_16 = 0x0006 -- This is a resource file or other non-metadata-containing file.  These 2 bits contain one of the following values:
	CharSetNotSpec: NATURAL_16 = 0x0000 --
	CharSetAnsi: NATURAL_16 = 0x0002 --
	CharSetUnicode: NATURAL_16 = 0x0004 --
	CharSetAuto: NATURAL_16 = 0x0006 --
	SupportsLastError: NATURAL_16 = 0x0040 -- Information about target function. Not relevant for fields

feature -- Calling convention
	CallConvMask: NATURAL_16 = 0x0700 -- These 3 bits contain one of the following values:
	CallConvPlatformapi: NATURAL_16 = 0x0100 -- .
	CallConvCdecl: NATURAL_16 = 0x0200 -- .
	CallConvStdcall: NATURAL_16 = 0x0300 -- .
	CallConvThiscall: NATURAL_16 = 0x0400 -- .
	CallConvFastcall: NATURAL_16 = 0x0500 -- .

end
