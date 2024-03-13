﻿note
	description: "Helper class to generate a PE file."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_GENERATOR

inherit
	PE_TABLE_CONSTANTS

	REFACTORING_HELPER

create
	make,
	make_pdb

feature {NONE} -- Initalizatiob

	make
			-- Creation procedure to instance a new object.
		do
			set_is_pe_generator (True)
			initialize
		end

	make_pdb (a_associated_pe: PE_GENERATOR)
			-- Creation procedure to instance a new object.
		do
			set_is_pdb_generator (True)
			associated_pe := a_associated_pe
			initialize
		end

	initialize
		do
			create stream_headers.make_filled (0, streams_count, 2)
			create guid.make
			create blob.make
			create us.make
			create strings.make
			create tables_header
			create string_map.make (0)
			initialize_metadata_tables
			create pdb_stream.make
		end

	initialize_metadata_tables
			-- Initialize an in-memory metadata tables
		local
			i,n: INTEGER
		do
			from
				i := 0
				n := {PE_TABLE_CONSTANTS}.max_tables
				create tables.make_empty (n)
			until
				i >= n
			loop
				tables.force (create {MD_TABLE}.make (i.to_natural_32), i)
				i := i + 1
			end
		end

feature -- Access

	associated_pe: detachable PE_GENERATOR
			-- Associated PE file generator when generating PDB content.

feature -- Constant

	version_string: STRING
			-- PE or PDB version string (after the BSJB binary sequence)
		do
			if is_pe_generator then
				Result := Runtime_version_STRING
			else
				check is_pdb_generator end
				Result := PDB_version_string
			end
		end

	Runtime_version_STRING: STRING = "v4.0.30319"
			--this is a CUSTOM version string for microsoft.
			--standard CIL differs
			--| The Version string shall be 'Standard CLI 2005' 
			--| for any file that is intended to be executed on any
			--| conforming implementation of the CLI

	PDB_version_string: STRING = "PDB v1.0"

feature -- Streams indexes

	streams_count: INTEGER

	stream_pdb_index: INTEGER  -- #Pdb
	stream_tilda_index: INTEGER  -- #~
	stream_strings_index: INTEGER  -- #Strings
	stream_us_index: INTEGER  -- #US
	stream_guid_index: INTEGER  -- #GUID
	stream_blob_index: INTEGER  -- #Blob

feature -- Access / table

	tables: SPECIAL [MD_TABLE]
			--  in-memory metadata tables

	is_valid_md_table_id (a_tb_id: NATURAL_32): BOOLEAN
		do
			Result := tables.valid_index (a_tb_id.to_integer_32)
		end

	md_table (a_tb_id: NATURAL_32): MD_TABLE
		require
			is_valid_md_table_id (a_tb_id)
		do
			Result := tables [a_tb_id.to_integer_32]
		end

	md_table_entry (a_token: NATURAL_32): detachable PE_TABLE_ENTRY_BASE
			-- MD Table entry for token `a_token`.
		do
			if attached {MD_EMIT}.extract_table_type_and_row (a_token.to_integer_32) as d then
				if is_valid_md_table_id (d.table_type_index) then
					Result := md_table (d.table_type_index)[d.table_row_index]
				end
			end
		end

	next_md_table_index (a_table_id: NATURAL_32): NATURAL_32
			-- Table for id `a_table_id`
			-- See `{PE_TABLES}` for table ids.
		require
			valid_table_index: is_valid_md_table_id (a_table_id)
		do
			Result := md_table (a_table_id).next_index
		end

