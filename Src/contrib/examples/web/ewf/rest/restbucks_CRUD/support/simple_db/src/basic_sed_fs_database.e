note
	description: "[
			Basic database for simple example using SED files.

			(no concurrency access control, ...)
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_SED_FS_DATABASE

inherit
	BASIC_FS_DATABASE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_location: PATH)
		do
			Precursor (a_location)
			create serialization
		end

feature -- Access

	serialization: SED_STORABLE_FACILITIES

feature {NONE} -- Access	

	default_extension: STRING_32 = "sed"
			-- Default file extension, if any.	

feature {NONE} -- Implementation

	item_from_location (a_entry_type: TYPE [detachable ANY]; p: PATH): like item
		local
			f: RAW_FILE
			l_reader: SED_MEDIUM_READER_WRITER
			s: STRING
		do
			create f.make_with_path (p)
			if f.exists then
				create s.make (f.count)
				f.open_read
				create l_reader.make_for_reading (f)
				Result := serialization.retrieved (l_reader, True)
				f.close
			end
		end

	save_item_to_location (a_entry: detachable ANY; p: PATH)
		local
			f: RAW_FILE
			l_writer: SED_MEDIUM_READER_WRITER
		do
			create f.make_with_path (p)
			f.open_write
			if a_entry /= Void then
				create l_writer.make_for_writing (f)
				serialization.store (a_entry, l_writer)
			end
			f.close
		end

note
	copyright: "2011-2017, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
