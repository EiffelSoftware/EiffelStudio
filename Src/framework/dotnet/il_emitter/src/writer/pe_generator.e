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
	make

feature {NONE} -- Initalizatiob

	make
			-- Creation procedure to instance a new object.
		do
			create guid.make
			create blob.make
			create us.make
			create strings.make
			create stream_headers.make_filled (0, 5, 2)
			create string_map.make (0)
		end

feature -- Constant

	RTV_STRING: STRING = "v4.0.30319"
			--this is a CUSTOM version string for microsoft.
			--standard CIL differs
			--| The Version string shall be 'Standard CLI 2005' 
			--| for any file that is intended to be executed on any
			--| conforming implementation of the CLI

feature -- Access

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
		local
			l_flag: NATURAL_8
			len: NATURAL_32
			n: INTEGER
			l_converter: BYTE_ARRAY_CONVERTER
			l_data: ARRAY [NATURAL_8]
		do
			if us.size = 0 then
				us.increment_size
			end
			check a_str.count = a_length end
			create l_converter.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_16le_string_8 (a_str))
			l_data := l_converter.to_natural_8_array
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

	hash_guid (a_guid: ARRAY [NATURAL_8]): NATURAL_32
			-- return the stream index
		do
			guid.confirm (16) -- 128 // 8
			Result := guid.size
			guid.copy_data (Result.to_integer_32, a_guid, 16)
			guid.increment_size_by (16)
			Result := Result // 16 + 1
		end

	hash_blob (a_blob_data: ARRAY [NATURAL_8]; a_blob_len: NATURAL_32): NATURAL_32
			-- Blob stream index.
			-- See: ECMA-335 6th edition, II.24.2.4 #US and #Blob heaps
		local
			l_rv: NATURAL_32
			l_blob_len: NATURAL_32
		do
			l_blob_len := a_blob_len
			if blob.size = 0 then
				blob.increment_size
			end
			blob.confirm (a_blob_len + 4)
			l_rv := blob.size
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
			Result := l_rv
		end

feature -- Operations

	create_guid: ARRAY [NATURAL_8]
			-- Create a new GUID as a byte array
		do
			Result := new_random_guid
		end

feature {MD_EMIT} -- Implemenation

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


feature {NONE} -- Implementation

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
