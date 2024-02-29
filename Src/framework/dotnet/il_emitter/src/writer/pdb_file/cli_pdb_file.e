note
	description: "In memory representation of a Pdb file for CLI."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_PDB_FILE

inherit

	REFACTORING_HELPER
		export {NONE} all end

	MD_UTILITIES
		export
			{NONE} padding, file_alignment
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like file_name; e: like emitter)
			-- Create new pdb file with name `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			emitter_attached: attached e

		local
			l_characteristics: INTEGER_16
		do
			is_debug_enabled := True
			is_valid := True
			file_name := a_name
			emitter := e

		ensure
			file_name_set: file_name = a_name
			is_valid_set: is_valid
		end

feature -- Status

	is_valid: BOOLEAN
			-- Is Current PE file still valid, i.e. not yet saved to disk?


	file_name: IMMUTABLE_STRING_32
			-- Name of current Pdb file on disk.

	has_strong_name: BOOLEAN
			-- Does current have a strong name signature?


	is_debug_enabled: BOOLEAN
		-- is debug output enabled?
		--| pdb generation.	

feature -- Access


	cli_header_has_flag_strong_name_signed: BOOLEAN
			-- Has CLI Header flag "strong_name_signed" ?
		do
			to_implement ("Not yet implemented")
		end


	internal_debug_directory: detachable CLI_DEBUG_DIRECTORY_I

feature -- Access


	emitter: MD_EMIT
			-- Meta data emitter, needed for RVA update.


feature -- Saving

	save
		local
			l_pdb_file, l_meta_data_file: RAW_FILE
			l_padding: MANAGED_POINTER
			l_strong_name_location: INTEGER
			l_size: INTEGER
			l_uni_string: CLI_STRING
			l_meta_data_file_name: like file_name
		do
			debug ("il_emitter")
				print ({STRING_32} "%N>> " + generator + ".save -> " + file_name + "%N")
			end

				-- First update all uninitialized PE_LIST (FieldList, MethodList, ParamList, ...)
			prepare

				-- First compute size of PE file headers and sections.
			compute_sizes

				-- Write to file now.
			create l_pdb_file.make_with_name (file_name)
			l_pdb_file.open_write

				-- First the headers
			-- l_pe_file.put_managed_pointer (dos_header, 0, dos_header.count)


			if emitter.appending_to_file_supported then
					-- Update the pdb metadata tables.
				emitter.update_pdb_stream
				emitter.append_to_pdb_file (l_pdb_file)
			else
				-- Save the metadata to `l_pe_file'. We cannot use `MD_EMIT.assembly_memory'
				-- because on some platforms the amount of required memory cannot be allocated
				-- in one chunk.
				-- Instead we save it to disk and then copy it over. This is not efficient
				-- but we cannot use the stream version of the API since we do not have a way
				-- to make an IStream from an Eiffel FILE.
				l_meta_data_file_name := file_name + ".pe"
				emitter.save (create {CLI_STRING}.make (l_meta_data_file_name))
				create l_meta_data_file.make_with_name (l_meta_data_file_name)
				l_meta_data_file.open_read
				check valid_size: l_meta_data_file.count = meta_data_size end
				l_meta_data_file.copy_to (l_pdb_file)
				l_meta_data_file.close
				safe_delete (l_meta_data_file)
			end
			debug ("il_emitter")
				print ({STRING_32} "PDB file saving: " + {MD_DBG_CHRONO}.report ("pdb_file") + "%N")
			end

			l_pdb_file.close
			is_valid := False

			if
				has_strong_name
			then
				create l_pdb_file.make_with_name (file_name)
				l_pdb_file.open_read
				create l_padding.make (l_pdb_file.count)
				l_pdb_file.read_to_managed_pointer (l_padding, 0, l_padding.count)
				l_pdb_file.close

				create l_uni_string.make (file_name)

				create l_pdb_file.make_with_name (file_name)
				l_pdb_file.open_write
				l_pdb_file.put_managed_pointer (l_padding, 0, l_padding.count)
				l_pdb_file.close
			end
		end

	safe_delete (f: FILE)
		local
			nb: INTEGER
		do
			if nb = 0 then
				f.delete
			elseif nb = 1 then
				{EXECUTION_ENVIRONMENT}.sleep (5_000) -- 5 ms
				f.delete
			else
				-- Keep the file ...
			end
		rescue
			nb := nb + 1
			retry
		end

	update_pdb_stream_pdb_id (a_pdb_id: ARRAY [NATURAL_8])
		require
			a_pdb_id.count = 20
		local
			f: RAW_FILE
			fpos: INTEGER
			mp: MANAGED_POINTER
		do
			if attached emitter.pdb_writer.pdb_stream as l_pdb_stream then
				l_pdb_stream.set_pdb_id (a_pdb_id)
				fpos := l_pdb_stream.recorded_binary_position
				if fpos > 0 then
					create f.make_with_name (file_name)
					if f.exists then
						f.open_read_write
						f.go (fpos)
						mp := l_pdb_stream.item.managed_pointer
						f.put_managed_pointer (mp, 0, l_pdb_stream.size_of)
						f.close
					end
				end
			end
		end

