note
	description: "Summary description for {PE_STRUCTURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_STRUCTURE

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER; lab: like label)
		do
			label := lab
			create structure_items.make (nb)
			create items.make (structure_items.count)
		end

feature -- Access

	label: READABLE_STRING_8

	structure_items: ARRAYED_LIST [PE_STRUCTURE_ITEM]

	items: ARRAYED_LIST [PE_ITEM]

feature -- Access

	index_item (lab: READABLE_STRING_GENERAL): detachable PE_INDEX_ITEM
		require
			is_index_item (lab)
		do
			if attached {PE_INDEX_ITEM} item (lab) as i then
				Result := i
			end
		end

	string_item (lab: READABLE_STRING_GENERAL): detachable PE_STRING_ITEM
		require
			is_string_item (lab)
		do
			if attached {PE_STRING_ITEM} item (lab) as i then
				Result := i
			end
		end

	natural_16_item (lab: READABLE_STRING_GENERAL): detachable PE_NATURAL_16_ITEM
		require
			is_natural_16_item (lab)
		do
			if attached {PE_NATURAL_16_ITEM} item (lab) as i then
				Result := i
			end
		end

	natural_32_item (lab: READABLE_STRING_GENERAL): detachable PE_NATURAL_32_ITEM
		require
			is_natural_32_item (lab)
		do
			if attached {PE_NATURAL_32_ITEM} item (lab) as i then
				Result := i
			end
		end

	item (lab: READABLE_STRING_GENERAL): detachable PE_ITEM
		do
			across
				items as ic
			until
				Result /= Void
			loop
				if lab.is_case_insensitive_equal (ic.item.label) then
					Result := ic.item
				end
			end
		end

