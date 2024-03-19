note
	description: "Summary description for {PE_MD_TABLES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDB_MD_TABLES

inherit
	PE_VISITABLE

create
	make

feature {NONE} -- Initialization

	make (pe: PDB_FILE; add: like address)
		do
			address := add
			create tables.make_filled (Void, max_table_id.to_integer_32 + 1)
			create tables_counts.make_filled (0, tables.count)
			pdb_file := pe
			read_header
		end

feature -- Access

	address: NATURAL_32
	address_of_tables: NATURAL_32

	pdb_file: PDB_FILE

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
			pdb: like PDB_FILE
		do
			pdb := PDB_FILE
			pdb.go (address)

			l_tb_counts := tables_counts

			reserved_1 := pdb.read_natural_32_item ("reserved")
			major_version := pdb.read_natural_16_item ("MajorVersion")
			minor_version := pdb.read_natural_16_item ("MinorVersion")

			if pdb.metadata_root.metadata_string_heap.size > 0xFFFF then
				 	-- Size of “#String” stream >= 2^16 = 0x1_0000
				string_heap_index_bytes_size := 4
			else
				string_heap_index_bytes_size := 2
			end
			if pdb.metadata_root.metadata_user_string_heap.size > 0xFFFF then
				 	-- Size of “#US” stream >= 2^16 = 0x1_0000
				user_string_heap_index_bytes_size := 4
			else
				user_string_heap_index_bytes_size := 2
			end
			if pdb.metadata_root.metadata_guid_heap.size > 0xFFFF then
					-- Size of “#GUID” stream >= 2^16 = 0x1_0000
				guid_heap_index_bytes_size := 4
			else
				guid_heap_index_bytes_size := 2
			end

			if pdb.metadata_root.metadata_blob_heap.size > 0xFFFF then
					-- Size of “#Blob” stream >= 2^16 = 0x1_0000	
				blob_heap_index_bytes_size := 4
			else
				blob_heap_index_bytes_size := 2
			end

--			reserved_5 := pdb.read_natural_8_item ("reserved")
			valid := pdb.read_natural_64_item ("Valid")
			sorted := pdb.read_natural_64_item ("Sorted")

			bin := valid.to_binary_string
			n := bin.occurrences ('1')
			from
				i := 0
				l_upper := l_tb_counts.upper
			until
				i > l_upper
			loop
				if is_table_included (i.to_natural_8, bin) then
					l_tb_counts[i] := pdb.read_natural_32_item ("Size").value
					debug ("pe_analyze")
						if l_tb_counts[i] > 0x1_0000 then
							io.error.put_string ("Big-")
						end
						io.error.put_string ("Table "+ {PDB_MD_TABLES}.table_name (i.to_natural_8) +" ["+ i.to_natural_8.to_hex_string +"]")
						io.error.put_string ("%T-> " + l_tb_counts[i].out + " 0x"+ l_tb_counts[i].to_natural_32.to_hex_string  +" row(s)%N")
					end
				end
				i := i + 1
			end

			address_of_tables := pdb.position.to_natural_32
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
			bin, sorted_bin: STRING_8
			sz: PE_NATURAL_16_ITEM
			l_tb_counts: like tables_counts
			pe: like PDB_FILE
		do
			pe := PDB_FILE
				-- After header, resume the read at `address_of_tables`
			pe.go (address_of_tables)

			l_tb_counts := tables_counts
			sorted_bin := sorted.to_binary_string
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
					if attached read_table (Current, pe, i.to_natural_8, n32) as tb then
						tables[i] := tb
						if should_table_be_sorted (i.to_natural_8, sorted_bin) then
							if not attached {PDB_MD_SORTED_TABLE [PDB_MD_TABLE_COMPARABLE_ENTRY]} tb then
								tb.report_error (create {PE_USER_ERROR}.make ("Table marked as sorted, but not sortable"))
							end
						end
					else
						check has_table: False end
					end
				end
				i := i + 1
			end
		end

feature -- Settings

	string_heap_index_bytes_size: NATURAL_8
	user_string_heap_index_bytes_size: NATURAL_8
	guid_heap_index_bytes_size: NATURAL_8
	blob_heap_index_bytes_size: NATURAL_8

