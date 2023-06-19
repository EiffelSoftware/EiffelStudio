note
	description: "Summary description for {PE_MD_TABLES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MD_TABLES

inherit
	PE_VISITABLE

create
	make

feature -- Initialization

	make (pe: PE_FILE)
		local
			s: STRING_8
			n: INTEGER
			o: ANY
			i, l_upper: INTEGER
			n32: NATURAL_32
			bin: STRING
			sz: PE_NATURAL_16_ITEM
			l_tb_counts: like tables_counts
		do
			create tables.make_filled (Void, max_table_id.to_integer_32 + 1)
			create l_tb_counts.make_filled (0, tables.count)
			tables_counts := l_tb_counts

			reserved_1 := pe.read_natural_32_item ("reserved")
			major_version := pe.read_natural_8_item ("MajorVersion")
			minor_version := pe.read_natural_8_item ("MinorVersion")
			heap_sizes := pe.read_natural_8_item ("HeapSizes")
			reserved_5 := pe.read_natural_8_item ("reserved")
			valid := pe.read_natural_64_item ("Valid")
			sorted := pe.read_natural_64_item ("Sorted")

			bin := valid.to_binary_string
			n := bin.occurrences ('1')
			from
				i := 0
				l_upper := l_tb_counts.upper
			until
				i > l_upper
			loop
				if is_table_included (i.to_natural_32, bin) then
					l_tb_counts[i] := pe.read_natural_32_item ("Size").value
				end
				i := i + 1
			end

			from
				i := 0
				l_upper := l_tb_counts.upper
			until
				i > l_upper or last_read_table_error
			loop
				if is_table_included (i.to_natural_32, bin) then
					s := table_name (i.to_natural_32)
					n32 := l_tb_counts [i]
					tables[i] := read_table (Current, pe, i.to_natural_32, n32)
				end
				i := i + 1
			end
		end

feature -- Item

	item alias "[]" (tid: NATURAL_32): detachable PE_MD_TABLE [PE_MD_TABLE_ENTRY]
		do
			Result := tables [tid.to_integer_32]
		end

feature -- Access

	starting_address: NATURAL_32
		do
			Result := reserved_1.declaration_address
		end

	reserved_1: PE_NATURAL_32_ITEM
	major_version,
	minor_version: PE_NATURAL_8_ITEM
	heap_sizes: PE_NATURAL_8_ITEM
	reserved_5: PE_NATURAL_8_ITEM
	valid: PE_NATURAL_64_ITEM
	sorted: PE_NATURAL_64_ITEM

	tables: SPECIAL [detachable PE_MD_TABLE [PE_MD_TABLE_ENTRY]]
	tables_counts: SPECIAL [NATURAL_32]

