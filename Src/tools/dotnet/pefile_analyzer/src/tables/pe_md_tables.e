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

feature {NONE} -- Initialization

	make (pe: PE_FILE; add: like address)
		do
			address := add
			create tables.make_filled (Void, max_table_id.to_integer_32 + 1)
			create tables_counts.make_filled (0, tables.count)
			pe_file := pe
			read_header
		end

feature -- Access

	address: NATURAL_32
	address_of_tables: NATURAL_32

	pe_file: PE_FILE

feature -- Input

	read_header
		local
			s: STRING_8
			n: INTEGER
			o: ANY
			i, l_upper: INTEGER
			n32: NATURAL_32
			n8: NATURAL_8
			bin: STRING
			sz: PE_NATURAL_16_ITEM
			l_tb_counts: like tables_counts
			pe: like pe_file
		do
			pe := pe_file
			pe.go (address)

			l_tb_counts := tables_counts

			reserved_1 := pe.read_natural_32_item ("reserved")
			major_version := pe.read_natural_8_item ("MajorVersion")
			minor_version := pe.read_natural_8_item ("MinorVersion")
			heap_sizes := pe.read_natural_8_item ("HeapSizes")
				-- See ECMA 335: II.24.2.6 #~ stream
				-- the HeapSizes field is a bitvector that encodes the width of indexes into the various heaps. If bit 0 is set,
				-- indexes into the “#String” heap are 4 bytes wide;
				-- if bit 1 is set, indexes into the “#GUID” heap are 4 bytes wide;
				-- if bit 2 is set, indexes into the “#Blob” heap are 4 bytes wide.
				-- Conversely, if the HeapSize bit for a particular heap is not set, indexes into that heap are 2 bytes wide.
			n8 := heap_sizes.value
			if n8 & 0x01 = 0x01 then
				 	-- Size of “#String” stream >= 2^16 = 0x1_0000
				string_heap_index_bytes_size := 4
			else
				string_heap_index_bytes_size := 2
			end
			if n8 & 0x02 = 0x02 then
					-- Size of “#GUID” stream >= 2^16 = 0x1_0000
				guid_heap_index_bytes_size := 4
			else
				guid_heap_index_bytes_size := 2
			end
			if n8 & 0x04 = 0x04 then
					-- Size of “#Blob” stream >= 2^16 = 0x1_0000	
				blob_heap_index_bytes_size := 4
			else
				blob_heap_index_bytes_size := 2
			end

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
				if is_table_included (i.to_natural_8, bin) then
					l_tb_counts[i] := pe.read_natural_32_item ("Size").value
					debug ("pe_analyze")
						if l_tb_counts[i] > 0x1_0000 then
							io.error.put_string ("Big-")
						end
						io.error.put_string ("Table "+ {PE_MD_TABLES}.table_name (i.to_natural_8) +" ["+ i.to_natural_8.to_hex_string +"]")
						io.error.put_string ("%T-> " + l_tb_counts[i].out + " 0x"+ l_tb_counts[i].to_natural_32.to_hex_string  +" row(s)%N")
					end
				end
				i := i + 1
			end

			address_of_tables := pe.position.to_natural_32
		end

	read_tables
			-- Read tables, once the header was read.
		local
			s: STRING_8
			n: INTEGER
			o: ANY
			i, l_upper: INTEGER
			n32: NATURAL_32
			n8: NATURAL_8
			bin: STRING
			sz: PE_NATURAL_16_ITEM
			l_tb_counts: like tables_counts
			pe: like pe_file
		do
			pe := pe_file
				-- After header, resume the read at `address_of_tables`
			pe.go (address_of_tables)

			l_tb_counts := tables_counts
			bin := valid.to_binary_string

			from
				i := 0
				l_upper := l_tb_counts.upper
			until
				i > l_upper or last_read_table_error
			loop
				if is_table_included (i.to_natural_8, bin) then
					s := table_name (i.to_natural_8)
					n32 := l_tb_counts [i]
					tables[i] := read_table (Current, pe, i.to_natural_8, n32)
				end
				i := i + 1
			end
		end

feature -- Settings

	string_heap_index_bytes_size: NATURAL_8
	guid_heap_index_bytes_size: NATURAL_8
	blob_heap_index_bytes_size: NATURAL_8

