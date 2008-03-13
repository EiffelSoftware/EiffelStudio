indexing
	description: "Handle user files."
	date: "$Date$"
	revision: "$Revision$"

class
	USER_OPTIONS_FACTORY

inherit
	ANY

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature -- Access

	successful: BOOLEAN
			-- Is last store/retrieve operation successful?

	last_options: USER_OPTIONS
			-- Last retrieved options.

	last_file_name: FILE_NAME
			-- Last file name for last store/load operation.

feature -- Query

	mapped_uuid (a_file_path: STRING): ?UUID
			-- Retrieves a mapped UUID for a given file path
		require
			a_file_path_attached: a_file_path /= Void
			not_a_file_path_is_empty: not a_file_path.is_empty
		local
			l_uuid: STRING
		do
			l_uuid := mapping.item (a_file_path)
			if l_uuid /= Void and then not l_uuid.is_empty then
				create Result.make_from_string (l_uuid)
			end
		ensure
			result_not_default: Result /= Void implies not Result.is_equal (create {UUID}.make (0, 0, 0, 0, 0))
		end

feature -- Store/Retrieve

	store (a_options: USER_OPTIONS) is
			-- Store user options to disk.
			-- `successful' is True if there is no error.
		require
			a_options_set: a_options /= Void
		local
			l_file: RAW_FILE
			l_sed_rw: SED_MEDIUM_READER_WRITER
			l_sed_facilities: SED_STORABLE_FACILITIES
			retried: BOOLEAN
			l_mapping: like mapping
			l_uuid_str: STRING
		do
			if not retried then
				create last_file_name.make_from_string (eiffel_layout.user_project_settings_path)
					-- Find associated file mapping, otherwise create a new one.
					-- The mapped name is always a UUID.
				l_mapping := mapping
				l_mapping.search (a_options.project_file_path)
				if l_mapping.found then
					l_uuid_str := l_mapping.found_item
				else
					l_uuid_str := (create {UUID_GENERATOR}).generate_uuid.out
					l_mapping.put (l_uuid_str, a_options.project_file_path)
					store_mapping (l_mapping)
				end
				last_file_name.extend (l_uuid_str)
				if eiffel_layout.is_valid_home then
					create l_file.make (last_file_name)
					l_file.open_write
					if l_file.is_writable then
						create l_sed_rw.make (l_file)
						l_sed_rw.set_for_writing
						create l_sed_facilities
						l_sed_facilities.independent_store (a_options, l_sed_rw, True)
						l_file.close
						successful := True
					else
						successful := False
					end
				end
			else
				successful := False
			end
		rescue
			retried := True
			retry
		end

	load (a_file_path: STRING) is
			-- Retrieve content of user data associated with `a_file_path' into `last_options'.
			-- If no such file is found, then `last_options' is set to Void.
		require
			a_file_path_not_void: a_file_path /= Void
		local
			l_file: RAW_FILE
			l_sed_rw: SED_MEDIUM_READER_WRITER
			l_sed_facilities: SED_STORABLE_FACILITIES
			retried: BOOLEAN
			l_mapping: like mapping
		do
			if not retried then
				last_options := Void
				create last_file_name.make_from_string (eiffel_layout.user_project_settings_path)
					-- Even if we could not create `eiffel_home', or find the user option
					-- file, we simply handle it as if they were not user file.
					-- This is why `successful' is set to `True' in all cases.
				successful := True
				l_mapping := mapping
				l_mapping.search (a_file_path)
				if l_mapping.found then
					last_file_name.extend (l_mapping.found_item)
						-- if file exists, load it
					create l_file.make (last_file_name)
					if l_file.exists and then l_file.is_readable then
						l_file.open_read
						create l_sed_rw.make (l_file)
						l_sed_rw.set_for_reading
						create l_sed_facilities
						last_options ?= l_sed_facilities.retrieved (l_sed_rw, True)
						l_file.close
					end
				end
			else
				successful := False
			end
		rescue
			retried := True
			retry
		end

	remove (a_options: USER_OPTIONS; a_target: STRING) is
			-- Remove from `a_options' options related to `a_target'.
		require
			a_options_not_void: a_options /= Void
		do
			a_options.targets.remove (a_target)
			store (a_options)
		end

feature {NONE} -- Implementation

	mapping: HASH_TABLE [STRING, STRING] is
			-- Mapping between path to a config file and its associated user option file.
		local
			l_file: RAW_FILE
			l_sed_rw: SED_MEDIUM_READER_WRITER
			l_sed_facilities: SED_STORABLE_FACILITIES
			retried: BOOLEAN
			l_file_name: FILE_NAME
		do
			if not retried then
				create l_file_name.make_from_string (eiffel_layout.user_project_settings_path)
				l_file_name.extend (mapping_file_name)
					-- Even if we could not create `eiffel_home', we simply handle
					-- it as if they were not mapping file.
					-- if file exists, load it
				create l_file.make (l_file_name)
				if l_file.exists and then l_file.is_readable then
					l_file.open_read
					create l_sed_rw.make (l_file)
					l_sed_rw.set_for_reading
					create l_sed_facilities
					Result ?= l_sed_facilities.retrieved (l_sed_rw, True)
					l_file.close
				end
			end
			if Result = Void then
				create Result.make (0)
			end
		ensure
			mapping_not_void: Result /= Void
		rescue
			retried := True
			retry
		end

	store_mapping (a_mapping: like mapping) is
			-- Store mapping to disk.
		require
			a_mapping_not_void: a_mapping /= Void
		local
			l_file: RAW_FILE
			l_sed_rw: SED_MEDIUM_READER_WRITER
			l_sed_facilities: SED_STORABLE_FACILITIES
			retried: BOOLEAN
			l_file_name: FILE_NAME
		do
			if not retried then
				create l_file_name.make_from_string (eiffel_layout.user_project_settings_path)
				l_file_name.extend (mapping_file_name)
				if eiffel_layout.is_valid_home then
					create l_file.make (l_file_name)
					l_file.open_write
					if l_file.is_writable then
						create l_sed_rw.make (l_file)
						l_sed_rw.set_for_writing
						create l_sed_facilities
						l_sed_facilities.independent_store (a_mapping, l_sed_rw, True)
						l_file.close
						successful := True
					else
						successful := False
					end
				end
			else
				successful := False
			end
		rescue
			retried := True
			retry
		end

	mapping_file_name: !STRING = "mapping.info"
			-- Name of file where `mapping' is stored.

end
