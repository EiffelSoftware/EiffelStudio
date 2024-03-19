note
	description: "Summary description for {PDB_FILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDB_FILE

create
	make

feature {NONE} -- Initialization

	make (fn: READABLE_STRING_GENERAL)
		local
			f: RAW_FILE
		do
			create f.make_with_name (fn)
			count := f.count
			file := f
			create size_settings
		end

feature {NONE} -- Access

	file: RAW_FILE

feature -- Access

	count: INTEGER

	position: INTEGER

feature -- Operation

	reset
		do
			position := 0
		end

	open_read
		do
			count := file.count
			file.open_read
			file.start
			if position > 0 then
				file.move (position)
			end
		end

	close
		do
			position := file.position
			file.close
		end

feature -- Status report

	is_access_readable: BOOLEAN
		do
			Result := file.is_access_readable
		end

	is_opened: BOOLEAN
		do
			Result := file.is_open_read
		end

feature -- Metadata

	metadata_root: PDB_ROOT
		do
			Result := internal_metadata_root
			if Result = Void then
				if not is_opened then
					open_read
					Result := read_metadata_root
					close
				else
					Result := read_metadata_root
				end
				internal_metadata_root := Result
			end
		end

	metadata_tables: PDB_MD_TABLES
		do
			Result := internal_metadata_tables
			if Result = Void then
					-- Get header
				if not is_opened then
					open_read
					create Result.make (Current, metadata_root.metadata_tables_address)
					close
				else
					create Result.make (Current, metadata_root.metadata_tables_address)
				end
				internal_metadata_tables := Result
				size_settings := Result.size_settings

					-- Get the tables
					-- note: but it relies on `is_table_using_4_bytes`, that relies on `metadata_tables`, ...
				if not is_opened then
					open_read
					Result.read_tables
					close
				else
					Result.read_tables
				end
			end
		end

	metadata_string_heap: PE_STRING_HEAP
		do
			Result := internal_metadata_string_heap
			if Result = Void then
				if not is_opened then
					open_read
					Result := read_metadata_string_heap
					close
				else
					Result := read_metadata_string_heap
				end
				internal_metadata_string_heap := Result
			end
		end

	metadata_user_string_heap: PE_USER_STRING_HEAP
		do
			Result := internal_metadata_user_string_heap
			if Result = Void then
				if not is_opened then
					open_read
					Result := read_metadata_user_string_heap
					close
				else
					Result := read_metadata_user_string_heap
				end
				internal_metadata_user_string_heap := Result
			end
		end

	metadata_guid_heap: PE_GUID_HEAP
		do
			Result := internal_metadata_guid_heap
			if Result = Void then
				if not is_opened then
					open_read
					Result := read_metadata_guid_heap
					close
				else
					Result := read_metadata_guid_heap
				end
				internal_metadata_guid_heap := Result
			end
		end

	metadata_blob_heap: PE_BLOB_HEAP
		do
			Result := internal_metadata_blob_heap
			if Result = Void then
				if not is_opened then
					open_read
					Result := read_metadata_blob_heap
					close
				else
					Result := read_metadata_blob_heap
				end
				internal_metadata_blob_heap := Result
			end
		end

	size_settings: PE_SIZE_SETTINGS

feature -- Access

	table_entry	(tok: NATURAL_32): detachable PDB_MD_TABLE_ENTRY
		local
			tag: NATURAL_8
			idx: NATURAL_32
		do
			tag := (tok |>> 24).to_natural_8
			idx := (tok & 0x00ff_ffff)
			if
				attached metadata_tables [tag] as tb and then
				tb.valid_index (idx)
			then
				Result := tb [idx]
			end
		end

--	entry_from_index (idx: PE_INDEX_ITEM): detachable PDB_MD_TABLE_ENTRY
--		do
--			if attached {PE_METHOD_DEF_INDEX_ITEM} idx then
--				Result := method_def (idx)

--			elseif attached {PE_TYPE_DEF_INDEX_ITEM} idx then
--				Result := type_def (idx)
--			elseif attached {PE_TYPE_REF_INDEX_ITEM} idx then
--				Result := type_def (idx)
--			elseif attached {PE_TYPE_SPEC_INDEX_ITEM} idx then
--				Result := type_spec (idx)