feature -- Table change

	add_table_entry (a_entry: PE_TABLE_ENTRY_BASE): NATURAL_32
			-- Index in related MD_TABLE
			-- add an entry to one of the tables
			-- note the data for the table will be a class inherited from TableEntryBase,
			--  and this class will self-report the table index to use
		require
			valid_entry_table_index: is_valid_md_table_id (a_entry.table_index)
		local
			l_table_id: NATURAL_32
			l_md_table: MD_TABLE
		do
			l_table_id := a_entry.table_index
			l_md_table := md_table (l_table_id)

			inspect a_entry.table_index
			when
				{PE_TABLES}.tmethoddef,
				{PE_TABLES}.tparam,
				{PE_TABLES}.tfield,
				{PE_TABLES}.tassemblydef,
				{PE_TABLES}.tClassLayout, -- Not used.
				{PE_TABLES}.tconstant, -- Not used.
				{PE_TABLES}.tcustomattribute,
				{PE_TABLES}.tfieldmarshal,
				{PE_TABLES}.tfieldrva,
				{PE_TABLES}.tGenericParam, -- Not used.
				{PE_TABLES}.tImplMap,
				{PE_TABLES}.tMethodSemantics,
				{PE_TABLES}.tNestedClass, -- Not used
				{PE_TABLES}.tStandaloneSig
			then
				-- No duplication checking
				do_nothing -- line to be able to set breakpoint
			when
				{PE_TABLES}.tmodule,
				{PE_TABLES}.ttypedef,
				{PE_TABLES}.tassemblyref,
				{PE_TABLES}.ttyperef,
				{PE_TABLES}.tmemberref,
				{PE_TABLES}.tmoduleref,
				{PE_TABLES}.tinterfaceimpl
			then
				Result := a_entry.token_from_table (l_md_table)

			when
				{PDB_TABLES}.tmethoddebuginformation,
				{PDB_TABLES}.tlocalscope,
				{PDB_TABLES}.tlocalvariable,
				{PDB_TABLES}.tlocalconstant,
				{PDB_TABLES}.timportscope,
				{PDB_TABLES}.tstatemachinemethod,
				{PDB_TABLES}.tCustomDebugInformation
			then
				-- No duplication checking				
				do_nothing -- line to be able to set breakpoint
			when
				{PDB_TABLES}.tdocument
			then
				Result := a_entry.token_from_table (l_md_table)
			else
				Result := a_entry.token_from_table (l_md_table)
			end
			if Result = 0 then
				l_md_table.force (a_entry)
				Result := l_md_table.size
			end
			Result := (l_table_id |<< 24) | Result
		ensure
			entry_added: a_entry.token_from_table (md_table (a_entry.table_index)) > 0
		end

feature -- Headers

	tables_header: PE_DOTNET_META_TABLES_HEADER
			-- `tables_header'

feature -- Access / streams			

	stream_headers: ARRAY2 [NATURAL_32]
			-- defined as streamHeaders_[5][2]
			--| There are five possible kinds of streams.
			--| - stream header with name `#~` that points to the physical representation of a set of tables.			
			--| - stream header with name `#Strings` that points to the physical representation of the
			--|     strings heap where identifier strings are stored
			--| - stream header with name `#US` that points to the physical representation of the
			--|     user strings heap
			--| - stream header with name `#Blob` that points to the physical representation of the blob heap,
			--| - stream header with name `#GUID` that points to the physical representation of the GUID heap
			--|
			--| And for PDB file generation, an additional stream (at first position):
			--| - stream header with name `#Pdb` that points to the PDB debugging data.

	stream_names: ARRAY [STRING_32]
		do
			if is_pe_generator then
				Result := {ARRAY [STRING_32]} <<"#~", "#Strings", "#US", "#GUID", "#Blob">>
			else
				check is_pdb_generator end
				Result := {ARRAY [STRING_32]} <<"#Pdb", "#~", "#Strings", "#US", "#GUID", "#Blob">>
			end
		end

	default_us: ARRAY [NATURAL_8]
			-- defined as static Byte defaultUS_[];
			--| Byte defined as 1 byte.
		do
			Result := {ARRAY [NATURAL_8]} <<0, 3, 0x20, 0, 0>>
			Result.conservative_resize_with_default (0, 1, 8)
		end

	string_map: STRING_TABLE [NATURAL_32]
			-- reflection of the String stream so that we can keep from doing duplicates.
			-- right now we don't check duplicates on any of the other streams...

	strings: PE_POOL
			--#Strings header is the physical
			--representation of the logical string heap

	us: PE_POOL
			-- #US Strean od bytes  physical representation of logical
			-- Userstring
			-- The first entry in this hesp is empty that consists of the single byte 0x00.

	blob: PE_POOL
			-- The #blob heap
			-- The first entry in this hesp is empty that consists of the single byte 0x00.

	guid: PE_POOL
			-- The #GUID header points to a sequence of 128-bit GUIDs


	pdb_stream: CLI_PDB_STREAM
			-- #Pdb only used when generate a pdb stream

feature -- Status report

	is_pe_generator: BOOLEAN assign set_is_pe_generator
			-- Is pe generator?
		do
			Result := not is_pdb_generator
		end

	is_pdb_generator: BOOLEAN assign set_is_pdb_generator
			-- Is PDB generator?

feature -- Status settings

	set_is_pe_generator (b: BOOLEAN)
		do
			set_is_pdb_generator (not b)
		ensure
			is_pe_generator = b
			b implies stream_blob_index = 5
		end

	set_is_pdb_generator (b: BOOLEAN)
		local
			i: INTEGER
		do
			is_pdb_generator := b
			if b then
				i := 1
			else
				i := 0
			end
			stream_pdb_index := i
			stream_tilda_index := i + 1
			stream_strings_index := i + 2
			stream_us_index := i + 3
			stream_guid_index := i + 4
			stream_blob_index := i + 5

			streams_count := stream_blob_index
		ensure
			is_pdb_generator = b
			b implies stream_blob_index = 6
		end

