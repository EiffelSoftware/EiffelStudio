note
	description: "[
			Basic database for simple example using JSON files.

			(no concurrency access control, ...)
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_JSON_FS_DATABASE

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

feature -- Access serialization

	serialization: JSON_SERIALIZATION

feature {NONE} -- Access	

	default_extension: STRING_32 = "json"
			-- Default file extension, if any.

feature {NONE} -- Implementation

	item_from_location (a_entry_type: TYPE [detachable ANY]; p: PATH): like item
		local
			f: RAW_FILE
			s: STRING
		do
			create f.make_with_path (p)
			if f.exists then
				create s.make (f.count)
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream (1_024)
					s.append (f.last_string)
				end
				f.close
				Result := serialization.from_json_string (s, a_entry_type)
			end
		end

	save_item_to_location (a_entry: detachable ANY; p: PATH)
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			f.open_write
			f.put_string (serialization.to_json (a_entry).representation)
			f.close
		end

note
	copyright: "2011-2017, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
