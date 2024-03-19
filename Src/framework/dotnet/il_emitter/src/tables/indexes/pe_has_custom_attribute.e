note
	description: "Define a type of possible index type that occur in the tables we are interested in. See HasCustomAttribute"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_HAS_CUSTOM_ATTRIBUTE

inherit
	PE_CODED_INDEX_BASE
		redefine
			get_index_shift,
			has_index_overflow,
			tag_for_table
		end

	HASHABLE
		undefine
			is_equal
		end

create
	make_with_tag_and_index

feature -- Enum: tags

	TagBits: INTEGER = 5
			-- HasCutomAttribute
			-- https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=299&zoom=100,116,96

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

		-- Not used now but needed in the future
	GenericParam: INTEGER = 19
	GenericParamConstraint: INTEGER = 20
	MethodSpec: INTEGER = 21

feature -- Access

	tag_for_table (tb_id: NATURAL_32): INTEGER_32
			-- <Precursor/>
		do
			inspect tb_id
			when {PE_TABLES}.tmethoddef then Result := methoddef
			when {PE_TABLES}.tfield then Result := fielddef
			when {PE_TABLES}.ttyperef then Result := TypeRef
			when {PE_TABLES}.ttypedef then Result := TypeDef
			when {PE_TABLES}.tparam then Result := paramdef
			when {PE_TABLES}.tinterfaceimpl then Result := InterfaceImpl
			when {PE_TABLES}.tmemberref then Result := MemberRef
			when {PE_TABLES}.tmodule then Result := Module
			when {PE_TABLES}.tdeclsecurity then Result := Permission
			when {PE_TABLES}.tproperty then Result := Property
			when {PE_TABLES}.tevent then Result := Event
			when {PE_TABLES}.tstandalonesig then Result := StandaloneSig
			when {PE_TABLES}.tmoduleref then Result := ModuleRef
			when {PE_TABLES}.ttypespec then Result := TypeSpec
			when {PE_TABLES}.tassemblydef then Result := Assembly
			when {PE_TABLES}.tassemblyref then Result := AssemblyRef
			when {PE_TABLES}.tfile then Result := File
			when {PE_TABLES}.texportedtype then Result := ExportedType
			when {PE_TABLES}.tmanifestresource then Result := ManifestResource
			when {PE_TABLES}.tgenericparam then Result := GenericParam
			when {PE_TABLES}.tgenericparamconstraint then Result := GenericParamConstraint
			when {PE_TABLES}.tmethodspec then Result := MethodSpec
			else
				Result := Precursor (tb_id)
			end
		end

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

	has_index_overflow (a_sizes: SPECIAL [NATURAL_32]): BOOLEAN
		do
			Result := large (a_sizes, {PE_TABLES}.tMethodDef)
				or else large (a_sizes, {PE_TABLES}.tField)
				or else large (a_sizes, {PE_TABLES}.tTypeRef)
				or else large (a_sizes, {PE_TABLES}.tTypeDef)
				or else large (a_sizes, {PE_TABLES}.tParam)
				or else large (a_sizes, {PE_TABLES}.tinterfaceimpl)
				or else large (a_sizes, {PE_TABLES}.tMemberRef)
				or else large (a_sizes, {PE_TABLES}.tModule)
				or else large (a_sizes, {PE_TABLES}.tStandaloneSig)
				or else large (a_sizes, {PE_TABLES}.tModuleRef)
				or else large (a_sizes, {PE_TABLES}.tTypeSpec)
				or else large (a_sizes, {PE_TABLES}.tAssemblyDef)
				or else large (a_sizes, {PE_TABLES}.tAssemblyRef)

				or else large (a_sizes, {PE_TABLES}.tDeclSecurity) -- Permission
				or else large (a_sizes, {PE_TABLES}.tproperty)
				or else large (a_sizes, {PE_TABLES}.tevent)

				or else large (a_sizes, {PE_TABLES}.tfile)
				or else large (a_sizes, {PE_TABLES}.texportedtype)
				or else large (a_sizes, {PE_TABLES}.tmanifestresource)
				or else large (a_sizes, {PE_TABLES}.tgenericparam)
				or else large (a_sizes, {PE_TABLES}.tgenericparamconstraint)
				or else large (a_sizes, {PE_TABLES}.tmethodspec)
		end

end