feature -- Sizes			

	us_heap_size: NATURAL_32
			-- User string heap size.
		do
			Result := us.size
		end

	guid_heap_size: NATURAL_32
			-- Guid heap size
		do
			Result := guid.size
		end

	blob_heap_size: NATURAL_32
			-- Blob heap size
		do
			Result := blob.size
		end

	strings_heap_size: NATURAL_32
			-- String heap size
		do
			Result := strings.size
		end

feature -- Stream functions

	hash_string (a_utf8: STRING_32): NATURAL_32
			-- return the stream index
			--| TODO add a precondition to verify a_utf8 is a valid UTF_8
		local
			l_str: STRING_8
			l_converter: BYTE_ARRAY_CONVERTER
		do
			if string_map.has_key (a_utf8) and then attached string_map.item (a_utf8) as l_val then
				Result := l_val
			else
				if strings.size = 0 then
					strings.increment_size
				end
				strings.confirm (strings.size + 1)
				Result := strings.size
				l_str := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_utf8)
				create l_converter.make_from_string (l_str)

				strings.copy_data (strings.size.to_integer_32, l_converter.to_natural_8_array, (l_str.count + 1).to_natural_32)
				strings.increment_size_by ((a_utf8.count + 1).to_natural_32)
				string_map.force (Result, a_utf8)
			end
		end

	string_at (idx: PE_STRING): detachable STRING_32
			-- String value for "Strings" index `idx`
		local
			l_heap: SPECIAL [NATURAL_8]
			l_size: INTEGER_32
			i, k, current_size: INTEGER
			mp: MANAGED_POINTER
		do
			l_heap := strings.base
			l_size := strings.size.to_integer_32
			i := {MD_EMIT}.extract_table_type_and_row (idx.index.to_integer_32).table_row_index.to_integer_32
			if i <= l_size then
				from
					k := 0
				until
					(l_heap [i + k] = 0) or (i + k > l_size)
				loop
					k := k + 1
				end
				current_size := k
				create mp.make (k + 1)
				from
				until
					k = 0
				loop
					mp.put_natural_8_le (l_heap[i + k - 1], k - 1)
					k := k - 1
				end
				Result := {UTF_CONVERTER}.utf_8_0_pointer_to_escaped_string_32 (mp)
			end
		end

	hash_us (a_str: STRING_32; a_length: INTEGER): NATURAL_32
			-- UserString (US) stream index
			-- See: ECMA-335 6th edition, II.24.2.4 #US and #Blob heaps		
			-- Computes the hash of a UserString `a_str'
			-- if the UserString already exists in a heap, returns the index of the existing value
			-- otherwise computes the hash and returns the index of the new value.
		local
			l_flag: NATURAL_8
			len: NATURAL_32
			n: INTEGER
			l_converter: BYTE_ARRAY_CONVERTER
			l_data: ARRAY [NATURAL_8]
		do
			create l_converter.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_16le_string_8 (a_str))
			l_data := l_converter.to_natural_8_array
			Result := check_us (us, l_data)
			if Result = 0 then
				if us.size = 0 then
					us.increment_size
				end
				check a_str.count = a_length end

				len := (l_data.count + 1).to_natural_32 -- +1 for the flag

				us.confirm (len + 5)
				Result := us.size
				if len < 0x80 then
					us.base [us.size.to_integer_32] := len.to_natural_8
					us.increment_size
				elseif len <= 0x3fff then
					us.base [us.size.to_integer_32] := ((len |>> 8) | 0x80).to_natural_8
					us.increment_size
					us.base [us.size.to_integer_32] := len.to_natural_8
					us.increment_size
				else
					len := len & 0x1fffffff
					us.base [us.size.to_integer_32] := ((len |>> 24) | 0xc0).to_natural_8
					us.increment_size
					us.base [us.size.to_integer_32] := (len |>> 16).to_natural_8
					us.increment_size
					us.base [us.size.to_integer_32] := (len |>> 8).to_natural_8
					us.increment_size
					us.base [us.size.to_integer_32] := (len |>> 0).to_natural_8
					us.increment_size
				end

				us.copy_data ((us.size).to_integer_32, l_data, len - 1) -- -1: len include the flag  byte.
				us.increment_size_by (len - 1)

					-- See II.24.2.4 from ECMA-335 6th Edition
					-- This final byte holds the value 1 if and only if any UTF16 character within the string has any bit
					-- set in its top byte, or its low byte is any of the following:
					--  0x01–0x08, 0x0E–0x1F, 0x27, 0x2D, 0x7F.
					-- Otherwise, it holds 0. The 1 signifies Unicode characters that require handling beyond that normally
					-- provided for 8-bit encoding sets.

				across a_str as i until l_flag = {NATURAL_8} 1 loop
					n := i.code
					if (n & 0xff00) /= 0 then
						l_flag := {NATURAL_8} 1
					else
						inspect n
						when 0x01..0x08 then
							l_flag := {NATURAL_8} 1
						when 0x0e..0x1F then
							l_flag := {NATURAL_8} 1
						when 0x27, 0x2d, 0x7f then
							l_flag := {NATURAL_8} 1
						else
							l_flag := {NATURAL_8} 0
						end
					end
				end
				us.base [us.size.to_integer_32] := l_flag -- 0 or 1
				us.increment_size
			end
		end

	check_us (a_us: PE_POOL; target_us: ARRAY [NATURAL_8]): NATURAL_32
			-- Check if `target_us` exists in `a_us` and return its index if found, otherwise return 0.
		local
			us_heap: SPECIAL [NATURAL_8]
			us_size: NATURAL_32;
			i, j, k, target_size, current_size: INTEGER
		do
			us_heap := a_us.base
			us_size := a_us.size

--			Result := 0 -- not found (yet)

			target_size := target_us.count
			from
					-- note: The first entry in both these heaps is the empty 'blob' that consists of the single byte 0x00.
					-- SPECIAL are 0-based, skip first entry.
				i := 1
			until
				i.to_natural_32 >= us_size or else Result > 0
			loop
					-- Check if the current user string matches the target user string.
				if us_heap [i] < 0x80 then
					-- 128 = 0x80 = 1000 0000
					current_size := us_heap [i]
					j := i + 1
				elseif us_heap [i] < 0xC0 then -- 0xC0 = 1100 0000
					-- 192 = 0xC0  =   1100 0000
					-- 256 = 0x100 = 1 0000 0000
					current_size := (us_heap [i] - 0x80) * 0x100
									+ us_heap [i + 1]
					j := i + 2
				else
					-- 16777216 = 0x100_0000 = 1 00000000 00000000 00000000
					-- 65 536  	=   0x1_0000 =          1 00000000 00000000
					-- 256 		=      0x100 =                   1 00000000
					current_size := (us_heap [i] - 0xC0) * 0x100_0000
									+ us_heap [i + 1] * 0x1_0000
									+ us_heap [i + 2] * 0x100
									+ us_heap [i + 3]
					j := i + 4
				end

					-- Note: the `current_size` for #US includes the final byte 0 or 1.
				if current_size - 1 = target_size then
						-- Exclude the final byte from the comparison: 0 or 1
					from
						k := 1
					until
						(j + k - 1).to_natural_32 >= us_size
						or else k > target_size
						or else target_us [k] /= us_heap [j + k - 1]
					loop
						k := k + 1
					end
					if (k - 1) = target_size then
							-- Found a match.
						Result := i.to_natural_32
					end
				end
				i := j + current_size
			end
		ensure
			valid_result: Result >= 0
		end

	hash_guid (a_guid: ARRAY [NATURAL_8]): NATURAL_32
			-- return the GUID stream index
		do
			guid.confirm (17) -- 128 // 8 + 1 (null char)
			Result := guid.size
			guid.copy_data (Result.to_integer_32, a_guid, 16)
			guid.increment_size_by (16)
			Result := Result // 16 + 1
		end

	check_guid (a_guid: ARRAY [NATURAL_8]): NATURAL_32
			-- Check if `a_guid` exists in `guid` and return its index if found, otherwise return 0.
		local
			l_heap: SPECIAL [NATURAL_8]
			l_heap_size: NATURAL_32
			i, k, target_size, current_size: INTEGER
		do
--			Result := 0 -- not found (yet)
			l_heap := guid.base
			l_heap_size := guid.size
			target_size := a_guid.count
			from
				i := 0 --| Special are 0-based
			until
				i.to_natural_32 >= l_heap_size or else Result /= 0
			loop
				current_size := a_guid.count
				check current_size = 16 end
				from
					k := 1
				until
					(i + k - 1).to_natural_32 > l_heap_size
					or else k > target_size
					or else a_guid [k] /= l_heap [i + k - 1]
				loop
					k := k + 1
				end
				if (k - 1) = target_size then
						-- Found a match.
					Result := (i + 1).to_natural_32
				end
				i := i + current_size
			end
		ensure
			valid_result: Result >= 0
		end

	hash_blob (a_blob_data: ARRAY [NATURAL_8]; a_blob_len: NATURAL_32): NATURAL_32
			-- Blob stream index.
			-- See: ECMA-335 6th edition, II.24.2.4 #US and #Blob heaps
			-- Computes the hash of a blob `a_blob_data'
			-- if the blob already exists in a heap, returns the index of the existing blob
			-- otherwise computes the hash and returns the index of the new blob.			
		local
			l_blob_len: NATURAL_32
		do
			Result := check_blob (a_blob_data)
			if Result = 0 then
				l_blob_len := a_blob_len
				if blob.size = 0 then
					blob.increment_size
				end
				blob.confirm (a_blob_len + 4)
				Result := blob.size
				if a_blob_len < 0x80 then
					blob.base [blob.size.to_integer_32] := l_blob_len.to_natural_8
					blob.increment_size
				elseif a_blob_len <= 0x3fff then
					blob.base [blob.size.to_integer_32] := ((l_blob_len |>> 8) | 0x80).to_natural_8
					blob.increment_size
					blob.base [blob.size.to_integer_32] := l_blob_len.to_natural_8
					blob.increment_size
				else
					l_blob_len := l_blob_len & 0x1fffffff
					blob.base [blob.size.to_integer_32] := ((l_blob_len |>> 24) | 0xc0).to_natural_8
					blob.increment_size
					blob.base [blob.size.to_integer_32] := (l_blob_len |>> 16).to_natural_8
					blob.increment_size
					blob.base [blob.size.to_integer_32] := (l_blob_len |>> 8).to_natural_8
					blob.increment_size
					blob.base [blob.size.to_integer_32] := (l_blob_len |>> 0).to_natural_8
					blob.increment_size
				end
				blob.copy_data ((blob.size).to_integer_32, a_blob_data, l_blob_len)
				blob.increment_size_by (l_blob_len)
			end
		ensure
			hashed: Result = check_blob (a_blob_data)
		end

	blob_at (idx: PE_BLOB): detachable MANAGED_POINTER
		local
			blob_heap: SPECIAL [NATURAL_8]
			blob_size: INTEGER_32
			i, j, k, current_size: INTEGER
		do
			blob_heap := blob.base
			blob_size := blob.size.to_integer_32
			i := {MD_EMIT}.extract_table_type_and_row (idx.index.to_integer_32).table_row_index.to_integer_32
			if i <= blob_size then
					-- Check if the blob header matches the target blob size.
				if blob_heap [i] < 0x80 then
					-- 128 = 0x80 = 1000 0000
					current_size := blob_heap [i]
					j := i + 1
				elseif blob_heap [i] < 0xC0 then -- 0xC0 = 1100 0000
					-- 192 = 0xC0  =   1100 0000
					-- 256 = 0x100 = 1 0000 0000
					current_size := (blob_heap [i] - 0x80) * 0x100
									+ blob_heap [i + 1]
					j := i + 2
				else
					-- 16777216 = 0x100 0000 = 1 00000000 00000000 00000000
					-- 65 536 	=   0x1 0000 =          1 00000000 00000000
					-- 256 		=      0x100 =                   1 00000000
					current_size := (blob_heap [i] - 0xC0) * 0x100_0000
									+ blob_heap [i + 1] * 0x1_0000
									+ blob_heap [i + 2] * 0x100
									+ blob_heap [i + 3]
					j := i + 4
				end

				create Result.make (current_size)
				from
					k := 1
				until
					k > current_size or
					(j + k - 1) > blob_size
				loop
					Result.put_natural_8_le (blob_heap[j + k - 1], k - 1)
					k := k + 1
				end
			end
		end

	check_blob (target_blob: ARRAY [NATURAL_8]): NATURAL_32
			-- Check if `target_blob` exists in `blob` and return its index if found, otherwise return 0.
		local
			blob_heap: SPECIAL [NATURAL_8]
			blob_size: NATURAL_32
			i, j, k, target_size, current_size: INTEGER
		do