feature -- Item

	item alias "[]" (tid: NATURAL_32): detachable PDB_MD_TABLE [PDB_MD_TABLE_ENTRY]
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

	document_table: detachable PDB_MD_TABLE_DOCUMENT
		do
			if attached {like document_table} item ({PDB_TABLES}.tdocument) as tb then
				Result := tb
			end
		end

	method_debug_information_table: detachable PDB_MD_TABLE_METHOD_DEBUG_INFORMATION
		do
			if attached {like method_debug_information_table} item ({PDB_TABLES}.tmethoddebuginformation) as tb then
				Result := tb
			end
		end

	local_scope_table: detachable PDB_MD_TABLE_LOCAL_SCOPE
		do
			if attached {like local_scope_table} item ({PDB_TABLES}.tLocalScope) as tb then
				Result := tb
			end
		end

	local_variable_table: detachable PDB_MD_TABLE_LOCAL_VARIABLE
		do
			if attached {like local_variable_table} item ({PDB_TABLES}.tLocalVariable) as tb then
				Result := tb
			end
		end

	local_constant_table: detachable PDB_MD_TABLE_LOCAL_CONSTANT
		do
			if attached {like local_constant_table} item ({PDB_TABLES}.tLocalConstant) as tb then
				Result := tb
			end
		end


	import_scope_table: detachable PDB_MD_TABLE_IMPORT_SCOPE
		do
			if attached {like import_scope_table} item ({PDB_TABLES}.tImportScope) as tb then
				Result := tb
			end
		end

	state_machine_method_table: detachable PDB_MD_TABLE_STATE_MACHINE_METHOD
		do
			if attached {like state_machine_method_table} item ({PDB_TABLES}.tStateMachineMethod) as tb then
				Result := tb
			end
		end

	custom_debug_information_table: detachable PDB_MD_TABLE_CUSTOM_DEBUG_INFORMATION
		do
			if attached {like custom_debug_information_table} item ({PDB_TABLES}.tCustomDebugInformation) as tb then
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
	minor_version: PE_NATURAL_16_ITEM
	valid: PE_NATURAL_64_ITEM
	sorted: PE_NATURAL_64_ITEM

	tables: SPECIAL [detachable PDB_MD_TABLE [PDB_MD_TABLE_ENTRY]]
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
			Result := {PDB_TABLES}.tcustomdebuginformation
		end

	is_table_included (tb: NATURAL_8; bin: STRING_8): BOOLEAN
		do
			Result := bin [bin.count - tb.to_integer_32] = '1'
		end

	should_table_be_sorted (tb: NATURAL_8; bin: STRING_8): BOOLEAN
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
--			when {PDB_TABLES}.tModule then Result := "Module"
--			when {PDB_TABLES}.tTypeRef then Result := "TypeRef"
--			when {PDB_TABLES}.tTypeDef then Result := "TypeDef"
--			when {PDB_TABLES}.tField then Result := "Field"
			when {PE_TABLES}.tMethodDef then Result := "MethodDef"
