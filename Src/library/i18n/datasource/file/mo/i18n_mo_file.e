note
	description: "[
			Class that represents a .mo file. 
			The description of this file format can be found here: 
				http://www.gnu.org/software/gettext/manual/html_node/gettext_136.html
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_MO_FILE

inherit

  		I18N_FILE

		IMPORTED_UTF8_READER_WRITER

create
	make

feature {NONE} -- Initialization

	make (a_path: READABLE_STRING_GENERAL)
			-- Initialize file from `a_path'.
			--
			-- `a_path': File path of a valid mo file
		local
			l_list: ARRAYED_LIST [STRING_32]
		do
			create {RAW_FILE} file.make_with_name (a_path)
			create l_list.make (0)
			last_translated := [0, l_list]
			create l_list.make (0)
			last_original := [0, l_list]
		ensure then
			last_translated /= Void
			last_original /= Void
		end

feature

	open
			-- Open file and intialise parser.
		do
			if file.exists and file.is_plain then
				file.open_read
				if file.is_open_read then
					read_magic_number
					if valid then
							-- Read mo file version.
						version := read_integer
							-- Read number of strings/entries
							-- (gettext documentation is a bit hazy on this: probably they mean "strings" as in "original strings").
						entry_count := read_integer
							-- Read offset of original strings' table.
						original_table_offset := read_integer
							-- Read offset of translated strings' table.
						translated_table_offset := read_integer
							-- Read size of hash table.
						hash_table_size := read_integer
							-- Read offset of hashing table.
						hash_table_offset := read_integer
							-- Read plural information
						plural_form := plural_tools.unknown_plural_form
						read_plural_form
						opened := True
					end
				end
			end
		end

	close
			-- Closes file.
		do
			file.close
			opened := False
		end

feature -- Access

	valid_index (i:INTEGER): BOOLEAN
			-- Is this index valid?
		do
			Result := i >= 1 and i <= entry_count
		ensure then
			correct_result: Result = (i >= 1 and i <= entry_count)
		end

	entry_has_plurals (i:INTEGER): BOOLEAN
			-- Does `i'-th entry have a plural?
		do
			get_original_entries (i)
			Result := last_original.list.count > 1
		end

	original_singular_string (i: INTEGER): STRING_32
			-- `i'-th original string.
		local
			l_list: LIST [STRING_32]
		do
			get_original_entries (i)
			l_list := last_original.list
			check l_list.valid_index (1) end -- Implied from postcondition of `get_translated_entries'
			Result := l_list.i_th (1)
				-- Extract original in case of `msgctxt' appears.
				-- '%/4/' is the separator used by .mo file.
			Result := Result.substring ((Result.index_of ('%/4/', 1) + 1).min (Result.count) , Result.count)
		end

	original_plural_string (i: INTEGER): STRING_32
			-- `i'-th original plural.
		local
			l_list: LIST [STRING_32]
		do
			get_original_entries (i)
			l_list := last_original.list
			check l_list.valid_index (2) end -- Implied from postcondition of `get_translated_entries'
			Result := l_list.i_th (2)
		end

	context_string (i: INTEGER): detachable STRING_32
			-- `i'-th original string.
		local
			l_list: LIST [STRING_32]
			l_index: INTEGER
		do
			get_original_entries (i)
			l_list := last_original.list
			check l_list.valid_index (1) end -- Implied from postcondition of `get_translated_entries'
			Result := l_list.i_th (1)
				-- Extract context string in case of `msgctxt' appears.
			l_index := Result.index_of ('%/4/', 1)
			if l_index > 0 then
				Result := Result.substring (1, (l_index - 1).max (1))
			else
				Result := Void
			end
		end

	translated_singular_string (i: INTEGER): STRING_32
			-- Singular translation of `i'-th entry.
		local
			red: INTEGER
			l_list: LIST [STRING_32]
		do
			get_translated_entries (i)
			l_list := last_translated.list
			red := plural_tools.get_reduction_agent (plural_form).item ([1])
			check l_list.valid_index (red + 1) end -- Implied from postcondition of `get_translated_entries'
			Result := l_list.i_th (red+1)
		end

	translated_plural_strings (i: INTEGER): ARRAY [STRING_32]
			-- Plural translations of `i'-th entry.
		local
			counter: INTEGER
			l_list: LIST [STRING_32]
		do
			get_translated_entries (i)
			l_list := last_translated.list
			create Result.make_filled ({STRING_32} "", 0, 3)
			from
				l_list.start
				counter := 0
			until
				l_list.after
				or
				counter > 3
			loop
				Result.put (l_list.item, counter)
				counter := counter + 1
				l_list.forth
			end
		end

	locale: detachable STRING_32
			-- Best guess at locale of the file. This could also be a language.
		local
			l_name: READABLE_STRING_GENERAL
		do
				-- The only inherent locale identifier in a .mo file is the name.
				-- Any other way to identify it is project dependent, see FILE_MANAGER for more details
			if attached file.path.entry as l_entry and then l_entry.has_extension ("mo") then
				l_name := l_entry.name
				if
					l_name.count = 5 or
					(l_name.count = 8 and (l_name.item (3) = '_' or l_name.item (3) = '-'))
				then
					create Result.make_from_string_general (l_name)
					Result.remove_tail (3)
				end
			end
		end