--			Result := 0 -- not found (yet)
			blob_heap := blob.base
			blob_size := blob.size
			target_size := target_blob.count
			from
				i := 1 --| 2 - 1  Special are 0-based
			until
				i.to_natural_32 >= blob_size or else Result /= 0
			loop
					-- Check if the blob header matches the target blob size.
				if blob_heap [i] < 0x80 then
					-- 128 = 0x80 = 1000 0000
					current_size := blob_heap [i]
					j := i + 1
				elseif blob_heap [i] < 0xC0 then -- 0xC0 = 1100 0000
					-- 192 = 0xC0  =   1100 0000
					-- 256 = 0x100 = 1 0000 0000
					current_size := (blob_heap [i] - 0x80) * 0x100
									+ blob_heap [i + 1]
					j := i + 2
				else
					-- 16777216 = 0x100 0000 = 1 00000000 00000000 00000000
					-- 65 536 	=   0x1 0000 =          1 00000000 00000000
					-- 256 		=      0x100 =                   1 00000000
					current_size := (blob_heap [i] - 0xC0) * 0x100_0000
									+ blob_heap [i + 1] * 0x1_0000
									+ blob_heap [i + 2] * 0x100
									+ blob_heap [i + 3]
					j := i + 4
				end
					-- Check if the current blob matches the target blob.
				if current_size = target_size then
					from
						k := 1
					until
						(j + k - 1).to_natural_32 > blob_size
						or else k > target_size
						or else target_blob [k] /= blob_heap [j + k - 1]
					loop
						k := k + 1
					end
					if (k - 1) = target_size then
							-- Found a match.
						Result := i.to_natural_32
					end
				end
				i := j + current_size
			end
		ensure
			valid_result: Result >= 0
		end

	hash_blob_file_content (a_path: CLI_STRING; a_algo: INTEGER): NATURAL_32
			-- File content hashed using the specified hash algorithm
			-- TODO: define `a_algo` type:
			-- 	ff1816ec-aa5e-4d10-87f7-6f4963833460 	SHA-1 hash
			--	8829d00f-11b8-4213-878b-770e8597ac16 	SHA-256 hash
		local
			l_hash: ARRAY [NATURAL_8]
		do
			-- TODO: implementation
			if a_algo = hash_algo_sha1 then
				l_hash := {MD_HASH_UTILITIES}.sha1_bytes_for_file_name (a_path.string_32)
			elseif a_algo = hash_algo_sha256 then
				l_hash := {MD_HASH_UTILITIES}.sha256_bytes_for_file_name (a_path.string_32)
			else
				l_hash := {ARRAY [NATURAL_8]} <<0>> -- FIXME
			end
			Result := hash_blob (l_hash, l_hash.count.to_natural_32)
		end

	hash_algo_sha1: INTEGER = 1
	hash_algo_sha256: INTEGER = 256

