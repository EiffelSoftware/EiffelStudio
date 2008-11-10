indexing
	description: "Serialize and deserialize multiple objects into one file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_MULTI_OBJECT_SERIALIZATION

inherit
	ANY

	SED_STORABLE_FACILITIES
		export
			{NONE} all
		end

feature -- Access

	deserialized_object: ?ANY
			-- Last deserialized object

	last_file_position: INTEGER
			-- Position after last serialization

	error_message: ?STRING
			-- Reason for failure

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
			l_raw_file: ?RAW_FILE
			l_reader: SED_MEDIUM_READER_WRITER
		do
			if not retried then
				create l_raw_file.make_open_read (path)
				l_raw_file.go (a_pos)
				create l_reader.make (l_raw_file)
				l_reader.set_for_reading
				deserialized_object := retrieved (l_reader, True)
				successful := deserialized_object /= Void
			else
				successful := False
			end
			if l_raw_file /= Void and then not l_raw_file.is_closed then
				l_raw_file.close
			end
		ensure
			deserialized_object_set_if_no_error: successful implies deserialized_object /= Void
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			retried := True
			retry
		end

feature -- Basic Operations

	serialize (a: ANY; path: STRING; is_appending: BOOLEAN) is
			-- Serialize object `a' at the end of file `path' if `is_appending', otherwise
			-- reset content of `path'.
			-- Set `last_file_position' after storing.
		require
			non_void_object: a /= Void
			non_void_path: path /= Void
		local
			l_raw_file: ?RAW_FILE
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
				last_file_position := l_raw_file.count
				successful := True
			else
				successful := False
				error_message := "Cannot store into " + path
			end
			if l_raw_file /= Void and then not l_raw_file.is_closed then
				l_raw_file.close
			end
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			retried := True
			retry
		end

feature {NONE} -- Logging

	log_last_exception is
			-- Log last exception.
		do
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
