note
	description: "Object representing the MethodDef table"
	date: "$Date$"
	revision: "$Revision$"
	see: "II.22.26 MethodDef : 0x06 "
	EIS: "name=MethodDef", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=259", "protocol=uri"

class
	PE_METHOD_DEF_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_method,
	make_without_param_index

feature {NONE} -- Initialization

	make_with_method (a_method: PE_METHOD; a_iflags: INTEGER_16; a_mflags: INTEGER_16; a_name_index: NATURAL_32; a_signature_index: NATURAL_32; a_param_index: NATURAL_32)
		do
			rva := 0
			method := a_method
			impl_flags := a_iflags
			flags := a_mflags
			create name_index.make_with_index (a_name_index)
			create signature_index.make_with_index (a_signature_index)
			create param_index.make_with_index (a_param_index)
			is_param_list_index_set := True
		ensure
			method_set: method = a_method
		end

	make_without_param_index (a_iflags: INTEGER_16; a_mflags: INTEGER_16; a_name_index: NATURAL_32; a_signature_index: NATURAL_32)
		do
			rva := 0
			impl_flags := a_iflags
			flags := a_mflags
			create name_index.make_with_index (a_name_index)
			create signature_index.make_with_index (a_signature_index)
			create param_index.make_with_index ({PE_PARAM_LIST}.default_index) -- Fake data
			is_param_list_index_set := False
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| If Flags.CompilerControlled = 1, then this row is ignored completely in duplicate
			--| checking.
			--|	There shall be no duplicate rows in the MethodDef table, based upon owner + Name
			--| + Signature (where owner is the owning row in the TypeDef table). (Note that the
			--| Signature encodes whether or not the method is generic, and for generic methods, it
			--| encodes the number of generic parameters.) (Note, however, that if
			--| Flags.CompilerControlled = 1, then this row is excluded from duplicate checking)
		do
			Result := Precursor (e)
				or else (
					e.impl_flags /= 1 and then
					e.signature_index.is_equal (signature_index) and then
					e.name_index.is_equal (name_index)
						)
		end

feature -- Access

	method: detachable PE_METHOD
			-- write for rva.

	rva: NATURAL_32
			-- rva

	impl_flags: INTEGER_16
			-- 2-byte bitmask of type MethodImplAttributes.

	flags: INTEGER_16
			-- 2-byte bitmask of type MethodAttributes

	name_index: PE_STRING
			-- index in the string heap

	signature_index: PE_BLOB
			-- index in the blob heap

	param_index: PE_PARAM_LIST
			-- index into the Param table

feature -- Status report			

	is_param_list_index_set: BOOLEAN

feature -- Element change

	set_param_list_index (idx: NATURAL_32)
		require
			not is_param_list_index_set
		do
			param_index.update_index (idx)
			is_param_list_index_set := True
		ensure
			is_param_list_index_set
		end

feature -- Enum: Implementation Flags

	CodeTypeMask: INTEGER = 0x0003 -- Flags about code type.
	IL: INTEGER = 0x0000 -- Method impl is IL.
	Native: INTEGER = 0x0001 -- Method impl is native.
	OPTIL: INTEGER = 0x0002 -- Method impl is OPTIL
	Runtime: INTEGER = 0x0003 -- Method impl is provided by the runtime.
	ManagedMask: INTEGER = 0x0004 -- Flags specifying whether the code is managed
			-- or unmanaged.
	Unmanaged: INTEGER = 0x0004 -- Method impl is unmanaged otherwise managed.
	Managed: INTEGER = 0x0000 -- Method impl is managed.

	ForwardRef: INTEGER = 0x0010 -- Indicates method is defined; used primarily
			-- in merge scenarios.
	PreserveSig: INTEGER = 0x0080 -- Indicates method sig is not to be mangled to
			-- do HRESULT conversion.

	InternalCall: INTEGER = 0x1000 -- Reserved for internal use.

	Synchronized: INTEGER = 0x0020 -- Method is single threaded through the body.
	NoInlining: INTEGER = 0x0008 -- Method may not be inlined.
	MaxMethodImplVal: INTEGER = 0xffff -- Range check value

feature -- Enum: flags

	MemberAccessMask: INTEGER = 0x0007
	PrivateScope: INTEGER = 0x0000
	Private: INTEGER = 0x0001
	FamANDAssem: INTEGER = 0x0002
	Assem: INTEGER = 0x0003
	Family: INTEGER = 0x0004
	FamORAssem: INTEGER = 0x0005
	Public: INTEGER = 0x0006

	Static: INTEGER = 0x0010
	Final: INTEGER = 0x0020
	Virtual: INTEGER = 0x0040
	HideBySig: INTEGER = 0x0080

	VtableLayoutMask: INTEGER = 0x0100

	ReuseSlot: INTEGER = 0x0000 -- The default.
	NewSlot: INTEGER = 0x0100

		-- implementation attribs
	CheckAccessOnOverride: INTEGER = 0x0200
	Abstract: INTEGER = 0x0400
	SpecialName: INTEGER = 0x0800

	PinvokeImpl: INTEGER = 0x2000

	UnmanagedExport: INTEGER = 0x0008

		-- Reserved flags for runtime use only.

	ReservedMask: INTEGER = 0xd000
	RTSpecialName: INTEGER = 0x1000

	HasSecurity: INTEGER = 0x4000
	RequireSecObject: INTEGER = 0x8000

feature -- Set Rva

	set_rva (a_value: like rva)
			-- Set rva with a_value.
		require
			valid_value: a_value > 0
		do
			rva := a_value
		ensure
			rva_set: rva = a_value
		end

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tmethoddef
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write the method.rva to the destination buffer `a_dest`.
			if attached method as l_method then
				{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest, l_method.rva, 0)
			else
				{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest, rva, 0)
			end
				-- Initialize the number of bytes written
			l_bytes := 4

				-- Write implementation flags to the destination buffer.
			{BYTE_ARRAY_HELPER}.put_array_integer_16 (a_dest, impl_flags, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2

				-- Write flags to the destination buffer.
			{BYTE_ARRAY_HELPER}.put_array_integer_16 (a_dest, flags, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2

				-- Write the name_index, signature_index, param_index
				-- to the buffer and update the number of bytes.

			l_bytes := l_bytes + name_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + signature_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + param_index.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Set the rva (from a_src)  to rva.
			rva := {BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src, 0)

				-- Initialize the number of bytes readed.
			l_bytes := 4

				-- Set the implementation flags (from a_src)  to impl_flags.
			impl_flags := {BYTE_ARRAY_HELPER}.byte_array_to_integer_16 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2

				-- Set the flags (from a_src)  to flags.
			flags := {BYTE_ARRAY_HELPER}.byte_array_to_integer_16 (a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2

				-- Get the name_index, signature_index, param_index
				-- to the buffer and update the number of bytes.

			l_bytes := l_bytes + name_index.render (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + signature_index.render (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + param_index.render (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