--			elseif attached {PE_MEMBER_REF_INDEX_ITEM} idx then
--				Result := member_ref (idx)
--			elseif attached {PE_MODULE_INDEX_ITEM} idx as mod_idx then
--				Result := module (mod_idx)
--			elseif attached {PE_MODULE_REF_INDEX_ITEM} idx as mod_idx then
--				Result := moduleref (mod_idx)
--			else
--				check False end
--			end
--		end

	document (idx: PE_DOCUMENT_INDEX_ITEM): detachable PDB_MD_TABLE_DOCUMENT_ENTRY
		do
			if
				attached {PDB_MD_TABLE_DOCUMENT} metadata_tables [{PDB_TABLES}.tdocument] as tb and then
				tb.valid_index (idx.index)
			then
				Result := tb [idx.index]
			end
		end

	import_scope (idx: PE_IMPORT_SCOPE_INDEX_ITEM): detachable PDB_MD_TABLE_IMPORT_SCOPE_ENTRY
		do
			if
				attached {PDB_MD_TABLE_IMPORT_SCOPE} metadata_tables [{PDB_TABLES}.timportscope] as tb and then
				tb.valid_index (idx.index)
			then
				Result := tb [idx.index]
			end
		end

	local_variable (idx: PE_LOCAL_VARIABLE_INDEX_ITEM): detachable PDB_MD_TABLE_LOCAL_VARIABLE_ENTRY
		do
			if
				attached {PDB_MD_TABLE_LOCAL_VARIABLE} metadata_tables [{PDB_TABLES}.tlocalvariable] as tb and then
				tb.valid_index (idx.index)
			then
				Result := tb [idx.index]
			end
		end

	local_constant (idx: PE_LOCAL_CONSTANT_INDEX_ITEM): detachable PDB_MD_TABLE_LOCAL_CONSTANT_ENTRY
		do
			if
				attached {PDB_MD_TABLE_LOCAL_CONSTANT} metadata_tables [{PDB_TABLES}.tlocalconstant] as tb and then
				tb.valid_index (idx.index)
			then
				Result := tb [idx.index]
			end
		end

	sequence_points_blob_heap_item (idx: PE_BLOB_INDEX_ITEM): detachable PDB_SEQUENCE_POINTS_BLOB_ITEM
		do
			if attached blob_heap_item (idx) as blob then
				create Result.make_from_item (blob)
			end
		end

	document_name_blob_heap_item (idx: PE_BLOB_INDEX_ITEM): detachable PDB_DOCUMENT_NAME_BLOB_ITEM
		do
			if attached blob_heap_item (idx) as blob then
				create Result.make_from_item (blob)
			end
		end

	import_scope_blob_heap_item (idx: PE_BLOB_INDEX_ITEM): detachable PDB_IMPORTS_BLOB_ITEM
		do
			if attached blob_heap_item (idx) as blob then
				create Result.make_from_item (blob)
			end
		end

	blob_heap_item (idx: PE_INDEX_ITEM): detachable PE_BLOB_ITEM
		do
			Result := blob_heap_item_at (idx.index)
		end

	blob_heap_item_at (i: NATURAL_32): detachable PE_BLOB_ITEM
		do
			if
				attached metadata_blob_heap as h and then
--				h.valid_index (i) and then
				attached h [i] as blb
			then
				Result := blb
			end
		end

	string_heap_item (idx: PE_INDEX_ITEM): detachable READABLE_STRING_GENERAL
		local
			i: NATURAL_32
		do
			i := idx.index
			if
				attached metadata_string_heap as h and then
--				h.valid_index (i) and then
				attached h [i] as str
			then
				Result := str.string_32
			end
		end

	user_string_heap_item (idx: PE_INDEX_ITEM): detachable READABLE_STRING_GENERAL
		local
			i: NATURAL_32
		do
			i := idx.index
			if
				attached metadata_user_string_heap as h and then
				h.valid_index (i) and then
				attached h [i] as str
			then
				Result := str.string_32
			end
		end

	guid_heap_item (idx: PE_GUID_INDEX_ITEM): detachable PE_GUID_ITEM
		local
			i: NATURAL_32
		do
			i := idx.index
			if
				attached metadata_guid_heap as h and then
				h.valid_index (i) and then
				attached h [i] as g
			then
				Result := g
			end
		end

