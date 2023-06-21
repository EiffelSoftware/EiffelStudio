note
	description: "[
			See II.23.1.11 MethodImplAttributes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_IMPL_ATTRIBUTES_ITEM

inherit
	PE_INTEGER_16_ITEM
		redefine
			to_string,
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
			t: NATURAL_16
		do
			create Result.make (0)
			v := value.to_natural_16

			-- TODO ...
			if has_flag (CodeTypeMask, IL,	v) then Result.append ("IL ") end
		end

	to_string: STRING_32
		do
			Result := to_flags_string + Precursor
		end

feature -- Flags

	CodeTypeMask: NATURAL_16 = 0x0003	-- These 2 bits contain one of the following values:
	IL: NATURAL_16 = 0x0000	-- Method impl is CIL
	Native: NATURAL_16 = 0x0001	-- Method impl is native
	OPTIL: NATURAL_16 = 0x0002	-- Reserved: shall be zero in conforming implementations
	Runtime: NATURAL_16 = 0x0003	-- Method impl is provided by the runtime

	ManagedMask: NATURAL_16 = 0x0004	-- Flags specifying whether the code is managed or unmanaged.  This bit contains one of the following values:
	Unmanaged: NATURAL_16 = 0x0004	-- Method impl is unmanaged, otherwise managed
	Managed: NATURAL_16 = 0x0000	-- Method impl is managed Implementation info and interop
	ForwardRef: NATURAL_16 = 0x0010	-- Indicates method is defined; used primarily in merge scenarios
	PreserveSig: NATURAL_16 = 0x0080	-- Reserved: conforming implementations can ignore
	InternalCall: NATURAL_16 = 0x1000	-- Reserved: shall be zero in conforming implementations
	Synchronized: NATURAL_16 = 0x0020	-- Method is single threaded through the body
	NoInlining: NATURAL_16 = 0x0008	-- Method cannot be inlined
	MaxMethodImplVal: NATURAL_16 = 0xffff	-- Range check value
	NoOptimization: NATURAL_16 = 0x0040	-- Method will not be optimized when generating native code	

end
