indexing
	description: "Handle user files."
	date: "$Date$"
	revision: "$Revision$"

class
	USER_OPTIONS_FACTORY

inherit
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
		do
			if not retried then
				create last_file_name.make_from_string (eiffel_layout.eiffel_home)
				last_file_name.extend (a_options.uuid.out)
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

	load (a_uuid: UUID) is
			-- Retrieve content of user data associated with `a_uuid' into `last_options'.
			-- If no such file is found, then `last_options' is set to Void.
		require
			a_uuid_not_void: a_uuid /= Void
		local
			l_file: RAW_FILE
			l_sed_rw: SED_MEDIUM_READER_WRITER
			l_sed_facilities: SED_STORABLE_FACILITIES
			retried: BOOLEAN
		do
			if not retried then
				last_options := Void
				create last_file_name.make_from_string (eiffel_layout.eiffel_home)
				last_file_name.extend (a_uuid.out)
					-- Even if we could not create `eiffel_home', we simply handle
					-- it as if they were not user file. This is why `successful' is
					-- set to `True' in all cases.
				successful := True
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

end
