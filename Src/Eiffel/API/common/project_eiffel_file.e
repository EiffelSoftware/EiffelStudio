indexing
	description:
		"project.eif or precompile.eif file for an eiffel project."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class PROJECT_EIFFEL_FILE

inherit
	EXCEPTIONS

	UNIX_SIGNALS
		rename
			meaning as sig_meanging,
			ignore as sig_ignore,
			catch as sig_catch
		end

	SYSTEM_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_file_name: STRING) is
			-- Project file whose location is `a_file_name'.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		do
			error_value := ok_value
			name := a_file_name
			create storage.make (a_file_name)
		ensure
			name_set: name = a_file_name
		end;

feature -- Access

	name: STRING
			-- Name of file for `storage'.

	precompilation_id: INTEGER;
			-- Precompilation id when checking for precompilation validity

	project_version_number: STRING;
			-- Version number of project eiffel file

feature -- Store/Retrieval

	retrieved_project: E_PROJECT is
			-- Retrieve project
			-- (Note: error cannot be invalid_precompilation)
		do
			Result ?= retrieved_object
		ensure
			valid_result: not has_error implies Result /= Void
			version_number_exists: project_version_number /= Void
		end;

	retrieved_precompile: PRECOMP_INFO is
			-- Retrieve the precompile info of project
			-- (Note: error cannot be invalid_precompilation)
		do
			Result ?= retrieved_object
		ensure
			valid_result: not has_error implies Result /= Void
		end;

	store (a_project: ANY; a_version: STRING; a_precompilation_id: INTEGER) is
			-- Store `a_project' for version `a_version' and `a_precompilation_id'.
		require
			a_project_not_void: a_project /= Void
			a_version_not_void: a_version /= Void
		local
			l_writer: SED_MEDIUM_READER_WRITER
			l_serializer: SED_INDEPENDENT_SERIALIZER
			retried: BOOLEAN
		do
			if not retried then
				storage.open_write
				storage.put_string (storage_validity_string)

				create l_writer.make (storage)
				create l_serializer.make (l_writer)
				l_serializer.set_is_for_fast_retrieval (True)
				l_writer.write_header
				l_writer.write_string_8 (a_version)
				l_writer.write_integer_32 (a_precompilation_id)

				if is_c_storable then
					l_writer.write_footer
						--| To store correctly the information after the project
						--| header, we need to set the position, otherwise the
						--| result is quite strange and won't be retrievable
					storage.flush
					storage.go (storage.count)

					compiler_store (storage.descriptor, $a_project)
				else
					l_serializer.set_root_object (a_project)
					l_serializer.encode
					l_writer.write_footer
				end

				storage.close
			else
				if not storage.is_closed then
					storage.close
				end
				error_value := cannot_store_value
			end
		rescue
			retried := True
			retry
		end

feature -- Status report

	is_interrupted: BOOLEAN is
			-- Was the retrieve of the project interrupted?
		do
			Result := error_value = interrupt_value
		end

	is_invalid_precompilation: BOOLEAN is
			-- Is the precompilation invalid?
		do
			Result := error_value = invalid_precompilation_value
		end

	is_corrupted: BOOLEAN is
			-- Is the project corrupted?
		do
			Result := error_value = corrupt_value
		end

	is_incompatible: BOOLEAN is
			-- Is the project incompatible with the current version ?
		do
			Result := error_value = incompatible_value
		end;

	is_valid: BOOLEAN is
			-- Is current a valid project file?
		do
			Result := storage.is_readable and then storage.is_plain
		end

	error, has_error: BOOLEAN is
			-- Did an error occurred during the retrieval?
		do
			Result := error_value /= ok_value
		end;

	exists: BOOLEAN is
			-- Does `storage' exist?
		do
			Result := storage.exists
		end

	is_readable: BOOLEAN is
			-- Is `storage' file readable?
		do
			Result := storage.is_readable
		end

	is_writable: BOOLEAN is
			-- Is `storage' file writable?
		do
			Result := storage.is_writable
		end

feature -- Update

	check_version_number (precomp_id: INTEGER) is
			-- Check the version number of the project.txt file.
			-- If `precomp_id' is 0 then do not check precompilation_id.
			-- If error ok set the error state.
		local
			l_reader: SED_MEDIUM_READER_WRITER
		do
			error_value := ok_value
			create l_reader.make (storage)
			l_reader.set_for_reading
			storage.open_read
			check_storage
			if not has_error then
				read_project_header (l_reader)
				if not has_error then
					if not project_version_number.is_equal (version_number) then
						error_value := incompatible_value;
					elseif precomp_id /= 0 and then precomp_id /= precompilation_id then
						error_value := invalid_precompilation_value;
					end
				end
			else
					-- To satisfy postcondition.
				create project_version_number.make_empty
			end
			storage.close
		ensure
			error_means_incompatible: has_error implies (is_incompatible or is_corrupted)
			valid_version_number: project_version_number /= Void
		end;

