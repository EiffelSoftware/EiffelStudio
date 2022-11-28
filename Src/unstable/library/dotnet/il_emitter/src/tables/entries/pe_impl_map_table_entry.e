note
	description: "[
			note this is necessary for pinvokes, however, there will be one record in the METHODDEF table
			to give information about the function and its parameters.
			if the function has a variable length argument list, there will also be one entry in the MEMBERREF
			table for each invocation
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_IMPL_MAP_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flag: INTEGER; a_method_index: PE_MEMBER_FORWARDED; a_import_name_index: NATURAL_64; a_module_index: NATURAL_64)
		do
			flags := a_flag
			method_index := a_method_index
			create import_name_index.make_with_index (a_import_name_index)
			create module_index.make_with_index (a_module_index)
		end

feature -- Access

	flags: INTEGER

	method_index: PE_MEMBER_FORWARDED

	import_name_index: PE_STRING
			-- The name of the unmanaged method as it is defined in the export table of the unmanaged module

	module_index: PE_MODULE_REF

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

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tImplMap.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

end