feature {NONE} -- Saving

	prepare
			-- Prepare emitter data before save.
		do
			emitter.prepare_pdb_to_save (file_name)
		end

	compute_sizes
			-- Compute sizes and basic locations of headers and sections,
			-- both real, on disk and in memory.
		do
				-- Size of meta data and code.
			meta_data_size := emitter.save_pdb_size
		end


feature {NONE} -- Implementation

	dos_header: MANAGED_POINTER
			-- MS-DOS header
			--| Defined in section II.25.2.1 MS-DOS header
		once
			create Result.make_from_array ({ARRAY [NATURAL_8]} <<
						0x4d, 0x5a, 0x90, 0x00, 0x03, 0x00, 0x00, 0x00,
						0x04, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00,
						0xb8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
						0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00,
							-- in previous line, the value 0x80:
							-- 		At offset 0x3c in the DOS header is a 4-byte unsigned integer offset,
							--		lfanew, to the PE signature (shall be "PE\0\0")

						0x0e, 0x1f, 0xba, 0x0e, 0x00, 0xb4, 0x09, 0xcd,
						0x21, 0xb8, 0x01, 0x4c, 0xcd, 0x21, 0x54, 0x68,
						0x69, 0x73, 0x20, 0x70, 0x72, 0x6f, 0x67, 0x72,
						0x61, 0x6d, 0x20, 0x63, 0x61, 0x6e, 0x6e, 0x6f,
						0x74, 0x20, 0x62, 0x65, 0x20, 0x72, 0x75, 0x6e,
						0x20, 0x69, 0x6e, 0x20, 0x44, 0x4f, 0x53, 0x20,
						0x6d, 0x6f, 0x64, 0x65, 0x2e, 0x0d, 0x0d, 0x0a,
						0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
							-- Then the PE signature: 4 bytes that shall be "PE\0\0"
						0x50, 0x45, 0x00, 0x00
					>>
				)
		ensure
			valid_size: dos_header.count = 132 -- 132 = 128 + 4
		end

	headers_size, text_size, reloc_size: INTEGER
	headers_size_on_disk, text_size_on_disk, reloc_size_on_disk: INTEGER
	text_rva, code_rva, reloc_rva: INTEGER
			-- Size information about current PE.

	debug_size, strong_name_size, meta_data_size, code_size: INTEGER
	resources_size: INTEGER

	import_table_padding: INTEGER
			-- Padding added before `import_table' so that it is aligned on 16 bytes boundaries.

	import_directory_rva: INTEGER
			-- RVA of import table.

invariant
	file_name_not_void: is_valid implies file_name /= Void
	file_name_not_empty: is_valid implies not file_name.is_empty
	dos_header_not_void: is_valid implies dos_header /= Void

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