feature -- Operations

	create_guid: ARRAY [NATURAL_8]
			-- Create a new GUID as a byte array
		do
			Result := new_random_guid
		end

feature -- hash_guid helpers

	sha1_hash_algorithm_guid_index: NATURAL_32

	hash_guid_for_sha1_hash_algorithm: NATURAL_32
		local
			conv: BYTE_ARRAY_CONVERTER
		do
			Result := sha1_hash_algorithm_guid_index
			if Result = 0 then
					-- See: https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#document-table-0x30
					-- HashAlgorithm field value 				hash field semantics
					-- ff1816ec-aa5e-4d10-87f7-6f4963833460 	SHA-1 hash
					-- 8829d00f-11b8-4213-878b-770e8597ac16 	SHA-256 hash
				create conv.make_from_string ("ff1816ec-aa5e-4d10-87f7-6f4963833460")
				Result := hash_guid (conv.to_natural_8_array)
				sha1_hash_algorithm_guid_index := Result
			end
		end

	sha256_hash_algorithm_guid_index: NATURAL_32

	hash_guid_for_sha256_hash_algorithm: NATURAL_32
		local
			conv: BYTE_ARRAY_CONVERTER
		do
			Result := sha256_hash_algorithm_guid_index
			if Result = 0 then
					-- See: https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#document-table-0x30
					-- HashAlgorithm field value 				hash field semantics
					-- ff1816ec-aa5e-4d10-87f7-6f4963833460 	SHA-1 hash
					-- 8829d00f-11b8-4213-878b-770e8597ac16 	SHA-256 hash
				create conv.make_from_string ("8829d00f-11b8-4213-878b-770e8597ac16")
				Result := hash_guid (conv.to_natural_8_array)
				sha256_hash_algorithm_guid_index := Result
			end
		end

