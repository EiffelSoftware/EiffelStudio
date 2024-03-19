note
	description: "[
					Define a type of possible index type that occur in the tables we are interested in.
					e MethodDef, ModuleRef,TypeDef, TypeRef, or TypeSpec
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MEMBER_REF_PARENT

inherit
	PE_CODED_INDEX_BASE
		redefine
			get_index_shift,
			has_index_overflow,
			tag_for_table
		end

create
	make_with_tag_and_index

feature -- Enum: tags

		-- memberrefparent
	TagBits: INTEGER = 3
			-- MemberRefParent
			-- 1 bit to encode.

	TypeDef: INTEGER = 0
	TypeRef: INTEGER = 1
	ModuleRef: INTEGER = 2
	MethodDef: INTEGER = 3
	TypeSpec: INTEGER = 4

feature -- Access

	tag_for_table (tb_id: NATURAL_32): INTEGER_32
			-- <Precursor/>
		do
			inspect tb_id
			when {PE_TABLES}.ttypedef then Result := typedef
			when {PE_TABLES}.ttyperef then Result := typeref
			when {PE_TABLES}.tmoduleref then Result := moduleref
			when {PE_TABLES}.tmethoddef then Result := methoddef
			when {PE_TABLES}.ttypespec then Result := typespec
			else
				Result := Precursor (tb_id)
			end
		end

feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: SPECIAL [NATURAL_32]): BOOLEAN
		do
			Result := large (a_sizes, {PE_TABLES}.tTypeDef)
				or else large (a_sizes, {PE_TABLES}.tTypeRef)
				or else large (a_sizes, {PE_TABLES}.tmoduleref)
				or else large (a_sizes, {PE_TABLES}.tMethodDef)
				or else large (a_sizes, {PE_TABLES}.tTypeSpec)
		end

end

