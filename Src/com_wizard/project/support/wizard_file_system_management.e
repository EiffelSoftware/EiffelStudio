indexing
	description: "File system management (file copy, deletion)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FILE_SYSTEM_MANAGEMENT

feature -- Basic Operations

	file_copy (a_source, a_destination: STRING) is
			-- Copy file `a_source' into `a_destination'.
			-- Does nothing if `a_source' is not a file.
		require
			non_void_source: a_source /= Void
			non_void_destination: a_destination /= Void
			valid_source: not a_source.is_empty
			valid_destination: not a_destination.is_empty
		local
			a_file_source, a_file_dest: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create a_file_source.make (a_source)
				if a_file_source.exists then
					a_file_source.open_read
					a_file_source.read_stream (a_file_source.count)
					create a_file_dest.make_open_write  (a_destination)
					a_file_dest.put_string (a_file_source.last_string)
					a_file_source.close
					a_file_dest.close
				end
			end
		rescue
			retried := True
			retry
		end

	file_delete (a_file_name: STRING) is
			-- Delete file `a_file_name'.
			-- Do nothing if `a_file_name' not a valid file name.
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		local
			a_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create a_file.make (a_file_name)
				if a_file.exists then
					a_file.delete
				end
			end
		rescue
			retried := True
			retry
		end

end -- class WIZARD_FILE_SYSTEM_MANAGEMENT