feature -- Helpers

	max_table_id: NATURAL_32
		do
			Result := {PE_TABLES}.tGenericParamConstraint
		end

	is_table_included (tb: NATURAL_32; bin: STRING_8): BOOLEAN
		do
			Result := bin [bin.count - tb.to_integer_32] = '1'
		end

	table_size (tb: NATURAL_32): NATURAL_32
		do
			Result := tables_counts [tb.to_integer_32]
		end

	table_name (tb: NATURAL_32): STRING
		do
			inspect tb
			when {PE_TABLES}.tModule then Result := "Module"
			when {PE_TABLES}.tTypeRef then Result := "TypeRef"
			when {PE_TABLES}.tTypeDef then Result := "TypeDef"
			when {PE_TABLES}.tField then Result := "Field"
			when {PE_TABLES}.tMethodDef then Result := "MethodDef"
			when {PE_TABLES}.tParam then Result := "Param"
			when {PE_TABLES}.tInterfaceImpl then Result := "InterfaceImpl"
			when {PE_TABLES}.tMemberRef then Result := "MemberRef"
			when {PE_TABLES}.tConstant then Result := "Constant"
			when {PE_TABLES}.tCustomAttribute then Result := "CustomAttribute"
			when {PE_TABLES}.tFieldMarshal then Result := "FieldMarshal"
			when {PE_TABLES}.tDeclSecurity then Result := "DeclSecurity"
			when {PE_TABLES}.tClassLayout then Result := "ClassLayout"
			when {PE_TABLES}.tFieldLayout then Result := "FieldLayout"
			when {PE_TABLES}.tStandaloneSig then Result := "StandaloneSig"
			when {PE_TABLES}.tEventMap then Result := "EventMap"
			when {PE_TABLES}.tEvent then Result := "Event"
			when {PE_TABLES}.tPropertyMap then Result := "PropertyMap"
			when {PE_TABLES}.tProperty then Result := "Property"
			when {PE_TABLES}.tMethodSemantics then Result := "MethodSemantics"
			when {PE_TABLES}.tMethodImpl then Result := "MethodImpl"
			when {PE_TABLES}.tModuleRef then Result := "ModuleRef"
			when {PE_TABLES}.tTypeSpec then Result := "TypeSpec"
			when {PE_TABLES}.tImplMap then Result := "ImplMap"
			when {PE_TABLES}.tFieldRVA then Result := "FieldRVA"
			when {PE_TABLES}.tAssemblyDef then Result := "AssemblyDef"
			when {PE_TABLES}.tAssemblyRef then Result := "AssemblyRef"
			when {PE_TABLES}.tFile then Result := "File"
			when {PE_TABLES}.tExportedType then Result := "ExportedType"
			when {PE_TABLES}.tManifestResource then Result := "ManifestResource"
			when {PE_TABLES}.tNestedClass then Result := "NestedClass"
			when {PE_TABLES}.tGenericParam then Result := "GenericParam"
			when {PE_TABLES}.tMethodSpec then Result := "MethodSpec"
			when {PE_TABLES}.tGenericParamConstraint then Result := "GenericParamConstraint"
			else
				Result := "#" + tb.to_natural_8.to_hex_string
			end
		end

	read_table (a_tables: PE_MD_TABLES; pe: PE_FILE; tb: NATURAL_32; nb: NATURAL_32): PE_MD_TABLE [PE_MD_TABLE_ENTRY]
		do
			if last_read_table_error then
				create {PE_MD_TABLE_ERROR} Result.make (a_tables, pe, tb, nb)
			else
				inspect tb
				when {PE_TABLES}.tModule then create {PE_MD_TABLE_MODULE} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tTypeRef then create {PE_MD_TABLE_TYPEREF} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tTypeDef then create {PE_MD_TABLE_TYPEDEF} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tField then create {PE_MD_TABLE_FIELD} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tMethodDef then create {PE_MD_TABLE_METHODDEF} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tParam then create {PE_MD_TABLE_PARAM} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tInterfaceImpl then create {PE_MD_TABLE_INTERFACEIMPL} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tMemberRef then create {PE_MD_TABLE_MEMBERREF} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tConstant then create {PE_MD_TABLE_CONSTANT} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tCustomAttribute then create {PE_MD_TABLE_CUSTOMATTRIBUTE} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tFieldMarshal then create {PE_MD_TABLE_FIELDMARSHAL} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tDeclSecurity then create {PE_MD_TABLE_DECLSECURITY} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tClassLayout then create {PE_MD_TABLE_CLASSLAYOUT} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tFieldLayout then create {PE_MD_TABLE_FIELDLAYOUT} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tStandaloneSig then create {PE_MD_TABLE_STANDALONESIG} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tEventMap then create {PE_MD_TABLE_EVENTMAP} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tEvent then create {PE_MD_TABLE_EVENT} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tPropertyMap then create {PE_MD_TABLE_PROPERTYMAP} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tProperty then create {PE_MD_TABLE_PROPERTY} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tMethodSemantics then create {PE_MD_TABLE_METHODSEMANTICS} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tMethodImpl then create {PE_MD_TABLE_METHODIMPL} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tModuleRef then create {PE_MD_TABLE_MODULEREF} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tTypeSpec then create {PE_MD_TABLE_TYPESPEC} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tImplMap then create {PE_MD_TABLE_IMPLMAP} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tFieldRVA then create {PE_MD_TABLE_FIELDRVA} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tAssemblyDef then create {PE_MD_TABLE_ASSEMBLYDEF} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tAssemblyRef then create {PE_MD_TABLE_ASSEMBLYREF} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tFile then create {PE_MD_TABLE_FILE} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tExportedType then create {PE_MD_TABLE_EXPORTEDTYPE} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tManifestResource then create {PE_MD_TABLE_MANIFESTRESOURCE} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tNestedClass then create {PE_MD_TABLE_NESTEDCLASS} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tGenericParam then create {PE_MD_TABLE_GENERICPARAM} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tMethodSpec then create {PE_MD_TABLE_METHODSPEC} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tGenericParamConstraint then create {PE_MD_TABLE_GENERICPARAMCONSTRAINT} Result.make (a_tables, pe, tb, nb)
				else
					last_read_table_error := True
					check knowned: False end
					create {PE_MD_TABLE_UNKNOWN} Result.make (a_tables, pe, tb, nb)
				end
			end
		rescue
			last_read_table_error := True
			retry
		end

	last_read_table_error: BOOLEAN

feature -- Visit

	accepts (v: PE_VISITOR)
		do
			v.visit_tables (Current)
		end

invariant

end
