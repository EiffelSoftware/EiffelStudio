note
	description: "Summary description for {PE_METHOD_DEF_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_DEF_TABLE_ENTRY

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

	make_with_data (a_method: PE_METHOD; a_iflags: INTEGER; a_mflags: INTEGER; a_name_index: NATURAL_64; a_signature_index: NATURAL_64; a_param_index: NATURAL_64 )
		do
			rva := 0
			method := a_method
			impl_flags := a_iflags
			flags := a_mflags
			create name_index.make_with_index (a_name_index)
			create signature_index.make_with_index (a_signature_index)
			create param_list.make_with_index (a_param_index)
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

	param_list: PE_PARAM_LIST

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

	render (a_sizes: ARRAY [NATURAL_64]; a_byte: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_byte: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

end