feature --Entries

	last_original: TUPLE [i: INTEGER; list: LIST [STRING_32]]
	last_translated: TUPLE [i: INTEGER; list: LIST [STRING_32]]

	get_original_entries (i_th: INTEGER)
			-- Get `i_th' original entry in the file.
		do
			if last_original.i /= i_th then
				last_original.i := i_th
				last_original.list := extract_string(original_table_offset, i_th).split('%U')
			end
		end

	get_translated_entries (i_th: INTEGER)
			-- What's the `i-th' translated entry?
		do
			if last_translated.i /= i_th then
				last_translated.i := i_th
				last_translated.list := extract_string(translated_table_offset, i_th).split('%U')
			end
		end

feature -- Status

	valid: BOOLEAN
			-- Is the file a valid .mo file? This is a silly check.
		do
			Result := is_little_endian_file xor is_big_endian_file
		end

feature {NONE} -- Implementation

	read_magic_number
			-- Read the magic number and set big/little endianness of machine and file.
			-- This will, hopefully, make `valid` true.
		require
			file_opened: file.is_open_read
		local
			l_magic_number: INTEGER
			t_magic_number: ARRAY[NATURAL_8]
		do
			is_big_endian_file := False
			is_little_endian_file := False
			-- Read magic number.
			file.go (0)
			file.read_integer
			l_magic_number := file.last_integer
			file.go(0)
			-- Read magic number byte-by-byte.
			t_magic_number := get_integer
			if t_magic_number.is_equal ({ARRAY [NATURAL_8]} <<0xde, 0x12, 0x04, 0x95>>) then
				is_little_endian_file := True
				if l_magic_number = 0xde120495 then
					is_big_endian_machine := True
				elseif l_magic_number = 0x950412de then
					is_little_endian_machine := True
				end
			elseif t_magic_number.is_equal ({ARRAY [NATURAL_8]} <<0x95, 0x04, 0x12, 0xde>>) then
				is_big_endian_file := True
				if l_magic_number = 0xde120495 then
					is_little_endian_machine := True
				elseif l_magic_number = 0x950412de then
					is_big_endian_machine := True
				end
			end
		end

	read_plural_form
			-- Read the Plural-Form header.
		require
			correct_file: file.is_open_read and valid
		local
			t_list : LIST [STRING_32]
			t_string : detachable STRING_32
			index : INTEGER
			code0: NATURAL_32
			conditional: STRING_32
			nplurals: INTEGER_32
		do
			code0 := ('0').natural_32_code
				-- Get the first translated string of the first entry in the .mo file - this is the headers entry (the empty string)
			get_translated_entries (1)
			t_list := last_translated.list.i_th(1).split('%N')
			 	-- Search the headers
			from
				t_list.start
			until
				t_string /= Void or t_list.after
			loop
				if t_list.item.has_substring ("Plural-Forms") then
					t_string := t_list.item
				end
				t_list.forth
			end
				-- Process the Plural-Forms header. For now we do a string comparison.
				-- Doing it properly would mean parsing the C-conditional so that it can be evaluated by reduce in I8N_PLURAL_TOOLS
			if t_string /= Void then
					-- There is a Plural-Forms header. This should have the form: 	
					-- Plural-Forms: nplurals=x; plural=y;
					-- x being a number, y a C conditional.
					-- The following code is not very nice.
				index := t_string.index_of (';', 1)
				if index > 1 and t_string.has_substring ("nplurals=") then
					check greater: t_string.code (index - 1) >= code0 end
					nplurals := (t_string.code(index-1) - code0).to_integer_32
						-- ?????? Does this find out the integer value of the represented character???
					index := t_string.index_of ('=', index)+1
				    conditional := t_string.substring (index, t_string.count)
				    plural_form := plural_tools.mo_header_to_plural_form (nplurals, conditional)
				end
			end
			if t_string = Void or plural_form = plural_tools.unknown_plural_form then
					-- No informations found or invalid information found
					-- set to default values (Germanic languages, coincidentally what English uses)
				plural_form := plural_tools.two_plural_forms_singular_one
			end
		end

