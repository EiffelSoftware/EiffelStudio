note
	description: "[
			See II.23.1.10 MethodAttributes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_ATTRIBUTES_ITEM

inherit
	PE_INTEGER_16_ITEM
		redefine
			to_string,
			make_from_item
		end

	PE_ATTRIBUTES_ITEM

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

			t := v & MemberAccessMask
			if (t & Private) = Private then
				Result.append ("Private ")
			end
			if (t & Family) = Family then
				Result.append ("Family ")
			end
			if (t & Public) = Public then
				Result.append ("Public ")
			end
			if (t & Static) = Static then
				Result.append ("Static ")
			end
			if (t & Final) = Final then
				Result.append ("Final ")
			end
			if (t & Virtual) = Virtual then
				Result.append ("Virtual ")
			end
			if (t & HideBySig) = HideBySig then
				Result.append ("HideBySig ")
			end

			t := v & VtableLayoutMask
--			if (t & ReuseSlot) = ReuseSlot then
--				Result.append ("ReuseSlot ")
--			end
--			if (t & NewSlot) = NewSlot then
--				Result.append ("NewSlot ")
--			end
			if (t & Strict) = Strict then
				Result.append ("Strict ")
			end
			if (t & Abstract) = Abstract then
				Result.append ("Abstract ")
			end

			if (t & SpecialName) = SpecialName then
				Result.append ("SpecialName ")
			end
		end

	to_string: STRING_32
		do
			Result := to_flags_string + Precursor
		end

feature -- Flags

	MemberAccessMask: NATURAL_16 = 0x0007	-- These 3 bits contain one of the following values:

	CompilerControlled: NATURAL_16 = 0x0000	-- Member not referenceable
	Private: NATURAL_16 = 0x0001	-- Accessible only by the parent type
	FamANDAssem: NATURAL_16 = 0x0002	-- Accessible by sub-types only in this Assembly
	Assem: NATURAL_16 = 0x0003	-- Accessibly by anyone in the Assembly
	Family: NATURAL_16 = 0x0004	-- Accessible only by type and sub-types
	FamORAssem: NATURAL_16 = 0x0005	-- Accessibly by sub-types anywhere, plus anyone in assembly
	Public: NATURAL_16 = 0x0006	-- Accessibly by anyone who has visibility to this scope
	Static: NATURAL_16 = 0x0010	-- Defined on type, else per instance
	Final: NATURAL_16 = 0x0020	-- Method cannot be overridden
	Virtual: NATURAL_16 = 0x0040	-- Method is virtual
	HideBySig: NATURAL_16 = 0x0080	-- Method hides by name+sig, else just by name

	VtableLayoutMask: NATURAL_16 = 0x0100	-- Use this mask to retrieve vtable attributes. This bit contains one of the following values:
	ReuseSlot: NATURAL_16 = 0x0000	-- Method reuses existing slot in vtable
	NewSlot: NATURAL_16 = 0x0100	-- Method always gets a new slot in the vtable
	Strict: NATURAL_16 = 0x0200	-- Method can only be overriden if also accessible
	Abstract: NATURAL_16 = 0x0400	-- Method does not provide an implementation
	SpecialName: NATURAL_16 = 0x0800	-- Method is special Interop attributes
	PInvokeImpl: NATURAL_16 = 0x2000	-- Implementation is forwarded through PInvoke
	UnmanagedExport: NATURAL_16 = 0x0008	-- Reserved: shall be zero for conforming implementations

feature -- Additional flags

	RTSpecialName: NATURAL_16 = 0x1000	-- CLI provides 'special' behavior, depending upon the name of the method
	HasSecurity: NATURAL_16 = 0x4000	-- Method has security associate with it
	RequireSecObject: NATURAL_16 = 0x8000	-- Method calls another method containing security code

end