feature -- Item

	item alias "[]" (tid: NATURAL_32): detachable PE_MD_TABLE [PE_MD_TABLE_ENTRY]
		local
			i: INTEGER
		do
			i := tid.to_integer_32
			if tables.valid_index (i) then
				Result := tables [i]
			else
				check valid_index: False end
			end
		end

	typedef_table: detachable PE_MD_TABLE_TYPEDEF
		do
			if attached {like typedef_table} item ({PE_TABLES}.ttypedef) as tb then
				Result := tb
			end
		end

	typespec_table: detachable PE_MD_TABLE_TYPESPEC
		do
			if attached {like typespec_table} item ({PE_TABLES}.ttypespec) as tb then
				Result := tb
			end
		end

	typeref_table: detachable PE_MD_TABLE_TYPEREF
		do
			if attached {like typeref_table} item ({PE_TABLES}.ttyperef) as tb then
				Result := tb
			end
		end

	methoddef_table: detachable PE_MD_TABLE_METHODDEF
		do
			if attached {like methoddef_table} item ({PE_TABLES}.tmethoddef) as tb then
				Result := tb
			end
		end

	methodspec_table: detachable PE_MD_TABLE_METHODSPEC
		do
			if attached {like methodspec_table} item ({PE_TABLES}.tmethodspec) as tb then
				Result := tb
			end
		end

	member_ref_table: detachable PE_MD_TABLE_MEMBERREF
		do
			if attached {like member_ref_table} item ({PE_TABLES}.tmemberref) as tb then
				Result := tb
			end
		end

	field_table: detachable PE_MD_TABLE_FIELD
		do
			if attached {like field_table} item ({PE_TABLES}.tfield) as tb then
				Result := tb
			end
		end

	property_table: detachable PE_MD_TABLE_PROPERTY
		do
			if attached {like property_table} item ({PE_TABLES}.tproperty) as tb then
				Result := tb
			end
		end

	param_table: detachable PE_MD_TABLE_PARAM
		do
			if attached {like param_table} item ({PE_TABLES}.tparam) as tb then
				Result := tb
			end
		end

	event_table: detachable PE_MD_TABLE_EVENT
		do
			if attached {like event_table} item ({PE_TABLES}.tevent) as tb then
				Result := tb
			end
		end

	interfaceimpl_table: detachable PE_MD_TABLE_INTERFACEIMPL
		do
			if attached {like interfaceimpl_table} item ({PE_TABLES}.tinterfaceimpl) as tb then
				Result := tb
			end
		end

	propertymap_table: detachable PE_MD_TABLE_PROPERTYMAP
		do
			if attached {like propertymap_table} item ({PE_TABLES}.tpropertymap) as tb then
				Result := tb
			end
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

feature -- Factory

	size_settings: PE_SIZE_SETTINGS
		do 
			create Result
			Result.initialize (Current)
		end

feature -- Helpers

	max_table_id: NATURAL_8
		do
			Result := {PE_TABLES}.tGenericParamConstraint
		end

	is_table_included (tb: NATURAL_8; bin: STRING_8): BOOLEAN
		do
			Result := bin [bin.count - tb.to_integer_32] = '1'
		end

	table_size (tb: NATURAL_8): NATURAL_32
		do
			Result := tables_counts [tb.to_integer_32]
		end

	table_name (tb: NATURAL_8): STRING
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


			when {PE_TABLES}.tFieldPointer then Result := "FieldPointer"
			when {PE_TABLES}.tMethodPointer then Result := "MethodPointer"
			else
				Result := "#" + tb.to_natural_8.to_hex_string
			end
		ensure
			class
		end

	read_table (a_tables: PE_MD_TABLES; pe: PE_FILE; tb: NATURAL_8; nb: NATURAL_32): detachable PE_MD_TABLE [PE_MD_TABLE_ENTRY]
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

				when {PE_TABLES}.tFieldPointer then create {PE_MD_TABLE_FIELDPOINTER} Result.make (a_tables, pe, tb, nb)
				when {PE_TABLES}.tMethodPointer then create {PE_MD_TABLE_METHODPOINTER} Result.make (a_tables, pe, tb, nb)

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