feature {NONE} -- Implementation (helpers)

	extract_string (a_offset, a_number: INTEGER): STRING_32
			-- Which is the a_number-th string into the table at a_offset?
		require
			correct_file: file.is_open_read and then valid
			valid_offset: (a_offset = translated_table_offset) or (a_offset = original_table_offset)
			valid_index: valid_index(a_number) -- defined in the abstract datasource
		local
			string_length,
			string_offset: INTEGER
		do
			file.go(a_offset + (a_number - 1) * 8)
			string_length := read_integer
			string_offset := read_integer
			file.go (string_offset)
			Result := utf8_rw.file_read_string_32_with_length (file, string_length)
		ensure
			result_exists : Result /= Void
		end

	read_integer: INTEGER
			-- Read an integer from the current
			-- position in the mo file, taking care of the endianness of the file.
		require
			file_open: file.is_open_read
		do
			if is_little_endian_file = is_little_endian_machine then
				Result := read_integer_same_endianness
			else
				Result := read_integer_opposite_endianness
			end
		end

	read_integer_same_endianness: INTEGER
			-- Reading an integer on the same architecture where the MO file was created.
		require
			file_open: file.is_open_read
		do
			file.read_integer
			Result := file.last_integer
		end

	read_integer_opposite_endianness: INTEGER
			-- Reading an integer on the opposite architecture of which where the MO file was created.
		require
			file_open: file.is_open_read
		local
			b0, b1, b2, b3 : NATURAL_32
			t_array : ARRAY[NATURAL_8]
		do
			t_array := get_integer
			b0 := t_array.item(1).as_natural_32
			b1 := t_array.item(2).as_natural_32
			b2 := t_array.item(3).as_natural_32
			b3 := t_array.item(4).as_natural_32
			if is_little_endian_file then
				Result := (b0 | (b1 |<< 8) | (b2 |<< 16) | (b3 |<< 24)).as_integer_32
			else
				Result := (b3 | (b2 |<< 8) | (b1 |<< 16) | (b0 |<< 24)).as_integer_32
			end
		end

	get_integer: ARRAY[NATURAL_8]
			-- Read an integer byte to byte
			-- and put them a tuple in the
			-- order they where encountered
			-- it moves the cursor of the file.
		local
			b0, b1, b2, b3 : NATURAL_8
		do
			file.read_natural_8
			b0 := file.last_natural_8
			file.read_natural_8
			b1 := file.last_natural_8
			file.read_natural_8
			b2 := file.last_natural_8
			file.read_natural_8
			b3 := file.last_natural_8
			Result := << b0, b1, b2, b3 >>
		end

feature {NONE} -- Implementation (parameters)

	is_big_endian_file,	is_little_endian_file: BOOLEAN
		-- File endianness.

	is_big_endian_machine, is_little_endian_machine: BOOLEAN
		-- Machine endianness.

	version: INTEGER
		-- Version of the mo file.

	original_table_offset: INTEGER
		-- Offset of the table containing the original strings.

	translated_table_offset: INTEGER
		-- Offset of the table containing the translated strings.

	hash_table_size: INTEGER
		-- Size of the hash table.

	hash_table_offset: INTEGER
		-- Offset of the hash table.

invariant
	last_translated /= Void
	last_original /= Void
	last_translated.i > 0 implies last_translated.list /= Void
	last_original.i > 0 implies last_original.list /= Void

note
	library:  "Internationalization library"
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