--			when {PDB_TABLES}.tParam then Result := "Param"
--			when {PDB_TABLES}.tInterfaceImpl then Result := "InterfaceImpl"
--			when {PDB_TABLES}.tMemberRef then Result := "MemberRef"
--			when {PDB_TABLES}.tConstant then Result := "Constant"
--			when {PDB_TABLES}.tCustomAttribute then Result := "CustomAttribute"
--			when {PDB_TABLES}.tFieldMarshal then Result := "FieldMarshal"
--			when {PDB_TABLES}.tDeclSecurity then Result := "DeclSecurity"
--			when {PDB_TABLES}.tClassLayout then Result := "ClassLayout"
--			when {PDB_TABLES}.tFieldLayout then Result := "FieldLayout"
--			when {PDB_TABLES}.tStandaloneSig then Result := "StandaloneSig"
--			when {PDB_TABLES}.tEventMap then Result := "EventMap"
--			when {PDB_TABLES}.tEvent then Result := "Event"
--			when {PDB_TABLES}.tPropertyMap then Result := "PropertyMap"
--			when {PDB_TABLES}.tProperty then Result := "Property"
--			when {PDB_TABLES}.tMethodSemantics then Result := "MethodSemantics"
--			when {PDB_TABLES}.tMethodImpl then Result := "MethodImpl"
--			when {PDB_TABLES}.tModuleRef then Result := "ModuleRef"
--			when {PDB_TABLES}.tTypeSpec then Result := "TypeSpec"
--			when {PDB_TABLES}.tImplMap then Result := "ImplMap"
--			when {PDB_TABLES}.tFieldRVA then Result := "FieldRVA"
--			when {PDB_TABLES}.tAssemblyDef then Result := "AssemblyDef"
--			when {PDB_TABLES}.tAssemblyRef then Result := "AssemblyRef"
--			when {PDB_TABLES}.tFile then Result := "File"
--			when {PDB_TABLES}.tExportedType then Result := "ExportedType"
--			when {PDB_TABLES}.tManifestResource then Result := "ManifestResource"
--			when {PDB_TABLES}.tNestedClass then Result := "NestedClass"
--			when {PDB_TABLES}.tGenericParam then Result := "GenericParam"
--			when {PDB_TABLES}.tMethodSpec then Result := "MethodSpec"
--			when {PDB_TABLES}.tGenericParamConstraint then Result := "GenericParamConstraint"


--			when {PDB_TABLES}.tFieldPointer then Result := "FieldPointer"
--			when {PDB_TABLES}.tMethodPointer then Result := "MethodPointer"
			when {PDB_TABLES}.tdocument then Result := "Document"
			when {PDB_TABLES}.tMethodDebugInformation then Result := "MethodDebugInformation"
			when {PDB_TABLES}.tLocalScope then Result := "LocalScope"
			when {PDB_TABLES}.tLocalVariable then Result := "LocalVariable"
			when {PDB_TABLES}.tLocalConstant then Result := "LocalConstant"
			when {PDB_TABLES}.tImportScope then Result := "ImportScope"
			when {PDB_TABLES}.tStateMachineMethod then Result := "StateMachineMethod"
			when {PDB_TABLES}.tCustomDebugInformation then Result := "CustomDebugInformation"

			else
				Result := "#" + tb.to_natural_8.to_hex_string
			end
		ensure
			class
		end

	read_table (a_tables: PDB_MD_TABLES; pe: PDB_FILE; tb: NATURAL_8; nb: NATURAL_32): detachable PDB_MD_TABLE [PDB_MD_TABLE_ENTRY]
		do
			if last_read_table_error then
				create {PE_MD_TABLE_ERROR} Result.make (a_tables, pe, tb, nb)
			else
				inspect tb
				when {PDB_TABLES}.tdocument then create {PDB_MD_TABLE_DOCUMENT} Result.make (a_tables, pe, tb, nb)
				when {PDB_TABLES}.tMethodDebugInformation then create {PDB_MD_TABLE_METHOD_DEBUG_INFORMATION} Result.make (a_tables, pe, tb, nb)
				when {PDB_TABLES}.tLocalScope then create {PDB_MD_TABLE_LOCAL_SCOPE} Result.make (a_tables, pe, tb, nb)
				when {PDB_TABLES}.tLocalVariable then create {PDB_MD_TABLE_LOCAL_VARIABLE} Result.make (a_tables, pe, tb, nb)
				when {PDB_TABLES}.tLocalConstant then create {PDB_MD_TABLE_LOCAL_CONSTANT} Result.make (a_tables, pe, tb, nb)
				when {PDB_TABLES}.tImportScope then create {PDB_MD_TABLE_IMPORT_SCOPE} Result.make (a_tables, pe, tb, nb)
				when {PDB_TABLES}.tStateMachineMethod then create {PDB_MD_TABLE_STATE_MACHINE_METHOD} Result.make (a_tables, pe, tb, nb)
				when {PDB_TABLES}.tCustomDebugInformation then create {PDB_MD_TABLE_CUSTOM_DEBUG_INFORMATION} Result.make (a_tables, pe, tb, nb)

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
