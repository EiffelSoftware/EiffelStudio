note
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
			create guid.make
			create blob.make
			create us.make
			create strings.make
			create stream_headers.make_filled (0, 5, 2)
			create tables_header
			create string_map.make (0)
			initialize_metadata_tables
			create pdb_stream.make
			is_pe_generator := True
		end

	make_pdb
			-- Creation procedure to instance a new object.
		do
			make
			is_pe_generator := False
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

feature -- Constant

	RTV_STRING: STRING = "v4.0.30319"
			--this is a CUSTOM version string for microsoft.
			--standard CIL differs
			--| The Version string shall be 'Standard CLI 2005' 
			--| for any file that is intended to be executed on any
			--| conforming implementation of the CLI

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
				{PDB_TABLES}.tdocument
			then
				Result := a_entry.token_from_table (l_md_table)
			else
				-- No duplication checking
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
			--|  There are five possible kinds of streams.
			--| A stream header with name `#Strings` that points to the physical representation of the string heap where
			--|	identifier strings are stored
			--| A stream header with name `#US` that points to the physical representation
			--| of the user string heap
			--| A stream header with name `#Blob` that points to the physical representation of the blob heap,
			--| A stream header with name `#GUID` that points to the physical representation of the GUID heap and
			--| A stream header with name `#~` that points to the physical representation of a set of tables.

	stream_names: ARRAY [STRING_32]
		do
				-- TODO: for PDB, it should also include #Pdb ?
			Result := {ARRAY [STRING_32]} <<"#~", "#Strings", "#US", "#GUID", "#Blob">>
		ensure
			instance_free: class
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


feature -- Sizes

feature -- Status report

	is_pe_generator: BOOLEAN
			-- Is pe generator?

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
			-- return the stream index
		do
			guid.confirm (17) -- 128 // 8 + 1 (null char)
			Result := guid.size
			guid.copy_data (Result.to_integer_32, a_guid, 16)
			guid.increment_size_by (16)
			Result := Result // 16 + 1
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
			Result := check_blob (blob, a_blob_data)
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
			hashed: Result = check_blob (blob, a_blob_data)
		end

	check_blob (a_blob: PE_POOL; target_blob: ARRAY [NATURAL_8]): NATURAL_32
			-- Check if `target_blob` exists in `a_blob` and return its index if found, otherwise return 0.
		local
			blob_heap: SPECIAL [NATURAL_8]
			blob_size: NATURAL_32
			i, j, k, target_size, current_size: INTEGER
		do
--			Result := 0 -- not found (yet)
			blob_heap := a_blob.base
			blob_size := a_blob.size
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

	compute_rtv_string_size: NATURAL
		do
			fixme ("To double check this works as expected")
			Result := (rtv_string.count + 1).to_natural_32
		end

	compute_metadata_size: NATURAL_32
			--| Computes the size of the PE metadata for the current emitted assembly.
			--| Iterate through each table and multiplying the size of the table by the number of entries in the table.
			--| Adds the size of each heap (string, user string, blob, and GUID)
			--| The size of the metadata header and table header.
			--| The final result is the size of the metadata in bytes.
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
			l_md_tables := tables
			l_stream_headers := stream_headers
			l_tables_header := tables_header

			l_current_rva := 16
				-- metadata header offest
				-- Signature + Major Version + MinorVersion + Reserved + Length

			l_current_rva := l_current_rva + compute_rtv_string_size
				-- Version.
				--| The Version string shall be
				--| Standard CLI 2005

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
				-- "#~", "#Strings", "#US", "#GUID", "#Blob"
				--   1 ,      2    ,   3  ,     4  ,    5
			across stream_names as elem loop
				l_current_rva := l_current_rva + 8 + (elem.count + 1).to_natural_32
				if (l_current_rva \\ 4) /= 0 then
					l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
				end
			end
			l_stream_headers [1, 1] := l_current_rva


-- Double check how to filter this code for PDB file generator.
-- table_header is not used see https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md

			if  is_pe_generator then
				l_tables_header.major_version := 2
				l_tables_header.reserved2 := 1
-- Why having Event and Property sorted? anyway, the Eiffel compiler does not use them.
--			l_tables_header.mask_sorted := 0b0000000000000000000101100000000000110011001001011111101000000000

				l_tables_header.mask_sorted := 0b0000000000000000000101100000000000110011000000011111101000000000
			--
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
			l_current_rva := l_current_rva + {PE_DOTNET_META_TABLES_HEADER}.size_of.to_natural_32
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

			l_stream_headers [1, 2] := l_current_rva - l_stream_headers [1, 1]
			l_stream_headers [2, 1] := l_current_rva
			l_current_rva := l_current_rva + strings.size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_stream_headers [2, 2] := l_current_rva - l_stream_headers [2, 1]
			l_stream_headers [3, 1] := l_current_rva
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

			l_stream_headers [3, 2] := l_current_rva - l_stream_headers [3, 1]
			l_stream_headers [4, 1] := l_current_rva
			l_current_rva := l_current_rva + guid.size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_stream_headers [4, 2] := l_current_rva - l_stream_headers [4, 1]
			l_stream_headers [5, 1] := l_current_rva
			l_current_rva := l_current_rva + blob.size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_stream_headers [5, 2] := l_current_rva - l_stream_headers [5, 1]

			Result := l_current_rva.to_natural_32
		end


	update_pdb_stream (a_pdb_stream: CLI_PDB_STREAM)
			-- Update the current pdb stream with
			-- ReferencedTypeSystemTables and TypeSystemTableRows

		local
			l_md_tables: like {PE_GENERATOR}.tables
			i,n: INTEGER
			l_referenced_type_system_tables: ARRAY [NATURAL_8]
			l_type_system_table_rows: ARRAYED_LIST [NATURAL_32]
		do
				-- Compute the ReferencedTypeSystemTables and TypeSystemTableRows
			create l_referenced_type_system_tables.make_filled (0, 1, 2)
			create l_type_system_table_rows.make (1)
			l_md_tables := tables
			from
			    i := 0
			    n := l_md_tables.count
			until
			    i >= n
			loop
			    if not l_md_tables [i].is_empty and is_known_pdb_table(i) then
			       	 	-- Update the bit vector using bit or.
			        l_referenced_type_system_tables [i // 8 + 1] := l_referenced_type_system_tables [i // 8 + 1] | ({NATURAL_8}1 |<< (i.to_natural_8 \\ 8))

			        	-- Update the l_type_system_table_rows array
 			       l_type_system_table_rows [i + 1] := l_md_tables [i].size

			    end
			    i := i + 1
			end
				-- Update pdb stream
			a_pdb_stream.set_referenced_type_system_tables (l_referenced_type_system_tables)
			a_pdb_stream.set_type_system_table_rows (l_type_system_table_rows.to_array)
		end

feature {NONE} -- Implementation

	is_known_pdb_table(i: INTEGER): BOOLEAN
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
