note
	description: "Define a type of possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_CUSTOM_ATTRIBUTE

inherit

	PE_INDEX_BASE
		rename
			make as make_base
		redefine
			get_index_shift,
			has_index_overflow
		end

	HASHABLE

create
	make_with_tag_and_index,
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Enum: tags

	TagBits: INTEGER = 5
	MethodDef: INTEGER = 0
	FieldDef: INTEGER = 1
	TypeRef: INTEGER = 2
	TypeDef: INTEGER = 3
	ParamDef: INTEGER = 4
	InterfaceImpl: INTEGER = 5
	MemberRef: INTEGER = 6
	Module: INTEGER = 7
	Permission: INTEGER = 8
	Property: INTEGER = 9
	Event: INTEGER = 10
	StandaloneSig: INTEGER = 11
	ModuleRef: INTEGER = 12
	TypeSpec: INTEGER = 13
	Assembly: INTEGER = 14
	AssemblyRef: INTEGER = 15
	File: INTEGER = 16
	ExportedType: INTEGER = 17
	ManifestResource: INTEGER = 18

feature -- Access

	hash_code: INTEGER
			-- Hash code value
		do
			Result := index.to_integer_32.hash_code
		end

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_64]): BOOLEAN
		do
			Result := large (a_sizes [{PE_TABLES}.tMethodDef.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tField.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tTypeRef.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tTypeDef.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tParam.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tImplMap.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tMemberRef.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tModule.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tStandaloneSig.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tModuleRef.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tTypeSpec.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tAssemblyDef.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tAssemblyRef.to_integer_32 + 1].to_natural_32)
		end

end