feature {MD_EMIT} -- Implementation

	meta_header1: PE_DOTNET_META_HEADER
		do
			create Result
			Result.set_signature ({PE_DOTNET_META_HEADER}.meta_sig)
			Result.set_major (1)
			Result.set_minor (1)
			Result.set_reserved (0)
		ensure
			instance_free: class
		end

	compute_version_string_size: NATURAL
		do
			Result := (version_string.count + 1).to_natural_32
		end

	computed_metadata_size: NATURAL_32
			-- metadata size computed by previous call to `compute_metadata_size`

	compute_metadata_size
			--| Computes the size of the PE metadata for the current emitted assembly.
			--| Iterate through each table and multiplying the size of the table by the number of entries in the table.
			--| Adds the size of each heap (string, user string, blob, and GUID)
			--| The size of the metadata header and table header.
			--| The size of the metadata (in bytes) in stored into `computed_metadata_size` attribute.
		note
			EIS: "name=Metadata Root", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=297", "protocol=uri"
		local
			l_current_rva: NATURAL_32
			l_counts: ARRAY [NATURAL_32]
			l_temp: NATURAL_32
			l_buffer: ARRAY [NATURAL_8]
			i,n: INTEGER
			l_stream_headers: ARRAY2 [NATURAL_32]
			l_tables_header: PE_DOTNET_META_TABLES_HEADER
			l_md_tables: like {PE_GENERATOR}.tables
		do
			computed_metadata_size := 0
			l_md_tables := tables
			l_stream_headers := stream_headers
			l_tables_header := tables_header

			l_current_rva := 16
				-- metadata header offest
				-- Signature + Major Version + MinorVersion + Reserved + Length

			l_current_rva := l_current_rva + compute_version_string_size
				-- Version (PE or PDB)

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end
				-- Padding to next 4 byte boundary

			l_current_rva := l_current_rva + 2
				-- flags

			l_current_rva := l_current_rva + 2
				-- streams, will be 5 in our implementation
				-- check stream_names feature.

				-- StreamHeaders. Array of n StreamHdr structures
				-- ("#Pdb), "#~", "#Strings", "#US", "#GUID", "#Blob"
			across stream_names as elem loop
				l_current_rva := l_current_rva + 8 + (elem.count + 1).to_natural_32
				if (l_current_rva \\ 4) /= 0 then
					l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
				end
			end
			if is_pdb_generator then
				l_stream_headers [stream_pdb_index, 1] := l_current_rva
				l_current_rva := l_current_rva + pdb_stream.size_of.to_natural_32 -- TODO: check
				l_stream_headers [stream_pdb_index, 2] := l_current_rva - l_stream_headers [stream_pdb_index, 1]
				l_stream_headers [stream_tilda_index, 1] := l_current_rva
			else
				l_stream_headers [stream_tilda_index, 1] := l_current_rva
			end

-- Double check how to filter this code for PDB file generator.
-- table_header is not used see https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md

			l_tables_header.major_version := 2
			l_tables_header.reserved2 := 1
			if is_pe_generator then

-- Why having Event and Property sorted? anyway, the Eiffel compiler does not use them.
--				l_tables_header.mask_sorted := 0b00000000_00000000_00010110_00000000_00110011_00100101_11111010_00000000
				l_tables_header.mask_sorted := 0b00000000_00000000_00010110_00000000_00110011_00000001_11111010_00000000
			else
				check is_pdb_generator end
					-- Sorted tables are 0x32 LocalScope  and 0x37 CustomDebugInformation
				l_tables_header.mask_sorted := 0b00000000_10000100_00000000_00000000_00000000_00000000_00000000_00000000 -- TO CHANGE !
			end
			--FIXME: check if size is about rows count, or offset (for Blob)
			-- See II.24.2.6 #~ stream
			-- Check size >= 2^16 = 0x1_0000
			if strings_heap_size >= 0x1_0000 then
				l_tables_header.heap_offset_sizes := l_tables_header.heap_offset_sizes | 0x1
			end
			if guid_heap_size >= 0x1_0000 then
				l_tables_header.heap_offset_sizes := l_tables_header.heap_offset_sizes | 0x2
			end
			if blob_heap_size >= 0x1_0000 then
				l_tables_header.heap_offset_sizes := l_tables_header.heap_offset_sizes | 0x4
			end

			create l_counts.make_filled (0, 1, Max_tables + Extra_indexes)

			l_counts [t_string + 1] := strings_heap_size
			l_counts [t_us + 1] := us_heap_size
			l_counts [t_guid + 1] := guid_heap_size
			l_counts [t_blob + 1] := blob_heap_size

			from
				i := 0
				n := l_md_tables.count
			until
				i >= n
			loop
				if not l_md_tables [i].is_empty then
					l_counts [i + 1] := l_md_tables [i].size
					l_tables_header.mask_valid := l_tables_header.mask_valid | ({INTEGER_64} 1 |<< i)
					l_temp := l_temp + 1
				end
				i := i + 1
			end
			l_current_rva := l_current_rva + l_tables_header.size_of.to_natural_32
				-- tables header
			l_current_rva := l_current_rva + (l_temp * ({PLATFORM}.natural_32_bytes).to_natural_32)
				-- table counts
				-- Dword is 4 bytes.

			from
				i := 0
				n := l_md_tables.count
			until
				i >= n
			loop
				if l_counts [i + 1] /= 0 then
					create l_buffer.make_filled (0, 1, 512)
					l_temp := l_md_tables [i][{NATURAL_32} 1].render (l_counts, l_buffer)
					l_temp := l_temp * (l_counts [i + 1])
					l_current_rva := l_current_rva + l_temp
				end
				i := i + 1
			end

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_stream_headers [stream_tilda_index, 2] := l_current_rva - l_stream_headers [stream_tilda_index, 1]
			l_stream_headers [stream_strings_index, 1] := l_current_rva
			l_current_rva := l_current_rva + strings.size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_stream_headers [stream_strings_index, 2] := l_current_rva - l_stream_headers [stream_strings_index, 1]
			l_stream_headers [stream_us_index, 1] := l_current_rva
			if us.size = 0 then
				l_current_rva := l_current_rva + default_us.count.to_natural_32
					-- US May be empty in our implementation we put an empty string there
			else
				l_current_rva := l_current_rva + us.size
			end

				-- TODO refactor this code into a feature.
			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_stream_headers [stream_us_index, 2] := l_current_rva - l_stream_headers [stream_us_index, 1]
			l_stream_headers [stream_guid_index, 1] := l_current_rva
			l_current_rva := l_current_rva + guid.size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_stream_headers [stream_guid_index, 2] := l_current_rva - l_stream_headers [stream_guid_index, 1]
			l_stream_headers [stream_blob_index, 1] := l_current_rva
			l_current_rva := l_current_rva + blob.size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_stream_headers [stream_blob_index, 2] := l_current_rva - l_stream_headers [stream_blob_index, 1]

			computed_metadata_size := l_current_rva.to_natural_32
		ensure
			computed_metadata_size > 0
		end

	update_pdb_stream
			-- Update the current pdb stream with
			-- ReferencedTypeSystemTables and TypeSystemTableRows
		local
			l_pdb_md_tables: like {PE_GENERATOR}.tables
			l_pe_md_tables: like {PE_GENERATOR}.tables
			i,j,n,l_upper: INTEGER
			l_referenced_type_system_tables: ARRAY [NATURAL_8]
			l_type_system_table_rows: ARRAYED_LIST [NATURAL_32]
		do
				-- Compute the ReferencedTypeSystemTables and TypeSystemTableRows
				-- there is potentially 64 md tables
			create l_referenced_type_system_tables.make_filled (0, 1, 8) -- 1-based index.
			create l_type_system_table_rows.make (1)

			l_pdb_md_tables := tables
			if attached associated_pe as pe then
				l_pe_md_tables := pe.tables
			else
				check has_associated_pe: False end
					-- when generating PDB , the associated_pe should be set!
				l_pe_md_tables := l_pdb_md_tables
			end
			from
				i := l_pe_md_tables.lower
				l_upper := l_pe_md_tables.upper
				j := 1 -- 1-based index
				n := 0 -- the number of bits that are 1 in l_referenced_type_system_tables
			until
				i >= l_upper
			loop
				if is_known_pdb_table (i) then
						-- the PDB stream only includes the information for the PE tables (not the PDB, see tables header for those)
				else
					if
						l_pe_md_tables /= Void and then
						not l_pe_md_tables [i].is_empty
					then
							-- Update the bit vector using bit or.
						l_referenced_type_system_tables [j // 8 + 1] := l_referenced_type_system_tables [j // 8 + 1] | ({NATURAL_8} 1 |<< ((j-1).to_natural_8 \\ 8))

							-- Update the l_type_system_table_rows array
						l_type_system_table_rows.force (l_pe_md_tables [i].size)
						n := n + 1
					end
				end
				j := j + 1
				i := i + 1
			end
				-- Update pdb stream
			pdb_stream.set_referenced_type_system_tables (l_referenced_type_system_tables)
			pdb_stream.set_type_system_table_rows (l_type_system_table_rows.to_array)
		end

feature {NONE} -- Implementation

	is_known_pdb_table (i: INTEGER): BOOLEAN
		do
			Result := ({PDB_TABLES}.tKnownTablesMask.bit_and ({NATURAL_64} 1 |<< i.to_integer_32)) /= 0
		end

	new_random_guid: ARRAY [NATURAL_8]
			-- Create a random GUID.
		local
			l_random: RANDOM
			l_data1: NATURAL_32
			l_data2: NATURAL_16
			l_data3: NATURAL_16
			l_data4: ARRAY [NATURAL_8]
			l_seed: INTEGER
			l_time: TIME
			l_val: NATURAL_8
			l_guid: CIL_GUID
		do
			create l_time.make_now
			l_seed := l_time.hour
			l_seed := l_seed * 60 + l_time.minute
			l_seed := l_seed * 60 + l_time.second
			l_seed := l_seed * 1000 + l_time.milli_second

			create l_random.set_seed (l_seed)
			l_random.start

			l_data1 := l_random.item.to_natural_32
			l_random.forth

			l_data2 := ((l_random.item.to_natural_32 \\ {NATURAL_16}.max_value) + 1).to_natural_16
			l_random.forth

			l_data3 := ((l_random.item.to_natural_32 \\ {NATURAL_16}.max_value) + 1).to_natural_16
			l_random.forth

			l_data4 := {ARRAY [NATURAL_8]} <<0, 0, 0, 0, 0, 0, 0, 0>>

			across 1 |..| 8 as i loop
				l_val := ((l_random.item.to_natural_32 \\ {NATURAL_8}.max_value) + 1).to_natural_8
				l_data4 [i] := l_val
				l_random.forth
			end

			create l_guid.make (l_data1, l_data2, l_data3, l_data4)
			Result := l_guid.to_array_natural_8
		end

end