feature -- Status report

	is_string_item (lab: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := attached {PE_STRING_ITEM} item (lab)
		end

	is_natural_16_item (lab: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := attached {PE_NATURAL_16_ITEM} item (lab)
		end

	is_natural_32_item (lab: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := attached {PE_NATURAL_32_ITEM} item (lab)
		end

	is_index_item (lab: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := attached {PE_INDEX_ITEM} item (lab)
		end

feature -- Constants

--	column_separator: STRING = " | "
	column_separator: STRING = "%T|"
	first_column_separator: STRING = "%T"
	last_column_separator: STRING = "" -- %T|"

	empty_string: STRING_32 = ""

feature -- Read

	read (pe: PDB_FILE)
		local
			l_pe_item: PE_ITEM
			sti: PE_STRUCTURE_ITEM
		do
			across
				structure_items as ic
			loop
				sti := ic.item
				l_pe_item := sti.read (pe)
				l_pe_item.set_associated_structure (sti)

				items.force (l_pe_item)
			end
			check structure_items.count = items.count end
		end

	has_error: BOOLEAN
		do
			across
				items as ic
			until
				Result
			loop
				Result := ic.item.has_error
			end
		end

	errors: ARRAYED_LIST [PE_ERROR]
		require
			has_error
		do
			create Result.make (1)
			across
				items as ic
			loop
				if attached ic.item.error as err then
					Result.force (err)
				end
			end
		end

feature -- Conversion

	to_string: STRING_32
		local
			l_is_first: BOOLEAN
		do
			Result := {STRING_32} "{"+ label +"}:"
			l_is_first := True
			across
				items as ic
			loop
				if l_is_first then
					Result.append (first_column_separator)
					l_is_first := False
				else
					Result.append (column_separator)
				end
				Result.append (item_to_string (ic.item))
			end
			Result.append (last_column_separator)
		end

	binary_byte_sizes_string_array: ARRAY [like to_string]
		local
			i,n: INTEGER
			tot: NATURAL_32
			lst: like binary_byte_sizes_array
		do
			lst := binary_byte_sizes_array
			create Result.make_filled (empty_string, lst.lower, lst.upper)
			i := Result.lower
			across
				lst as ic
			loop
				Result [i] := ic.item.out
				i := i + 1
			end
		end

	binary_byte_sizes_array: ARRAY [NATURAL_32]
		local
			i,n: INTEGER
			tot: NATURAL_32
		do
			create Result.make_filled (0, 0, structure_items.count)
			i := 1
			across
				items as ic
			loop
				tot := tot + ic.item.binary_byte_size
				Result [i] := ic.item.binary_byte_size
				i := i + 1
			end
			Result [0] := tot
		end

	to_string_array: ARRAY [like to_string]
		local
			i,n: INTEGER
		do
			create Result.make_filled (empty_string, 0, structure_items.count)
			Result [0] := {STRING_32} "{"+ label +"}"
			i := 1
			across
				items as ic
			loop
				Result [i] := item_to_string (ic.item)
				i := i + 1
			end
		end

	item_to_string (i: PE_ITEM): STRING_32
		do
			Result := i.to_string
			if attached i.info as inf then
				if inf.is_link then
					Result := Result + {STRING_32} " @" + inf.text
				else
					Result := Result + {STRING_32} " %"" + inf.text + "%""
				end
			end
		end

	dump: STRING_8
		do
			create Result.make (items.count * 3)
			across
				items as ic
			loop
				if Result.is_empty then
					Result.append (first_column_separator)
				else
					Result.append (column_separator)
				end
				Result.append (ic.item.dump)
			end
			Result.append (last_column_separator)
		end

	description_as_array: ARRAY [READABLE_STRING_GENERAL]
		local
			i,n: INTEGER
		do
			create Result.make_filled (empty_string, 1, structure_items.count)
--			Result [0] := "Columns"
			i := 1
			across
				structure_items as ic
			loop
				Result [i] := ic.item.label
				i := i + 1
			end
		end

	description: STRING_8
		do
			create Result.make (structure_items.count * 5)
			across
				structure_items as ic
			loop
				if Result.is_empty then
					Result.append (first_column_separator)
				else
					Result.append (column_separator)
				end
				Result.append (ic.item.label)
			end
			Result.append (last_column_separator)
		end

feature -- Element change

	add (i: PE_STRUCTURE_ITEM)
		do
			structure_items.force (i)
		end

	add_flags_16 (lab: STRING)
		do
			add (create {PE_FLAGS_16}.make (lab))
		end

	add_flags_32 (lab: STRING)
		do
			add (create {PE_FLAGS_32}.make (lab))
		end

	add_method_def_index (lab: STRING)
		do
			add (create {PE_METHOD_DEF_INDEX}.make (lab))
		end

	add_document_index (lab: STRING)
		do
			add (create {PE_DOCUMENT_INDEX}.make (lab))
		end

	add_sequence_points_index (lab: STRING)
		do
			add (create {PDB_SEQUENCE_POINTS_BLOB_INDEX}.make (lab))
		end

	add_document_name_blob_index (lab: STRING)
		do
			add (create {PDB_DOCUMENT_NAME_BLOB_INDEX}.make (lab))
		end

	add_import_scope_index (lab: STRING)
		do
			add (create {PE_IMPORT_SCOPE_INDEX}.make (lab))
		end

	add_imports_blob_index (lab: STRING)
		do
			add (create {PDB_IMPORTS_BLOB_INDEX}.make (lab))
		end

	add_local_variable_index (lab: STRING)
		do
			add (create {PDB_LOCAL_VARIABLE_LIST_INDEX}.make (lab))
		end

	add_local_constant_index (lab: STRING)
		do
			add (create {PE_LOCAL_CONSTANT_INDEX}.make (lab))
		end

	add_string_index (lab: STRING)
		do
			add (create {PE_STRING_INDEX}.make (lab))
		end

--	add_index (lab: STRING)
--		do
--			add (create {PE_INDEX}.make (lab))
--		end

	add_blob_index (lab: STRING)
		do
			add (create {PE_BLOB_INDEX}.make (lab))
		end

	add_guid_index (lab: STRING)
		do
			add (create {PE_GUID_INDEX}.make (lab))
		end

	add_natural_32 (lab: STRING)
		do
			add (create {PE_NATURAL_32}.make (lab))
		end

	add_natural_16 (lab: STRING)
		do
			add (create {PE_NATURAL_16}.make (lab))
		end

	add_natural_8 (lab: STRING)
		do
			add (create {PE_NATURAL_8}.make (lab))
		end

end