feature -- Internal MD

	internal_metadata_root: detachable like metadata_root
	internal_metadata_tables: detachable like metadata_tables
	internal_metadata_string_heap: detachable like metadata_string_heap
	internal_metadata_user_string_heap: detachable like metadata_user_string_heap
	internal_metadata_guid_heap: detachable like metadata_guid_heap
	internal_metadata_blob_heap: detachable like metadata_blob_heap

feature -- Helper

	go_to_metatable_start
		do
				-- Magic signature for physical metadata: 0x424A5342
			start
--			go_to_bytes (<<0x42, 0x53, 0x4A, 0x42>>, 4)
			go_to_string ("%/0x42/%/0x53/%/0x4A/%/0x42/") -- "BSJB"
		end

	read_metadata_root: PDB_ROOT
		do
			go_to_metatable_start
			create Result.make (Current)
		end

	read_metadata_tables: PDB_MD_TABLES
		do
			go (metadata_root.metadata_tables_address)
			create Result.make (Current, metadata_root.metadata_tables_address)
			Result.read_tables
		end

	read_metadata_string_heap: PE_STRING_HEAP
		local
			tu: TUPLE [address, size: NATURAL_32]
		do
			tu := metadata_root.metadata_string_heap
			go (tu.address)
			create Result.make (Current, tu.address, tu.size)
		end

	read_metadata_user_string_heap: PE_USER_STRING_HEAP
		local
			tu: TUPLE [address, size: NATURAL_32]
		do
			tu := metadata_root.metadata_user_string_heap
			go (tu.address)
			create Result.make (Current, tu.address, tu.size)
		end

	read_metadata_guid_heap: PE_GUID_HEAP
		local
			tu: TUPLE [address, size: NATURAL_32]
		do
			tu := metadata_root.metadata_guid_heap
			go (tu.address)
			create Result.make (Current, tu.address, tu.size)
		end

	read_metadata_blob_heap: PE_BLOB_HEAP
		local
			tu: TUPLE [address, size: NATURAL_32]
		do
			tu := metadata_root.metadata_blob_heap
			go (tu.address)
			create Result.make (Current, tu.address, tu.size)
		end

feature -- Read

--	read_string_8 (nb: INTEGER): IMMUTABLE_STRING_8
--		local
--			f: like file
--		do
--			f := file
--			f.read_stream (nb)
--			create Result.make_from_string (f.last_string)
--			position := f.position
--		end

	read_bytes_at (nb: NATURAL_32; a_pos: INTEGER): MANAGED_POINTER
		local
			f: like file
			pos: INTEGER
		do
			f := file
			pos := f.position
			f.go (a_pos)
			create Result.make (nb.to_integer_32)
			f.read_to_managed_pointer (Result, 0, nb.to_integer_32)
			f.go (pos)
			position := f.position
		ensure
			position = old position
		end

	go (abs_position: NATURAL_32)
		do
			file.go (abs_position.to_integer_32)
			position := file.position
		end

	goto_null_character
		local
			f: like file
		do
			f := file

			from
			until
				f.item = '%U'
			loop
				f.move (+1)
			end
			position := f.position
		ensure
			file.exhausted or file.item = '%U'
		end

	read_null_ended_bytes: MANAGED_POINTER
		local
			f: like file
			c: CHARACTER_8
			s: STRING_8
			pos: INTEGER
			nb: INTEGER
		do
			pos := position
			goto_null_character
			nb := position - pos
			Result := read_bytes_at (nb.to_natural_32, pos)
		end

	read_bytes (nb: NATURAL_32): MANAGED_POINTER
		require

		local
			f: like file
		do
			f := file
			create Result.make (nb.to_integer_32)
			f.read_to_managed_pointer (Result, 0, nb.to_integer_32)
			position := f.position
		end

	read_natural_64: NATURAL_64
		do
			if attached read_bytes ({PLATFORM}.natural_64_bytes.to_natural_32) as mp then
				Result := mp.read_natural_64_le (0)
			end
		end

	read_natural_32: NATURAL_32
		do
			if attached read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32) as mp then
				Result := mp.read_natural_32_le (0)
			end
		end

	read_natural_16: NATURAL_16
		do
			if attached read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32) as mp then
				Result := mp.read_natural_16_le (0)
			end
		end

	read_natural_8: NATURAL_8
		do
			if attached read_bytes ({PLATFORM}.natural_8_bytes.to_natural_32) as mp then
				Result := mp.read_natural_8_le (0)
			end
		end

	read_character_8: CHARACTER_8
		local
			f: like file
		do
			f := file
			f.read_character
			Result := f.last_character
			position := f.position
		end

