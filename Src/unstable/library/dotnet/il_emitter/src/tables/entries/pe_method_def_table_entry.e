note
	description: "Summary description for {PE_METHOD_DEF_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_DEF_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_method: PE_METHOD; a_iflags: INTEGER; a_mflags: INTEGER; a_name_index: NATURAL_64; a_signature_index: NATURAL_64; a_param_index: NATURAL_64)
		do
			rva := 0
			method := a_method
			impl_flags := a_iflags
			flags := a_mflags
			create name_index.make_with_index (a_name_index)
			create signature_index.make_with_index (a_signature_index)
			create param_index.make_with_index (a_param_index)
		ensure
			method_set: method = a_method

		end

feature -- Access

	method: detachable PE_METHOD
			-- write for rva.

	rva: INTEGER
			-- read only.

	impl_flags: INTEGER

	flags: INTEGER

	name_index: PE_STRING

	signature_index: PE_BLOB

	param_index: PE_PARAM_LIST

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

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tmethoddef.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write the method.rva to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_32_with_natural_64 (a_dest.to_special, if attached method as l_method then l_method.rva else {NATURAL_64} 0 end, 0)

				-- Initialize the number of bytes written
			l_bytes := 4
				-- Write implementation flags to the destination buffer.
			{BYTE_ARRAY_HELPER}.put_array_natural_16_with_integer_32 (a_dest.to_special, impl_flags, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2

				-- Write flags to the destination buffer.
			{BYTE_ARRAY_HELPER}.put_array_natural_16_with_integer_32 (a_dest.to_special, flags, l_bytes.to_integer_32)
			l_bytes := l_bytes + 2

				-- Write the name_index, signature_index, param_index
				-- to the buffer and update the number of bytes.

			l_bytes := l_bytes + name_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + signature_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + param_index.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the total number of bytes written.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Set the rva (from a_src)  to rva.
			rva := {BYTE_ARRAY_HELPER}.byte_array_to_integer_32 (a_src, 0)

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
