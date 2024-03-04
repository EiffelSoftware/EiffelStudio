note
	description: "[
			note this is necessary for pinvokes, however, there will be one record in the METHODDEF table
			to give information about the function and its parameters.
			if the function has a variable length argument list, there will also be one entry in the MEMBERREF
			table for each invocation
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=ImplMap", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=256&zoom=100,116,440", "protocol=uri"

class
	PE_IMPL_MAP_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flag: INTEGER_16; a_method_index: PE_MEMBER_FORWARDED; a_import_name_index: NATURAL_32; a_module_index: NATURAL_32)
		do
			flags := a_flag
			method_index := a_method_index
			create import_name_index.make_with_index (a_import_name_index)
			create module_index.make_with_index (a_module_index)
		end

feature -- Status

	token_searching_supported: BOOLEAN = True

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (
					e.flags = flags and then
					e.method_index.is_equal (method_index) and then
					e.import_name_index.is_equal (import_name_index) and then
					e.module_index.is_equal (module_index)
				)
		end

feature -- Access

	flags: INTEGER_16
			-- a 2-byte bitmask of type PInvokeAttributes
			-- see https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=277&zoom=100,116,740

	method_index: PE_MEMBER_FORWARDED
			-- an index into the Field or MethodDef table; more precisely, a MemberForwarded

	import_name_index: PE_STRING
			-- The name of the unmanaged method as it is defined in the export table of the unmanaged module
			-- an index into the String heap

	module_index: PE_MODULE_REF
			-- an index into the ModuleRef table

feature -- Flags

	NoMangle: INTEGER = 0x0001 -- use the member name as specified

	CharSetMask: INTEGER = 0x0006
	CharSetNotSpec: INTEGER = 0x0000
	CharSetAnsi: INTEGER = 0x0002
	CharSetUnicode: INTEGER = 0x0004
	CharSetAuto: INTEGER = 0x0006

	BestFitUseAssem: INTEGER = 0x0000
	BestFitEnabled: INTEGER = 0x0010
	BestFitDisabled: INTEGER = 0x0020
	BestFitMask: INTEGER = 0x0030

	ThrowOnUnmappableCharUseAssem: INTEGER = 0x0000
	ThrowOnUnmappableCharEnabled: INTEGER = 0x1000
	ThrowOnUnmappableCharDisabled: INTEGER = 0x2000
	ThrowOnUnmappableCharMask: INTEGER = 0x3000

	SupportsLastError: INTEGER = 0x0040

	CallConvMask: INTEGER = 0x0700
	CallConvWinapi: INTEGER = 0x0100 -- Index_( will use native callconv appropriate to target windows platform.
	CallConvCdecl: INTEGER = 0x0200
	CallConvStdcall: INTEGER = 0x0300
	CallConvThiscall: INTEGER = 0x0400 -- In M9 Index_( will raise exception.

	CallConvFastcall: INTEGER = 0x0500

	MaxValue: INTEGER = 0xFFFF

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tImplMap
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write flags to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_integer_16 (a_dest, flags, 0)

				-- Intialize the number of bytes written
			l_bytes := 2

				-- Write method_index, import_name_index and module_index to the buffer and update the number of bytes.
			l_bytes := l_bytes + method_index.render (a_sizes, a_dest, l_bytes)
			l_bytes := l_bytes + import_name_index.render (a_sizes, a_dest, l_bytes)
			l_bytes := l_bytes + module_index.render (a_sizes, a_dest, l_bytes)

				-- Return the number of bytes written
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Set the flags (from a_src)  to flags
			flags := {BYTE_ARRAY_HELPER}.integer_16_at (a_src, 0)

				-- Intialize the number of bytes.
			l_bytes := 2

				-- Read method_index, import_name_index and module_index from the buffer and update the number of bytes.
			l_bytes := l_bytes + method_index.get (a_sizes, a_src, l_bytes)
			l_bytes := l_bytes + import_name_index.get (a_sizes, a_src, l_bytes)
			l_bytes := l_bytes + module_index.get (a_sizes, a_src, l_bytes)

				-- Return the number of bytes readed
			Result := l_bytes
		end
end
