note
	description: "Summary description for {PE_FILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FILE

create
	make

feature

	make (fn: READABLE_STRING_GENERAL)
		local
			f: RAW_FILE
		do
			create f.make_with_name (fn)
			count := f.count
			file := f
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

	is_opened: BOOLEAN
		do
			Result := file.is_open_read
		end

feature -- Metadata

	metadata_root: PE_MD_ROOT
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

	metadata_tables: PE_MD_TABLES
		do
			Result := internal_metadata_tables
			if Result = Void then
				if not is_opened then
					open_read
					Result := read_metadata_tables
					close
				else
					Result := read_metadata_tables
				end
				internal_metadata_tables := Result
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

	type_def_or_ref_or_spec (idx: PE_INDEX_ITEM): detachable PE_MD_TABLE_ENTRY
		local
			tb_id: NATURAL_32
			i: NATURAL_32
		do
			tb_id := {PE_TABLES}.ttypedef
			i := idx.index
			if
				attached {PE_MD_TABLE_TYPEDEF} metadata_tables [tb_id] as tb and then
				tb.valid_index (i)
			then
				Result := tb [i]
			end
		end

	type_def (idx: PE_INDEX_ITEM): detachable PE_MD_TABLE_TYPEDEF_ENTRY
		local
			tb_id: NATURAL_32
			i: NATURAL_32
		do
			tb_id := {PE_TABLES}.ttypedef
			i := idx.index
			if
				attached {PE_MD_TABLE_TYPEDEF} metadata_tables [tb_id] as tb and then
				tb.valid_index (i)
			then
				Result := tb [i]
			end
		end

	type_ref (idx: PE_INDEX_ITEM): detachable PE_MD_TABLE_TYPEREF_ENTRY
		local
			tb_id: NATURAL_32
			i: NATURAL_32
		do
			tb_id := {PE_TABLES}.ttyperef
			i := idx.index
			if
				attached {PE_MD_TABLE_TYPEREF} metadata_tables [tb_id] as tb and then
				tb.valid_index (i)
			then
				Result := tb [i]
			end
		end

	type_spec (idx: PE_INDEX_ITEM): detachable PE_MD_TABLE_TYPESPEC_ENTRY
		local
			tb_id: NATURAL_32
			i: NATURAL_32
		do
			tb_id := {PE_TABLES}.ttypespec
			i := idx.index
			if
				attached {PE_MD_TABLE_TYPESPEC} metadata_tables [tb_id] as tb and then
				tb.valid_index (i)
			then
				Result := tb [i]
			end
		end

	method_def (idx: PE_INDEX_ITEM): detachable PE_MD_TABLE_METHODDEF_ENTRY
		local
			tb_id: NATURAL_32
			i: NATURAL_32
		do
			tb_id := {PE_TABLES}.tmethoddef
			i := idx.index
			if
				attached {PE_MD_TABLE_METHODDEF} metadata_tables [tb_id] as tb and then
				tb.valid_index (i)
			then
				Result := tb [i]
			end
		end

	method_spec (idx: PE_INDEX_ITEM): detachable PE_MD_TABLE_METHODSPEC_ENTRY
		local
			tb_id: NATURAL_32
			i: NATURAL_32
		do
			tb_id := {PE_TABLES}.tmethodspec
			i := idx.index
			if
				attached {PE_MD_TABLE_METHODSPEC} metadata_tables [tb_id] as tb and then
				tb.valid_index (i)
			then
				Result := tb [i]
			end
		end

	member_ref (idx: PE_INDEX_ITEM): detachable PE_MD_TABLE_MEMBERREF_ENTRY
		local
			tb_id: NATURAL_32
			i: NATURAL_32
		do
			tb_id := {PE_TABLES}.tmemberref
			i := idx.index
			if
				attached {PE_MD_TABLE_MEMBERREF} metadata_tables [tb_id] as tb and then
				tb.valid_index (i)
			then
				Result := tb [i]
			end
		end

	field (idx: PE_INDEX_ITEM): detachable PE_MD_TABLE_FIELD_ENTRY
		local
			tb_id: NATURAL_32
			i: NATURAL_32
		do
			tb_id := {PE_TABLES}.tfield
			i := idx.index
			if
				attached {PE_MD_TABLE_FIELD} metadata_tables [tb_id] as tb and then
				tb.valid_index (i)
			then
				Result := tb [i]
			end
		end

	fields (idx: PE_INDEX_ITEM; nb: NATURAL_32): ARRAYED_LIST [PE_MD_TABLE_FIELD_ENTRY]
		local
			tb_id: NATURAL_32
			i, n: NATURAL_32
		do
			create Result.make (nb.to_integer_32)
			tb_id := {PE_TABLES}.tfield
			if attached {PE_MD_TABLE_FIELD} metadata_tables [tb_id] as tb then
				from
					n := nb
					i := idx.index
				until
					n = 0
				loop
					if tb.valid_index (i) and then attached tb [i] as item then
						Result.force (item)
					end
					i := i + 1
					n := n - 1
				end
			end
		ensure
			Result.count = nb.to_integer_32
		end

	methods (idx: PE_INDEX_ITEM; nb: NATURAL_32): ARRAYED_LIST [PE_MD_TABLE_METHODDEF_ENTRY]
		local
			tb_id: NATURAL_32
			i, n: NATURAL_32
		do
			create Result.make (nb.to_integer_32)
			tb_id := {PE_TABLES}.tmethoddef
			if attached {PE_MD_TABLE_METHODDEF} metadata_tables [tb_id] as tb then
				from
					n := nb
					i := idx.index
				until
					n = 0
				loop
					if tb.valid_index (i) and then attached tb [i] as item then
						Result.force (item)
					end
					i := i + 1
					n := n - 1
				end
			end
		ensure
			Result.count = nb.to_integer_32
		end

	params (idx: PE_INDEX_ITEM; nb: NATURAL_32): ARRAYED_LIST [PE_MD_TABLE_PARAM_ENTRY]
		local
			tb_id: NATURAL_32
			i, n: NATURAL_32
		do
			create Result.make (nb.to_integer_32)
			tb_id := {PE_TABLES}.tparam
			if attached {PE_MD_TABLE_PARAM} metadata_tables [tb_id] as tb then
				from
					n := nb
					i := idx.index
				until
					n = 0
				loop
					if tb.valid_index (i) and then attached tb [i] as item then
						Result.force (item)
					end
					i := i + 1
					n := n - 1
				end
			end
		ensure
			Result.count = nb.to_integer_32
		end

	param (idx: PE_INDEX_ITEM): detachable PE_MD_TABLE_PARAM_ENTRY
		local
			tb_id: NATURAL_32
			i: NATURAL_32
		do
			tb_id := {PE_TABLES}.tparam
			i := idx.index
			if
				attached {PE_MD_TABLE_PARAM} metadata_tables [tb_id] as tb and then
				tb.valid_index (i)
			then
				Result := tb [i]
			end
		end

	event (idx: PE_INDEX_ITEM): detachable PE_MD_TABLE_EVENT_ENTRY
		local
			tb_id: NATURAL_32
			i: NATURAL_32
		do
			tb_id := {PE_TABLES}.tevent
			i := idx.index
			if
				attached {PE_MD_TABLE_EVENT} metadata_tables [tb_id] as tb and then
				tb.valid_index (i)
			then
				Result := tb [i]
			end
		end

	signature_blob_heap_item (idx: PE_INDEX_ITEM): detachable PE_SIGNATURE_BLOB_ITEM
		do
			if attached blob_heap_item (idx) as blob then
				create Result.make_from_item (blob)
			end
		end

	blob_heap_item (idx: PE_INDEX_ITEM): detachable PE_BLOB_ITEM
		local
			i: NATURAL_32
		do
			i := idx.index
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
			go_to_string ("%/0x42/%/0x53/%/0x4A/%/0x42/")
		end

	read_metadata_root: PE_MD_ROOT
		do
			go_to_metatable_start
			create Result.make (Current)
		end

	read_metadata_tables: PE_MD_TABLES
		do
			go (metadata_root.metadata_tables_address)
			create Result.make (Current)
		end

	read_metadata_string_heap: PE_STRING_HEAP
		local
			tu: TUPLE [address, size: NATURAL_32]
		do
			tu := metadata_root.metadata_string_head
			go (tu.address)
			create Result.make (Current, tu.address, tu.size)
		end

	read_metadata_user_string_heap: PE_USER_STRING_HEAP
		local
			tu: TUPLE [address, size: NATURAL_32]
		do
			tu := metadata_root.metadata_user_string_head
			go (tu.address)
			create Result.make (Current, tu.address, tu.size)
		end

	read_metadata_guid_heap: PE_GUID_HEAP
		local
			tu: TUPLE [address, size: NATURAL_32]
		do
			tu := metadata_root.metadata_guid_head
			go (tu.address)
			create Result.make (Current, tu.address, tu.size)
		end

	read_metadata_blob_heap: PE_BLOB_HEAP
		local
			tu: TUPLE [address, size: NATURAL_32]
		do
			tu := metadata_root.metadata_blob_head
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