feature -- Read item

	read_null_ended_string_item (lab: like {PE_ITEM}.label): PE_STRING_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
		do
			b := file.position.to_natural_32
			mp := read_null_ended_bytes
			e := file.position.to_natural_32
			create Result.make (b, b, e, mp, lab)
		end

	read_utf_16_string_item (lab: like {PE_ITEM}.label; nb: NATURAL_32; a_declaration_start_address: NATURAL_32): PE_UTF_16_STRING_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
		do
			b := file.position.to_natural_32
			mp := read_bytes (nb)
			e := file.position.to_natural_32
			create Result.make (a_declaration_start_address, b, e, mp, nb, lab)
		end

	read_bytes_item (lab: like {PE_ITEM}.label; nb: NATURAL_32; a_declaration_start_address: NATURAL_32): PE_BYTES_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
		do
			b := file.position.to_natural_32
			mp := read_bytes (nb)
			e := file.position.to_natural_32
			create Result.make (a_declaration_start_address, b, e, mp, lab)
		end

	read_blob_item (lab: like {PE_ITEM}.label; nb: NATURAL_32; a_declaration_start_address: NATURAL_32): PE_BLOB_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
		do
			b := file.position.to_natural_32
			mp := read_bytes (nb)
			e := file.position.to_natural_32
			create Result.make (a_declaration_start_address, b, e, mp, lab)
		end

	read_natural_64_item (lab: like {PE_ITEM}.label): PE_NATURAL_64_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			create Result.make (b, read_bytes ({PLATFORM}.natural_64_bytes.to_natural_32), lab)
			e := file.position.to_natural_32
		end

	read_integer_32_item (lab: like {PE_ITEM}.label): PE_INTEGER_32_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			create Result.make (b, read_bytes ({PLATFORM}.integer_32_bytes.to_natural_32), lab)
			e := file.position.to_natural_32
		end

	read_natural_32_item (lab: like {PE_ITEM}.label): PE_NATURAL_32_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			create Result.make (b, read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32), lab)
			e := file.position.to_natural_32
		end

	read_integer_16_item (lab: like {PE_ITEM}.label): PE_INTEGER_16_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			create Result.make (b, read_bytes ({PLATFORM}.integer_16_bytes.to_natural_32), lab)
			e := file.position.to_natural_32
		end

	read_natural_16_item (lab: like {PE_ITEM}.label): PE_NATURAL_16_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			create Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			e := file.position.to_natural_32
		end

	read_natural_8_item (lab: like {PE_ITEM}.label): PE_NATURAL_8_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			create Result.make (b, read_bytes ({PLATFORM}.natural_8_bytes.to_natural_32), lab)
			e := file.position.to_natural_32
		end

feature -- Status report

	is_string_heap_using_4_bytes: BOOLEAN
		do
			Result := metadata_tables.string_heap_index_bytes_size = 4
		end

	is_guid_heap_using_4_bytes: BOOLEAN
		do
			Result := metadata_tables.guid_heap_index_bytes_size = 4
		end

	is_blob_heap_using_4_bytes: BOOLEAN
		do
			Result := metadata_tables.blob_heap_index_bytes_size = 4
		end

feature -- Basic value

	read_flags_16 (lab: like {PE_ITEM}.label): PE_INTEGER_16_ITEM
		do
			Result := read_integer_16_item (lab)
		end

	read_flags_32 (lab: like {PE_ITEM}.label): PE_INTEGER_32_ITEM
		do
			Result := read_integer_32_item (lab)
		end

