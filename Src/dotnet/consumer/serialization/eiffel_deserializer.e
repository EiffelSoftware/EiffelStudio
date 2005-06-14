indexing
	description: "Retrieve objects"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DESERIALIZER

inherit
	ANY

	SED_STORABLE_FACILITIES
		export
			{NONE} all
		end

feature -- Access

	deserialized_object: ANY
			-- Last deserialized object

feature -- Status report

	successful: BOOLEAN
			-- Was last retrieval successful?

feature -- Basic Operations

	deserialize (path: STRING; a_pos: INTEGER) is
			-- Deserialize object previously serialized in `path' at position `a_pos'.
		require
			non_void_path: path /= Void
			valid_path: (create {RAW_FILE}.make (path)).exists
		local
			retried: BOOLEAN
			l_raw_file: RAW_FILE
			l_reader: SED_MEDIUM_READER_WRITER
		do
			if not retried then
				create l_raw_file.make_open_read (path)
				l_raw_file.go (a_pos)
				create l_reader.make (l_raw_file)
				l_reader.set_for_reading
				deserialized_object := retrieved (l_reader, True)
				successful := deserialized_object /= Void
				l_raw_file.close
			else
				successful := False
			end
		ensure
			deserialized_object_set_if_no_error: successful implies deserialized_object /= Void
		rescue
			retried := True
			retry
		end

end
