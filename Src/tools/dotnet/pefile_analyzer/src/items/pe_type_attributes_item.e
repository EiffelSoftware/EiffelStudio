note
	description: "[
			See II.23.1.15 TypeAttributes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TYPE_ATTRIBUTES_ITEM

inherit
	PE_INTEGER_32_ITEM
		redefine
			make_from_item
		end

	PE_ATTRIBUTES_ITEM
		rename
			has_flag_32 as has_flag
		end

create
	make,
	make_from_item

convert
	value: {INTEGER_32}

feature {NONE} -- Initialization	

	make_from_item (a_item: PE_ITEM)
		do
			Precursor (a_item)
			value := pointer.read_integer_32_le (0)
		end

feature -- Status report

	to_flags_string: STRING_8
		local
			v: NATURAL_32
		do
			create Result.make (0)
			v := value.to_natural_32

			if has_flag (VisibilityMask, Public,	v) then add_flag_to ("Public", Result) else
				if has_flag (VisibilityMask, NotPublic,	v) then add_flag_to ("NotPublic", Result) end
			end

			if has_flag (LayoutMask, AutoLayout,	v) then add_flag_to ("auto", Result) end

			if has_flag (ClassSemanticsMask, Class_,	v) then add_flag_to ("Class", Result) end
			if has_flag (ClassSemanticsMask, Interface,	v) then add_flag_to ("Interface", Result) end

			if has_flag (0x0, Abstract,	v) then add_flag_to ("Abstract", Result) end
			if has_flag (0x0, Sealed,	v) then add_flag_to ("Sealed", Result) end
			if has_flag (0x0, SpecialName,	v) then add_flag_to ("SpecialName", Result) end

			if has_flag (StringFormatMask, AnsiClass,	v) then add_flag_to ("ansi", Result) end
			if has_flag (StringFormatMask, UnicodeClass,	v) then add_flag_to ("unicode", Result) end

			if has_flag (0x0, BeforeFieldInit,	v) then add_flag_to ("BeforeFieldInit", Result) end
		end

--	to_string: STRING_32
--		do
--			Result := to_flags_string + Precursor
--		end

feature -- Status report

	is_nested_private: BOOLEAN
		do
			Result := ((value.to_natural_32 & VisibilityMask) & NestedPrivate) = NestedPrivate
		end

feature -- Visbility attributes

	VisibilityMask: NATURAL_32 = 0x00000007

	NotPublic: NATURAL_32 = 0x00000000 -- Class has no public scope
	Public: NATURAL_32 = 0x00000001 -- Class has public scope
	NestedPublic: NATURAL_32 = 0x00000002 -- Class is nested with public visibility
	NestedPrivate: NATURAL_32 = 0x00000003 -- Class is nested with private visibility
	NestedFamily: NATURAL_32 = 0x00000004 -- Class is nested with family visibility
	NestedAssembly: NATURAL_32 = 0x00000005 -- Class is nested with assembly visibility
	NestedFamANDAssem: NATURAL_32 = 0x00000006 -- Class is nested with family and assembly visibility
	NestedFamORAssem: NATURAL_32 = 0x00000007 -- Class is nested with family or assembly visibility


feature -- Class layout attributes
	LayoutMask: NATURAL_32 = 0x00000018 --

	AutoLayout: NATURAL_32 = 0x00000000 -- Class fields are auto-laid out
	SequentialLayout: NATURAL_32 = 0x00000008 -- Class fields are laid out sequentially
	ExplicitLayout: NATURAL_32 = 0x00000010 -- Layout is supplied explicitly Class semantics attributes

feature -- Class semantics attributes

	ClassSemanticsMask: NATURAL_32 = 0x00000020 --

	Class_: NATURAL_32 = 0x00000000 -- Type is a class
	Interface: NATURAL_32 = 0x00000020 -- Type is an interface

feature -- Special semantics in addition to class semantics

	Abstract: NATURAL_32 = 0x00000080 -- Class is abstract
	Sealed: NATURAL_32 = 0x00000100 -- Class cannot be extended
	SpecialName: NATURAL_32 = 0x00000400 -- Class name is special

feature -- Implementation Attributes

	Import: NATURAL_32 = 0x00001000 -- Class/Interface is imported
	Serializable: NATURAL_32 = 0x00002000 -- Reserved (Class is serializable)

feature -- String formatting Attributes
	StringFormatMask: NATURAL_32 = 0x00030000 --
	AnsiClass: NATURAL_32 = 0x00000000 -- LPSTR is interpreted as ANSI
	UnicodeClass: NATURAL_32 = 0x00010000 -- LPSTR is interpreted as Unicode
	AutoClass: NATURAL_32 = 0x00020000 -- LPSTR is interpreted automatically
	CustomFormatClass: NATURAL_32 = 0x00030000 -- A non-standard encoding specified by CustomStringFormatMask
	CustomStringFormatMask: NATURAL_32 = 0x00C00000 -- Use this mask to retrieve non-standard encoding information for native interop. The meaning of the values of these 2 bits is unspecified.

feature -- Class Initialization Attributes
	BeforeFieldInit: NATURAL_32 = 0x00100000 -- Initialize the class before first static field access

feature -- Additional Flags
	RTSpecialName: NATURAL_32 = 0x00000800 -- CLI provides 'special' behavior, depending upon the name of the Type
	HasSecurity: NATURAL_32 = 0x00040000 -- Type has security associate with it IsTypeForwarder 0x00200000 This ExportedType entry is a type for

end