feature {NONE} -- Implementation

	storage: RAW_FILE
			-- Storage for project file.

	error_value: INTEGER
			-- Error value

	ok_value,
	corrupt_value,
	invalid_precompilation_value,
	incompatible_value,
	interrupt_value,
	cannot_store_value: INTEGER is unique
			-- Error values

	retrieved_object: ANY is
			-- Retrieve project
		local
			retried: BOOLEAN
			l_reader: SED_MEDIUM_READER_WRITER
			l_deserializer: SED_INDEPENDENT_DESERIALIZER
		do
			if not retried then
				check_version_number (0)

				if not has_error then
					storage.open_read
					check_storage

					if not has_error then
						create l_reader.make (storage)
						l_reader.set_for_reading
						create l_deserializer.make (l_reader)
						read_project_header (l_reader)
						if not has_error then
							if is_c_storable then
								l_reader.read_footer
								Result := retrieved_using_old_storable
							else
								l_deserializer.decode (False)
								if not l_deserializer.has_error then
									Result := l_deserializer.last_decoded_object
									l_reader.read_footer
								else
									error_value := corrupt_value
								end
							end
						end
					end
						-- Close the Eiffel Project file.
					storage.close
				end
			else
				if not storage.is_closed then
					storage.close
				end
			end
		ensure
			valid_result: not has_error implies Result /= Void
		rescue
			if is_signal and then signal = Sigint then
				error_value := interrupt_value
			else
				error_value := corrupt_value
			end
			retried := True
			retry
		end

	retrieved_using_old_storable: ANY is
			-- Read project file using the C storable.
		require
			is_c_storable: is_c_storable
		local
			l_pos: INTEGER
			retried, l_is_collecting: BOOLEAN
			l_mem: MEMORY
		do
			if not retried then
				l_pos := storage.position
				create l_mem
				l_is_collecting := l_mem.collecting
				l_mem.full_collect
				l_mem.full_coalesce
				l_mem.collection_off
				Result := ise_compiler_retrieved (storage.descriptor, storage.position);
				l_mem.collection_on
				l_mem.full_collect
				l_mem.full_coalesce
				if Result = Void then
					error_value := corrupt_value
				end
			else
				if l_is_collecting then
					l_mem.collection_on
				end
				error_value := corrupt_value
			end
		rescue
			retried := True
			retry
		end

	read_project_header (a_reader: SED_MEDIUM_READER_WRITER) is
			-- Read project file to get version info.
		require
			a_reader_not_void: a_reader /= Void
			a_reader_ready_for_reading: a_reader.is_ready_for_reading
			no_error: not has_error
		local
			retried: BOOLEAN
		do
			if not retried then
				a_reader.read_header
				project_version_number := a_reader.read_string_8
				precompilation_id := a_reader.read_integer_32
			else
				error_value := corrupt_value
			end
		rescue
			retried := True
			retry
		end

	check_storage is
			-- Check validity of Storage.
		require
			storage_open: storage.is_open_read
		do
			storage.read_stream (storage_validity_string.count)
			if not storage.last_string.is_equal (storage_validity_string) then
				error_value := corrupt_value
			end
		end

	storage_validity_string: STRING is "EiffelStudio_Project"
			-- String to validate that an epr is somewhat valid.

feature {NONE} -- C externals

	is_c_storable: BOOLEAN is True
			-- We still default to C storage format because it is faster
			-- to store.

	ise_compiler_retrieved (f_desc, pos: INTEGER) : ANY is
		external
			"C | %"pretrieve.h%""
		alias
			"parsing_retrieve"
		end

	compiler_store (f_desc: INTEGER; obj: POINTER) is
		external
			"C | %"pstore.h%""
		alias
			"parsing_store"
		end

invariant
	name_not_void: name /= Void
	storage_not_void: storage /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class PROJECT_EIFFEL_FILE