feature -- table indexes

	read_method_def_index (lab: like {PE_ITEM}.label): PE_METHOD_DEF_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
		do
			-- FIXME
			b := file.position.to_natural_32
			if size_settings.is_method_def_table_using_4_bytes then
				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
				create {PE_METHOD_DEF_INDEX_32_ITEM} Result.make (b, mp, lab)
			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_METHOD_DEF_INDEX_16_ITEM} Result.make (b, mp, lab)
			end
			e := file.position.to_natural_32
		end

	read_document_index (lab: like {PE_ITEM}.label): PE_DOCUMENT_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
		do
			-- FIXME
			b := file.position.to_natural_32
			if size_settings.is_document_table_using_4_bytes then
				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
				create {PE_DOCUMENT_INDEX_32_ITEM} Result.make (b, mp, lab)
			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_DOCUMENT_INDEX_16_ITEM} Result.make (b, mp, lab)
			end
			e := file.position.to_natural_32
		end

	read_import_scope_index (lab: like {PE_ITEM}.label): PE_IMPORT_SCOPE_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
		do
			-- FIXME
			b := file.position.to_natural_32
			if size_settings.is_import_scope_table_using_4_bytes then
				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
				create {PE_IMPORT_SCOPE_INDEX_32_ITEM} Result.make (b, mp, lab)
			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_IMPORT_SCOPE_INDEX_16_ITEM} Result.make (b, mp, lab)
			end
			e := file.position.to_natural_32
		end

	read_local_variable_index (lab: like {PE_ITEM}.label): PE_LOCAL_VARIABLE_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
		do
			-- FIXME
			b := file.position.to_natural_32
			if size_settings.is_local_variable_table_using_4_bytes then
				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
				create {PE_LOCAL_VARIABLE_INDEX_32_ITEM} Result.make (b, mp, lab)
			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_LOCAL_VARIABLE_INDEX_16_ITEM} Result.make (b, mp, lab)
			end
			e := file.position.to_natural_32
		end

	read_local_constant_index (lab: like {PE_ITEM}.label): PE_LOCAL_CONSTANT_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
		do
			-- FIXME
			b := file.position.to_natural_32
--			if size_settings.is_local_constant_table_using_4_bytes then
--				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
--				create {PE_LOCAL_CONSTANT_INDEX_32_ITEM} Result.make (b, mp, lab)
--			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_LOCAL_CONSTANT_INDEX_16_ITEM} Result.make (b, mp, lab)
--			end
			e := file.position.to_natural_32
		end

feature -- Heap indexes

	read_blob_index (lab: like {PE_ITEM}.label): PE_BLOB_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			if size_settings.is_blob_heap_using_4_bytes then
				create {PE_BLOB_INDEX_32_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32), lab)
			else
				create {PE_BLOB_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			end
			e := file.position.to_natural_32
		end

	read_guid_index (lab: like {PE_ITEM}.label): PE_GUID_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			if size_settings.is_guid_heap_using_4_bytes then
				create {PE_GUID_INDEX_32_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32), lab)
			else
				create {PE_GUID_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			end
			e := file.position.to_natural_32
		end

	read_string_index (lab: like {PE_ITEM}.label): PE_STRING_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			if size_settings.is_string_heap_using_4_bytes then
				create {PE_STRING_INDEX_32_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32), lab)
			else
				create {PE_STRING_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			end
			e := file.position.to_natural_32
		end

feature -- Table indexes

	read_index (lab: like {PE_ITEM}.label): PE_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			-- TODO: check if needed?
			b := file.position.to_natural_32
			create {PE_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			e := file.position.to_natural_32
		end

feature -- Multi table indexes


feature -- Status report

	current_is_string (s: READABLE_STRING_8): BOOLEAN
		local
			n, pos: INTEGER
			f: like file
		do
			n := s.count
			f := file
			pos := f.position
			if pos + n - 1 <= count then
				f.read_stream (n)
				Result := f.last_string.same_string (s)
				f.move (-n)
			end
		ensure
			file.position = old file.position
		end

feature -- Search

	start
		do
			file.start
			position := file.position
		end

	go_to_string (s: STRING_8)
		local
			pos: INTEGER
			exit: BOOLEAN
			f: like file
		do
			f := file
			from
			until
				f.exhausted or f.end_of_file or exit
			loop
				pos := f.position
				f.search (s [1])
				if not f.exhausted then
					check f.item = s [1] end
					pos := f.position
					if current_is_string (s) then
						exit := True
					else
						f.move (+1)
					end
				end
			end
			position := f.position
		end

	go_to_bytes (bytes: ITERABLE [NATURAL_8]; nb: INTEGER)
		local
			s: STRING_8
		do
			create s.make (nb)
			across
				bytes as ic
			loop
				s.append_natural_8 (ic.item)
			end
			go_to_string (s)
		end

feature -- Status

	exhausted: BOOLEAN
		do
			Result := file.exhausted
		end

feature -- Visit

	accepts (v: PE_VISITOR)
		do
			v.visit_pdb_file (Current)
		end

end
