indexing
	description: "Store objects."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SERIALIZER

inherit
	ANY

	SED_STORABLE_FACILITIES
		export
			{NONE} all
		end

feature -- Status report

	successful: BOOLEAN
			-- Was last operation successful?

	error_message: STRING
			-- Reason for failure
			
	last_file_position: INTEGER
			-- Position after last serialization

feature -- Basic Operations

	serialize (a: ANY; path: STRING; is_appending: BOOLEAN) is
			-- Serialize object `a' at the end of file `path' if `is_appending', otherwise
			-- reset content of `path'.
			-- Set `last_file_position' after storing.
		require
			non_void_object: a /= Void
			non_void_path: path /= Void
		local
			l_raw_file: RAW_FILE
			l_writer: SED_MEDIUM_READER_WRITER
			retried: BOOLEAN
		do
			if not retried then
				if is_appending then
					create l_raw_file.make_open_append (path)
				else
					create l_raw_file.make_open_write (path)
				end
				create l_writer.make (l_raw_file)
				l_writer.set_for_writing
				independent_store (a, l_writer, False)
				l_raw_file.close
				last_file_position := l_raw_file.count
				successful := True
			else
				successful := False
				error_message := "Cannot store into " + path
			end
		rescue
			retried := True
			retry
		end

end