feature -- PE MD reader

	is_table_using_4_bytes (tb: NATURAL_32): BOOLEAN
		do
			--TODO
		end

	is_blob_heap_using_4_bytes: BOOLEAN
		do
		end
	is_guid_heap_using_4_bytes: BOOLEAN
		do
		end
	is_string_heap_using_4_bytes: BOOLEAN
		do
		end

	is_field_table_using_4_bytes: BOOLEAN
		do
			Result := is_table_using_4_bytes ({PE_TABLES}.tfield)
		end
	is_method_def_table_using_4_bytes: BOOLEAN
		do
			Result := is_table_using_4_bytes ({PE_TABLES}.tmethoddef)
		end
	is_member_ref_table_using_4_bytes: BOOLEAN
		do
			Result := is_table_using_4_bytes ({PE_TABLES}.tmemberref)
		end
	is_param_table_using_4_bytes: BOOLEAN
		do
			Result := is_table_using_4_bytes ({PE_TABLES}.tparam)
		end
	is_property_table_using_4_bytes: BOOLEAN
		do
			Result := is_table_using_4_bytes ({PE_TABLES}.tproperty)
		end
	is_type_def_table_using_4_bytes: BOOLEAN
		do
			Result := is_table_using_4_bytes ({PE_TABLES}.ttypedef)
		end
	is_type_ref_table_using_4_bytes: BOOLEAN
		do
			Result := is_table_using_4_bytes ({PE_TABLES}.ttyperef)
		end
	is_type_spec_table_using_4_bytes: BOOLEAN
		do
			Result := is_table_using_4_bytes ({PE_TABLES}.ttypespec)
		end

	read_rva (lab: like {PE_ITEM}.label): PE_NATURAL_32_ITEM
		do
			Result := read_natural_32_item (lab)
		end

	read_flags_16 (lab: like {PE_ITEM}.label): PE_INTEGER_16_ITEM
		do
			Result := read_integer_16_item (lab)
		end

	read_flags_32 (lab: like {PE_ITEM}.label): PE_INTEGER_32_ITEM
		do
			Result := read_integer_32_item (lab)
		end

	read_index (lab: like {PE_ITEM}.label): PE_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			-- TODO: check if needed?
			b := file.position.to_natural_32
			create {PE_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			e := file.position.to_natural_32
		end

	read_blob_index (lab: like {PE_ITEM}.label): PE_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			if is_blob_heap_using_4_bytes then
				create {PE_INDEX_32_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32), lab)
			else
				create {PE_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			end
			e := file.position.to_natural_32
		end

	read_guid_index (lab: like {PE_ITEM}.label): PE_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			if is_guid_heap_using_4_bytes then
				create {PE_INDEX_32_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32), lab)
			else
				create {PE_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			end
			e := file.position.to_natural_32
		end

	read_string_index (lab: like {PE_ITEM}.label): PE_STRING_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			if is_string_heap_using_4_bytes then
				create {PE_STRING_INDEX_32_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32), lab)
			else
				create {PE_STRING_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			end
			e := file.position.to_natural_32
		end

	read_type_def_index (lab: like {PE_ITEM}.label): PE_TYPE_DEF_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			if is_type_def_table_using_4_bytes then
				create {PE_TYPE_DEF_INDEX_32_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32), lab)
			else
				create {PE_TYPE_DEF_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			end
			e := file.position.to_natural_32
		end

	read_type_def_or_ref_or_spec_index (lab: like {PE_ITEM}.label; multi: PE_STRUCTURE_TAG_ITEM): PE_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
			idx: PE_INDEX_ITEM
		do
			b := file.position.to_natural_32
			if
				is_type_def_table_using_4_bytes
				or is_type_ref_table_using_4_bytes
				or is_type_spec_table_using_4_bytes
			then
				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
				create {PE_INDEX_32_ITEM} idx.make (b, mp, lab)
			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_INDEX_16_ITEM} idx.make (b, mp, lab)
			end
			if attached multi.tag_and_index (idx) as tu then
				inspect tu.table
				when {PE_TYPE_DEF_OR_REF_OR_SPEC_INDEX}.typedef then
					if is_type_def_table_using_4_bytes then
						create {PE_TYPE_DEF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_TYPE_DEF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_TYPE_DEF_OR_REF_OR_SPEC_INDEX}.typeref then
					if is_type_ref_table_using_4_bytes then
						create {PE_TYPE_REF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_TYPE_REF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_TYPE_DEF_OR_REF_OR_SPEC_INDEX}.typespec then
					if is_type_spec_table_using_4_bytes then
						create {PE_TYPE_SPEC_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_TYPE_SPEC_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				else
					check False end
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
					Result := idx
				end
			else
				check False end
				Result := idx
			end
			e := file.position.to_natural_32
		end

	read_has_constant_index (lab: like {PE_ITEM}.label; multi: PE_STRUCTURE_TAG_ITEM): PE_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
			idx: PE_INDEX_ITEM
		do
			b := file.position.to_natural_32
			-- FIXME
			if
				is_method_def_table_using_4_bytes
				or is_member_ref_table_using_4_bytes
			then
				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
				create {PE_INDEX_32_ITEM} idx.make (b, mp, lab)
			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_INDEX_16_ITEM} idx.make (b, mp, lab)
			end
			if attached multi.tag_and_index (idx) as tu then
				inspect tu.table
				when {PE_HAS_CONSTANT_INDEX}.field then
					if is_table_using_4_bytes (tu.table) then
						create {PE_FIELD_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_FIELD_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CONSTANT_INDEX}.param then
					if is_table_using_4_bytes (tu.table) then
						create {PE_PARAM_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_PARAM_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CONSTANT_INDEX}.property then
					if is_table_using_4_bytes (tu.table) then
						create {PE_PROPERTY_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_PROPERTY_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				else
					check False end
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
					Result := idx
				end
			else
				check False end
				Result := idx
			end
			e := file.position.to_natural_32
		end

	read_has_semantic_index (lab: like {PE_ITEM}.label; multi: PE_STRUCTURE_TAG_ITEM): PE_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
			idx: PE_INDEX_ITEM
		do
			b := file.position.to_natural_32
			-- FIXME
			if
				is_property_table_using_4_bytes
				or is_table_using_4_bytes ({PE_TABLES}.tevent)
			then
				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
				create {PE_INDEX_32_ITEM} idx.make (b, mp, lab)
			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_INDEX_16_ITEM} idx.make (b, mp, lab)
			end
			if attached multi.tag_and_index (idx) as tu then
				inspect tu.table
				when {PE_HAS_SEMANTIC_INDEX}.event then
					if is_table_using_4_bytes (tu.table) then
						create {PE_EVENT_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_EVENT_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_SEMANTIC_INDEX}.property then
					if is_table_using_4_bytes (tu.table) then
						create {PE_PROPERTY_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_PROPERTY_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				else
					check False end
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
					Result := idx
				end
			else
				check False end
				Result := idx
			end
			e := file.position.to_natural_32
		end

	read_resolution_scope_index (lab: like {PE_ITEM}.label; multi: PE_STRUCTURE_TAG_ITEM): PE_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
			idx: PE_INDEX_ITEM
		do
			b := file.position.to_natural_32
			-- FIXME
			if
				is_method_def_table_using_4_bytes
				or is_member_ref_table_using_4_bytes
			then
				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
				create {PE_INDEX_32_ITEM} idx.make (b, mp, lab)
			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_INDEX_16_ITEM} idx.make (b, mp, lab)
			end
			if attached multi.tag_and_index (idx) as tu then
				inspect tu.table
				when {PE_RESOLUTION_SCOPE_INDEX}.module then
					if is_table_using_4_bytes (tu.table) then
						create {PE_MODULE_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_MODULE_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_RESOLUTION_SCOPE_INDEX}.moduleref then
					if is_table_using_4_bytes (tu.table) then
						create {PE_MODULE_REF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_MODULE_REF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_RESOLUTION_SCOPE_INDEX}.assemblyref then
					if is_table_using_4_bytes (tu.table) then
						create {PE_ASSEMBLY_REF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_ASSEMBLY_REF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_RESOLUTION_SCOPE_INDEX}.typeref then
					if is_table_using_4_bytes (tu.table) then
						create {PE_TYPE_REF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_TYPE_REF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				else
					check False end
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
					Result := idx
				end
			else
				check False end
				Result := idx
			end
			e := file.position.to_natural_32
		end

	read_custom_attribute_type_index (lab: like {PE_ITEM}.label; multi: PE_STRUCTURE_TAG_ITEM): PE_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
			idx: PE_INDEX_ITEM
		do
			b := file.position.to_natural_32
			-- FIXME
			if
				is_method_def_table_using_4_bytes
				or is_member_ref_table_using_4_bytes
			then
				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
				create {PE_INDEX_32_ITEM} idx.make (b, mp, lab)
			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_INDEX_16_ITEM} idx.make (b, mp, lab)
			end
			if attached multi.tag_and_index (idx) as tu then
				inspect tu.table
				when {PE_CUSTOM_ATTRIBUTE_TYPE_INDEX}.methoddef then
					if is_table_using_4_bytes (tu.table) then
						create {PE_METHOD_DEF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_METHOD_DEF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_CUSTOM_ATTRIBUTE_TYPE_INDEX}.memberref then
					if is_table_using_4_bytes (tu.table) then
						create {PE_MEMBER_REF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_MEMBER_REF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				else
--					check False end
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
					Result := idx
				end
			else
				check False end
				Result := idx
			end
			e := file.position.to_natural_32
		end

	read_has_custom_attribute_index (lab: like {PE_ITEM}.label; multi: PE_STRUCTURE_TAG_ITEM): PE_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
			idx: PE_INDEX_ITEM
		do
			b := file.position.to_natural_32
			if
				is_type_def_table_using_4_bytes
				or is_type_ref_table_using_4_bytes
				or is_type_spec_table_using_4_bytes
			then
				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
				create {PE_INDEX_32_ITEM} idx.make (b, mp, lab)
			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_INDEX_16_ITEM} idx.make (b, mp, lab)
			end
			if attached multi.tag_and_index (idx) as tu then
				inspect tu.table
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.methoddef then
					if is_table_using_4_bytes (tu.table) then
						create {PE_METHOD_DEF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_METHOD_DEF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.methodspec then
					if is_table_using_4_bytes (tu.table) then
						create {PE_METHOD_SPEC_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_METHOD_SPEC_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.memberref then
					if is_table_using_4_bytes (tu.table) then
						create {PE_MEMBER_REF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_MEMBER_REF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.field then
					if is_table_using_4_bytes (tu.table) then
						create {PE_FIELD_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_FIELD_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.typedef then
					if is_table_using_4_bytes (tu.table) then
						create {PE_TYPE_DEF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_TYPE_DEF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.typeref then
					if is_table_using_4_bytes (tu.table) then
						create {PE_TYPE_REF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_TYPE_REF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.typespec then
					if is_table_using_4_bytes (tu.table) then
						create {PE_TYPE_SPEC_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_TYPE_SPEC_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.param then
					if is_table_using_4_bytes (tu.table) then
						create {PE_PARAM_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_PARAM_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.property then
					if is_table_using_4_bytes (tu.table) then
						create {PE_PROPERTY_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_PROPERTY_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.interfaceimpl then
					if is_table_using_4_bytes (tu.table) then
						create {PE_INTERFACE_IMPL_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_INTERFACE_IMPL_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.module then
					if is_table_using_4_bytes (tu.table) then
						create {PE_MODULE_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_MODULE_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.permission then
					if is_table_using_4_bytes (tu.table) then
						create {PE_PERMISSION_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_PERMISSION_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.event then
					if is_table_using_4_bytes (tu.table) then
						create {PE_EVENT_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_EVENT_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.standalonesig then
					if is_table_using_4_bytes (tu.table) then
						create {PE_STANDALONESIG_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_STANDALONESIG_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.moduleref then
					if is_table_using_4_bytes (tu.table) then
						create {PE_MODULE_REF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_MODULE_REF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.assembly then
					if is_table_using_4_bytes (tu.table) then
						create {PE_ASSEMBLY_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_ASSEMBLY_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.assemblyref then
					if is_table_using_4_bytes (tu.table) then
						create {PE_ASSEMBLY_REF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_ASSEMBLY_REF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.file then
					if is_table_using_4_bytes (tu.table) then
						create {PE_FILE_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_FILE_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.exportedtype then
					if is_table_using_4_bytes (tu.table) then
						create {PE_EXPORTED_TYPE_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_EXPORTED_TYPE_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.manifestresource then
					if is_table_using_4_bytes (tu.table) then
						create {PE_MANIFEST_RESOURCE_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_MANIFEST_RESOURCE_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.genericparam then
					if is_table_using_4_bytes (tu.table) then
						create {PE_GENERIC_PARAM_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_GENERIC_PARAM_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.genericparamconstraint then
					if is_table_using_4_bytes (tu.table) then
						create {PE_GENERIC_PARAM_CONSTRAINT_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_GENERIC_PARAM_CONSTRAINT_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)

				else
--					check False end
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
					Result := idx
				end
			else
				check False end
				Result := idx
			end
			e := file.position.to_natural_32
		end

	read_field_index (lab: like {PE_ITEM}.label): PE_FIELD_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			if is_field_table_using_4_bytes then
				create {PE_FIELD_INDEX_32_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32), lab)
			else
				create {PE_FIELD_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			end
			e := file.position.to_natural_32
		end

	read_method_def_index (lab: like {PE_ITEM}.label): PE_METHOD_DEF_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
		do
			b := file.position.to_natural_32
			if is_method_def_table_using_4_bytes then
				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
				create {PE_METHOD_DEF_INDEX_32_ITEM} Result.make (b, mp, lab)
			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_METHOD_DEF_INDEX_16_ITEM} Result.make (b, mp, lab)
			end
			e := file.position.to_natural_32
		end

	read_method_def_or_member_ref_index (lab: like {PE_ITEM}.label; multi: PE_METHOD_DEF_OR_MEMBER_REF_INDEX): PE_INDEX_ITEM
		local
			b,e: NATURAL_32
			mp: MANAGED_POINTER
			idx: PE_INDEX_ITEM
		do
			b := file.position.to_natural_32
			if is_method_def_table_using_4_bytes or is_member_ref_table_using_4_bytes then
				mp := read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32)
				create {PE_INDEX_32_ITEM} idx.make (b, mp, lab)
			else
				mp := read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32)
				create {PE_INDEX_16_ITEM} idx.make (b, mp, lab)
			end
			if attached multi.tag_and_index (idx) as tu then
				inspect tu.table
				when {PE_METHOD_DEF_OR_MEMBER_REF_INDEX}.methoddef then
					if is_method_def_table_using_4_bytes then
						create {PE_METHOD_DEF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_METHOD_DEF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				when {PE_METHOD_DEF_OR_MEMBER_REF_INDEX}.memberref then
					if is_member_ref_table_using_4_bytes then
						create {PE_MEMBER_REF_INDEX_32_ITEM} Result.make (b, mp, lab)
					else
						create {PE_MEMBER_REF_INDEX_16_ITEM} Result.make (b, mp, lab)
					end
					Result.update_index (tu.index)
				else
					check False end
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
					Result := idx
				end
			else
				check False end
				Result := idx
			end
			e := file.position.to_natural_32
		end

	read_param_index (lab: like {PE_ITEM}.label): PE_PARAM_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			if is_param_table_using_4_bytes then
				create {PE_PARAM_INDEX_32_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32), lab)
			else
				create {PE_PARAM_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			end
			e := file.position.to_natural_32
		end

	read_event_index (lab: like {PE_ITEM}.label): PE_EVENT_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			if is_param_table_using_4_bytes then
				create {PE_EVENT_INDEX_32_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32), lab)
			else
				create {PE_EVENT_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			end
			e := file.position.to_natural_32
		end

	read_property_index (lab: like {PE_ITEM}.label): PE_PROPERTY_INDEX_ITEM
		local
			b,e: NATURAL_32
		do
			b := file.position.to_natural_32
			if is_property_table_using_4_bytes then
				create {PE_PROPERTY_INDEX_32_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_32_bytes.to_natural_32), lab)
			else
				create {PE_PROPERTY_INDEX_16_ITEM} Result.make (b, read_bytes ({PLATFORM}.natural_16_bytes.to_natural_32), lab)
			end
			e := file.position.to_natural_32
		end

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
			v.visit_pe_file (Current)
		end

end
